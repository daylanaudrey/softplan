unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.SQLiteVDataSet, FireDAC.Comp.DataSet, Data.FMTBcd, Data.SqlExpr,
  Data.DbxSqlite, Datasnap.DBClient, Datasnap.Provider;

type
  TDM = class(TDataModule)
    Conexao: TSQLConnection;
    dtsDados: TDataSource;
    qryDownload: TSQLQuery;
    dspDados: TDataSetProvider;
    cdsDados: TClientDataSet;
    qryHistorico: TSQLQuery;
    qryHistoricocodigo: TLargeintField;
    qryHistoricourl: TWideStringField;
    qryHistoricoColumn2: TWideMemoField;
    qryHistoricoColumn3: TWideMemoField;
    qryHistoricoColumn4: TWideMemoField;
    cdsDadoscodigo: TLargeintField;
    cdsDadosurl: TWideStringField;
    cdsDadosColumn2: TWideMemoField;
    cdsDadosColumn3: TWideMemoField;
    cdsDadosColumn4: TWideMemoField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InsertDownload(Url: String);
    procedure UpdateDownload;
  end;

var
  DM: TDM;

implementation

uses
  TFPrincipal;

var
  FrmPrincipal: TTFormPrincipal;
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
  { TDM }

procedure TDM.InsertDownload(Url: String);
begin
  try
    qryDownload.Close;
    qryDownload.SQL.Text := 'insert into logdownload (url, datainicio) values (:url, ''' + FormatDateTime('YYYY-MM-DD hh:mm:ss',
      Now) + ''')';
    qryDownload.ParamByName('url').AsString := Url;
    qryDownload.ExecSQL;
  except
    on e: Exception do
    begin
      TFormPrincipal.Erro(e.Message);
    end;
  end;

end;

procedure TDM.UpdateDownload;
begin
  try
    qryDownload.Close;
    qryDownload.SQL.Text := 'update logdownload set datafim = ''' + FormatDateTime('YYYY-MM-DD hh:mm:ss', Now) +
      ''' where codigo = (select max(codigo) from logdownload)';
    qryDownload.ExecSQL;
  except
    on e: Exception do
    begin
      TFormPrincipal.Erro(e.Message);
    end;
  end;
end;

end.
