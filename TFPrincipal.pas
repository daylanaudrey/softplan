unit TFPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, SyncObjs, Vcl.Grids, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.Samples.Gauges, IdBaseComponent, IdComponent,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, TFHistorico;

type
  TTFormPrincipal = class(TForm)
    sbIniciarDownload: TSpeedButton;
    sdPrincipal: TSaveDialog;
    stLinkDownload: TStaticText;
    gpbDownload: TGauge;
    sbExibirMensagem: TSpeedButton;
    sbParaDownload: TSpeedButton;
    sbHistoricoDownloads: TSpeedButton;
    mmLinkDownload: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure sbIniciarDownloadClick(Sender: TObject);
    procedure sbExibirMensagemClick(Sender: TObject);
    procedure sbParaDownloadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbHistoricoDownloadsClick(Sender: TObject);
  private
    { Private declarations }
    procedure AlterarBotoes(Tipo: Boolean);

  var
    NumeroDownload: Integer;

  public
    { Public declarations }

    procedure Erro(Msg: String);

  var
    procedure setBarraProgresso(Posicao, Maximo: Integer);
    procedure setFinalizado(DownloadNumero: Integer);
    procedure FinalizarDownload;

  end;

var
  TFormPrincipal: TTFormPrincipal;

implementation

{$R *.dfm}

uses uDownload;

var
  ThreadDownload: TDownload;

procedure TTFormPrincipal.AlterarBotoes(Tipo: Boolean);
begin
  if Tipo then
    sbParaDownload.Enabled := False
  else
    sbParaDownload.Enabled := True;
  sbIniciarDownload.Enabled := Tipo;
  mmLinkDownload.Enabled := Tipo;
end;

procedure TTFormPrincipal.Erro(Msg: String);
begin

  ShowMessage('Houve um problema: ' + Msg);
  FinalizarDownload;
end;

procedure TTFormPrincipal.FinalizarDownload;
begin

  ThreadDownload.FinalizarArquivoDownload;
  try
    ThreadDownload.Terminate;
    gpbDownload.Progress := 0;
    gpbDownload.Refresh;
    AlterarBotoes(True);
  finally
    FreeAndNil(ThreadDownload);
  end;
end;

procedure TTFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (ThreadDownload <> nil) then
    if ThreadDownload.Suspended = False then
      if application.messagebox('Existe um download em andamento, deseja interrompe-lo?', 'Confirmação', MB_YESNO) = IDYES then
      begin
        TerminateThread(ThreadDownload.Handle, 0);
        FreeAndNil(ThreadDownload);
        Action := TCloseAction.caFree;
      end
      else
        Action := TCloseAction.caNone;
end;

procedure TTFormPrincipal.FormCreate(Sender: TObject);
begin
  NumeroDownload := 0;
end;

procedure TTFormPrincipal.setBarraProgresso(Posicao, Maximo: Integer);
begin
  with gpbDownload do
  begin
    if Posicao > 0 then
      Progress := Posicao
    else
      Posicao := MaxValue;

    if Maximo > 0 then
      MaxValue := Maximo;
  end;
end;

procedure TTFormPrincipal.setFinalizado(DownloadNumero: Integer);
begin
  AlterarBotoes(True);
  FinalizarDownload
end;

procedure TTFormPrincipal.sbExibirMensagemClick(Sender: TObject);
begin
  if (ThreadDownload <> nil) then
  begin
    if ThreadDownload.Suspended = False then
      ShowMessage(IntToStr(gpbDownload.PercentDone) + '% concluidos as ' + FormatDateTime('dd/mm/yyyy hh:MM:ss', Now))
    else
      ShowMessage('Nem um download em andamento.');
  end
  else
    ShowMessage('Nem um download em andamento.');
end;

procedure TTFormPrincipal.sbHistoricoDownloadsClick(Sender: TObject);
var
  AFrmHistorico: TFrmHistorico;
begin
  AFrmHistorico := TFrmHistorico.Create(Self);
  try
    AFrmHistorico.SetEmAndamento((ThreadDownload <> nil));
    AFrmHistorico.ShowModal;
  finally
    AFrmHistorico.Free;
  end;
end;

procedure TTFormPrincipal.sbIniciarDownloadClick(Sender: TObject);
var
  UrlArquivo, Arquivo: String;

begin
  UrlArquivo := Trim(mmLinkDownload.Lines.Text);
  if Trim(UrlArquivo) <> '' then
  begin
    Arquivo := ExtractFileName(StringReplace(UrlArquivo, '/', '\', [rfReplaceAll]));
    sdPrincipal.FileName := Arquivo;
    if sdPrincipal.Execute then
      if sdPrincipal.FileName <> '' then
      begin
        AlterarBotoes(False);
        ThreadDownload := TDownload.Create(True);
        try
          with ThreadDownload do
          begin
            FreeOnTerminate := True;
            SetDownload(NumeroDownload, UrlArquivo, sdPrincipal.FileName);
            Resume;
          end;
        finally
          Inc(NumeroDownload);
        end;
      end;
  end
  else
  begin
    mmLinkDownload.SetFocus;
    ShowMessage('Informe a URL!');
  end;
end;

procedure TTFormPrincipal.sbParaDownloadClick(Sender: TObject);
begin
  gpbDownload.Progress := 0;
  gpbDownload.Refresh;
  AlterarBotoes(True);
  ThreadDownload.FinalizarArquivoDownload;
  ThreadDownload.Suspend;
  TerminateThread(ThreadDownload.Handle, 0);
end;

end.
