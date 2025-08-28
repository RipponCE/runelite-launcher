[Setup]
AppName=Veskar Launcher
AppPublisher=Veskar
UninstallDisplayName=Veskar
AppVersion=${project.version}
AppSupportURL=https://vesarps.com
DefaultDirName={localappdata}\Veskar

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=arm64
PrivilegesRequired=lowest

WizardSmallImageFile=${project.projectDir}/innosetup/runelite_small.bmp
SetupIconFile=${project.projectDir}/innosetup/runelite.ico
UninstallDisplayIcon={app}\Veskar.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${project.projectDir}
OutputBaseFilename=VeskarSetupAArch64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${project.projectDir}\build\win-aarch64\Veskar.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-aarch64\Veskar.jar"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-aarch64\launcher_aarch64.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-aarch64\config.json"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-aarch64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Veskar\Veskar"; Filename: "{app}\Veskar.exe"
Name: "{userprograms}\Veskar\Veskar (configure)"; Filename: "{app}\Veskar.exe"; Parameters: "--configure"
Name: "{userprograms}\Veskar\Veskar (safe mode)"; Filename: "{app}\Veskar.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Veskar"; Filename: "{app}\Veskar.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Veskar.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Veskar.exe"; Description: "&Open Veskar"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Veskar.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.veskar\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: ""; ValueData: "URL:runelite-jav Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\Veskar.exe"" ""%1"""; Flags: uninsdeletekey

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"