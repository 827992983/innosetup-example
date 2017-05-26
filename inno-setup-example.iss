; 脚本由 Inno Setup 脚本向导 生成！
; 有关创建 Inno Setup 脚本文件的详细资料请查阅帮助文档！

#define MyAppName "XXX软件名称"
#define MyAppVersion "1.0"
#define MyAppMiniVerson "0"
#define MyAppPublisher "XXX公司"
#define MyAppURL "https://www.xxx.com/"

[Setup]
; 注: AppId的值为单独标识该应用程序。
; 不要为其他安装程序使用相同的AppId值。
; (生成新的GUID，点击 工具|在IDE中生成GUID。)
AppId={#MyAppName}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\XXX
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputBaseFilename={#MyAppName}
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin
SetupIconFile=Source\share\icons\xxx.ico
AppCopyright=北京优帆科技有限公司
AppMutex=WIN_CTP_CLIENT_MUTEX
UninstallDisplayIcon=Source\share\icons\uninstall.ico
WizardImageFile=Source\share\icons\wizard_left.bmpWizardSmallImageFile=Source\share\icons\wizard_small.bmp
VersionInfoVersion={#MyAppVersion}.{#MyAppMiniVerson}
DisableReadyPage=yes
OutputDir=Output\{#MyAppVersion}\
VersionInfodescription="xxx安装包"
AlwaysRestart=no
SetupLogging = yes

[Languages]Name: "ch"; MessagesFile: "compiler:Languages\chinese.isl"Name: "en"; MessagesFile: "compiler:Languages\english.isl"

[Icons]
Name: "{commonstartmenu}\XXX"; Filename: "{app}\bin\xxx.exe";
Name: "{commondesktop}\XXX"; Filename: "{app}\bin\xxx.exe";

[Files]
Source: "Source\bin\drivers\usbdk_x64\*"; DestDir: "{app}\bin\drivers\usbdk_x64"; Flags: ignoreversion
Source: "Source\bin\drivers\usbdk_x86\*"; DestDir: "{app}\bin\drivers\usbdk_x86"; Flags: ignoreversion
Source: "Source\bin\*"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "Source\bin\drivers\usbdk_x64\UsbDkHelper.dll"; DestDir: "{app}\bin"; Check: Is64BitInstallMode; Flags: ignoreversion
Source: "Source\bin\drivers\usbdk_x86\UsbDkHelper.dll"; DestDir: "{app}\bin"; Check: not Is64BitInstallMode; Flags: ignoreversion
Source: "Source\share\icons\uninstall.ico"; Flags: solidbreak dontcopy
Source: "Source\share\icons\hicolor\16x16\apps\*"; DestDir: "{app}\share\icons\hicolor\16x16\apps"; Flags: ignoreversion
Source: "Source\share\icons\hicolor\22x22\apps\*"; DestDir: "{app}\share\icons\hicolor\22x22\apps"; Flags: ignoreversion
Source: "Source\share\icons\hicolor\24x24\apps\*"; DestDir: "{app}\share\icons\hicolor\24x24\apps"; Flags: ignoreversion
Source: "Source\share\icons\hicolor\24x24\devices\*"; DestDir: "{app}\share\icons\hicolor\24x24\apps"; Flags: ignoreversion
Source: "Source\share\icons\hicolor\32x32\apps\*"; DestDir: "{app}\share\icons\hicolor\32x32\apps"; Flags: ignoreversion
Source: "Source\share\icons\hicolor\48x48\apps\*"; DestDir: "{app}\share\icons\hicolor\48x48\apps"; Flags: ignoreversion
Source: "Source\share\icons\hicolor\256x256\apps\*"; DestDir: "{app}\share\icons\hicolor\256x256\apps"; Flags: ignoreversion
Source: "Source\share\icons\hicolor\*"; DestDir: "{app}\share\icons\hicolor"; Flags: ignoreversion
Source: "Source\share\icons\Adwaita\16x16\actions\*"; DestDir: "{app}\share\icons\Adwaita\16x16\actions"; Flags: ignoreversion
Source: "Source\share\icons\Adwaita\24x24\actions\*"; DestDir: "{app}\share\icons\Adwaita\24x24\actions"; Flags: ignoreversion
Source: "Source\share\icons\Adwaita\32x32\actions\*"; DestDir: "{app}\share\icons\Adwaita\32x32\actions"; Flags: ignoreversion
Source: "Source\share\icons\Adwaita\48x48\actions\*"; DestDir: "{app}\share\icons\Adwaita\48x48\actions"; Flags: ignoreversion
Source: "Source\share\icons\Adwaita\64x64\actions\*"; DestDir: "{app}\share\icons\Adwaita\64x64\actions"; Flags: ignoreversion
Source: "Source\share\icons\Adwaita\96x96\actions\*"; DestDir: "{app}\share\icons\Adwaita\96x96\actions"; Flags: ignoreversion
Source: "Source\share\icons\Adwaita\*"; DestDir: "{app}\share\icons\Adwaita"; Flags: ignoreversion
; 注意: 不要在任何共享系统文件上使用“ Flags: ignoreversion”

[Run]; 安装驱动程序Filename: "{app}\bin\drivers\usbdk_x64\UsbDkController.exe "; Parameters: "-i"; Check: Is64BitInstallModeFilename: "{app}\bin\drivers\usbdk_x86\UsbDkController.exe "; Parameters: "-i"; Check: not Is64BitInstallMode

[Code]
function UpdateIcon(const hWnd: Integer; const exeFileName, exeIcon, IcoFileName: String; wlangID: DWORD): Boolean;
external 'UpdateIcon@files:UpdateIcon.dll stdcall';

function UpdateUninstIcon(const IcoFileName: String): Boolean;
begin  //要替换图标的exe文件路径名称留空，则插件会自动替换掉Inno卸载程序的图标！其它参数类似！
  Result:= UpdateIcon(MainForm.Handle, '', '', IcoFileName, 0); //替换卸载图标
end;

//在新向导页 (由CurPageID 指定) 显示后调用
procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpSelectDir then  //在安装目录界面执行
    begin
    WizardForm.NextButton.Caption:= '安装（I）';  
    end;
end;

const MF_BYPOSITION=$400;

function DeleteMenu(HMENU: HWND; uPosition: UINT; uFlags: UINT): BOOL;
external 'DeleteMenu@user32.dll stdcall';

function GetSystemMenu(HWND: hWnd; bRevert: BOOL): HWND;
external 'GetSystemMenu@user32.dll stdcall';

function CheckFirstinstall() : Boolean;
var
 ThisAppName         :String;
 PreAppName          :String;
 Name                :String;
 msgStr              :String;
 Mark                :Integer; 
 Version             :String;
 ErrorCode           :Integer;
 UninstallStr        :String;  
begin
  Result := true;
  Mark := 0;                        
  //check whether installed or not
  ThisAppName := ExpandConstant('{#MyAppName}');
  if RegkeyExists(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + ThisAppName + '_is1') then
  begin
    Mark := 1;
    Name := ThisAppName;
    RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + ThisAppName + '_is1', 'DisplayVersion', Version);
  end;

  if RegkeyExists(HKLM, 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\' + ThisAppName + '_is1') then
  begin
    Mark := 1;
    Name := ThisAppName;
    RegQueryStringValue(HKLM, 'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\' + ThisAppName + '_is1', 'DisplayVersion', Version);
  end;

  if Mark = 1 then
  begin
    Result := false;
    msgStr := '程序已安装，是否卸载 ' + Version + ' 版本。';
    if MsgBox(msgStr, mbConfirmation, MB_YESNO) = IDYES then
    begin
    RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + Name + '_is1', 'UninstallString', UninstallStr);
    ShellExec( '', UninstallStr , '/SILENT' , '' , SW_SHOW , ewWaitUntilTerminated , ErrorCode);
    Result := true;
    end
  end;
end;

//该函数在安装程序初始化时调用
function InitializeSetup(): Boolean;
begin 
  Result := true;
  Result := CheckFirstinstall;
  if Result = false then
  begin
    exit;
  end;
end;

//在开始的时候改变向导或者向导页
procedure InitializeWizard();
begin
DeleteMenu(GetSystemMenu(wizardform.handle,false),8,MF_BYPOSITION);
DeleteMenu(GetSystemMenu(wizardform.handle,false),7,MF_BYPOSITION);
end;

//安装过程中调用（该过程提供用户完成预安装和安装之后的任务，更多的是提供了安装过程中的状态。）
procedure CurStepChanged (CurStep: TSetupStep );
var
  ErrorCode: Integer;
  sIcon:     String;
  ExePath:   String;
begin
  //在程序实际安装前（准备写入文件了）
  if CurStep=ssInstall then
  begin
    sIcon:=ExpandConstant('{tmp}\uninstall.ico');
    ExtractTemporaryFile(ExtractFileName(sIcon));
    UpdateUninstIcon(sIcon);
  end;
  //实际安装完成后（文件复制完成）
  if CurStep = ssPostInstall  then
  begin
  //TODO: 写入注册表
      ExePath := ExpandConstant('{app}') + '\bin\remote-viewer.exe %1';
      RegWriteStringValue(HKCR, 'VirtViewer.vvfile\shell\open\command', '', ExePath);
  end; 
  //在一次成功的安装完成后、安装程序终止前（即点击finish按钮后执行） 
  if CurStep = ssDone then
  begin
  
  end;
end;

//卸载时调用
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  ErrorCode: Integer;
begin
  //开始卸载
	if CurUninstallStep = usUninstall then
	begin
	end;
  //卸载完成
  if CurUninstallStep = usPostUninstall then
	begin
  //TODO: 删除注册表项
  RegDeleteKeyIncludingSubkeys(HKCR, 'VirtViewer.vvfile');
	end;
end;
