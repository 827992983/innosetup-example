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
//�ؼ����뾲Ĭ��װ
procedure InitializeWizard();
begin
  //����ʾ�߿��������ܴﵽ������������
  WizardForm.BorderStyle:=bsNone;
end;


procedure CurPageChanged(CurPageID: Integer);
begin
 //��Ϊ��װ���̽������ز��ˣ��������ô��ڿ��Ϊ0
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