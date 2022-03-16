unit uvendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, udm, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, ubuscaprod, System.Math,
  biblio, uCliente, uVenda;

type
  Tfvendas = class(TForm)
    dbg_itens: TDBGrid;
    lbl_quantidade: TLabel;
    lbl_total: TLabel;
    dbn_proven: TDBNavigator;
    btn_sair: TButton;
    gpb_cliente: TGroupBox;
    lbl_pedido: TLabel;
    dbe_pedido: TDBEdit;
    lbl_cidade: TLabel;
    dbe_cidade: TDBEdit;
    lbl_uf: TLabel;
    dbe_uf: TDBEdit;
    dbe_totqtd: TDBEdit;
    dbe_totvlr: TDBEdit;
    lbl_dtemi: TLabel;
    dbe_dtemi: TDBEdit;
    shp: TShape;
    src_venda: TDataSource;
    src_proven: TDataSource;
    qry_venda: TFDQuery;
    qry_vendaven_cod: TFDAutoIncField;
    qry_vendaven_dtemi: TDateField;
    qry_vendaven_cliente: TIntegerField;
    qry_vendaven_vlrtotal: TFloatField;
    qry_vendacli_nome: TStringField;
    qry_vendacli_cidade: TStringField;
    qry_vendacli_uf: TStringField;
    qry_proven: TFDQuery;
    qry_provenproven_cod: TFDAutoIncField;
    qry_provenproven_codven: TIntegerField;
    qry_provenproven_codpro: TIntegerField;
    qry_provenpro_desc: TStringField;
    qry_provenproven_qtd: TSingleField;
    qry_provenproven_vlrun: TSingleField;
    qry_provenproven_vlrtotal: TSingleField;
    qry_provenpro_preco_venda: TSingleField;
    qry_provenTOT_QTD: TAggregateField;
    qry_provenTOT_VLR: TAggregateField;
    dbn_vendas: TDBNavigator;
    schema: TFDSchemaAdapter;
    dbc_cliente: TDBLookupComboBox;
    src_cliente: TDataSource;
    qry_cliente: TFDQuery;
    qry_clientecli_cod: TFDAutoIncField;
    qry_clientecli_nome: TStringField;
    qry_clientecli_cidade: TStringField;
    qry_clientecli_uf: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_sairClick(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
    procedure dbg_itensEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qry_vendaNewRecord(DataSet: TDataSet);
    procedure qry_provenproven_codproValidate(Sender: TField);
    procedure qry_provenproven_qtdValidate(Sender: TField);
    procedure qry_provenproven_vlrunValidate(Sender: TField);
    procedure qry_vendaBeforePost(DataSet: TDataSet);
    procedure qry_provenBeforePost(DataSet: TDataSet);
    procedure dbg_itensEnter(Sender: TObject);
    procedure qry_vendaAfterPost(DataSet: TDataSet);
    procedure dbg_itensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    bscProd: Tfbuscaprod;
  public
    { Public declarations }
  end;

var
  fvendas: Tfvendas;

implementation

{$R *.dfm}

procedure Tfvendas.btn_cancelarClick(Sender: TObject);
begin
  src_venda.DataSet.Cancel;
end;

procedure Tfvendas.btn_excluirClick(Sender: TObject);
begin
  if MessageDlg('Confirma a exclusão do Pedido de venda?',mtConfirmation,[mbYes,mbNo],0,mbNo)=mrYes then
    src_venda.DataSet.Delete;
end;

procedure Tfvendas.btn_gravarClick(Sender: TObject);
begin
  src_venda.DataSet.Post;
end;

procedure Tfvendas.btn_novoClick(Sender: TObject);
begin
  src_venda.DataSet.Append;
  dbe_dtemi.SetFocus;
end;

procedure Tfvendas.btn_sairClick(Sender: TObject);
begin
  Close;
end;

procedure Tfvendas.dbg_itensEditButtonClick(Sender: TObject);
begin
  if dbg_itens.SelectedField.FieldName='proven_codpro' then
  begin
    bscProd.ExecuteSQL;
    bscProd.ShowModal;
    if bscProd.ModalResult=mrOK then
    begin
      if not (qry_proven.State in dsEditModes) then
        qry_proven.Edit;
      qry_provenproven_codpro.AsInteger := bscProd.CodProduto;
    end;
  end;
end;

procedure Tfvendas.dbg_itensEnter(Sender: TObject);
begin
  if qry_venda.State in dsEditModes then
    qry_venda.Post;
end;

procedure Tfvendas.dbg_itensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_DELETE then
    dbn_proven.BtnClick(nbDelete)
  else if Key=VK_RETURN then
  begin
    if qry_proven.State in dsEditModes then
      qry_proven.Post
    else
      qry_proven.Edit;
  end;
end;

procedure Tfvendas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  bscProd.Free;
  FreeAndNil(Venda);
  Action:=caFree;
end;

procedure Tfvendas.FormCreate(Sender: TObject);
begin
  // Criar Objetos
  Venda := TVenda.Create;

  // Abrir Consultas
  if not qry_venda.Active then
    qry_venda.Active:=True;
  if not qry_proven.Active then
    qry_proven.Active:=True;
  if not qry_cliente.Active then
    qry_cliente.Active:=True;
  // Inicia Form Busca de Produtos
  bscProd := Tfbuscaprod.Create(Application);
end;

procedure Tfvendas.qry_provenBeforePost(DataSet: TDataSet);
begin
  ValidarCamposEmBranco(DataSet);
end;

procedure Tfvendas.qry_provenproven_codproValidate(Sender: TField);
begin
  // Limpar Campos
  qry_provenpro_desc.Clear;
  qry_provenproven_vlrun.Clear;

  // Pesquisar Registro
  if StrToIntDef(Sender.AsString,0)>0 then
  begin
    bscProd.ExecuteSQL(Sender.AsInteger);
    if not bscProd.IsEmpty then
    begin
      qry_provenpro_desc.AsString := bscProd.DescProduto;
      qry_provenproven_vlrun.AsFloat := bscProd.VlrProduto;
    end else
      MessageDlg('Produto inválido ou inexistente.',mtInformation,[mbOk],0);
  end;
end;

procedure Tfvendas.qry_provenproven_qtdValidate(Sender: TField);
begin
  qry_provenproven_vlrtotal.AsFloat := RoundTo(qry_provenproven_vlrun.AsFloat
                                             * qry_provenproven_qtd.AsFloat, -2);
end;

procedure Tfvendas.qry_provenproven_vlrunValidate(Sender: TField);
begin
  qry_provenproven_vlrtotal.AsFloat := RoundTo(qry_provenproven_vlrun.AsFloat
                                             * qry_provenproven_qtd.AsFloat, -2);
end;

procedure Tfvendas.qry_vendaAfterPost(DataSet: TDataSet);
begin
  qry_venda.Refresh;
end;

procedure Tfvendas.qry_vendaBeforePost(DataSet: TDataSet);
begin
  ValidarCamposEmBranco(DataSet);
end;

procedure Tfvendas.qry_vendaNewRecord(DataSet: TDataSet);
begin
  qry_vendaven_dtemi.AsDateTime := Now;
end;

end.
