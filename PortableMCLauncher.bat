@echo off
set curdir=%CD%

echo Checking for pre-existing minecraft installations.

IF NOT EXIST "%appdata%\.minecraft\assets\" (goto dnchk) ELSE (goto alreadyInstalled)
:dnchk
echo Done. No installations found.



echo.
echo Portable Minecraft Launcher 
echo For help, type PortableMCLauncher.bat -h


IF [%1]==[-del] goto delMC
IF [%1]==[-r] goto repair 
IF [%1]==[-h] goto help 
IF [%1]==[-c] goto customparams 
IF [%1]==[-d] goto downloadMC
IF [%1] NEQ [] goto badoption

IF NOT EXIST ".\bin\Minecraft.exe" goto downloadMC 
goto defaultparams
rem 


:defaultparams
title Portable Minecraft Launcher (By Andrew Maney);  Status: [Starting MC Launcher: %ERRORLEVEL%]
echo Starting MC Launcher From "%CD%\bin\Minecraft.exe" and setting working directory as "%CD%\mcdata\.minecraft" ...
title Portable Minecraft Launcher (By Andrew Maney);  Status: [Starting MC Launcher: %ERRORLEVEL%]
"%CD%\bin\Minecraft.exe" --workDir "%CD%\mcdata\.minecraft"

IF %ERRORLEVEL% NEQ 0 goto error
echo Finished!


echo Deleting ".minecraft" folder from %appdata%, as it is not used or needed by the portable launcher or Minecraft. 
echo (This also removes some traces of playing MC, provided that someone knows where to look)


cd %appdata%
title Portable Minecraft Launcher (By Andrew Maney);  Status: [Deleting MC Appdata Folder; %ERRORLEVEL%]
@RD /S /Q ".minecraft"
IF %ERRORLEVEL% NEQ 0 goto error
title Portable Minecraft Launcher (By Andrew Maney);  Status: %ERRORLEVEL%

echo Status: %ERRORLEVEL%
echo.
echo [Status 0 = deleted .minecraft successfully]
echo [Status {any # other than 0} = an error occured]
echo.

title Portable Minecraft Launcher (By Andrew Maney);  Status: [Done! %ERRORLEVEL%]

echo Done!
goto done



:error
IF %ERRORLEVEL% == 3 title Portable Minecraft Launcher (By Andrew Maney);  Status: [ERROR %ERRORLEVEL%; Failed to Find File or Path]
echo [========================]
echo [    AN ERROR OCCURED!   ]
echo [   Error: %errorlevel%             ]
echo [========================]
IF %ERRORLEVEL% == 1 echo The Minecraft Launcher is already running!
title Portable Minecraft Launcher (By Andrew Maney);  Status: [ERROR: %errorlevel%]
goto done






:customparams
IF [%2]==[] IF [%3]==[] IF [%4]==[] echo No launcher path and launcher executable specified! && goto error
IF [%2]==[] echo No launcher path specified! && goto error
IF [%3]==[] echo No launcher executable specified! && goto error
IF [%4]==[] echo No workDir folder specified! && goto error

echo [%4]
title Portable Minecraft Launcher (By Andrew Maney);  Status: [Starting MC Launcher: %ERRORLEVEL%]
echo Starting MC Launcher From "%2\%3" and setting working directory as "%4" ...
title Portable Minecraft Launcher (By Andrew Maney);  Status: [Starting MC Launcher: %ERRORLEVEL%]
"%2\%3" --workDir "%CD%\%4"

IF %ERRORLEVEL% NEQ 0 goto error
echo Finished!


echo Deleting ".minecraft" folder from %appdata%, as it is not used or needed by the portable launcher or Minecraft. 
echo (This also removes some traces of playing MC, provided that someone knows where to look)


cd %appdata%
title Portable Minecraft Launcher (By Andrew Maney);  Status: [Deleting MC Appdata Folder; %ERRORLEVEL%]
@RD /S /Q ".minecraft"
IF %ERRORLEVEL% NEQ 0 goto error
title Portable Minecraft Launcher (By Andrew Maney);  Status: %ERRORLEVEL%

echo Status: %ERRORLEVEL%
echo.
echo [Status 0 = deleted .minecraft successfully]
echo [Status {any # other than 0} = an error occured]
echo.

title Portable Minecraft Launcher (By Andrew Maney);  Status: [Done! %ERRORLEVEL%]

echo Done!
goto done


:error
IF %ERRORLEVEL% == 3 title Portable Minecraft Launcher (By Andrew Maney);  Status: [ERROR %ERRORLEVEL%; Failed to Find File or Path]
echo [========================]
echo [    AN ERROR OCCURED!   ]
echo [   Error: %errorlevel%             ]
echo [========================]
title Portable Minecraft Launcher (By Andrew Maney);  Status: [ERROR: %errorlevel%]

goto done

:badoption
echo Invalid Option!
echo valid options are:

echo	-h (for help)
echo	-c (for custom parameters)
echo	-d (for downloading the minecraft launcher)

echo.
echo.
goto done

:help
echo.
echo.
echo Portable Minecraft Launcher Help:

echo To specify a custom location for the minecraft launcher, use the syntax below (Without the asterisks!):
echo        PortableMCLauncher.bat -c *path to launcher folder* *Launcher Executable Name*.exe *app data folder (can be any folder, and must be in the same directory as this program!)*
echo.
echo (The app data folder is where the launcher stores accounts and game files.)

echo.
echo.
echo To repair the Minecraft Launcher, type PortableMCLauncher.bat -r
echo Then answer Y when prompted.


echo.
echo.
echo.
echo For Default Options, put the launcher in a folder named "bin", and make another empty folder named "mcdata", unless the launcher has not been downloaded yet.
echo.
goto done

:downloadMC
title Portable Minecraft Launcher (By Andrew Maney);  Status: [Downloading MC Launcher: %ERRORLEVEL%]
echo Making Directory ".\bin"...
mkdir .\bin
cd .\bin
echo Downloading Minecraft Launcher...
powershell -Command "Invoke-WebRequest https://launcher.mojang.com/download/Minecraft.exe -OutFile .\Minecraft.exe"
cd %curdir%
echo Starting MC Launcher...
title Portable Minecraft Launcher (By Andrew Maney);  Status: [Downloading MC Launcher: %ERRORLEVEL%]
start PortableMCLauncher.bat
exit

:repair
echo This will delete both the .bin AND mcdata folders! Please make a backup of these folders if you want to save any worlds!
SET /P AREYOUSURE="Are you sure you want to continue (Y/[N])?: "
IF /I "%AREYOUSURE%" NEQ "Y" (echo Not Repairing!) && (GOTO done)

cd %curdir%
echo Repairing Minecraft Launcher...
@RD /S /Q ".\bin"
@RD /S /Q ".\mcdata"
echo Done.
start PortableMCLauncher.bat
exit



:alreadyInstalled
echo This Computer already has Minecraft Java Edition installed! Quitting...
goto done

:delMC
echo This will PERMANENTLY DELETE both the .bin AND mcdata folders! Please make a backup of these folders if you want to save anything!
SET /P AREYOUSURE="Are you sure you want to continue (Y/[N])?: "
IF /I "%AREYOUSURE%" NEQ "Y" (echo Deletion Cancelled!) && (GOTO done)

cd %curdir%
echo Deleting Minecraft...
@RD /S /Q ".\bin"
@RD /S /Q ".\mcdata"
echo Done.


:done
cd %curdir%
pause
