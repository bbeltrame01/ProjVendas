unit ubuscaprod;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  Tfbuscaprod = class(TForm)
    gpb_filtros: TGroupBox;
    lbl_procod: TLabel;
    lbl_prodesc: TLabel;
    edt_procod: TEdit;
    edt_prodesc: TEdit;
    btn_pesquisar: TButton;
    dbg_itens: TDBGrid;
    btn_cancelar: TButton;
    btn_selecionar: TButton;
    src_itens: TDataSource;
    qry_itens: TFDQuery;
    qry_itenspro_cod: TFDAutoIncField;
    qry_itenspro_desc: TStringField;
    qry_itenspro_preco_venda: TSingleField;
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_selecionarClick(Sender: TObject);
    procedure btn_pesquisarClick(Sender: TObject);
    procedure dbg_itensDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    CodProduto: Integer;
    DescProduto: String;
    VlrProduto: Double;
    IsEmpty: Boolean;

    procedure ExecuteSQL(CodProd: Integer=0);
  end;

var
  fbuscaprod: Tfbuscaprod;

implementation

{$R *.dfm}

procedure Tfbuscaprod.btn_cancelarClick(Sender: TObject);
begin
  Close;
end;

procedure Tfbuscaprod.btn_pesquisarClick(Sender: TObject);
var
  sSQL,sFilter: String;
begin
  qry_itens.Close;
  sSQL := 
    ' SELECT * FROM cad_produtos';
  if Trim(edt_prodesc.Text)<>'' then
    sFilter := ' WHERE pro_desc LIKE '+QuotedStr('%'+edt_prodesc.Text+'%');
  if StrToIntDef(edt_procod.Text, 0)>0 then
  begin
    if sFilter='' then
      sFilter := ' WHERE pro_cod='+Trim(edt_procod.Text)
    else
      sFilter := sFilter + ' AND pro_cod='+Trim(edt_procod.Text);
  end;
  qry_itens.Open(sSQL+sFilter); 
end;

procedure Tfbuscaprod.btn_selecionarClick(Sender: TObject);
begin
  if StrToIntDef(qry_itenspro_cod.AsString, 0)>0 then
  begin
    CodProduto := qry_itenspro_cod.AsInteger;
    DescProduto := qry_itenspro_desc.AsString;
    VlrProduto := qry_itenspro_preco_venda.AsFloat;
    IsEmpty := False;
    Close;
  end;
end;

procedure Tfbuscaprod.dbg_itensDblClick(Sender: TObject);
begin
  btn_selecionar.Click;
end;

procedure Tfbuscaprod.ExecuteSQL(CodProd: Integer);
var
  sSQL,sFilter: String;
begin
  IsEmpty:=True;

  qry_itens.Close;  
  sSQL := ' SELECT * FROM cad_produtos';
  
  // Filtros
  if (Trim(edt_prodesc.Text) <> '') then
    sFilter := ' WHERE pro_desc LIKE '+QuotedStr('%'+edt_prodesc.Text+'%');
  if (CodProd > 0) then
    edt_procod.Text:=IntToStr(CodProd);
  if (StrToIntDef(edt_procod.Text, 0)>0) then
  begin
    if sFilter='' then
      sFilter := ' WHERE pro_cod='+Trim(edt_procod.Text)
    else
      sFilter := sFilter + ' AND pro_cod='+Trim(edt_procod.Text);
  end;             
  
  // Abre Consulta
  qry_itens.Open(sSQL+sFilter);

  if (CodProd > 0) then
  begin
    // Retorna valores
    if (qry_itens.RecordCount = 1) then
    begin
      CodProduto  := CodProd;
      DescProduto := qry_itenspro_desc.AsString;
      VlrProduto  := qry_itenspro_preco_venda.AsFloat;
      IsEmpty     := False;
    end;
  end;
end;

procedure Tfbuscaprod.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if CodProduto>0 then
    ModalResult:=mrOk
  else
    ModalResult:=mrCancel;
end;

end.
