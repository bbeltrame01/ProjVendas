program Projeto_WK;

uses
  Vcl.Forms,
  uvendas in 'uvendas.pas' {fvendas},
  ubuscaprod in 'ubuscaprod.pas' {fbuscaprod},
  trataException in 'trataException.pas',
  udm in 'udm.pas' {dm: TDataModule},
  biblio in 'biblio.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfvendas, fvendas);
  Application.Run;
end.
