object fvendas: Tfvendas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pedido de Vendas'
  ClientHeight = 571
  ClientWidth = 844
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object lbl_quantidade: TLabel
    Left = 566
    Top = 473
    Width = 79
    Height = 16
    Caption = 'Quantidade:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_total: TLabel
    Left = 695
    Top = 473
    Width = 37
    Height = 16
    Caption = 'Total:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_pedido: TLabel
    Left = 39
    Top = 80
    Width = 38
    Height = 16
    Caption = 'Pedido'
  end
  object lbl_dtemi: TLabel
    Left = 39
    Top = 126
    Width = 77
    Height = 16
    Caption = 'Data Emiss'#227'o'
  end
  object shp: TShape
    Left = 8
    Top = 519
    Width = 828
    Height = 1
  end
  object dbg_itens: TDBGrid
    Left = 39
    Top = 181
    Width = 797
    Height = 286
    DataSource = src_proven
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnEditButtonClick = dbg_itensEditButtonClick
    OnEnter = dbg_itensEnter
    OnKeyDown = dbg_itensKeyDown
    Columns = <
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'proven_codpro'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pro_desc'
        ReadOnly = True
        Width = 350
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'proven_vlrun'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'proven_qtd'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'proven_vlrtotal'
        ReadOnly = True
        Width = 100
        Visible = True
      end>
  end
  object dbn_proven: TDBNavigator
    Left = 8
    Top = 181
    Width = 29
    Height = 75
    DataSource = src_proven
    VisibleButtons = [nbDelete, nbPost, nbCancel]
    Kind = dbnVertical
    TabOrder = 3
  end
  object btn_sair: TButton
    Left = 695
    Top = 526
    Width = 141
    Height = 37
    Caption = 'Sair'
    TabOrder = 7
    OnClick = btn_sairClick
  end
  object gpb_cliente: TGroupBox
    Left = 135
    Top = 72
    Width = 701
    Height = 103
    Caption = 'Cliente'
    TabOrder = 2
    object lbl_cidade: TLabel
      Left = 16
      Top = 54
      Width = 39
      Height = 16
      Caption = 'Cidade'
    end
    object lbl_uf: TLabel
      Left = 632
      Top = 54
      Width = 15
      Height = 16
      Caption = 'UF'
    end
    object dbe_cidade: TDBEdit
      Left = 16
      Top = 70
      Width = 601
      Height = 24
      DataField = 'cli_cidade'
      DataSource = src_venda
      Enabled = False
      TabOrder = 0
    end
    object dbe_uf: TDBEdit
      Left = 632
      Top = 70
      Width = 49
      Height = 24
      DataField = 'cli_uf'
      DataSource = src_venda
      Enabled = False
      TabOrder = 1
    end
    object dbc_cliente: TDBLookupComboBox
      Left = 16
      Top = 24
      Width = 665
      Height = 24
      DataField = 'ven_cliente'
      DataSource = src_venda
      KeyField = 'cli_cod'
      ListField = 'cli_nome'
      ListSource = src_cliente
      TabOrder = 2
    end
  end
  object dbe_pedido: TDBEdit
    Left = 39
    Top = 96
    Width = 90
    Height = 24
    DataField = 'ven_cod'
    DataSource = src_venda
    Enabled = False
    ReadOnly = True
    TabOrder = 0
  end
  object dbe_totqtd: TDBEdit
    Left = 566
    Top = 489
    Width = 123
    Height = 24
    DataField = 'TOT_QTD'
    DataSource = src_proven
    Enabled = False
    ReadOnly = True
    TabOrder = 5
  end
  object dbe_totvlr: TDBEdit
    Left = 695
    Top = 489
    Width = 123
    Height = 24
    DataField = 'TOT_VLR'
    DataSource = src_proven
    Enabled = False
    ReadOnly = True
    TabOrder = 6
  end
  object dbe_dtemi: TDBEdit
    Left = 39
    Top = 142
    Width = 90
    Height = 24
    DataField = 'ven_dtemi'
    DataSource = src_venda
    TabOrder = 1
  end
  object dbn_vendas: TDBNavigator
    Left = 0
    Top = 0
    Width = 844
    Height = 57
    DataSource = src_venda
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
    Align = alTop
    TabOrder = 8
  end
  object src_venda: TDataSource
    DataSet = qry_venda
    Left = 760
    Top = 48
  end
  object src_proven: TDataSource
    DataSet = qry_proven
    Left = 776
    Top = 400
  end
  object qry_venda: TFDQuery
    BeforePost = qry_vendaBeforePost
    AfterPost = qry_vendaAfterPost
    OnNewRecord = qry_vendaNewRecord
    Connection = dm.connec
    SchemaAdapter = schema
    SQL.Strings = (
      'SELECT * FROM mov_vendas v'
      'LEFT JOIN cad_clientes c ON '
      'c.cli_cod=v.ven_cliente')
    Left = 728
    Top = 48
    object qry_vendaven_cod: TFDAutoIncField
      DisplayLabel = 'Pedido'
      FieldName = 'ven_cod'
      Origin = 'ven_cod'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qry_vendaven_dtemi: TDateField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Data Emiss'#227'o'
      FieldName = 'ven_dtemi'
      Origin = 'ven_dtemi'
      EditMask = '99/99/9999;1;_'
    end
    object qry_vendaven_cliente: TIntegerField
      DisplayLabel = 'Cliente'
      FieldName = 'ven_cliente'
      Origin = 'ven_cliente'
      Required = True
    end
    object qry_vendaven_vlrtotal: TFloatField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Total'
      FieldName = 'ven_vlrtotal'
      Origin = 'ven_vlrtotal'
    end
    object qry_vendacli_nome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cli_nome'
      Origin = 'cli_nome'
      ProviderFlags = []
      Size = 100
    end
    object qry_vendacli_cidade: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cli_cidade'
      Origin = 'cli_cidade'
      ProviderFlags = []
      Size = 100
    end
    object qry_vendacli_uf: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cli_uf'
      Origin = 'cli_uf'
      ProviderFlags = []
      FixedChar = True
      Size = 2
    end
  end
  object qry_proven: TFDQuery
    BeforePost = qry_provenBeforePost
    IndexFieldNames = 'proven_codven'
    AggregatesActive = True
    MasterSource = src_venda
    MasterFields = 'ven_cod'
    DetailFields = 'proven_codven'
    Connection = dm.connec
    SchemaAdapter = schema
    SQL.Strings = (
      'SELECT * FROM mov_prodven pv '
      'LEFT JOIN cad_produtos p ON '
      'p.pro_cod=pv.proven_codpro'
      'WHERE pv.proven_codven=:ven_cod')
    Left = 744
    Top = 400
    ParamData = <
      item
        Name = 'VEN_COD'
        DataType = ftAutoInc
        ParamType = ptInput
        Value = Null
      end>
    object qry_provenproven_cod: TFDAutoIncField
      FieldName = 'proven_cod'
      Origin = 'proven_cod'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qry_provenproven_codven: TIntegerField
      FieldName = 'proven_codven'
      Origin = 'proven_codven'
      Required = True
    end
    object qry_provenproven_codpro: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'proven_codpro'
      Origin = 'proven_codpro'
      ProviderFlags = [pfInUpdate]
      Required = True
      OnValidate = qry_provenproven_codproValidate
    end
    object qry_provenpro_desc: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Produto'
      FieldName = 'pro_desc'
      Origin = 'pro_desc'
      ProviderFlags = []
      Size = 100
    end
    object qry_provenproven_qtd: TSingleField
      DisplayLabel = 'Quantidade'
      FieldName = 'proven_qtd'
      Origin = 'proven_qtd'
      ProviderFlags = [pfInUpdate]
      Required = True
      OnValidate = qry_provenproven_qtdValidate
    end
    object qry_provenproven_vlrun: TSingleField
      DisplayLabel = 'Valor UN'
      FieldName = 'proven_vlrun'
      Origin = 'proven_vlrun'
      ProviderFlags = [pfInUpdate]
      Required = True
      OnValidate = qry_provenproven_vlrunValidate
    end
    object qry_provenproven_vlrtotal: TSingleField
      DisplayLabel = 'Valor Total'
      FieldName = 'proven_vlrtotal'
      Origin = 'proven_vlrtotal'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object qry_provenpro_preco_venda: TSingleField
      AutoGenerateValue = arDefault
      FieldName = 'pro_preco_venda'
      Origin = 'pro_preco_venda'
      ProviderFlags = []
      ReadOnly = True
    end
    object qry_provenTOT_QTD: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TOT_QTD'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(proven_qtd)'
    end
    object qry_provenTOT_VLR: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TOT_VLR'
      Active = True
      currency = True
      DisplayName = ''
      DisplayFormat = '#,###,##0.00'
      Expression = 'SUM(proven_vlrtotal)'
    end
  end
  object schema: TFDSchemaAdapter
    Left = 768
    Top = 256
  end
  object src_cliente: TDataSource
    DataSet = qry_cliente
    Left = 768
    Top = 88
  end
  object qry_cliente: TFDQuery
    Connection = dm.connec
    SQL.Strings = (
      'SELECT * FROM cad_clientes')
    Left = 727
    Top = 88
    object qry_clientecli_cod: TFDAutoIncField
      FieldName = 'cli_cod'
      Origin = 'cli_cod'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qry_clientecli_nome: TStringField
      FieldName = 'cli_nome'
      Origin = 'cli_nome'
      Required = True
      Size = 100
    end
    object qry_clientecli_cidade: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cli_cidade'
      Origin = 'cli_cidade'
      Size = 100
    end
    object qry_clientecli_uf: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'cli_uf'
      Origin = 'cli_uf'
      FixedChar = True
      Size = 2
    end
  end
end
