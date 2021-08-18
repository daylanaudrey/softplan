unit TFHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Data.DB,
  Vcl.DBGrids, uDM;

type
  TFrmHistorico = class(TForm)
    btnFechar: TButton;
    gdDownload: TDBGrid;
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  var
    FEmAndamento: Boolean;
    { Private declarations }
  public
    { Public declarations }
    procedure SetEmAndamento(EmAndamento: Boolean);
  end;

var
  FrmHistorico: TFrmHistorico;
  DM: TDM;

implementation

{$R *.dfm}

procedure TFrmHistorico.btnFecharClick(Sender: TObject);
begin
  FreeAndNil(DM);
  Self.Close;
end;

procedure TFrmHistorico.FormCreate(Sender: TObject);
begin
  DM := TDM.Create(Self);
end;

procedure TFrmHistorico.FormShow(Sender: TObject);
begin
  gdDownload.DataSource.DataSet.Refresh;
end;

procedure TFrmHistorico.SetEmAndamento(EmAndamento: Boolean);
begin
  FEmAndamento := EmAndamento;
end;

end.
