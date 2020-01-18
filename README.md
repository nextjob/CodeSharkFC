# CodeSharkFC
FreeCAD integration project

Demo program to test integration of FreeCAD with an application program using python4delphi.

Line Selection
![Line Selection](https://raw.githubusercontent.com/nextjob/CodeSharkFC/master/images/LineSelection.png)
Arc Selection
![Arc Selection](https://raw.githubusercontent.com/nextjob/CodeSharkFC/master/images/ArcSelection.png)
Circle Selection
![Circle Selection](https://raw.githubusercontent.com/nextjob/CodeSharkFC/master/images/CircleSelection.png)

FreeCAD is found at:
https://www.freecadweb.org/

See forum post: https://forum.freecadweb.org/viewtopic.php?f=22&t=42530


The sample application was created with the Lazarus IDE and complied with Free Pascal.

Compiling program:

Download and install Lazarus (https://www.lazarus-ide.org/)

Download python4delphi (https://github.com/pyscripter/python4delphi) and install the package into the Lazarus IDE

(https://wiki.freepascal.org/Install_Packages)

Edit file ..\python4delphi-master\PythonForDelphi\Components\Sources\Core\Definition.Inc to select the python
version being used:

       .
       
//{$DEFINE PYTHON35}

{$DEFINE PYTHON36}

//{$DEFINE PYTHON37}

       .
      
With the IDE, open the Lazarus project information file for CodeSharkFC (CodeSharkFC.lpi), and build the application.

	   
Notes

This program is designed with the assumption that you are working with 2D drawings.

The Draft workbench Shape 2D View tool can be handy in creating 2D outlines of an object.

FreeCAD objects may need to be downgraded to their "sub components" via the Draft Downgrade command.


Trouble Shooting

Error - could not load a Python engine

FreeCAD install does not ?always? load all the required Python files for python4delphi to interface properly.  
Installing python from python.org (currently version Python 3.6.6). Fixes this issue.

Error - This application failed to start because it could not find or load the Qt platform plugin "windows" 

Problem with QT5 looking for ..\platforms\ in the directory of the executable (in this case CodeSharkFC.exe).  
You should be able to set environment variables to point to ..\FreeCAD19\bin\platforms but I have not had any luck with this.
Work around is to copy contents of ..\FreeCAD19\bin\platforms to ..\CodeSharkFC\platforms 
