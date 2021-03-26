object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 354
  ClientWidth = 546
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 546
    Height = 354
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 440
    ExplicitTop = 288
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Memo1: TMemo
      Left = 16
      Top = 32
      Width = 257
      Height = 249
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
    end
    object Button1: TButton
      Left = 384
      Top = 96
      Width = 105
      Height = 33
      Caption = 'Carregar XML'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object XMLDocument1: TXMLDocument
    Left = 128
    Top = 152
  end
end
