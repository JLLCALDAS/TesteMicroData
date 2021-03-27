unit UController;

interface

uses
  MVCFramework, MVCFramework.Commons, MVCFramework.Serializer.Commons;

type

  [MVCPath('/api')]
  TMyController = class(TMVCController) 
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

    [MVCPath('/reversedstrings/($Value)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetReversedString(const Value: String);
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public
    //Sample CRUD Actions for a "cliente" entity
    [MVCPath('/cliente/($cliente)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomer(cliente: string);
  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, UdtmClienteContato;

procedure TMyController.Index;
begin
  //use Context property to access to the HTTP request and response 
  Render('Seja Bem vindo API Cliente/Contato');
end;

procedure TMyController.GetReversedString(const Value: String);
begin
  Render(System.StrUtils.ReverseString(Value.Trim));
end;

procedure TMyController.OnAfterAction(Context: TWebContext; const AActionName: string); 
begin
  { Executed after each action }
  inherited;
end;

procedure TMyController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

procedure TMyController.GetCustomer(cliente: string);
begin
  Render('<h1>JSON Cliente/Contato</h1><br>'+dtmClienteContato.ObterJsonCliente(cliente));
  ContentType:='text/html; json; charset=utf-8';
end;

end.
