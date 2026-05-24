import ctypes
import ctypes.wintypes
from pathlib import Path
import os
import sys

import user_paths

def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False

def get_windows_documents_directory():
    CSIDL_PERSONAL = 5       # My Documents
    SHGFP_TYPE_CURRENT = 0   # Get current, not default value

    buf = ctypes.create_unicode_buffer(ctypes.wintypes.MAX_PATH)
    ctypes.windll.shell32.SHGetFolderPathW(None, CSIDL_PERSONAL, None, SHGFP_TYPE_CURRENT, buf)
    return Path(buf.value)

if not is_admin():
    # Re-run the program with admin rights
    ret = ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, " ".join(sys.argv), None, 1)
else:
    mission_stem = "bn_mikeforce_indev"

    content_root = Path(__file__).parent
    mission_root = content_root / "mission"
    paradigm_path = Path(user_paths.PARADIGM_PATH)
    map_root = content_root / "maps"
    map_folders = [ map_path for map_path in map_root.iterdir() if map_path.is_dir() ]

    def mission_folder_name(map_folder_name):
        if map_folder_name == "mftraining":
            return "bn_mftraining_indev.cam_lao_nam"
        return f"{mission_stem}.{map_folder_name}"

    arma_missions_folder = Path(user_paths.MISSIONS_PATH)
    arma_missions_folder.mkdir(parents=True, exist_ok=True)

    # Folders from mission/ that only belong in the training mission
    training_only_folders = {"training"}

    def symlink_immediate_children(target, source, exclude=None):
        for path in source.iterdir():
            if exclude and path.name in exclude:
                continue
            target_path = target / path.name
            if target_path.exists():
                continue
            target_path.symlink_to(path, target_is_directory=path.is_dir())

    existing_paths = []
    for map_folder in map_folders:
        target_folder = arma_missions_folder / mission_folder_name(map_folder.name)
        if target_folder.exists():
            print(f"Existing mission folder exists, syncing missing links: {target_folder}")
            existing_paths.append(target_folder)
        else:
            target_folder.mkdir()

        print("Symlinking map-specific content...")
        symlink_immediate_children(target_folder, map_folder)
        print("Symlinking mission content...")
        exclude = None if map_folder.name == "mftraining" else training_only_folders
        symlink_immediate_children(target_folder, mission_root, exclude=exclude)
        print("Symlinking paradigm...")
        paradigm_target = target_folder / "paradigm"
        if not paradigm_target.exists():
            paradigm_target.symlink_to(paradigm_path, target_is_directory=True)

    if existing_paths:
        print("Synced missing links into existing mission folders.")

    input("Press any key to exit...")
    exit(0)

