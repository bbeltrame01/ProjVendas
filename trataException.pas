unit trataException;

interface

uses
  System.SysUtils, Forms, System.Classes, Dialogs;

type
  TException = class
    private
      FLogFile: String;
    public
      constructor Create;
      procedure TrataException(Sender: TObject; E: Exception);
      procedure GravarLog(Value: String);
  end;

implementation

{ TException }

constructor TException.Create;
begin
  FLogFile := ChangeFileExt(ParamStr(0), '.log');
  Application.OnException := TrataException;
end;

procedure TException.GravarLog(Value: String);
var
  TXT: TextFile;
begin
  AssignFile(TXT, FLogFile);
  if FileExists(FLogFile) then
    Append(TXT)
  else
    Rewrite(TXT);

  Writeln(TXT, FormatDateTime('dd/mm/yyyy hh:nn:ss', now) + Value);
  CloseFile(TXT);
end;

procedure TException.TrataException(Sender: TObject; E: Exception);
begin
  if TComponent(Sender) is TForm then
  begin
    GravarLog('[TForm.Name]' + TForm(Sender).Name);
    GravarLog('[TForm.Caption]' + TForm(Sender).Caption);
    GravarLog('[ClassName]' + E.ClassName);
    GravarLog('[Error]' + E.Message);
  end else
  begin
    GravarLog('[TForm.Name]' + TForm(TComponent(Sender).Owner).Name);
    GravarLog('[TForm.Caption]' + TForm(TComponent(Sender).Owner).Caption);
    GravarLog('[ClassName]' + E.ClassName);
    GravarLog('[Error]' + E.Message);
  end;

  ShowMessage(E.Message);
end;

var
  ProjException: TException;

initialization
  ProjException := TException.Create;

finalization
  ProjException.Free;

end.
