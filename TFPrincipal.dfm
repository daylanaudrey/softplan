object TFormPrincipal: TTFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Sistema Download - Softplan'
  ClientHeight = 571
  ClientWidth = 898
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sbIniciarDownload: TSpeedButton
    Left = 8
    Top = 163
    Width = 105
    Height = 22
    Caption = 'Iniciar Download'
    OnClick = sbIniciarDownloadClick
  end
  object gpbDownload: TGauge
    Left = 8
    Top = 351
    Width = 882
    Height = 100
    Progress = 0
  end
  object sbExibirMensagem: TSpeedButton
    Left = 136
    Top = 163
    Width = 105
    Height = 22
    Caption = 'Exibir Mensagem'
    OnClick = sbExibirMensagemClick
  end
  object sbParaDownload: TSpeedButton
    Left = 8
    Top = 191
    Width = 105
    Height = 22
    Caption = 'Parar Download'
    Enabled = False
    OnClick = sbParaDownloadClick
  end
  object sbHistoricoDownloads: TSpeedButton
    Left = 136
    Top = 191
    Width = 145
    Height = 22
    Caption = 'Exibir hist'#243'rio de download'
    OnClick = sbHistoricoDownloadsClick
  end
  object stLinkDownload: TStaticText
    Left = 8
    Top = 16
    Width = 147
    Height = 17
    Caption = 'Informe o link para download:'
    TabOrder = 0
  end
  object mmLinkDownload: TMemo
    Left = 8
    Top = 59
    Width = 882
    Height = 89
    Lines.Strings = (
      'http://187.108.112.23/testebw/file2.test')
    TabOrder = 1
  end
  object sdPrincipal: TSaveDialog
    Left = 840
    Top = 520
  end
end
