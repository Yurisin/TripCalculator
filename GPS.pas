unit GPS;
interface
uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Sensors,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Maps, FMX.Layouts,
  FMX.TabControl, System.Sensors.Components, System.Actions, FMX.ActnList,
  FMX.Edit, REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.Objects, System.JSON, System.Permissions;
type
  TFormGPS = class(TForm)
    LocationSensor1: TLocationSensor;
    TabControl1: TTabControl;
    TabItemGPS: TTabItem;
    LayoutFundo: TLayout;
    MapView1: TMapView;
    Switch1: TSwitch;
    LayoutSwitch: TLayout;
    ActionList1: TActionList;
    TabGPS: TChangeTabAction;
    TabDistancia: TChangeTabAction;
    TabItemDistancia: TTabItem;
    LayoutFundoDistancia: TLayout;
    LayoutCabecalhoDistancia: TLayout;
    LabelCabecalho: TLabel;
    LayoutCorpoDistancia: TLayout;
    LabelOrigem: TLabel;
    EditOrigem: TEdit;
    LabelDestino: TLabel;
    EditDestino: TEdit;
    LayoutRodapeDistancia: TLayout;
    LabelDistancia: TLabel;
    LabelTempo: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    BtnCalcularRota: TRoundRect;
    LabelCalcularRota: TLabel;
    BtnMenu: TRoundRect;
    LabelMenu: TLabel;
    BtnMapa: TButton;
    BtnVoltar: TButton;
    procedure LocationSensor1LocationChanged(Sender: TObject;
     const OldLocation, NewLocation: TLocationCoord2D);
    procedure FormCreate(Sender: TObject);
    procedure BtnCalcularRotaClick(Sender: TObject);
    procedure BtnMenuClick(Sender: TObject);
    procedure Switch1Click(Sender: TObject);
    procedure BtnVoltarClick(Sender: TObject);
    procedure BtnMapaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  FormGPS: TFormGPS;
implementation
uses UDM, Home, UOpenURL
{$IFDEF ANDROID}
    , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
    ;
{$R *.fmx}

procedure TFormGPS.BtnCalcularRotaClick(Sender: TObject);
var
retorno: TJSONObject;
prows: TJSONPair;
arrayr: TJSONArray;
orows: TJSONObject;
arraye: TJSONArray;
oelementos : TJSONObject;
oduracao, odistancia: TJSONObject;
distancia_str, duracao_str: string;
distancia_int, duracao_int: integer;
begin
RESTRequest1.Resource :=
'json?origins={origem}&destinations={destino}&mode=driving&language=pt-BR&key=AIzaSyAwjnJzF57fQddVy_dL8yTC01Zw7ufVuY8';
RESTRequest1.Params.AddUrlSegment('origem', EditOrigem.Text);
RESTRequest1.Params.AddUrlSegment('destino', EditDestino.Text);
RESTRequest1.Execute;
retorno := RESTRequest1.Response.JSONValue as TJSONObject;
if retorno.GetValue('status').Value <> 'OK' then
begin
  showmessage('Ocorreu um erro ao calcular a viagem.');
  exit;
end;
prows := retorno.Get('rows');
arrayr := prows.JSONValue as TJSONArray;
orows := arrayr.Items[0] as TJSONObject;
arraye := orows.GetValue('elements') as TJSONArray;
oelementos := arraye.Items[0] as TJSONObject;

odistancia := oelementos.GetValue('distance') as TJSONObject;
oduracao := oelementos.GetValue('duration') as TJSONObject;

distancia_str := odistancia.GetValue('text').Value;
distancia_int := odistancia.GetValue('value').Value.ToInteger;

duracao_str := oduracao.GetValue('text').Value;
duracao_int := oduracao.GetValue('value').Value.ToInteger;

LabelDistancia.Text := 'Distância: '+ distancia_str;
LabelTempo.Text := 'Tempo: ' + duracao_str;

end;
procedure TFormGPS.BtnMapaClick(Sender: TObject);
begin
  TabGPS.Execute;
end;

procedure TFormGPS.BtnMenuClick(Sender: TObject);
begin
  FormHome.Show;
  FormHome.TabCadVeiculo.Execute;
end;
procedure TFormGPS.BtnVoltarClick(Sender: TObject);
begin
    TabDistancia.Execute;
end;

procedure TFormGPS.FormCreate(Sender: TObject);
begin
  MapView1.MapType := TMapType.Normal;
end;
procedure TFormGPS.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var
  MyMarker: TMapMarkerDescriptor;
  posicao: TMapCoordinate;
begin
  MapView1.Location := TMapCoordinate.Create(NewLocation.Latitude,
    NewLocation.Longitude);
  posicao.Latitude := NewLocation.Latitude;
  posicao.Longitude := NewLocation.Longitude;
  MyMarker := TMapMarkerDescriptor.Create(posicao, 'Estou aqui!');
  MyMarker.Draggable := true;
  MyMarker.Visible := true;
  MyMarker.Snippet := 'Eu';
  MapView1.AddMarker(MyMarker);
end;

procedure TFormGPS.Switch1Click(Sender: TObject);
{$IFDEF ANDROID}
var
  ApermissaoGPS: string;
{$ENDIF}
begin
{$IFDEF ANDROID}
  ApermissaoGPS := JStringToString
    (TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);

  PermissionsService.RequestPermissions([ApermissaoGPS],
    procedure(const ApermissaoGPS: TArray<string>;
      const AGrantResults: TArray<TPermissionStatus>)
    begin
      if (Length(AGrantResults) = 1) and
        (AGrantResults[0] = TPermissionStatus.Granted) then
        LocationSensor1.Active := true
      else
        LocationSensor1.Active := false;

    end);
{$ENDIF}
end;

end.
