unit CarregarXML;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.Imaging.pngimage, Vcl.Buttons,
  Vcl.Menus, Vcl.ComCtrls, Data.DB, Vcl.DBGrids, frxClass, frxExportBaseDialog,
  frxExportPDF, frxDBSet, PngSpeedButton;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    XMLDocument1: TXMLDocument;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Fornecedor: TEdit;
    IE: TEdit;
    DANFE: TEdit;
    UFEmi: TEdit;
    CNPJ: TEdit;
    Label5: TLabel;
    CFOP: TEdit;
    UFDest: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    OpenDialogxml1: TOpenDialog;
    Panel2: TPanel;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    RazaoSocial: TEdit;
    Label9: TLabel;
    CNPJLojaDest: TEdit;
    Label10: TLabel;
    IELoja: TEdit;
    GroupBox3: TGroupBox;
    Label11: TLabel;
    DateEmiss�o: TDateTimePicker;
    Label12: TLabel;
    DateVencimento: TDateTimePicker;
    IVAPAGE: TPageControl;
    TabSheet1: TTabSheet;
    PAUTA: TTabSheet;
    GroupBox5: TGroupBox;
    DBGridPAUTA: TDBGrid;
    Label13: TLabel;
    ValorTotalDare: TEdit;
    DBGridIVA: TDBGrid;
    Panel3: TPanel;
    chaveXml: TEdit;
    Label14: TLabel;
    relatorio: TfrxReport;
    frxRelatorioDadosnfe: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxRelatorioDareIva: TfrxDBDataset;
    frxRelatorioDarePauta: TfrxDBDataset;
    Observa��o: TMemo;
    Label15: TLabel;
    btnImportar: TPngSpeedButton;
    btnCalcular: TPngSpeedButton;
    btnSalvar: TPngSpeedButton;
    btnSair: TPngSpeedButton;
    btnTelaRelatorios: TPngSpeedButton;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridIVADrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGridPAUTADrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure btnCalcularClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnTelaRelatoriosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    procedure associarCampos;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses modulo, FiltroRelatorios;

var nodeInfNfe:IXMLNode;
var nodeDet:IXMLNode;
i : Integer;
j : Integer;
cnpjLoja : string;
quantidade : double;
quantidadeText : string;
valorUnitario : double;
valorUnitarioText : string;
valorTotal : double;
icmsEmit : double;
icmsEmitText: string;
iva : double;
ivaTotal : double;
indice : Integer;
teste : string;
imprimir : Integer;
IcmsDest : double;
IcmsDestTotal : double;
IcmsEmitTotal : double;
StAPagar : double;
ValorTotalPagarIVA : double;
ValorTotalPagarPAUTA : double;
reduFarmaceutica : double;
farmaReduzida : double;
reduFarmaceuticaPorcentagem : double;
reduCestaBasica : double;
reduCestaPorcentagem : double;
reduBebida : double;
reduBebidaPorcentagem : double;
bebidaReduzida : double;
IcmsDestPorcentagem : double;
cnpjTexto : string;
testeVazio : string;

valorPauta : double;
pautaTotal : double;
quantidadeProd : double;
IcmsStTotal : double;
Dare : double;
RedCestaBasicaPorcentagem : double;
RedCestaBasica : double;
RedBebidaPorcen : double;
RedBebida : double;
ReduzidaBebida : double;
danfeConsulta : boolean;
danfeVariavel : string;
sair : Integer;
ValorTotalDa : double;
TotalBaseCalcPauta: double;
TotalBaseCalcIva : double;
totalBaseCalculo : double;
TotalBaseIcmsDest : double;
TotalBaseIcmsEmit : double;
Fecoep : double;
valorTotalup : double;

procedure TForm1.associarCampos;
begin
//EDIT PRODUTOS
    for I := 0 to nodeInfNfe.ChildNodes.Count -1 do
      begin
        dm.tb_gridiva.Insert;
        dm.tb_gridPauta.Insert;
        if nodeInfNfe.ChildNodes[i].NodeName = 'det' then
          begin
            //ASSOCIANDO CAMPOS DO BANCO COM VALORES XML --- IVA
            nodeDet := nodeInfNfe.ChildNodes[i];

            dm.tb_gridiva.FieldByName('idProduto').Value := (nodeDet.Attributes['nItem']);
            dm.tb_gridiva.FieldByName('Produto').Value := (nodeDet.ChildNodes.FindNode('prod').ChildValues['xProd']);

            quantidadeText := (nodeDet.ChildNodes.FindNode('prod').ChildValues['qCom']);
            quantidadeText := StringReplace(quantidadeText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
            quantidade := strToFloat(quantidadeText);
            dm.tb_gridiva.FieldByName('Quantidade').Value := quantidade;

            valorUnitarioText := (nodeDet.ChildNodes.FindNode('prod').ChildValues['vUnCom']);
            valorUnitarioText := StringReplace(valorUnitarioText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
            valorUnitario := strToFloat(valorUnitarioText);
            dm.tb_gridiva.FieldByName('ValorUnitario').Value := valorUnitario;

            valorTotal := quantidade * valorUnitario;
            dm.tb_gridiva.FieldByName('ValorTotal').Value := valorTotal;

            dm.tb_gridiva.FieldByName('Iva').Value := 0;
            dm.tb_gridiva.FieldByName('IvaTotal').Value := 0;
            dm.tb_gridiva.FieldByName('icmsDest').Value := 18;
            dm.tb_gridiva.FieldByName('icmsDestTotal').Value := 0;

            for J := 0 to nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes.Count -1 do
            begin
            if nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes[j].NodeName = 'ICMS00' then
             begin
                icmsEmitText := (nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes.FindNode('ICMS00').ChildValues['pICMS']);
                icmsEmitText := StringReplace(icmsEmitText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
                icmsEmit := strToFloat(icmsEmitText);
                dm.tb_gridiva.FieldByName('icmsEmit').Value := icmsEmit;
                dm.tb_gridPauta.FieldByName('IcmsEmit').Value := icmsEmit;
             end;

            if nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes[j].NodeName = 'ICMS10' then
             begin
                icmsEmitText := (nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes.FindNode('ICMS10').ChildValues['pICMS']);
                icmsEmitText := StringReplace(icmsEmitText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
                icmsEmit := strToFloat(icmsEmitText);
                dm.tb_gridiva.FieldByName('icmsEmit').Value := icmsEmit;
                dm.tb_gridPauta.FieldByName('IcmsEmit').Value := icmsEmit;
             end;

            if nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes[j].NodeName = 'ICMS20' then
             begin
                icmsEmitText := (nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes.FindNode('ICMS20').ChildValues['pICMS']);
                icmsEmitText := StringReplace(icmsEmitText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
                icmsEmit := strToFloat(icmsEmitText);
                dm.tb_gridiva.FieldByName('icmsEmit').Value := icmsEmit;
                dm.tb_gridPauta.FieldByName('IcmsEmit').Value := icmsEmit;
             end;

             if nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes[j].NodeName = 'ICMS30' then
             begin
                icmsEmitText := (nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes.FindNode('ICMS30').ChildValues['pICMS']);
                icmsEmitText := StringReplace(icmsEmitText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
                icmsEmit := strToFloat(icmsEmitText);
                dm.tb_gridiva.FieldByName('icmsEmit').Value := icmsEmit;
                dm.tb_gridPauta.FieldByName('IcmsEmit').Value := icmsEmit;
             end;

             if nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes[j].NodeName = 'ICMS40' then
             begin
                //icmsEmitText := (nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes.FindNode('ICMS40').ChildValues['pICMS']);
                //icmsEmitText := StringReplace(icmsEmitText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
                icmsEmit := 0;
                dm.tb_gridiva.FieldByName('icmsEmit').Value := icmsEmit;
                dm.tb_gridPauta.FieldByName('IcmsEmit').Value := icmsEmit;
             end;

             if nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes[j].NodeName = 'ICMS51' then
             begin
                icmsEmitText := (nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes.FindNode('ICMS51').ChildValues['pICMS']);
                icmsEmitText := StringReplace(icmsEmitText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
                icmsEmit := strToFloat(icmsEmitText);
                dm.tb_gridiva.FieldByName('icmsEmit').Value := icmsEmit;
                dm.tb_gridPauta.FieldByName('IcmsEmit').Value := icmsEmit;
             end;

             if nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes[j].NodeName = 'ICMS60' then
             begin
                icmsEmitText := (nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes.FindNode('ICMS60').ChildValues['pICMS']);
                icmsEmitText := StringReplace(icmsEmitText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
                icmsEmit := strToFloat(icmsEmitText);
                dm.tb_gridiva.FieldByName('icmsEmit').Value := icmsEmit;
                dm.tb_gridPauta.FieldByName('IcmsEmit').Value := icmsEmit;
             end;

             if nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes[j].NodeName = 'ICMS70' then
             begin
                icmsEmitText := (nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes.FindNode('ICMS70').ChildValues['pICMS']);
                icmsEmitText := StringReplace(icmsEmitText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
                icmsEmit := strToFloat(icmsEmitText);
                dm.tb_gridiva.FieldByName('icmsEmit').Value := icmsEmit;
                dm.tb_gridPauta.FieldByName('IcmsEmit').Value := icmsEmit;
             end;

             if nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes[j].NodeName = 'ICMS90' then
             begin
                icmsEmitText := (nodeDet.ChildNodes.FindNode('imposto').ChildNodes.FindNode('ICMS').ChildNodes.FindNode('ICMS90').ChildValues['pICMS']);
                icmsEmitText := StringReplace(icmsEmitText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
                icmsEmit := strToFloat(icmsEmitText);
                dm.tb_gridiva.FieldByName('icmsEmit').Value := icmsEmit;
                dm.tb_gridPauta.FieldByName('IcmsEmit').Value := icmsEmit;
             end;

            end;

            dm.tb_gridiva.FieldByName('icmsEmitTotal').Value := 0;
            dm.tb_gridiva.FieldByName('reduFarmaceutica').Value := 0;
            dm.tb_gridiva.FieldByName('reduCestaBasica').Value := 0;
            dm.tb_gridiva.FieldByName('reduBebida').Value := 0;
            dm.tb_gridiva.FieldByName('stIva').Value := 0;
            dm.tb_gridiva.Post;
            //FIM IVA


            //ASSOCIANDO CAMPOS DO BANCO COM VALORES XML --- PAUTA

            dm.tb_gridPauta.FieldByName('idProduto').Value := (nodeDet.Attributes['nItem']);
            dm.tb_gridPauta.FieldByName('Produto').Value := (nodeDet.ChildNodes.FindNode('prod').ChildValues['xProd']);

            quantidadeText := (nodeDet.ChildNodes.FindNode('prod').ChildValues['qCom']);
            quantidadeText := StringReplace(quantidadeText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
            quantidade := strToFloat(quantidadeText);
            dm.tb_gridPauta.FieldByName('Quantidade').Value := quantidade;

            valorUnitarioText := (nodeDet.ChildNodes.FindNode('prod').ChildValues['vUnCom']);
            valorUnitarioText := StringReplace(valorUnitarioText, '.', ',',[rfReplaceAll, rfIgnoreCase]);
            valorUnitario := strToFloat(valorUnitarioText);
            dm.tb_gridPauta.FieldByName('ValorUnitario').Value := valorUnitario;

            valorTotal := quantidade * valorUnitario;
            dm.tb_gridPauta.FieldByName('ValorTotal').Value := valorTotal;

            dm.tb_gridPauta.FieldByName('Pauta').Value := 0;
            dm.tb_gridPauta.FieldByName('PautaTotal').Value := 0;
            dm.tb_gridPauta.FieldByName('IcmsDest').Value := 18;
            dm.tb_gridPauta.FieldByName('IcmsDestTotal').Value := 0;

            dm.tb_gridPauta.FieldByName('IcmsEmitTotal').Value := 0;
            dm.tb_gridPauta.FieldByName('IcmsStTotal').Value := 0;
            dm.tb_gridPauta.FieldByName('RedCestaBasica').Value := 0;
            dm.tb_gridPauta.FieldByName('RedBebida').Value := 0;
            dm.tb_gridPauta.FieldByName('ValorDare').Value := 0;
            dm.tb_gridPauta.Post;
          end;
      end;
end;

procedure TForm1.DBGridPAUTADrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    with DBGridPAUTA do
    begin
        if Odd (DataSource.DataSet.RecNo) then
          Canvas.Brush.Color := clScrollBar
        else
          Canvas.Brush.Color := clWhite;
          canvas.FillRect(Rect);
          DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
end;

procedure TForm1.btnCalcularClick(Sender: TObject);
begin
    ValorTotalPagarPauta := 0;
    ValorTotalPagarIVA := 0;
    TotalBaseCalcIva := 0;
    TotalBaseIcmsDest := 0;
    TotalBaseIcmsEmit := 0;
    TotalBaseCalcPauta := 0;
    TotalBaseCalcIva := 0;
    //EDITANDO OS CAMPOS IVA
    if dm.queryIVACALC.FieldByName('Iva').Value <> null then
     begin
     dm.queryIVACALC.edit;

     dm.queryIVACALC.FieldByName('Quantidade').Value := DBGridIVA.Fields[2].Value;
     dm.queryIVACALC.FieldByName('ValorUnitario').Value := DBGridIVA.Fields[3].Value;
     valorTotalup :=  StrToFloat(DBGridIVA.Fields[2].Value) * StrToFloat(DBGridIVA.Fields[3].Value);
     dm.queryIVACALC.FieldByName('ValorTotal').Value := valorTotalup;
     dm.queryIVACALC.FieldByName('Iva').Value := DBGridIVA.Fields[8].Value;
     dm.queryIVACALC.FieldByName('reduFarmaceutica').Value :=  DBGridIVA.Fields[9].Value;
     dm.queryIVACALC.FieldByName('reduCestaBasica').Value :=  DBGridIVA.Fields[10].Value;
     dm.queryIVACALC.FieldByName('reduBebida').Value :=  DBGridIVA.Fields[11].Value;
     dm.queryIVACALC.Post;
     dm.queryIVACALC.ApplyUpdates();
     dm.queryIVACALC.CommitUpdates;
     dm.queryIVACALC.edit;
     end;

    //EDITANDO OS CAMPOS PAUTA
    if dm.queryPAUTACALC.FieldByName('Pauta').Value <> null then
    begin
    dm.queryPAUTACALC.edit;
    dm.queryPAUTACALC.FieldByName('Quantidade').Value := DBGridPAUTA.Fields[2].Value;
    dm.queryPAUTACALC.FieldByName('ValorUnitario').Value := DBGridPAUTA.Fields[3].Value;
    valorTotalup := StrToFloat(DBGridPAUTA.Fields[2].Value) * StrToFloat(DBGridPAUTA.Fields[3].Value);
    dm.queryPAUTACALC.FieldByName('ValorTotal').Value := valorTotalup;
    dm.queryPAUTACALC.FieldByName('Pauta').Value := DBGridPAUTA.Fields[8].Value;
    dm.queryPAUTACALC.FieldByName('RedCestaBasica').Value :=  DBGridPAUTA.Fields[9].Value;
    dm.queryPAUTACALC.FieldByName('RedBebida').Value :=  DBGridPAUTA.Fields[10].Value;
    dm.queryPAUTACALC.Post;
    dm.queryPAUTACALC.ApplyUpdates();
    dm.queryPAUTACALC.CommitUpdates;
    dm.queryPAUTACALC.edit;
    end;

    //SELECT PARA TRAZER TODOS OS CAMPOS
    ValorTotalPagarIVA := 0;
    ValorTotalPagarPAUTA := 0;
    dm.queryIVACALC.Close;
    dm.queryIVACALC.SQL.Clear;
    dm.queryIVACALC.SQL.Add('SELECT * FROM dbgridiva');
    dm.queryIVACALC.Open;
    dm.queryIVACALC.First;

    dm.queryPAUTACALC.Close;
    dm.queryPAUTACALC.SQL.Clear;
    dm.queryPAUTACALC.SQL.Add('SELECT * FROM dbgridpauta');
    dm.queryPAUTACALC.Open;
    dm.queryPAUTACALC.First;

  //PERCORRER TODA TABELA E REALIZAR OS CALCULOS IVA
   while not dm.queryIVACALC.Eof  do
      begin
          //CALCULO IVA TOTAL
          dm.queryIVACALC.Edit;
          iva := dm.queryIVACALC.FieldByName('Iva').value;
          if iva > 0 then
            begin
                valorTotal := dm.queryIVACALC.FieldByName('ValorTotal').value;
                ivaTotal := (iva/100)* valorTotal + valorTotal;

               //CALCULO REDU��O FARMACEUTICA
                reduFarmaceutica := dm.queryIVACALC.FieldByName('reduFarmaceutica').value;
                reduFarmaceuticaPorcentagem := reduFarmaceutica / 100;
                farmaReduzida :=  ivaTotal - (reduFarmaceuticaPorcentagem * ivaTotal) ;

               //CALCULO ICMS DESTINATARIO TOTAL
                IcmsDest := dm.queryIVACALC.FieldByName('IcmsDest').value;
                IcmsDestTotal :=  (farmaReduzida*IcmsDest) / 100;

                //CAMPO REDU��O CESTA E REDU��O BEBIDA
                reduCestaBasica := dm.queryIVACALC.FieldByName('reduCestaBasica').value;
                reduCestaPorcentagem  :=  reduCestaBasica/100;

                reduBebida := dm.queryIVACALC.FieldByName('reduBebida').value;
                reduBebidaPorcentagem  :=  reduBebida/100;
                Fecoep := Fecoep + (ivaTotal * reduBebidaPorcentagem);


                //CALCULO ICMS EMIT_TOTAL
                icmsEmit := dm.queryIVACALC.FieldByName('IcmsEmit').value;
                IcmsEmitTotal := (valorTotal * icmsEmit)/100;

                //CALCULO ST A PAGAR POR PRODUTO
                StAPagar := IcmsDestTotal - IcmsEmitTotal;

                if reduCestaPorcentagem > 0 then
                  begin
                    StApagar := StAPagar - (reduCestaPorcentagem * StAPagar) ;
                  end;

                if reduBebidaPorcentagem > 0 then
                  begin
                    bebidaReduzida := IcmsEmitTotal - (reduBebidaPorcentagem * IcmsEmitTotal);
                    IcmsDestPorcentagem := IcmsDest/100;
                    StApagar := (ivaTotal * IcmsDestPorcentagem) - bebidaReduzida;

                    TotalBaseIcmsEmit := TotalBaseIcmsEmit + bebidaReduzida;
                  end
                else
                  begin
                    TotalBaseIcmsEmit := TotalBaseIcmsEmit + IcmsEmitTotal;
                  end;


                //ATUALIZANDO DADOS NA TABELA

                dm.queryIVACALC.FieldByName('IcmsEmitTotal').Value :=  IcmsEmitTotal;
                dm.queryIVACALC.FieldByName('IcmsDestTotal').Value :=  IcmsDestTotal;
                dm.queryIVACALC.FieldByName('IvaTotal').Value :=  ivaTotal;
                dm.queryIVACALC.FieldByName('StIva').Value :=  StAPagar;
                dm.queryIVACALC.Post;
                dm.queryIVACALC.ApplyUpdates();
                dm.queryIVACALC.CommitUpdates;

                ValorTotalPagarIVA := ValorTotalPagarIVA + StAPagar;
                TotalBaseCalcIva :=  TotalBaseCalcIva + farmaReduzida;
                TotalBaseIcmsDest := TotalBaseIcmsDest + IcmsDestTotal;


            end;
            dm.queryIVACALC.next;
      end;

      //FIM IVA
      ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      //PERCORRER TODA TABELA E REALIZAR OS CALCULOS PAUTA
      while not dm.queryPAUTACALC.Eof  do
      begin
          //CALCULO IVA TOTAL
          dm.queryPAUTACALC.Edit;
          valorPauta := dm.queryPAUTACALC.FieldByName('Pauta').value;
          valorTotal := dm.queryPAUTACALC.FieldByName('ValorTotal').value;
          if valorPauta > 0 then
            begin
                quantidadeProd := dm.queryPAUTACALC.FieldByName('Quantidade').value;
                pautaTotal := valorPauta * quantidadeProd;

                //CALCULO ICMS DESTINATARIO TOTAL
                IcmsDest := dm.queryPAUTACALC.FieldByName('IcmsDest').value;
                IcmsDestTotal :=  (pautaTotal*IcmsDest) / 100;

                //REDU��O BEBIDA
                RedBebida := dm.queryPAUTACALC.FieldByName('RedBebida').value;
                RedBebidaPorcen :=  RedBebida/100;
                icmsEmit := dm.queryPAUTACALC.FieldByName('IcmsEmit').value;
                IcmsEmitTotal := (valorTotal * icmsEmit)/100;
                ReduzidaBebida :=  IcmsEmitTotal - (IcmsEmitTotal * RedBebidaPorcen);
                Fecoep := Fecoep + (pautaTotal * RedBebidaPorcen);

                //CALCULO ST ICMS CRED EMIT
                IcmsStTotal := IcmsDestTotal - ReduzidaBebida;

                //REDU��O CESTA BASICA
                RedCestaBasica := dm.queryPAUTACALC.FieldByName('RedCestaBasica').value;
                RedCestaBasicaPorcentagem :=  RedCestaBasica/100;

                //CALCULO DARE
                Dare :=   IcmsStTotal - (RedCestaBasicaPorcentagem * IcmsStTotal);

                //ATUALIZANDO DADOS NA TABELA
                dm.queryPAUTACALC.FieldByName('IcmsEmitTotal').Value := IcmsEmitTotal;
                dm.queryPAUTACALC.FieldByName('pautaTotal').Value :=  pautaTotal;
                dm.queryPAUTACALC.FieldByName('IcmsDestTotal').Value := IcmsDestTotal;
                dm.queryPAUTACALC.FieldByName('IcmsStTotal').Value := IcmsStTotal;
                dm.queryPAUTACALC.FieldByName('ValorDare').Value := Dare;
                dm.queryPAUTACALC.Post;
                dm.queryPAUTACALC.ApplyUpdates();
                dm.queryPAUTACALC.CommitUpdates;


                ValorTotalPagarPauta := ValorTotalPagarPauta + Dare;
                TotalBaseCalcPauta :=  TotalBaseCalcPauta + pautaTotal;
                TotalBaseIcmsDest := TotalBaseIcmsDest + IcmsDestTotal;
                TotalBaseIcmsEmit := TotalBaseIcmsEmit + ReduzidaBebida;
            end;
            dm.queryPAUTACALC.next;
      end;

      ValorTotalDa := ValorTotalPagarIVA + ValorTotalPagarPAUTA;
      ValorTotalDare.Text := FormatFloat('0.00', ValorTotalDa);

      dm.queryIVACALC.Close;
      dm.queryIVACALC.SQL.Clear;
      dm.queryIVACALC.SQL.Add('SELECT * FROM dbgridiva WHERE Iva > 0');
      dm.queryIVACALC.Open;
      dm.queryIVACALC.First;

      dm.queryPAUTACALC.Close;
      dm.queryPAUTACALC.SQL.Clear;
      dm.queryPAUTACALC.SQL.Add('SELECT * FROM dbgridpauta WHERE Pauta > 0');
      dm.queryPAUTACALC.Open;
      dm.queryPAUTACALC.First;

      if dm.queryIVACALC.FieldByName('Iva').Value or dm.queryPAUTACALC.FieldByName('Pauta').Value <> null  then
      begin
          btnSalvar.Enabled := True;
         MessageBox(handle,'Calculo realizado, por gentileza conferir.', 'Aten��o', MB_ICONINFORMATION);
      end;

      if dm.queryIVACALC.FieldByName('Iva').Value = null  then
      begin
        if dm.queryPAUTACALC.FieldByName('Pauta').Value = null  then
        begin
          dm.queryIVACALC.Close;
          dm.queryIVACALC.SQL.Clear;
          dm.queryIVACALC.SQL.Add('SELECT * FROM dbgridiva');
          dm.queryIVACALC.Open;

          dm.queryPAUTACALC.Close;
          dm.queryPAUTACALC.SQL.Clear;
          dm.queryPAUTACALC.SQL.Add('SELECT * FROM dbgridpauta');
          dm.queryPAUTACALC.Open;

          MessageBox(handle,'Nenhum produto preenchido, por gentileza verificar.', 'Aten��o', MB_ICONINFORMATION);
        end;
      end;
end;

procedure TForm1.btnImportarClick(Sender: TObject);
begin
    //Abrir XML
    if OpenDialogxml1.execute then
    begin
      XMLDocument1.LoadFromFile(OpenDialogxml1.FileName);
    end;

    //MAPEAMENTO XML
    nodeInfNfe := XMLDocument1.ChildNodes.FindNode('nfeProc').ChildNodes.FindNode('NFe').ChildNodes.FindNode('infNFe');

    //VALIDA��O DA CHAVE PRIM�RIA DANFE
    danfeVariavel := (nodeInfNfe.ChildNodes.FindNode('ide').ChildValues['nNF']);

    dm.queryDadosNfeDare.Close;
    dm.queryDadosNfeDare.SQL.Clear;
    dm.queryDadosNfeDare.SQL.Add('SELECT * FROM dadosnfedare WHERE danfe = '+danfeVariavel);
    dm.queryDadosNfeDare.Open;

    if dm.queryDadosNfeDare.FieldByName('danfe').value <> StrToInt(danfeVariavel) then
    begin
    //EDIT
    Fornecedor.text := (nodeInfNfe.ChildNodes.FindNode('emit').ChildValues['xNome']);
    IE.text    := (nodeInfNfe.ChildNodes.FindNode('emit').ChildValues['IE']);
    DANFE.text := (nodeInfNfe.ChildNodes.FindNode('ide').ChildValues['nNF']);
    UFEmi.text := (nodeInfNfe.ChildNodes.FindNode('emit').ChildNodes.FindNode('enderEmit').ChildValues['UF']);
    CNPJ.text := (nodeInfNfe.ChildNodes.FindNode('emit').ChildValues['CNPJ']);
    CFOP.text  := (nodeInfNfe.ChildNodes.FindNode('det').ChildNodes.FindNode('prod').ChildValues['CFOP']);
    UFDest.text := (nodeInfNfe.ChildNodes.FindNode('dest').ChildNodes.FindNode('enderDest').ChildValues['UF']);
    cnpjLoja := (nodeInfNfe.ChildNodes.FindNode('dest').ChildValues['CNPJ']);
    CNPJLojaDest.text := cnpjLoja;

    //COMPARANDO CNPJ E INSERINDO NO CAMPO RAZ�O SOCIAL
    dm.queryLojas.Close;
    dm.queryLojas.SQL.Clear;
    dm.queryLojas.SQL.Add('SELECT * FROM lojas WHERE cnpj = '+ cnpjLoja);
    dm.queryLojas.Open;
    RazaoSocial.text := dm.queryLojas.FieldByName('raz�oSocial').value;

    IELoja.text := (nodeInfNfe.ChildNodes.FindNode('dest').ChildValues['IE']);
    chaveXml.text := (XMLDocument1.ChildNodes.FindNode('nfeProc').ChildNodes.FindNode('protNFe').ChildNodes.FindNode('infProt').ChildValues['chNFe']);

    //DateVencimento.Date := dm.queryLojas.FieldByName('dataVencimento').value;

    //deletando tudo no banco
    dm.queryIVACALC.Close;
    dm.queryIVACALC.SQL.Clear;
    dm.queryIVACALC.SQL.Add('DELETE FROM `dbcaduceu_novo`.`dbgridiva`');
    dm.queryIVACALC.ExecSQL;

    dm.queryPAUTACALC.Close;
    dm.queryPAUTACALC.SQL.Clear;
    dm.queryPAUTACALC.SQL.Add('DELETE FROM `dbcaduceu_novo`.`dbgridpauta`');
    dm.queryPAUTACALC.ExecSQL;
    ValorTotalDare.Text := '';

    //associando campos no banco
    associarCampos;
    Fecoep := 0;
    //realizando select para trazer os dados para a grid
    dm.queryIVACALC.Close;
    dm.queryIVACALC.SQL.Clear;
    dm.queryIVACALC.SQL.Add('SELECT * FROM dbgridiva');
    dm.queryIVACALC.Open;
    dm.queryIVACALC.First;
    dm.queryIVACALC.edit;

    dm.queryPAUTACALC.Close;
    dm.queryPAUTACALC.SQL.Clear;
    dm.queryPAUTACALC.SQL.Add('SELECT * FROM dbgridpauta');
    dm.queryPAUTACALC.Open;
    dm.queryPAUTACALC.First;
    dm.queryPAUTACALC.edit;

    Observa��o.Text := '';
    btnCalcular.Enabled := True;
    MessageBox(handle,'XML importado com sucesso.', 'Aten��o', MB_ICONINFORMATION);
    end;
    if dm.queryDadosNfeDare.FieldByName('danfe').value = StrToInt(danfeVariavel) then
    begin
       MessageBox(handle,'XML j� cadastrado na base de dados', 'Aten��o', MB_ICONINFORMATION);
    end;

end;

procedure TForm1.btnSairClick(Sender: TObject);
begin
    sair := MessageBox(Handle,'Deseja sair? Todos os dados n�o salvos ser�o perdidos.', 'Aten��o', MB_YESNO);

    if sair = 6 then
    begin
       PostMessage(FindWindow(nil, 'Caduceu - Calc Dare'), WM_CLOSE, 0, 0);
    end;
end;

procedure TForm1.btnSalvarClick(Sender: TObject);
begin
    totalBaseCalculo := 0;
    //INSER��O NA TABELA dadosnfedare
    dm.tb_dadosnfedare.Insert;
    dm.tb_dadosnfedare.FieldByName('danfe').Value := StrToInt(DANFE.Text);
    dm.tb_dadosnfedare.FieldByName('chaveXML').Value := chaveXml.Text;
    dm.tb_dadosnfedare.FieldByName('fornecedor').Value := Fornecedor.Text;
    dm.tb_dadosnfedare.FieldByName('cnpjFornecedor').Value := CNPJ.Text;
    dm.tb_dadosnfedare.FieldByName('ieFornecedor').Value := IE.Text;
    dm.tb_dadosnfedare.FieldByName('cfop').Value := CFOP.Text;
    dm.tb_dadosnfedare.FieldByName('ufEmitente').Value := UFEmi.Text;
    dm.tb_dadosnfedare.FieldByName('ufDestinatario').Value := UFDest.Text;
    dm.tb_dadosnfedare.FieldByName('razaoSocialDestinatario').Value := RazaoSocial.Text;
    dm.tb_dadosnfedare.FieldByName('cnpjDestinatario').Value := CNPJLojaDest.Text;
    dm.tb_dadosnfedare.FieldByName('ieDestinatario').Value := IELoja.Text;
    dm.tb_dadosnfedare.FieldByName('dataEmissaoDare').Value :=  DateToStr(DateEmiss�o.Date);
    dm.tb_dadosnfedare.FieldByName('dataVencimentoDare').Value := DateToStr(DateVencimento.Date);
    dm.tb_dadosnfedare.FieldByName('observacao').Value := Observa��o.Text;
    dm.tb_dadosnfedare.FieldByName('totalDare').Value := ValorTotalDare.Text;
    dm.tb_dadosnfedare.FieldByName('status').Value := 'GERADO';
    dm.tb_dadosnfedare.FieldByName('fecoep').Value := Fecoep;

    totalBaseCalculo := TotalBaseCalcPauta + TotalBaseCalcIva;
    dm.tb_dadosnfedare.FieldByName('totalBaseCalculo').Value := totalBaseCalculo;
    dm.tb_dadosnfedare.FieldByName('totalIcmsDestTotal').Value := TotalBaseIcmsDest;
    dm.tb_dadosnfedare.FieldByName('totalCredIcmsEmit').Value := TotalBaseIcmsEmit;
    dm.tb_dadosnfedare.Post;

    //INSER��O NA TABELA dareiva
    while not dm.queryIVACALC.Eof  do
    begin
    iva := dm.queryIVACALC.FieldByName('Iva').value;
    if iva > 0 then
      begin
        dm.tb_dareiva.Insert;
        dm.tb_dareiva.FieldByName('danfeIVA').Value := DANFE.Text;
        dm.tb_dareiva.FieldByName('chaveXMLIVA').Value := chaveXml.Text;
        dm.tb_dareiva.FieldByName('produto').Value :=  DBGridIVA.Fields[1].Value;
        dm.tb_dareiva.FieldByName('quantidade').Value :=  DBGridIVA.Fields[2].Value;
        dm.tb_dareiva.FieldByName('valorUnitario').Value :=  DBGridIVA.Fields[3].Value;
        dm.tb_dareiva.FieldByName('valorTotal').Value :=  DBGridIVA.Fields[4].Value;
        dm.tb_dareiva.FieldByName('icmsDest').Value :=  DBGridIVA.Fields[5].Value;
        dm.tb_dareiva.FieldByName('icmsEmit').Value :=  DBGridIVA.Fields[6].Value;
        dm.tb_dareiva.FieldByName('baseIcmsEmit').Value := DBGridIVA.Fields[7].Value;
        dm.tb_dareiva.FieldByName('baseIcmsDest').Value := DBGridIVA.Fields[13].Value;
        dm.tb_dareiva.FieldByName('iva').Value :=  DBGridIVA.Fields[8].Value;
        dm.tb_dareiva.FieldByName('baseIva').Value :=  DBGridIVA.Fields[12].Value;
        dm.tb_dareiva.FieldByName('reduFarmaceutica').Value :=  DBGridIVA.Fields[9].Value;
        dm.tb_dareiva.FieldByName('reduCestaBasica').Value :=   DBGridIVA.Fields[10].Value;
        dm.tb_dareiva.FieldByName('reduBebida').Value :=  DBGridIVA.Fields[11].Value;
        dm.tb_dareiva.FieldByName('valorDare').Value :=  DBGridIVA.Fields[14].Value;
       dm.tb_dareiva.Post;
      end;
    dm.queryIVACALC.next;
    end;

    //INSER��O NA TABELA darepauta
    while not dm.queryPAUTACALC.Eof  do
    begin
      valorPauta := dm.queryPAUTACALC.FieldByName('Pauta').value;
      if valorPauta > 0 then
      begin
        dm.tb_darepauta.Insert;
        dm.tb_darepauta.FieldByName('danfePAUTA').Value :=  DANFE.Text;
        dm.tb_darepauta.FieldByName('chaveXMLPAUTA').Value := chaveXml.Text;
        dm.tb_darepauta.FieldByName('produto').Value := DBGridPAUTA.Fields[1].Value;
        dm.tb_darepauta.FieldByName('quantidade').Value := DBGridPAUTA.Fields[2].Value;
        dm.tb_darepauta.FieldByName('valorUnitario').Value :=  DBGridPAUTA.Fields[3].Value;
        dm.tb_darepauta.FieldByName('valorTotal').Value :=  DBGridPAUTA.Fields[4].Value;
        dm.tb_darepauta.FieldByName('icmsDest').Value :=  DBGridPAUTA.Fields[5].Value;
        dm.tb_darepauta.FieldByName('icmsEmit').Value :=   DBGridPAUTA.Fields[6].Value;
        dm.tb_darepauta.FieldByName('baseIcmsDest').Value :=  DBGridPAUTA.Fields[12].Value;
        dm.tb_darepauta.FieldByName('baseIcmsEmit').Value := DBGridPAUTA.Fields[7].Value;
        dm.tb_darepauta.FieldByName('pauta').Value := DBGridPAUTA.Fields[8].Value;
        dm.tb_darepauta.FieldByName('basePauta').Value := DBGridPAUTA.Fields[11].Value;
        dm.tb_darepauta.FieldByName('reduCestaBasica').Value := DBGridPAUTA.Fields[9].Value;
        dm.tb_darepauta.FieldByName('reduBebida').Value :=  DBGridPAUTA.Fields[10].Value;
        dm.tb_darepauta.FieldByName('credEmitStDest').Value :=  DBGridPAUTA.Fields[13].Value;
        dm.tb_darepauta.FieldByName('valorDare').Value :=  DBGridPAUTA.Fields[14].Value;
        dm.tb_darepauta.Post;
      end;
    dm.queryPAUTACALC.next;
    end;

    imprimir := MessageBox(Handle,'Deseja imprimir o relat�rio detalhado?', 'Salvo com sucesso!', MB_YESNO);

    if imprimir = 6 then
    begin
       dm.queryDadosNfeDare.Close;
       dm.queryDadosNfeDare.SQL.Clear;
       dm.queryDadosNfeDare.SQL.Add('SELECT * FROM dadosnfedare WHERE danfe = ' +DANFE.Text);
       dm.queryDadosNfeDare.Open;

       dm.queryDareIva.Close;
       dm.queryDareIva.SQL.Clear;
       dm.queryDareIva.SQL.Add('SELECT * FROM dareiva WHERE danfeIVA = ' +DANFE.Text);
       dm.queryDareIva.Open;

       dm.queryDarePauta.Close;
       dm.queryDarePauta.SQL.Clear;
       dm.queryDarePauta.SQL.Add('SELECT * FROM darepauta WHERE danfePAUTA = ' +DANFE.Text);
       dm.queryDarePauta.Open;

       relatorio.ShowReport();
    end;

    //ZERANDO TUDO DEPOIS DE SALVAR
    btnSalvar.Enabled := False;
    btnCalcular.Enabled := False;

    DANFE.Text := '';
    chaveXml.Text  := '';
    Fornecedor.Text  := '';
    CNPJ.Text := '';
    IE.Text  := '';
    CFOP.Text  := '';
    UFEmi.Text  := '';
    UFDest.Text  := '';
    RazaoSocial.Text  := '';
    CNPJLojaDest.Text := '';
    IELoja.Text  := '';
    ValorTotalDare.Text := '';
    Observa��o.Text := '';

    dm.queryIVACALC.Close;
    dm.queryIVACALC.SQL.Clear;
    dm.queryIVACALC.SQL.Add('DELETE FROM `dbcaduceu_novo`.`dbgridiva`');
    dm.queryIVACALC.ExecSQL;

    dm.queryPAUTACALC.Close;
    dm.queryPAUTACALC.SQL.Clear;
    dm.queryPAUTACALC.SQL.Add('DELETE FROM `dbcaduceu_novo`.`dbgridpauta`');
    dm.queryPAUTACALC.ExecSQL;
    ValorTotalDare.Text := '';
end;

procedure TForm1.btnTelaRelatoriosClick(Sender: TObject);
begin
    FormFiltroRelatorios := TFormFiltroRelatorios.Create(self);
    FormFiltroRelatorios.ShowModal;
end;

procedure TForm1.DBGridIVADrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    with DBGridIVA do
    begin
        if Odd (DataSource.DataSet.RecNo) then
          Canvas.Brush.Color := clScrollBar
        else
          Canvas.Brush.Color := clWhite;
          canvas.FillRect(Rect);
          DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    dm.queryIVACALC.Close;
    dm.queryIVACALC.SQL.Clear;
    dm.queryIVACALC.SQL.Add('DELETE FROM `dbcaduceu_novo`.`dbgridiva`');
    dm.queryIVACALC.ExecSQL;

    dm.queryPAUTACALC.Close;
    dm.queryPAUTACALC.SQL.Clear;
    dm.queryPAUTACALC.SQL.Add('DELETE FROM `dbcaduceu_novo`.`dbgridpauta`');
    dm.queryPAUTACALC.ExecSQL;
    ValorTotalDare.Text := '';
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  dm.tb_gridiva.Active := true;
  dm.tb_gridPauta.Active := true;
  dm.tb_dadosnfedare.Active := true;
  dm.tb_dareiva.Active := true;
  dm.tb_darepauta.Active := true;
  Observa��o.Text := '';
  DateEmiss�o.Date := Date();
  btnSalvar.Enabled := False;
  btnCalcular.Enabled := False;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
     //INSER��O NA TABELA dadosnfedare
    dm.tb_dadosnfedare.Insert;
    dm.tb_dadosnfedare.FieldByName('danfe').Value := StrToInt(DANFE.Text);
    dm.tb_dadosnfedare.FieldByName('chaveXML').Value := chaveXml.Text;
    dm.tb_dadosnfedare.FieldByName('fornecedor').Value := Fornecedor.Text;
    dm.tb_dadosnfedare.FieldByName('cnpjFornecedor').Value := CNPJ.Text;
    dm.tb_dadosnfedare.FieldByName('ieFornecedor').Value := IE.Text;
    dm.tb_dadosnfedare.FieldByName('cfop').Value := CFOP.Text;
    dm.tb_dadosnfedare.FieldByName('ufEmitente').Value := UFEmi.Text;
    dm.tb_dadosnfedare.FieldByName('ufDestinatario').Value := UFDest.Text;
    dm.tb_dadosnfedare.FieldByName('razaoSocialDestinatario').Value := RazaoSocial.Text;
    dm.tb_dadosnfedare.FieldByName('cnpjDestinatario').Value := CNPJLojaDest.Text;
    dm.tb_dadosnfedare.FieldByName('ieDestinatario').Value := IELoja.Text;
    dm.tb_dadosnfedare.FieldByName('dataEmissaoDare').Value :=  DateToStr(DateEmiss�o.Date);
    dm.tb_dadosnfedare.FieldByName('dataVencimentoDare').Value := DateToStr(DateVencimento.Date);
    dm.tb_dadosnfedare.FieldByName('observacao').Value := Observa��o.Text;
    dm.tb_dadosnfedare.FieldByName('totalDare').Value := ValorTotalDare.Text;
    dm.tb_dadosnfedare.Post;

    //INSER��O NA TABELA dareiva
    while not dm.queryIVACALC.Eof  do
    begin
    iva := dm.queryIVACALC.FieldByName('Iva').value;
    if iva > 0 then
      begin
        dm.tb_dareiva.Insert;
        dm.tb_dareiva.FieldByName('danfeIVA').Value := DANFE.Text;
        dm.tb_dareiva.FieldByName('chaveXMLIVA').Value := chaveXml.Text;
        dm.tb_dareiva.FieldByName('produto').Value :=  DBGridIVA.Fields[1].Value;
        dm.tb_dareiva.FieldByName('quantidade').Value :=  DBGridIVA.Fields[2].Value;
        dm.tb_dareiva.FieldByName('valorUnitario').Value :=  DBGridIVA.Fields[3].Value;
        dm.tb_dareiva.FieldByName('valorTotal').Value :=  DBGridIVA.Fields[4].Value;
        dm.tb_dareiva.FieldByName('icmsDest').Value :=  DBGridIVA.Fields[5].Value;
        dm.tb_dareiva.FieldByName('icmsEmit').Value :=  DBGridIVA.Fields[6].Value;
        dm.tb_dareiva.FieldByName('baseIcmsEmit').Value := DBGridIVA.Fields[7].Value;
        dm.tb_dareiva.FieldByName('baseIcmsDest').Value := DBGridIVA.Fields[13].Value;
        dm.tb_dareiva.FieldByName('iva').Value :=  DBGridIVA.Fields[8].Value;
        dm.tb_dareiva.FieldByName('baseIva').Value :=  DBGridIVA.Fields[12].Value;
        dm.tb_dareiva.FieldByName('reduFarmaceutica').Value :=  DBGridIVA.Fields[9].Value;
        dm.tb_dareiva.FieldByName('reduCestaBasica').Value :=   DBGridIVA.Fields[10].Value;
        dm.tb_dareiva.FieldByName('reduBebida').Value :=  DBGridIVA.Fields[11].Value;
        dm.tb_dareiva.FieldByName('valorDare').Value :=  DBGridIVA.Fields[14].Value;
       dm.tb_dareiva.Post;
      end;
    dm.queryIVACALC.next;
    end;

    //INSER��O NA TABELA darepauta
    while not dm.queryPAUTACALC.Eof  do
    begin
      valorPauta := dm.queryPAUTACALC.FieldByName('Pauta').value;
      if valorPauta > 0 then
      begin
        dm.tb_darepauta.Insert;
        dm.tb_darepauta.FieldByName('danfePAUTA').Value :=  DANFE.Text;
        dm.tb_darepauta.FieldByName('chaveXMLPAUTA').Value := chaveXml.Text;
        dm.tb_darepauta.FieldByName('produto').Value := DBGridPAUTA.Fields[1].Value;
        dm.tb_darepauta.FieldByName('quantidade').Value := DBGridPAUTA.Fields[2].Value;
        dm.tb_darepauta.FieldByName('valorUnitario').Value :=  DBGridPAUTA.Fields[3].Value;
        dm.tb_darepauta.FieldByName('valorTotal').Value :=  DBGridPAUTA.Fields[4].Value;
        dm.tb_darepauta.FieldByName('icmsDest').Value :=  DBGridPAUTA.Fields[5].Value;
        dm.tb_darepauta.FieldByName('icmsEmit').Value :=   DBGridPAUTA.Fields[6].Value;
        dm.tb_darepauta.FieldByName('baseIcmsDest').Value :=  DBGridPAUTA.Fields[12].Value;
        dm.tb_darepauta.FieldByName('baseIcmsEmit').Value := DBGridPAUTA.Fields[7].Value;
        dm.tb_darepauta.FieldByName('pauta').Value := DBGridPAUTA.Fields[8].Value;
        dm.tb_darepauta.FieldByName('basePauta').Value := DBGridPAUTA.Fields[11].Value;
        dm.tb_darepauta.FieldByName('reduCestaBasica').Value := DBGridPAUTA.Fields[9].Value;
        dm.tb_darepauta.FieldByName('reduBebida').Value :=  DBGridPAUTA.Fields[10].Value;
        dm.tb_darepauta.FieldByName('credEmitStDest').Value :=  DBGridPAUTA.Fields[13].Value;
        dm.tb_darepauta.FieldByName('valorDare').Value :=  DBGridPAUTA.Fields[14].Value;
        dm.tb_darepauta.Post;
      end;
    dm.queryPAUTACALC.next;
    end;

    imprimir := MessageBox(Handle,'Deseja imprimir o relat�rio detalhado?', 'Salvo com sucesso!', MB_YESNO);

    if imprimir = 6 then
    begin
       dm.queryDadosNfeDare.Close;
       dm.queryDadosNfeDare.SQL.Clear;
       dm.queryDadosNfeDare.SQL.Add('SELECT * FROM dadosnfedare WHERE danfe = ' +DANFE.Text);
       dm.queryDadosNfeDare.Open;

       dm.queryDareIva.Close;
       dm.queryDareIva.SQL.Clear;
       dm.queryDareIva.SQL.Add('SELECT * FROM dareiva WHERE danfeIVA = ' +DANFE.Text);
       dm.queryDareIva.Open;

       dm.queryDarePauta.Close;
       dm.queryDarePauta.SQL.Clear;
       dm.queryDarePauta.SQL.Add('SELECT * FROM darepauta WHERE danfePAUTA = ' +DANFE.Text);
       dm.queryDarePauta.Open;

       relatorio.ShowReport();
    end;

    //ZERANDO TUDO DEPOIS DE SALVAR
    btnSalvar.Enabled := False;
    btnCalcular.Enabled := False;

    DANFE.Text := '';
    chaveXml.Text  := '';
    Fornecedor.Text  := '';
    CNPJ.Text := '';
    IE.Text  := '';
    CFOP.Text  := '';
    UFEmi.Text  := '';
    UFDest.Text  := '';
    RazaoSocial.Text  := '';
    CNPJLojaDest.Text := '';
    IELoja.Text  := '';
    ValorTotalDare.Text := '';
    Observa��o.Text := '';

    dm.queryIVACALC.Close;
    dm.queryIVACALC.SQL.Clear;
    dm.queryIVACALC.SQL.Add('DELETE FROM `dbcaduceu_novo`.`dbgridiva`');
    dm.queryIVACALC.ExecSQL;

    dm.queryPAUTACALC.Close;
    dm.queryPAUTACALC.SQL.Clear;
    dm.queryPAUTACALC.SQL.Add('DELETE FROM `dbcaduceu_novo`.`dbgridpauta`');
    dm.queryPAUTACALC.ExecSQL;
    ValorTotalDare.Text := '';
end;

end.



