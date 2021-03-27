unit uClienteContato;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, System.Rtti, FMX.Grid.Style, FMX.ScrollBox,
  FMX.Grid, Data.DB, ZAbstractConnection, ZConnection, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Controls, Data.Bind.EngExt, Fmx.Bind.DBEngExt,
  Data.Bind.Components, FMX.Layouts, Fmx.Bind.Navigator, Data.Bind.Grid,
  Data.Bind.DBScope, REST.Types, REST.Client, Data.Bind.ObjectScope, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.FMXUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmClienteContato = class(TForm)
    pnlBotom: TPanel;
    dtsCliente: TDataSource;
    dtsContato: TDataSource;
    grdCliente: TGrid;
    grdContato: TGrid;
    bindSourceCliente: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    navCliente: TBindNavigator;
    bindListClienteContato: TBindingsList;
    bindSourceContato: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    Panel1: TPanel;
    navContato: TBindNavigator;
    rResponseIBGE: TRESTResponse;
    rClientIBGE: TRESTClient;
    rRequestIBGE: TRESTRequest;
    cnxClienteContato: TFDConnection;
    qryCliente: TFDQuery;
    qryContato: TFDQuery;
    qryClienteID: TIntegerField;
    qryClienteNOME: TStringField;
    qryClienteCEP: TStringField;
    qryClienteLOGRADOURO: TStringField;
    qryClienteNUMERO: TStringField;
    qryClienteCOMPLEMENTO: TStringField;
    qryClienteCIDADE: TStringField;
    qryClienteIBGE_CIDADE: TStringField;
    qryClienteSIGLA_UF: TStringField;
    qryClienteIBGE_UF: TStringField;
    qryContatoID: TIntegerField;
    qryContatoNOME: TStringField;
    qryContatoDATA_NASC: TSQLTimeStampField;
    qryContatoIDADE: TIntegerField;
    qryContatoTELEFONE: TStringField;
    qryContatoID_CLIENTE: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure qryClienteCEPSetText(Sender: TField; const Text: string);
  private
    function LimparFormatacao(FieldValue: string): string;
  public
    { Public declarations }
  end;

var
  frmClienteContato: TfrmClienteContato;

implementation

{$R *.fmx}

procedure TfrmClienteContato.FormShow(Sender: TObject);
begin
  cnxClienteContato.Connected:=True;
  qryCliente.Open;
  qryContato.Open;

  rClientIBGE.BaseURL:='https://api.postmon.com.br/v1';
  rRequestIBGE.Method:=rmGET;
end;

function TfrmClienteContato.LimparFormatacao(FieldValue: string): string;
var
  vValue: string;
begin
  vValue:=StringReplace(FieldValue,'.','',[rfReplaceAll]);
  vValue:=StringReplace(FieldValue,'-','',[rfReplaceAll]);
  Result:=vValue;
end;

procedure TfrmClienteContato.qryClienteCEPSetText(Sender: TField; const Text: string);
var
  json: TJSONObject;
  JsonCidadeInfo: TJSONObject;
  JsonEstadoInfo: TJSONObject;
  Logradouro: string;
begin
  rRequestIBGE.Resource:='cep/'+LimparFormatacao(Text);
  rRequestIBGE.Execute;
  try
    json:=rResponseIBGE.JSONValue as TJSONObject;
    JsonCidadeInfo:=json.Values['cidade_info'] as TJSONObject;
    JsonEstadoInfo:=json.Values['estado_info'] as TJSONObject;

    if json.Values['logradouro']<>nil then
      Logradouro:=json.Values['logradouro'].Value;
    qryCliente.FieldByName('cep').AsString:=text;
    qryCliente.FieldByName('logradouro').AsString:=Logradouro;
    qryCliente.FieldByName('cidade').AsString:=json.Values['cidade'].Value;
    qryCliente.FieldByName('ibge_cidade').AsString:=JsonCidadeInfo.Values['codigo_ibge'].Value;
    qryCliente.FieldByName('sigla_uf').AsString:=json.Values['estado'].Value;
    qryCliente.FieldByName('ibge_uf').AsString:=JsonEstadoInfo.Values['codigo_ibge'].Value;
  finally

  end;
end;

end.
