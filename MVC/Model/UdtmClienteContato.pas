unit UdtmClienteContato;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, REST.Json,  System.JSON, System.JSON.Builders,
  System.JSON.Writers, System.JSON.Types;

type
  TCliente = record
    id: integer;
    nome: string;
    cep: string;
    logradouro: string;
    numero: string;
    complemento: string;
    cidade: string;
    ibge_cidade: string;
    sigla_uf: string;
    ibge_uf: string;
  end;

  TdtmClienteContato = class(TDataModule)
    cnxClienteContato: TFDConnection;
    qryCliente: TFDQuery;
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
  private
    arrCliente: array of TCliente;
    function VerificaConexao: boolean;
  public
    function ObterJsonCliente(Cliente: string): string;
  end;

var
  dtmClienteContato: TdtmClienteContato;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

const
  SqlLikeCliente='select * from cliente where lower(cliente.nome) like ''%s'' ';

function TdtmClienteContato.ObterJsonCliente(Cliente: string): string;
var
  i: integer;
  jsonClienteMaster: TJSONArray;
  jsonClienteDetail: TJSONObject;
begin
  if VerificaConexao then
  begin
    qryCliente.Close;
    qryCliente.SQL.Clear;
    qryCliente.Open(Format(SqlLikeCliente,['%'+Cliente+'%']));
  end;

  try
    jsonClienteMaster:=TJSONArray.Create;
    qryCliente.First;
    if not qryCliente.IsEmpty then
    begin
      SetLength(arrCliente,qryCliente.RecordCount);
      while not qryCliente.Eof do
      begin
        jsonClienteDetail:=TJSONObject.Create;
        for i:=0 to Pred(qryCliente.Fields.Count) do
          jsonClienteDetail.AddPair(qryCliente.Fields[i].FieldName,qryCliente.Fields[i].Value);
        jsonClienteMaster.AddElement(jsonClienteDetail);
        qryCliente.Next;
      end;
    end
    else
    begin
      jsonClienteDetail.AddPair('Mensagem','Nenhum cliente encontrado. Verifique!!');
      jsonClienteMaster.AddElement(jsonClienteDetail);
    end;

    Result:=jsonClienteMaster.ToString;
  finally
    jsonClienteMaster.Free;
  end;
end;

function TdtmClienteContato.VerificaConexao: boolean;
begin
  if not cnxClienteContato.Connected then
    cnxClienteContato.Connected:=True;
  Result:=cnxClienteContato.Connected;
end;

end.
