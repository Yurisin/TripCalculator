unit Home;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.TabControl, FMX.Objects, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, idHashSHA, FMX.ListBox;

type
  TFormHome = class(TForm)
    TabControlHome: TTabControl;
    TabItemLogin: TTabItem;
    TabItemCadastro: TTabItem;
    LayoutBackCadastro: TLayout;
    LayoutCabecalhoCadastro: TLayout;
    LayoutCorpoCadastro: TLayout;
    LblCadastrar: TLabel;
    ImgCadastro: TImage;
    LblEmailCadastro: TLabel;
    EditEmailCadastro: TEdit;
    LblSenhaCadastro: TLabel;
    EditSenhaCadastro: TEdit;
    LayoutRodapeCadastro: TLayout;
    BtnCadastrar: TRoundRect;
    BtnLimparTextoCadastro: TRoundRect;
    LblBtnCadastrar: TLabel;
    LblBtnLimparTextoCadastro: TLabel;
    LayoutBackLogin: TLayout;
    LayoutCabecalhoLogin: TLayout;
    LayoutCorpoLogin: TLayout;
    LayoutCorpoRodape: TLayout;
    LblLogin: TLabel;
    ImgLogin: TImage;
    LblEmailLogin: TLabel;
    EditEmailLogin: TEdit;
    LblSenhaLogin: TLabel;
    EditSenhaLogin: TEdit;
    BtnLogar: TRoundRect;
    BtnCadastro: TRoundRect;
    LblLogar: TLabel;
    LblCadastre: TLabel;
    TabItemVeiculo: TTabItem;
    LayoutFundoVeiculo: TLayout;
    LayoutCabecalho: TLayout;
    LayoutCampos: TLayout;
    LayoutRodape: TLayout;
    lblCadastroVeiculo: TLabel;
    EditPlacaVeiculo: TEdit;
    LabelPlaca: TLabel;
    LabelDescricao: TLabel;
    EditDescricaoVeiculo: TEdit;
    LabelTamTanque: TLabel;
    EditTamanhoTanque: TEdit;
    LabelMediaG: TLabel;
    EditMediaGasolina: TEdit;
    LabelMediaEtanol: TLabel;
    EditMediaEtanol: TEdit;
    LabelMediaDiesel: TLabel;
    EditMediaDiesel: TEdit;
    BtnCadastrarVeiculo: TRoundRect;
    BtnClearVeiculo: TRoundRect;
    BtnEditarVeiculo: TRoundRect;
    LabelCadVeiculo: TLabel;
    LabelClearVeiculo: TLabel;
    LabelEditarVeiculo: TLabel;
    ActionList1: TActionList;
    TabCadastro: TChangeTabAction;
    TabLogin: TChangeTabAction;
    TabCadVeiculo: TChangeTabAction;
    TabItemViagem: TTabItem;
    TabCadViagem: TChangeTabAction;
    LayoutFundo: TLayout;
    LayoutCabecalhoViagem: TLayout;
    LayoutCorpoViagem: TLayout;
    LayoutRodapeViagem: TLayout;
    LabelCadastroViagem: TLabel;
    LabelVeiculoViagem: TLabel;
    LabelOrigemViagem: TLabel;
    EditOrigemViagem: TEdit;
    LabelDestinoViagem: TLabel;
    EditDestinoViagem: TEdit;
    LabelValorGasolina: TLabel;
    EditValorGasolina: TEdit;
    LabelValorEtanol: TLabel;
    EditValorEtanol: TEdit;
    LabelValorDiesel: TLabel;
    EditValorDiesel: TEdit;
    BtnCalcularViagem: TRoundRect;
    BtnClearViagem: TRoundRect;
    LabelCalcularViagem: TLabel;
    LabelClearViagem: TLabel;
    ComboBoxVeiculoViagem: TComboBox;
    BtnCadastrarViagem: TRoundRect;
    LabelCadastrarViagem: TLabel;
    procedure BtnCadastroClick(Sender: TObject);
    procedure BtnLogarClick(Sender: TObject);
    procedure BtnCadastrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnClearVeiculoClick(Sender: TObject);
    procedure BtnCadastrarVeiculoClick(Sender: TObject);
    procedure BtnCadastrarViagemClick(Sender: TObject);
    procedure BtnClearViagemClick(Sender: TObject);
    procedure BtnCalcularViagemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function SHA1(AString: string): string;
  end;

var
  FormHome: TFormHome;

implementation

{$R *.fmx}
uses UDM, Splash, UOpenURL, GPS;

procedure TFormHome.BtnCadastrarClick(Sender: TObject);
var
  senha: string;
begin
  DM.FDQLogin.Close;
  DM.FDQLogin.Open();

  if (EditEmailCadastro.text = EmptyStr) or (EditSenhaCadastro.text = EmptyStr)
  then
    Abort;

  DM.FDQLogin.Append;
  DM.FDQLoginEmail.AsString := EditEmailCadastro.text;
  DM.FDQLoginSenha.AsString := SHA1(EditSenhaCadastro.text);
  DM.FDQLogin.Post;
  DM.FDConnection1.CommitRetaining;

  ShowMessage('Cadastrado com sucesso!');
  TabLogin.Execute;
end;

procedure TFormHome.BtnCadastrarVeiculoClick(Sender: TObject);
begin
  DM.FDQVeiculo.Close;
  DM.FDQVeiculo.Open();

  if (EditPlacaVeiculo.text = EmptyStr) or (EditDescricaoVeiculo.text = EmptyStr) or (EditMediaGasolina.text = EmptyStr) or (EditMediaEtanol.text = EmptyStr) or (EditMediaDiesel.text = EmptyStr)
  then
    Abort;

  DM.FDQVeiculo.Append;
  DM.FDQVeiculoplaca.AsString := EditPlacaVeiculo.text;
  DM.FDQVeiculodescricao.AsString := EditDescricaoVeiculo.text;
  DM.FDQVeiculoqtdTanque.AsString := EditTamanhoTanque.text;
  DM.FDQVeiculomediaG.AsString := EditMediaGasolina.text;
  DM.FDQVeiculomediaE.AsString := EditMediaEtanol.text;
  DM.FDQVeiculomediaD.AsString := EditMediaDiesel.text;
  DM.FDQVeiculo.Post;
  DM.FDConnection1.CommitRetaining;

  ShowMessage('Veiculo Cadastrado com Sucesso.');

  TabCadViagem.Execute;
end;

procedure TFormHome.BtnCadastrarViagemClick(Sender: TObject);
begin
  begin
  DM.FDQViagem.Close;
  DM.FDQViagem.Open();

  if (EditOrigemViagem.text = EmptyStr) or (EditDestinoViagem.text = EmptyStr)
  then
    Abort;

  DM.FDQViagem.Append;
  DM.FDQViagemorigem.AsString := EditOrigemViagem.text;
  DM.FDQViagemdestino.AsString := EditDestinoViagem.text;
  DM.FDQViagemvalorgasolina.AsString := EditValorGasolina.text;
  DM.FDQViagemvaloretanol.AsString := EditValorEtanol.text;
  DM.FDQViagemvalordiesel.AsString := EditValorDiesel.text;
  DM.FDQViagem.Post;
  DM.FDConnection1.CommitRetaining;

  ShowMessage('Viagem Cadastrada com Sucesso.');
end;
end;

procedure TFormHome.BtnCadastroClick(Sender: TObject);
begin
  TabCadastro.Execute;
end;

procedure TFormHome.BtnCalcularViagemClick(Sender: TObject);
begin
  FormGPS:=TFormGPS.Create(Application);
  FormGPS.Show();
end;

procedure TFormHome.BtnClearVeiculoClick(Sender: TObject);
begin
  EditPlacaVeiculo.Text := '';
  EditDescricaoVeiculo.Text := '';
  EditTamanhoTanque.Text := '';
  EditMediaGasolina.Text := '';
  EditMediaEtanol.Text := '';
  EditMediaDiesel.Text := '';
  EditPlacaVeiculo.SetFocus;
end;

procedure TFormHome.BtnClearViagemClick(Sender: TObject);
begin
  EditOrigemViagem.Text := '';
  EditDestinoViagem.text := '';
  EditValorGasolina.text := '';
  EditValorEtanol.text := '';
  EditValorDiesel.text := '';
end;

procedure TFormHome.BtnLogarClick(Sender: TObject);
var
  senha: string;
begin
  senha := SHA1(EditSenhaLogin.text);
  DM.FDQLogin.Close;
  DM.FDQLogin.ParamByName('pEmail').AsString := EditEmailLogin.Text;
  DM.FDQLogin.Open();

  if not (DM.FDQLogin.IsEmpty) and (DM.FDQLoginsenha.AsString = senha) then
  begin
    if not Assigned(FormHome) then
    Application.CreateForm(TFormHome, FormHome);
    TabCadVeiculo.Execute;
  end
  else
  begin
    ShowMessage('Email ou senha incorretos');
  end;
end;

procedure TFormHome.FormCreate(Sender: TObject);
begin
  DM.FDQVeiculo.close;
  DM.FDQVeiculo.Open();
  DM.FDQViagem.close;
  DM.FDQViagem.Open();
end;

function TFormHome.SHA1(AString: string): string;
var
  SenhaSH1: TIDhASHsha1;
begin
  SenhaSH1 := TIDhASHsha1.Create;
  try
    Result := SenhaSH1.HashStringAsHex(AString);
  finally
  SenhaSH1.Free;
  end;
end;



end.
