unit Splash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON;

type
  TFormSplash = class(TForm)
    LayoutFundo: TLayout;
    imgFundo: TImage;
    LayoutNomeApp: TLayout;
    LabelNomeApp: TLabel;
    LayoutUpdate: TLayout;
    LayoutCabecalho: TLayout;
    LayoutCorpoUpdate: TLayout;
    LayoutRodape: TLayout;
    BtnUpdate: TRoundRect;
    LabelUpdate: TLabel;
    LabelNewVersao: TLabel;
    LabelCorpo: TLabel;
    Image1: TImage;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnUpdateClick(Sender: TObject);
    procedure imgFundoClick(Sender: TObject);
  private
  procedure OnFinishUpdate(Sender: TObject);
    { Private declarations }
  public
  versao_app: string;
  versao_server: string;
    { Public declarations }
  end;

var
  FormSplash: TFormSplash;

implementation

{$R *.fmx}

uses UOpenURL, Home;


procedure TFormSplash.FormCreate(Sender: TObject);
begin
  versao_app := '1.1';
  versao_server := '1.1';
end;



procedure TFormSplash.FormShow(Sender: TObject);
var
  t:TThread;

begin
  t:= TThread.CreateAnonymousThread(
  procedure
  var
    JsonObj: TJSONObject;
  begin
    sleep(2000);
    try
      RESTRequest1.Execute;
    except
      on ex: Exception do
    begin
      raise Exception.Create('Erro ao acessar servidor' + ex.Message);
        exit;
    end;
  end;
  try
    JsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes
    (RESTRequest1.Response.JSONValue.ToString), 0) as TJSONObject;

     versao_server := TJSONObject(JsonObj).GetValue('Versao').Value;
    finally
      JsonObj.disposeof;
    end;
  end);
  t.OnTerminate := OnFinishUpdate;
  t.Start;
end;

procedure TFormSplash.imgFundoClick(Sender: TObject);
begin
  FormHome:=TFormHome.Create(Application);
  FormHome.Show();
end;

procedure TFormSplash.OnFinishUpdate(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
    begin
    showmessage(Exception(TThread(Sender).FatalException).Message);
    exit;
    end;

    if versao_app < versao_server then
    begin
        LayoutFundo.Visible := True;
        LayoutUpdate.Visible := False;
        BtnUpdate.Opacity := 0;
        LabelCorpo.Opacity := 0;
        LabelNewVersao.Opacity := 0;
    end;
end;

procedure TFormSplash.BtnUpdateClick(Sender: TObject);
var
  url: string;
begin
{$IFDEF ANDROID}
  url := 'https://drive.google.com/drive/folders/1ambg9UDdeaco0mEgv-O0i8m8wqYRdqFP';
{$ELSE}
  url := 'https://drive.google.com/drive/folders/1ambg9UDdeaco0mEgv-O0i8m8wqYRdqFP';
{$ENDIF}
  OpenURL(url, False);
  Application.Terminate;


end;



end.
