unit biblio;

interface

uses
  Data.DB, Vcl.Dialogs, System.SysUtils, Vcl.DBCtrls;

  procedure ValidarCamposEmBranco(DataSet: TDataSet);
  procedure CarregarItemsComboBox(ComboBox: TDBComboBox; sTable,sField,sWhere: String);

implementation

uses
  FireDAC.Comp.Client, udm;

{Validar Campos Obrigatórios}
procedure ValidarCamposEmBranco(DataSet: TDataSet);
var
  i: Integer;
begin
  for i := 0 to DataSet.FieldCount-1 do
  begin
    if DataSet.Fields[i].Required then
    begin
      if Trim(DataSet.Fields[i].AsString)='' then
      begin
        MessageDlg('Campo "'+DataSet.Fields[i].DisplayLabel+'" obrigatório não preenchido!',mtInformation,[mbOk],0,mbOk);
        DataSet.Fields[i].FocusControl;
        Abort;
      end;
    end;
  end;
end;

procedure CarregarItemsComboBox(ComboBox: TDBComboBox; sTable,sField,sWhere: String);
var
  qry: TFDQuery;
  sSQL: String;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Close;
    qry.Connection:=dm.connec;
    // Consulta
    sSQL := 'SELECT '+sField+' FROM '+sTable+' '+sWhere;
    qry.Open(sSQL);
    // Incluir no ComboBox
    ComboBox.Items.Clear;
    qry.First;
    while not qry.Eof do
    begin
      ComboBox.Items.Add(qry.FieldByName(sField).AsString);
      // Próx
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

end.
