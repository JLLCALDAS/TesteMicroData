program prjClienteContato;

uses
  System.StartUpCopy,
  FMX.Forms,
  uClienteContato in 'uClienteContato.pas' {frmClienteContato};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmClienteContato, frmClienteContato);
  Application.Run;
end.
