; -- update-desktop-tools.iss --
;
; This script auto update desktop tools .

[Setup]
AppName=Update-tools
AppVersion=1.5
WizardStyle=modern
DisableWelcomePage=no
CreateAppDir=no
DisableProgramGroupPage=yes
DefaultGroupName=My Program
UninstallDisplayIcon={app}\MyProg.exe
OutputDir=userdocs:Inno Setup Examples Output

[Code]
//关键代码静默安装
procedure InitializeWizard();
begin
  //不显示边框，这样就能达到不会闪两下了
  WizardForm.BorderStyle:=bsNone;
end;


procedure CurPageChanged(CurPageID: Integer);
begin
 //因为安装过程界面隐藏不了，所以设置窗口宽高为0
  WizardForm.ClientWidth := ScaleX(0)
  WizardForm.ClientHeight := ScaleY(0)
  if CurPageID = wpWelcome then
    WizardForm.NextButton.OnClick(WizardForm);
  if CurPageID >= wpInstalling then
    WizardForm.Visible := False
  else
    WizardForm.Visible := True;
end;
 
function ShouldSkipPage(PageID: Integer): Boolean;
begin
  result := true;
end;