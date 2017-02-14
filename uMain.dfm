object Form1: TForm1
  Left = 246
  Top = 262
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Hidden Words'
  ClientHeight = 422
  ClientWidth = 1018
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblBPC: TLabel
    Left = 744
    Top = 120
    Width = 81
    Height = 13
    Caption = #1041#1080#1090' '#1085#1072' '#1087#1080#1082#1089#1077#1083#1100':'
  end
  object Label1: TLabel
    Left = 448
    Top = 8
    Width = 129
    Height = 20
    Caption = #1052#1077#1085#1102' '#1050#1086#1076#1091#1074#1072#1085#1085#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 120
    Top = 48
    Width = 55
    Height = 20
    Caption = #1064#1080#1092#1088#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 728
    Top = 48
    Width = 170
    Height = 20
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1080' '#1082#1086#1076#1091#1074#1072#1085#1085#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 16
    Top = 80
    Width = 185
    Height = 13
    Caption = #1054#1073#1077#1088#1110#1090#1100' '#1082#1110#1083#1100#1082#1110#1089#1090#1100' '#1084#1077#1090#1086#1076#1110#1074' '#1082#1086#1076#1091#1074#1072#1085#1085#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 48
    Top = 128
    Width = 17
    Height = 13
    Caption = #8470'1'
    Visible = False
  end
  object Label6: TLabel
    Left = 48
    Top = 176
    Width = 17
    Height = 13
    Caption = #8470'2'
    Visible = False
  end
  object Label7: TLabel
    Left = 48
    Top = 224
    Width = 17
    Height = 13
    Caption = #8470'3'
    Visible = False
  end
  object Label8: TLabel
    Left = 48
    Top = 272
    Width = 17
    Height = 13
    Caption = #8470'4'
    Visible = False
  end
  object Label9: TLabel
    Left = 16
    Top = 384
    Width = 17
    Height = 13
    Caption = #8470'5'
    Visible = False
  end
  object Label10: TLabel
    Left = 8
    Top = 416
    Width = 17
    Height = 13
    Caption = #8470'6'
    Visible = False
  end
  object Label12: TLabel
    Left = 872
    Top = 200
    Width = 66
    Height = 13
    Caption = #1063#1080#1089#1083#1086' '#1079#1089#1091#1074#1091':'
  end
  object Label11: TLabel
    Left = 48
    Top = 312
    Width = 153
    Height = 13
    Caption = #1047#1072#1089#1090#1086#1089#1091#1074#1072#1085#1085#1103'  '#1082#1086#1076#1091#1074#1072#1085#1085#1103' LSB'
  end
  object Label13: TLabel
    Left = 48
    Top = 336
    Width = 209
    Height = 13
    Caption = #1047#1073#1077#1088#1110#1075#1072#1085#1085#1103' '#1082#1083#1102#1095#1110#1074' '#1091' '#1090#1077#1082#1089#1090#1086#1074#1080#1081'  '#1076#1086#1082#1091#1084#1077#1085#1090
  end
  object bbtnEncrypt: TBitBtn
    Left = 863
    Top = 368
    Width = 130
    Height = 49
    Caption = #1050#1086#1076#1091#1074#1072#1085#1085#1103
    TabOrder = 0
    OnClick = bbtnEncryptClick
  end
  object pb1: TProgressBar
    Left = 336
    Top = 384
    Width = 361
    Height = 25
    TabOrder = 1
    Visible = False
  end
  object edtBPC: TEdit
    Left = 840
    Top = 116
    Width = 25
    Height = 21
    ReadOnly = True
    TabOrder = 2
    Text = '1'
  end
  object udBitsPerChannel: TUpDown
    Left = 865
    Top = 116
    Width = 15
    Height = 21
    Associate = edtBPC
    Min = 1
    Max = 8
    Position = 1
    TabOrder = 3
  end
  object ComboBox1: TComboBox
    Left = 208
    Top = 80
    Width = 57
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
    OnChange = ComboBox1Change
    Items.Strings = (
      '1'
      '2'
      '3'
      '4')
  end
  object ComboBox2: TComboBox
    Left = 80
    Top = 128
    Width = 153
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
    Visible = False
    OnChange = ComboBox2Change
    Items.Strings = (
      #1064#1080#1092#1088' '#1062#1077#1079#1072#1088#1103
      'RSA'
      #1064#1080#1092#1088' '#1042#1110#1078#1077#1085#1077#1088#1072
      #1064#1080#1092#1088' '#1045#1083#1100'-'#1043#1072#1084#1072#1083#1103)
  end
  object ComboBox3: TComboBox
    Left = 80
    Top = 176
    Width = 153
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 6
    Visible = False
    OnChange = ComboBox3Change
    Items.Strings = (
      #1064#1080#1092#1088' '#1062#1077#1079#1072#1088#1103
      'RSA'
      #1064#1080#1092#1088' '#1042#1110#1078#1077#1085#1077#1088#1072
      #1064#1080#1092#1088' '#1045#1083#1100'-'#1043#1072#1084#1072#1083#1103)
  end
  object ComboBox4: TComboBox
    Left = 80
    Top = 224
    Width = 153
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 7
    Visible = False
    OnChange = ComboBox4Change
    Items.Strings = (
      #1064#1080#1092#1088' '#1062#1077#1079#1072#1088#1103
      'RSA'
      #1064#1080#1092#1088' '#1042#1110#1078#1077#1085#1077#1088#1072
      #1064#1080#1092#1088' '#1045#1083#1100'-'#1043#1072#1084#1072#1083#1103)
  end
  object ComboBox5: TComboBox
    Left = 80
    Top = 272
    Width = 153
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 8
    Visible = False
    OnChange = ComboBox5Change
    Items.Strings = (
      #1064#1080#1092#1088' '#1062#1077#1079#1072#1088#1103
      'RSA'
      #1064#1080#1092#1088' '#1042#1110#1078#1077#1085#1077#1088#1072
      #1064#1080#1092#1088' '#1045#1083#1100'-'#1043#1072#1084#1072#1083#1103)
  end
  object ComboBox6: TComboBox
    Left = 40
    Top = 376
    Width = 153
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 9
    Visible = False
    OnChange = ComboBox6Change
    Items.Strings = (
      #1064#1080#1092#1088' '#1062#1077#1079#1072#1088#1103
      'RSA'
      #1064#1080#1092#1088' '#1042#1110#1078#1077#1085#1077#1088#1072
      #1064#1080#1092#1088' '#1045#1083#1100'-'#1043#1072#1084#1072#1083#1103)
  end
  object ComboBox7: TComboBox
    Left = 40
    Top = 416
    Width = 153
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 10
    Visible = False
    OnChange = ComboBox7Change
    Items.Strings = (
      #1064#1080#1092#1088' '#1062#1077#1079#1072#1088#1103
      'RSA'
      #1064#1080#1092#1088' '#1042#1110#1078#1077#1085#1077#1088#1072
      #1064#1080#1092#1088' '#1045#1083#1100'-'#1043#1072#1084#1072#1083#1103)
  end
  object ComboBox8: TComboBox
    Left = 720
    Top = 200
    Width = 145
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 11
    Items.Strings = (
      #1055#1088#1072#1074#1086#1088#1091#1095
      #1051#1110#1074#1086#1088#1091#1095)
  end
  object UpDown1: TUpDown
    Left = 969
    Top = 200
    Width = 16
    Height = 21
    Associate = Edit1
    Position = 1
    TabOrder = 12
  end
  object Edit1: TEdit
    Left = 944
    Top = 200
    Width = 25
    Height = 21
    TabOrder = 13
    Text = '1'
  end
  object Button1: TButton
    Left = 896
    Top = 152
    Width = 113
    Height = 21
    Caption = #1043#1077#1085#1077#1088#1072#1094#1110#1103' '#1082#1083#1102#1095#1110#1074
    TabOrder = 14
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 712
    Top = 152
    Width = 41
    Height = 21
    TabOrder = 15
  end
  object Edit3: TEdit
    Left = 768
    Top = 152
    Width = 41
    Height = 21
    TabOrder = 16
  end
  object Edit4: TEdit
    Left = 824
    Top = 152
    Width = 41
    Height = 21
    TabOrder = 17
  end
  object CheckBox1: TCheckBox
    Left = 216
    Top = 312
    Width = 17
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 18
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 272
    Top = 336
    Width = 17
    Height = 17
    Caption = 'CheckBox2'
    TabOrder = 19
  end
  object Button2: TButton
    Left = 56
    Top = 368
    Width = 129
    Height = 49
    Caption = #1047#1072#1074#1072#1085#1090#1072#1078#1080#1090#1080' '#1060#1072#1081#1083
    TabOrder = 20
    OnClick = Button2Click
  end
  object DBChart1: TDBChart
    Left = 264
    Top = 104
    Width = 441
    Height = 217
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    MarginTop = 5
    Title.Text.Strings = (
      #1042#1030#1076#1085#1086#1096#1077#1085#1085#1103' '#1074#1072#1075#1080' '#1087#1086#1095#1072#1090#1082#1086#1074#1086#1075#1086' '#1092#1072#1081#1083#1091' '#1076#1086' '#1082#1110#1085#1094#1077#1074#1086#1075#1086)
    BottomAxis.AxisValuesFormat = 'Text'
    LeftAxis.LabelStyle = talValue
    TabOrder = 21
    object Series2: TBarSeries
      Marks.ArrowLength = 20
      Marks.Style = smsValue
      Marks.Visible = True
      SeriesColor = clRed
      ShowInLegend = False
      Title = 'SaveFile'
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Bar'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object xpmnfst1: TXPManifest
    Left = 136
  end
  object dlgOpenPic1: TOpenPictureDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp|JPEG (*jpg)|*.jpg'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = #1054#1073#1077#1088#1110#1090#1100' '#1079#1086#1073#1088#1072#1078#1077#1085#1085#1103
    Left = 104
  end
  object dlgOpen1: TOpenDialog
    Filter = 'All files (*.*)|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = #1054#1073#1077#1088#1110#1090#1100' '#1092#1072#1081#1083' '#1076#1083#1103' '#1082#1086#1076#1091#1074#1072#1085#1085#1103
    Left = 40
  end
  object dlgSavePic1: TSavePictureDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp|JPEG (*.jpg)|*.jpg'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = #1047#1073#1077#1088#1077#1078#1110#1090#1100' '#1086#1090#1088#1080#1084#1072#1085#1077' '#1079#1086#1073#1088#1072#1078#1077#1085#1085#1103
    Left = 72
  end
  object dlgSave1: TSaveDialog
    Filter = 'All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = #1047#1073#1077#1088#1077#1078#1110#1090#1100' '#1079#1072#1082#1086#1076#1086#1074#1072#1085#1077' '#1087#1086#1074#1110#1076#1086#1084#1083#1077#1085#1085#1103
    Left = 8
  end
end
