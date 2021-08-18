unit uDownload;

interface

uses
  System.Classes, System.SysUtils, IdHTTP, IdComponent, Vcl.Dialogs,
  Vcl.Controls, TFPrincipal, uDM;

type
  TDownload = class(TThread)
  private
    { Private declarations }
    FUrl: String;
    FArquivo: String;
    FNumero: Integer;
    DM: TDM;
    FArquivoDownload: TFileStream;
    FLink: TIdHTTP;
  protected
    procedure Execute; override;
    procedure Download(Url, SavarEm: String);
    class procedure Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    class procedure WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    class procedure WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
  public
    procedure SetDownload(Numero: Integer; Url, SalvarEm: String);
    procedure CancelarDownload;
    procedure FinalizarArquivoDownload;
  end;

implementation

procedure TDownload.CancelarDownload;
begin
  FinalizarArquivoDownload;
  TFormPrincipal.setFinalizado(FNumero);
end;

procedure TDownload.Download(Url, SavarEm: String);
begin
  FLink := TIdHTTP.Create(TFormPrincipal);
  try
    FArquivoDownload := TFileStream.Create(SavarEm, fmCreate);
    try

      with FLink do
      begin
        OnWork := Work;
        OnWorkBegin := WorkBegin;
        OnWorkEnd := WorkEnd;
        Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
        Request.CacheControl := 'no-cache';
      end;
      DM.InsertDownload(Url);
      FLink.Get(Url, FArquivoDownload);
    finally
      FreeAndNil(FArquivoDownload);
      FreeAndNil(FLink);
    end;
  except
    on e: Exception do
    begin
      FreeAndNil(FArquivoDownload);
      FreeAndNil(FLink);
      ShowMessage('Houve um problema: ' + e.Message);
      CancelarDownload;
    end;
  end;

end;

procedure TDownload.Execute;
begin
  inherited;
  Priority := tpNormal;
  DM := TDM.Create(TFormPrincipal);
  try
    if (FUrl <> '') and (FArquivo <> '') then
      Download(FUrl, FArquivo);
  finally
    try
      DM.UpdateDownload;
    finally
      FreeAndNil(DM);
      ShowMessage('Download Completo');
      TFormPrincipal.setFinalizado(FNumero);
    end;
  end;
end;

procedure TDownload.FinalizarArquivoDownload;
begin
  FreeAndNil(FArquivoDownload);

end;

procedure TDownload.SetDownload(Numero: Integer; Url, SalvarEm: String);
begin
  Self.FNumero := Numero;
  Self.FUrl := Url;
  Self.FArquivo := SalvarEm;
end;

class procedure TDownload.Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  TFormPrincipal.setBarraProgresso(AWorkCount, 0);

end;

class procedure TDownload.WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  TFormPrincipal.setBarraProgresso(0, AWorkCountMax);
end;

class procedure TDownload.WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  TFormPrincipal.setBarraProgresso(0, 0);
end;

end.
