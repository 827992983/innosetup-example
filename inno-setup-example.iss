; �ű��� Inno Setup �ű��� ���ɣ�
; �йش��� Inno Setup �ű��ļ�����ϸ��������İ����ĵ���

#define MyAppName "XXX�������"
#define MyAppVersion "1.0"
#define MyAppMiniVerson "0"
#define MyAppPublisher "XXX��˾"
#define MyAppURL "https://www.xxx.com/"

[Setup]
; ע: AppId��ֵΪ������ʶ��Ӧ�ó���
; ��ҪΪ������װ����ʹ����ͬ��AppIdֵ��
; (�����µ�GUID����� ����|��IDE������GUID��)
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
AppCopyright=�����ŷ��Ƽ����޹�˾
AppMutex=WIN_CTP_CLIENT_MUTEX
UninstallDisplayIcon=Source\share\icons\uninstall.ico
WizardImageFile=Source\share\icons\wizard_left.bmpWizardSmallImageFile=Source\share\icons\wizard_small.bmp
VersionInfoVersion={#MyAppVersion}.{#MyAppMiniVerson}
DisableReadyPage=yes
OutputDir=Output\{#MyAppVersion}\
VersionInfodescription="xxx��װ��"
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
; ע��: ��Ҫ���κι���ϵͳ�ļ���ʹ�á� Flags: ignoreversion��

[Run]; ��װ��������Filename: "{app}\bin\drivers\usbdk_x64\UsbDkController.exe "; Parameters: "-i"; Check: Is64BitInstallModeFilename: "{app}\bin\drivers\usbdk_x86\UsbDkController.exe "; Parameters: "-i"; Check: not Is64BitInstallMode

[Code]
function UpdateIcon(const hWnd: Integer; const exeFileName, exeIcon, IcoFileName: String; wlangID: DWORD): Boolean;
external 'UpdateIcon@files:UpdateIcon.dll stdcall';

function UpdateUninstIcon(const IcoFileName: String): Boolean;
begin  //Ҫ�滻ͼ���exe�ļ�·���������գ��������Զ��滻��Innoж�س����ͼ�꣡�����������ƣ�
  Result:= UpdateIcon(MainForm.Handle, '', '', IcoFileName, 0); //�滻ж��ͼ��
end;

//������ҳ (��CurPageID ָ��) ��ʾ�����
procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpSelectDir then  //�ڰ�װĿ¼����ִ��
    begin
    WizardForm.NextButton.Caption:= '��װ��I��';  
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
    msgStr := '�����Ѱ�װ���Ƿ�ж�� ' + Version + ' �汾��';
    if MsgBox(msgStr, mbConfirmation, MB_YESNO) = IDYES then
    begin
    RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + Name + '_is1', 'UninstallString', UninstallStr);
    ShellExec( '', UninstallStr , '/SILENT' , '' , SW_SHOW , ewWaitUntilTerminated , ErrorCode);
    Result := true;
    end
  end;
end;

//�ú����ڰ�װ�����ʼ��ʱ����
function InitializeSetup(): Boolean;
begin 
  Result := true;
  Result := CheckFirstinstall;
  if Result = false then
  begin
    exit;
  end;
end;

//�ڿ�ʼ��ʱ��ı��򵼻�����ҳ
procedure InitializeWizard();
begin
DeleteMenu(GetSystemMenu(wizardform.handle,false),8,MF_BYPOSITION);
DeleteMenu(GetSystemMenu(wizardform.handle,false),7,MF_BYPOSITION);
end;

//��װ�����е��ã��ù����ṩ�û����Ԥ��װ�Ͱ�װ֮������񣬸�������ṩ�˰�װ�����е�״̬����
procedure CurStepChanged (CurStep: TSetupStep );
var
  ErrorCode: Integer;
  sIcon:     String;
  ExePath:   String;
begin
  //�ڳ���ʵ�ʰ�װǰ��׼��д���ļ��ˣ�
  if CurStep=ssInstall then
  begin
    sIcon:=ExpandConstant('{tmp}\uninstall.ico');
    ExtractTemporaryFile(ExtractFileName(sIcon));
    UpdateUninstIcon(sIcon);
  end;
  //ʵ�ʰ�װ��ɺ��ļ�������ɣ�
  if CurStep = ssPostInstall  then
  begin
  //TODO: д��ע���
      ExePath := ExpandConstant('{app}') + '\bin\remote-viewer.exe %1';
      RegWriteStringValue(HKCR, 'VirtViewer.vvfile\shell\open\command', '', ExePath);
  end; 
  //��һ�γɹ��İ�װ��ɺ󡢰�װ������ֹǰ�������finish��ť��ִ�У� 
  if CurStep = ssDone then
  begin
  
  end;
end;

//ж��ʱ����
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  ErrorCode: Integer;
begin
  //��ʼж��
	if CurUninstallStep = usUninstall then
	begin
	end;
  //ж�����
  if CurUninstallStep = usPostUninstall then
	begin
  //TODO: ɾ��ע�����
  RegDeleteKeyIncludingSubkeys(HKCR, 'VirtViewer.vvfile');
	end;
end;
