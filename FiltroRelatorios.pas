unit FiltroRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, PngSpeedButton, Data.DB, Vcl.Grids, Vcl.DBGrids, frxClass,
  frxExportBaseDialog, frxExportPDF, frxDBSet;

type
  TFormFiltroRelatorios = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    DanfeRelatorio: TEdit;
    ChaveRelatorio: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    DataRelatorio: TDateTimePicker;
    btnPesquisarRelatorio: TPngSpeedButton;
    DBGrid1: TDBGrid;
    GroupBox2: TGroupBox;
    btnImprimir: TPngSpeedButton;
    btnExcluir: TPngSpeedButton;
    btnEditar: TPngSpeedButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    relatorio: TfrxReport;
    frxRelatorioDadosnfe: TfrxDBDataset;
    frxRelatorioDareIva: TfrxDBDataset;
    frxRelatorioDarePauta: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    DateTimePicker1: TDateTimePicker;
    CheckBox1: TCheckBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    EditFecoep: TEdit;
    GroupBox4: TGroupBox;
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnPesquisarRelatorioClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure CheckBox1Click(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFiltroRelatorios: TFormFiltroRelatorios;
  danfe : String;
  chave: String;
  dataEmissao : String;
  mesFecoep : String;
  anoFecoep : String;
  dataEscolhida : String;
  dataVencimento : String;
  fecoepTotal: double;
  fecoep : double;
  sair: Integer;
  dataAtual : String;
  horaAtual : String;
  log : String;
  senhaDigitada : String;
  usuario : String;

implementation

{$R *.dfm}

uses modulo, CarregarXML;

procedure TFormFiltroRelatorios.btnExcluirClick(Sender: TObject);
begin
    senhaDigitada := InputBox('Aten��o',#31+'Insira a senha para confirmar a exclus�o:','');

    dm.queryUsuario.Close;
    dm.queryUsuario.SQL.Clear;
    dm.queryUsuario.SQL.Add('SELECT * FROM usuario WHERE senha = ' + senhaDigitada);
    dm.queryUsuario.Open;

    if dm.queryUsuario.FieldByName('senha').Value <> null then
    begin
       dm.queryDadosNfeDare.Close;
       dm.queryDadosNfeDare.SQL.Clear;
       dm.queryDadosNfeDare.SQL.Add('DELETE FROM dadosnfedare WHERE danfe = ' + DanfeRelatorio.Text);
       dm.queryDadosNfeDare.ExecSQL;

       dm.queryDareIva.Close;
       dm.queryDareIva.SQL.Clear;
       dm.queryDareIva.SQL.Add('DELETE FROM dareiva WHERE danfeIVA = ' + DanfeRelatorio.Text);
       dm.queryDareIva.ExecSQL;

       dm.queryDarePauta.Close;
       dm.queryDarePauta.SQL.Clear;
       dm.queryDarePauta.SQL.Add('DELETE FROM darepauta WHERE danfePAUTA = ' + DanfeRelatorio.Text);
       dm.queryDarePauta.ExecSQL;

       usuario :=  dm.queryUsuario.FieldByName('nome').Value;
       dataAtual := DateToStr(Date());
       horaAtual := TimeToStr(Time());
       log := 'Danfe '+ DanfeRelatorio.Text + ' Exclu�do em '+ dataAtual +' '+ horaAtual + ' pelo usu�rio '+ usuario;
       dm.tb_log.Insert;
       dm.tb_log.FieldByName('log').Value := log;
       dm.tb_log.FieldByName('data').Value := dataAtual;
       dm.tb_log.FieldByName('danfe').Value := DanfeRelatorio.Text;
       dm.tb_log.Post;

       DanfeRelatorio.Text := '';
       ChaveRelatorio.Text := '';
       btnImprimir.Enabled := False;
       btnExcluir.Enabled := False;
       dm.queryDadosNfeDare.Close;
       dm.queryDadosNfeDare.SQL.Clear;
       dm.queryDadosNfeDare.SQL.Add('SELECT * FROM dadosnfedare');
       dm.queryDadosNfeDare.Open;
    end
    else
    begin
        MessageBox(Handle,'Senha Inv�lida, contacte o administrador do sistema.', 'Aten��o', MB_OK);
    end;
end;

procedure TFormFiltroRelatorios.btnImprimirClick(Sender: TObject);
begin

       dm.queryDadosNfeDare.Close;
       dm.queryDadosNfeDare.SQL.Clear;
       dm.queryDadosNfeDare.SQL.Add('SELECT * FROM dadosnfedare WHERE danfe = ' + DanfeRelatorio.Text);
       dm.queryDadosNfeDare.Open;

       dm.queryDareIva.Close;
       dm.queryDareIva.SQL.Clear;
       dm.queryDareIva.SQL.Add('SELECT * FROM dareiva WHERE danfeIVA = ' + DanfeRelatorio.Text);
       dm.queryDareIva.Open;

       dm.queryDarePauta.Close;
       dm.queryDarePauta.SQL.Clear;
       dm.queryDarePauta.SQL.Add('SELECT * FROM darepauta WHERE danfePAUTA = ' + DanfeRelatorio.Text);
       dm.queryDarePauta.Open;

       DanfeRelatorio.Text := '';
       ChaveRelatorio.Text := '';
       btnImprimir.Enabled := False;
       btnExcluir.Enabled := False;

       relatorio.ShowReport();

       dm.queryDadosNfeDare.Close;
       dm.queryDadosNfeDare.SQL.Clear;
       dm.queryDadosNfeDare.SQL.Add('SELECT * FROM dadosnfedare');
       dm.queryDadosNfeDare.Open;
end;

procedure TFormFiltroRelatorios.btnPesquisarRelatorioClick(Sender: TObject);
begin
    fecoepTotal := 0;
    if checkbox1.checked = True then
    begin
      mesFecoep := FormatDateTime('MM',DateTimePicker1.Date);
      anoFecoep := FormatDateTime('yyyy',DateTimePicker1.Date);
      dm.queryDadosNfeDare.Close;
      dm.queryDadosNfeDare.SQL.Clear;
      dm.queryDadosNfeDare.SQL.Add('SELECT * FROM dadosnfedare WHERE YEAR(dataEmissaoDare) = '+QuotedStr(anoFecoep)+' AND MONTH(dataEmissaoDare) = '+QuotedStr(mesFecoep));
      dm.queryDadosNfeDare.Open;

      while not dm.queryDadosNfeDare.Eof  do
      begin
          fecoep := dm.queryDadosNfeDare.FieldByName('fecoep').Value;
          fecoepTotal := fecoepTotal + fecoep;
          dm.queryDadosNfeDare.Next;
      end;
      EditFecoep.Text := FormatFloat('0.00', fecoepTotal);
    end
    else
    begin
      danfe := DanfeRelatorio.Text;
      if danfe <> '' then
      begin
        dm.queryDadosNfeDare.Close;
        dm.queryDadosNfeDare.SQL.Clear;
        dm.queryDadosNfeDare.SQL.Add('SELECT * FROM dadosnfedare WHERE danfe = '+ danfe);
        dm.queryDadosNfeDare.Open;
      end
      else
       begin
       chave := ChaveRelatorio.Text;
       if chave <> '' then
       begin
          dm.queryDadosNfeDare.Close;
          dm.queryDadosNfeDare.SQL.Clear;
          dm.queryDadosNfeDare.SQL.Add('SELECT * FROM dadosnfedare WHERE chaveXML = '+ chave);
          dm.queryDadosNfeDare.Open;
       end
       else
       begin
          if dataEscolhida = 'emissao' then
          begin
          dataEmissao := FormatDateTime('yyyy-MM-dd',DataRelatorio.Date);
          dm.queryDadosNfeDare.Close;
          dm.queryDadosNfeDare.SQL.Clear;
          dm.queryDadosNfeDare.SQL.Add('SELECT * FROM dadosnfedare WHERE DATE(dataEmissaoDare) = '+ QuotedStr(dataEmissao));
          dm.queryDadosNfeDare.Open;
          end;

          if dataEscolhida = 'vencimento' then
          begin
          dataVencimento := FormatDateTime('yyyy-MM-dd',DataRelatorio.Date);
          dm.queryDadosNfeDare.Close;
          dm.queryDadosNfeDare.SQL.Clear;
          dm.queryDadosNfeDare.SQL.Add('SELECT * FROM dadosnfedare WHERE DATE(dataVencimentoDare) = '+ QuotedStr(dataVencimento));
          dm.queryDadosNfeDare.Open;
          end;
       end;
      end;
    end;
end;

procedure TFormFiltroRelatorios.CheckBox1Click(Sender: TObject);
begin
   if checkbox1.checked = True then
   begin
      DanfeRelatorio.Enabled := False;
      ChaveRelatorio.Enabled := False;
      DataRelatorio.Enabled := False;
      EditFecoep.Text := '';
   end;
   if checkbox1.checked = False then
   begin
      DanfeRelatorio.Enabled := True;
      ChaveRelatorio.Enabled := True;
      DataRelatorio.Enabled := True;
      EditFecoep.Text := '';
   end;
end;

procedure TFormFiltroRelatorios.DBGrid1CellClick(Column: TColumn);
begin
  btnImprimir.Enabled := True;
  btnExcluir.Enabled := True;
  if dm.queryDadosNfeDare.FieldByName('danfe').Value <> null then
  begin
  DanfeRelatorio.Text := dm.queryDadosNfeDare.FieldByName('danfe').Value;
  ChaveRelatorio.Text := dm.queryDadosNfeDare.FieldByName('chaveXML').Value;
  end;
  //btnEditar.Enabled := True;
end;

procedure TFormFiltroRelatorios.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    with DBGrid1 do
    begin
        if Odd (DataSource.DataSet.RecNo) then
          Canvas.Brush.Color := clScrollBar
        else
          Canvas.Brush.Color := clWhite;
          canvas.FillRect(Rect);
          DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
end;

procedure TFormFiltroRelatorios.FormShow(Sender: TObject);
begin
btnImprimir.Enabled := False;
btnEditar.Enabled := False;
btnExcluir.Enabled := False;
DataRelatorio.Date := Date();
       dm.queryDadosNfeDare.Close;
       dm.queryDadosNfeDare.SQL.Clear;
       dm.queryDadosNfeDare.SQL.Add('SELECT * FROM dadosnfedare');
       dm.queryDadosNfeDare.Open;
end;

procedure TFormFiltroRelatorios.RadioButton1Click(Sender: TObject);
begin
    dataEscolhida := 'emissao';
end;

procedure TFormFiltroRelatorios.RadioButton2Click(Sender: TObject);
begin
  dataEscolhida := 'vencimento';
end;

end.
