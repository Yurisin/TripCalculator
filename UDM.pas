unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IOUtils;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQVeiculo: TFDQuery;
    FDQLogin: TFDQuery;
    FDQLoginidlogin: TFDAutoIncField;
    FDQLoginemail: TStringField;
    FDQLoginsenha: TStringField;
    FDQVeiculoidcarro: TFDAutoIncField;
    FDQVeiculoplaca: TStringField;
    FDQVeiculodescricao: TStringField;
    FDQVeiculoqtdTanque: TIntegerField;
    FDQVeiculomediaG: TBCDField;
    FDQVeiculomediaE: TBCDField;
    FDQVeiculomediaD: TWideStringField;
    FDQViagem: TFDQuery;
    FDQViagemidviagem: TFDAutoIncField;
    FDQViagemorigem: TStringField;
    FDQViagemorigemlatitude: TFMTBCDField;
    FDQViagemorigemlongitude: TFMTBCDField;
    FDQViagemdestino: TStringField;
    FDQViagemdestinolatitude: TFMTBCDField;
    FDQViagemdestinolongitude: TFMTBCDField;
    FDQViagemvalorgasolina: TFMTBCDField;
    FDQViagemvaloretanol: TFMTBCDField;
    FDQViagemvalordiesel: TFMTBCDField;
    FDQViagemidveiculoviagem: TWideStringField;
    procedure FDConnection1AfterConnect(Sender: TObject);
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}

procedure TDM.FDConnection1AfterConnect(Sender: TObject);
var
  strSQL: string;
begin
  strSQL := 'create table IF NOT EXISTS login(' +
    'idlogin integer primary key autoincrement,' + 'email varchar(50) not null,'
    + 'senha varchar(200) not null)';

  FDConnection1.ExecSQL(strSQL);
  strSQL := EmptyStr;

  strSQL := 'create table IF NOT EXISTS veiculo(' +
    'idcarro integer primary key autoincrement,' + 'placa varchar(7),' +
    'descricao varchar(50), ' + 'qtdTanque integer,   ' +
    'mediaG numeric(8,2),  ' + 'mediaE numeric(8,2),' + 'mediaD nuemric(8,2))';

  FDConnection1.ExecSQL(strSQL);
  strSQL := EmptyStr;

  strSQL := 'create table IF NOT EXISTS viagem( ' +
       'idviagem integer primary key autoincrement, ' +
       'origem varchar(100),   '          +
       'origemlatitude numeric(10, 8), '      +
       'origemlongitude numeric(10, 8), '    +
       'destino varchar(100),       '         +
       'destinolatitude numeric(10, 8),   '     +
       'destinolongitude numeric(10, 8), ' +
       'valorgasolina numeric(10, 8), '   +
       'valoretanol numeric(10, 8), '    +
       'valordiesel numeric(10, 8))';

  FDConnection1.ExecSQL(strSQL);
  strSQL := EmptyStr;

  FDQLogin.Active := true;
  FDQVeiculo.Active := true;
  FDQViagem.Active := true;

end;

procedure TDM.FDConnection1BeforeConnect(Sender: TObject);
var
  strPath: string;
begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  strPath := System.IOUtils.TPath.Combine
    (System.IOUtils.TPath.GetDocumentsPath, 'BD.db');
{$ENDIF}
{$IFDEF MSWINDOWS}
  strPath := System.IOUtils.TPath.Combine
    ('D:\Users\aluno\Desktop\Calculator\BD', 'BD.db');
{$ENDIF}
  FDConnection1.Params.Values['UseUnicode'] := 'False';
  FDConnection1.Params.Values['DATABASE'] := strPath;
end;

end.
