from pathlib import Path
import os
import shutil
import user_paths

arma_missions_folder = Path(user_paths.MISSIONS_PATH)
mission_stem = "bn_mikeforce_indev"

def mission_folder_name(map_folder_name):
	if map_folder_name == "mftraining":
		return "bn_mftraining_indev.cam_lao_nam"
	return f"{mission_stem}.{map_folder_name}"

# We don't need these - they bloat the build
blacklisted_folders = [
	"paradigm/.git",
	"paradigm/paradigm_data",
	".vscode",
]

# Folders from mission/ that only belong in the training mission build
training_only_folders = {
	"training",
}


def ignore_unreadable_entries(base_dir, names):
	"""Skip unreadable children so copytree doesn't crash on protected folders."""
	ignored = []
	for name in names:
		child_path = Path(base_dir) / name
		if not os.access(child_path, os.R_OK):
			print(f"  Skipping unreadable path: {child_path}")
			ignored.append(name)
	return ignored


def is_permission_denied_copy_error(error_tuple):
	"""True when copytree reported a non-fatal permission denied for a source entry."""
	_src_path, _dst_path, err_msg = error_tuple
	return "Errno 13" in err_msg or "Permission denied" in err_msg

def set_permissions_if_delete_fails(func, path, exc_info):
    """
    Error handler for ``shutil.rmtree``.

    If the error is due to an access error (read only file)
    it attempts to add write permission and then retries.

    If the error is for another reason it re-raises the error.

    Usage : ``shutil.rmtree(path, onerror=onerror)``
    """
    import stat
    if not os.access(path, os.W_OK):
        # Is the error an access error ?
        os.chmod(path, stat.S_IWUSR)
        func(path)
    else:
        raise


content_root = Path(__file__).parent
map_root = content_root / "maps"
map_folders = sorted(
	[map_path for map_path in map_root.iterdir() if map_path.is_dir()],
	key=lambda path: path.name.lower(),
)
output_folder = content_root / "build_output"

if not output_folder.exists():
	output_folder.mkdir()

for map_folder in map_folders:
	folder_name = mission_folder_name(map_folder.name)
	source_folder = arma_missions_folder / folder_name
	target_folder = output_folder / folder_name

	if target_folder.exists():
		print(f"Removing existing folder: {target_folder}")
		shutil.rmtree(target_folder, onerror=set_permissions_if_delete_fails)
		
	print(f"Copying mission to {folder_name}")
	try:
		shutil.copytree(source_folder, target_folder, ignore=ignore_unreadable_entries)
	except shutil.Error as copy_error:
		error_items = copy_error.args[0]
		unexpected_errors = [item for item in error_items if not is_permission_denied_copy_error(item)]
		if unexpected_errors:
			print("  Warning: partial copy from live mission source; continuing with repo sync fallback.")
			for src_path, dst_path, err_msg in unexpected_errors:
				print(f"    {src_path} -> {dst_path}: {err_msg}")
		target_folder.mkdir(exist_ok=True)
	except OSError as os_error:
		print(f"  Warning: could not fully copy live mission source: {os_error}")
		target_folder.mkdir(exist_ok=True)

	# Also copy any folders/files from the repo that weren't symlinked into
	# the live folder (e.g. added after setup was last run)
	for source in [map_folder, content_root / "mission"]:
		for item in source.iterdir():
			if item.name in training_only_folders and map_folder.name != "mftraining":
				continue
			target_item = target_folder / item.name
			if not target_item.exists():
				if item.is_dir():
					print(f"  Adding folder from repo: {item.name}")
					shutil.copytree(item, target_item)
				else:
					print(f"  Adding file from repo: {item.name}")
					shutil.copy2(item, target_item)

	print("Trimming fat...")
	to_delete = [ target_folder / folder for folder in blacklisted_folders ]
	for path_to_delete in to_delete:
		print(f"Removing {path_to_delete}")
		if path_to_delete.exists():
			shutil.rmtree(path_to_delete, onerror=set_permissions_if_delete_fails)
	
# Default is to pause for local interactive use. Set MF_BUILD_NO_PAUSE=1 to skip.
if os.environ.get("MF_BUILD_NO_PAUSE", "0") not in {"1", "true", "True"}:
	input("Press any key to exit...")
exit(0)

