program Caduceu_CalcDare;

uses
  Vcl.Forms,
  CarregarXML in 'CarregarXML.pas' {Form1},
  modulo in 'modulo.pas' {dm: TDataModule},
  FiltroRelatorios in 'FiltroRelatorios.pas' {FormFiltroRelatorios};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFormFiltroRelatorios, FormFiltroRelatorios);
  Application.Run;
end.
