object fbuscaprod: Tfbuscaprod
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Busca de Produtos'
  ClientHeight = 371
  ClientWidth = 543
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object gpb_filtros: TGroupBox
    Left = 8
    Top = 8
    Width = 527
    Height = 65
    Caption = 'Filtros'
    TabOrder = 0
    object lbl_procod: TLabel
      Left = 11
      Top = 16
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
    end
    object lbl_prodesc: TLabel
      Left = 99
      Top = 16
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object edt_procod: TEdit
      Left = 11
      Top = 31
      Width = 78
      Height = 21
      TabOrder = 0
    end
    object edt_prodesc: TEdit
      Left = 99
      Top = 31
      Width = 310
      Height = 21
      TabOrder = 1
    end
    object btn_pesquisar: TButton
      Left = 416
      Top = 29
      Width = 100
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 2
      OnClick = btn_pesquisarClick
    end
  end
  object dbg_itens: TDBGrid
    Left = 8
    Top = 79
    Width = 527
    Height = 243
    DataSource = src_itens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbg_itensDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'pro_cod'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pro_desc'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pro_preco_venda'
        Width = 100
        Visible = True
      end>
  end
  object btn_cancelar: TButton
    Left = 440
    Top = 328
    Width = 95
    Height = 35
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btn_cancelarClick
  end
  object btn_selecionar: TButton
    Left = 339
    Top = 328
    Width = 95
    Height = 35
    Caption = 'Selecionar'
    TabOrder = 3
    OnClick = btn_selecionarClick
  end
  object src_itens: TDataSource
    DataSet = qry_itens
    Left = 232
    Top = 328
  end
  object qry_itens: TFDQuery
    Connection = dm.connec
    SQL.Strings = (
      'SELECT * FROM cad_produtos')
    Left = 184
    Top = 328
    object qry_itenspro_cod: TFDAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'pro_cod'
      Origin = 'pro_cod'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object qry_itenspro_desc: TStringField
      DisplayLabel = 'Produto'
      FieldName = 'pro_desc'
      Origin = 'pro_desc'
      Required = True
      Size = 100
    end
    object qry_itenspro_preco_venda: TSingleField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'pro_preco_venda'
      Origin = 'pro_preco_venda'
    end
  end
end
