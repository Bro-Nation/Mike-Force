# README

## IMPORTANT LICENSING INFORMATION

We're still finalising the license under which this code can be modified and redistributed. 
Until the new license is published, you can modify this work under the original license within this repository, further to the conditions stated here: https://community.sogpf.com/d/198-modifying-mike-force.

## IMPORTANT BUILD INFORMATION

We're in the process of updating our build tools for Mike Force. They're in their final review phase, but we didn't want to prematurely push out buggy build tools.
For now, the old tools should still work on Windows - see `setup_dev_environment.py` and `build.py`.

## Issue Reporting

Report issues using the "Issues" section above. Please be sure to follow the template, and include as much detail as possible to help us figure out the best solution! 

## Downloading
*Mike Force* is hosted on the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2477873447). It's strongly advised to use Steam Workshop to manage the gamemode, and regularly check for updates, in case you're missing out on fixes or features!
* Download link: <https://steamcommunity.com/sharedfiles/filedetails/?id=2477873447>

## Running

The gamemode is a self-contained mission file. Simply download the mission from Steam Workshop into your server's mpmissions folder, and select it from the in-game mission list. 

## Installation Instructions for BN Composition Devs / BN Scripts Devs

### Prerequisites

You will need to install Python via the Microsoft Store. 
Open the windows start menu, search for Microsoft Store and open it. 
Then search for Python, any version 3 of Python will work. 
Install it.

You will need to download the code for both BN versions of Mike-Force and the Paradigm library.

- https://github.com/Bro-Nation/Mike-Force
- https://github.com/Bro-Nation/Paradigm

For compositions devs, open each of the above links in an internet browser, 
then click on the `Code` dropdown (top right of each page) and select download as Zip. 
Extract the Zip files out into a suitable location on your computer, 
e.g. a new `BN-MIKE-FORCE` folder in your Documents folder.

You should now have two folders in your `BN-MIKE-FORCE` folder, namely `Mike-Force` and `Paradigm`.

For mission scripting devs, you should be do the above using `git clone`.

### Setting up the missions

1. In the `BN-MIKE-FORCE\Mike-Force` folder, copy the `user_paths_example.py` and save it as a new file named `user_paths.py` in the same folder.
2. Open the file up with Notepad or similar. 
3. Delete out the text between the double quotes for both `PARADIGM_PATH` and `MISSIONS_PATH` i.e. `r"everything between the quotes here"`
4. In Windows File Explorer, open up the `BN-MIKE-FORCE\Paradigm` folder. Double click in the address bar and copy the full location of the folder (Ctrl + C).
5. Paste (Ctrl + V) this between the quotes on the same line as `PARADIGM_PATH`. It should look like this
```
PARADIGM_PATH = r"C:\Users\dijksterhuis\BN-MIKE-FORCE\Paradigm`
```
6. In Windows File Explorer, open up your default Arma profile's directory. Double click in the address bar and copy the full location of the folder (Ctrl + C).
7. Paste (Ctrl + V) this between the quotes on the same line as `MISSIONS_PATH`. Make sure it ends with `\MP_Missions`. It should look like this
```
MISSIONS_PATH = r"C:\Users\dijksterhuis\Documents\Arma 3\MPMissions`
```
8. Save the `user_paths.py` file.
9. Bring up the Windows start menu and search for `Command Prompt`. Right click on it and `Run as Administrator`.
10. In Windows File Explorer, open up the `BN-MIKE-FORCE\Mike-Force` folder. Double click in the address bar and copy the full location of the folder (Ctrl + C).
11. Back in the Command Prompt, type `cd` then press the spacebar then use Ctrl + V to paste in the Mike Force folder location. Press Enter.
12. Now type the following and hit Enter. This will automatically build your Python mission.
```
python setup_dev_environment.py
```
13. You should see some text saying different folders have been created and if nothing went wrong it should be asking you to `press any key to exit`. 
14. Press any key on your keyboard and close the Command Prompt.
15. Start Arma3.
16. Switch to your default game profile (or the profile where your linked `MPMissions` folder is under)
17. Go to `Multiplayer` > `Host Server` > Click on `Host Server` (bottom right)
18. You should see the multiplayer missions menu screen. Select a Map (Altis, CamLaoNam, KheSan or Bra). 
19. The `Mike Force (v1.00.0+)` should be highlighted in green. You can now enter the 3D editor or play as a non whitelisted unit (bottom right of the screen).

### Whitelisted Units

When playing the BN mike force mission locally you will get errors popping up on your screen regarding the whitelist and curator players. 
This happens because you do not have a copy of the whitelisting database running locally and is perfectly normal.
However, it does mean you cannot test anything regarding whitelisted units.

## installation for development

Clone repo to local location of your choice and then symlink the `vn_mf.cam_lao_nam` folder into your Arma 3 missions folder.

Something like this:

```shell
C:\Users\USERNAME\Documents\Arma 3\missions
```

Windows symlinks are handled with the `mklink` command.

```shell
mklink /j "C:\Users\USERNAME\Documents\Arma 3\missions\vn_mf.cam_lao_nam" SGD_mikeforce\HAM\vn_mf.cam_lao_nam
```

**note** Use the standard windows commandline for this, bash on windows makes a mess of the paths.


The SGD_Paradigm folder is also required to by symlinked in to be the `vn_mf.cam_lao_nam\paradigm` folder.


```shell
mklink /j "C:\Users\USERNAME\Documents\Arma 3\missions\vn_mf.cam_lao_nam\paradigm" SGD_paradigm
```

## generated doc file

Started a simple documentation generator : <https://github.com/ryantownshend/sqf_tools>

The file `mikeforce_api.html` is a super crude parse of the header comments from within the project.

This can be fleshed out as we go, but it does provide a single place to view all the function file headers.



