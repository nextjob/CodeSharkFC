# CodeSharkFC
Integrating FreeCAD with python4delphi

This repository includes a demo program to test integration of [FreeCAD](https://www.freecadweb.org/) (an opensource 2D/3D CAD/CAM solution) with an application program using python4delphi.


## Screenshots
Line Selection
![Line Selection](https://raw.githubusercontent.com/nextjob/CodeSharkFC/master/images/LineSelection.png)
Arc Selection
![Arc Selection](https://raw.githubusercontent.com/nextjob/CodeSharkFC/master/images/ArcSelection.png)
Circle Selection
![Circle Selection](https://raw.githubusercontent.com/nextjob/CodeSharkFC/master/images/CircleSelection.png)


## Discussion
See the FreeCAD forum post: https://forum.freecadweb.org/viewtopic.php?f=22&t=42530


## Prerequisites
__Note:__ The sample application was created with the Lazarus IDE and complied with Free Pascal, a Delphi port is available [Here](https://github.com/nextjob/CodeSharkFCs).

* Windows & Linux operating System
* Latest FreeCAD (https://github.com/FreeCAD/FreeCAD/releases)
* [Lazarus IDE](https://www.lazarus-ide.org/)
* LazSerial via Lazarus Online Package Manager
* PythonForLazarus via Lazarus Online Package Manager

## Installation
    
* With Lazarus IDE, open the Lazarus project information file for CodeSharkFC (`./CodeSharkFC.lpi`)
* Build the application

	   
## Notes
* This program is designed with the assumption that you are working with 2D drawings.
* The Draft workbench Shape 2D View tool can be handy in creating 2D outlines of an object.
* FreeCAD objects may need to be downgraded to their "sub components" via the [Draft Downgrade](https://freecadweb.org/wiki/Draft_Downgrade) command.


## Troubleshooting

See FreeCADSetupNotesLinux.txt for Linux specific issues. 

Error: `Error - could not load a Python engine`

Problem: FreeCAD install does not ?always? load all the required Python files for `python4delphi` to the interface properly.  
Solution: Installing python from python.org (current FreeCAD version Python 3.8.6) fixes this issue.

Error: `Error - This application failed to start because it could not find or load the Qt platform plugin "windows"`  

Problem: Problem with QT5 looking for `..\platforms\` in the directory of the executable (in this case `CodeSharkFC.exe`).  
Solution: You should be able to set environment variables to point to ..\FreeCAD19\bin\platforms but I have not had any luck with this.
Workaround is to copy contents of `..\FreeCAD19\bin\platforms` to `..\CodeSharkFC\platforms` 
