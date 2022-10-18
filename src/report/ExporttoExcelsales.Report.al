report 50008 "DEL Export to Excel sales"
{

    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem("Sales Price Worksheet"; "Sales Price Worksheet")
        {
            DataItemTableView = SORTING("Starting Date", "Ending Date", "Sales Type", "Sales Code", "Currency Code", "Item No.", "Variant Code", "Unit of Measure Code", "Minimum Quantity");

            trigger OnAfterGetRecord()
            begin
                Row += 1;

                EnterCell(Row, 1, FORMAT("Starting Date"), FALSE, FALSE, FALSE);
                EnterCell(Row, 2, FORMAT("Ending Date"), FALSE, FALSE, FALSE);
                EnterCell(Row, 3, FORMAT("Sales Type"), FALSE, FALSE, FALSE);
                EnterCell(Row, 4, FORMAT("Sales Code"), FALSE, FALSE, FALSE);
                EnterCell(Row, 5, FORMAT("Currency Code"), FALSE, FALSE, FALSE);
                EnterCell(Row, 6, FORMAT("Item No."), TRUE, FALSE, FALSE);
                EnterCell(Row, 7, FORMAT("Variant Code"), FALSE, FALSE, FALSE);
                EnterCell(Row, 8, FORMAT("Unit of Measure Code"), FALSE, FALSE, FALSE);
                EnterCell(Row, 9, FORMAT("Minimum Quantity"), FALSE, FALSE, FALSE);
                EnterCell(Row, 10, FORMAT("Current Unit Price"), FALSE, FALSE, FALSE);
                EnterCell(Row, 11, FORMAT("New Unit Price"), FALSE, FALSE, FALSE);
                EnterCell(Row, 12, FORMAT("Allow Invoice Disc."), FALSE, FALSE, FALSE);
                EnterCell(Row, 13, FORMAT("Price Includes VAT"), FALSE, FALSE, FALSE);
                EnterCell(Row, 14, FORMAT("VAT Bus. Posting Gr. (Price)"), FALSE, FALSE, FALSE);
                EnterCell(Row, 15, FORMAT("Allow Line Disc."), FALSE, FALSE, FALSE);

                RecNo += 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;

                //TODO: only for onprem dev ! à corriger #Abiir
                // TempExcelBuffer.CreateBook(Text000, Text000);
                // TempExcelBuffer.GiveUserControl;
                TempExcelBuffer.CreateNewBook(Text000);
                TempExcelBuffer.WriteSheet('Text000', CompanyName(), UserId());
                TempExcelBuffer.CloseBook();

            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN(
                  Text001 +
                  '@1@@@@@@@@@@@@@@@@@@@@@\');
                Window.UPDATE(1, 0);
                TotalRecNo := "Sales Price Worksheet".COUNT;
                RecNo := 0;

                TempExcelBuffer.DELETEALL;
                CLEAR(TempExcelBuffer);
                EnterCell(1, 1, Text000, TRUE, TRUE, FALSE);
                EnterCell(3, 1, Text002, TRUE, TRUE, FALSE); //dd début
                EnterCell(3, 2, Text003, TRUE, TRUE, FALSE); //dd fin
                EnterCell(3, 3, Text004, TRUE, TRUE, FALSE);  // type vente
                EnterCell(3, 4, Text005, TRUE, TRUE, FALSE);   //code vente
                EnterCell(3, 5, Text006, TRUE, TRUE, FALSE);   //code devise
                EnterCell(3, 6, Text007, TRUE, TRUE, FALSE);   //n. article
                EnterCell(3, 7, Text008, TRUE, TRUE, FALSE);    //code variante
                EnterCell(3, 8, Text009, TRUE, TRUE, FALSE);     //unité
                EnterCell(3, 9, Text010, TRUE, TRUE, FALSE);     //quantité min
                EnterCell(3, 10, Text011, TRUE, TRUE, FALSE);    //prix unitaire actuel
                EnterCell(3, 11, Text012, TRUE, TRUE, FALSE);    //new prix unitaire
                EnterCell(3, 12, Text013, TRUE, TRUE, FALSE);     //remise facture autorisé
                EnterCell(3, 13, Text014, TRUE, TRUE, FALSE);     //prix ttc
                EnterCell(3, 14, Text015, TRUE, TRUE, FALSE);     //groupe compta marché tva
                EnterCell(3, 15, Text016, TRUE, TRUE, FALSE);     //autoriser remise ligne

                Row += 4;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Window: Dialog;
        Row: Integer;
        Text000: Label 'Sales Price';
        TotalRecNo: Integer;
        RecNo: Integer;
        Text001: Label 'Analyzing Data...';
        Text002: Label 'Date début';
        Text003: Label 'Date fin';
        Text004: Label 'Type vente';
        Text005: Label 'Code vente';
        Text006: Label 'Code devise';
        Text007: Label 'N° article';
        Text008: Label 'Code variante';
        Text009: Label 'Code unité';
        Text010: Label 'Quantité minimum';
        Text012: Label 'Nouveau prix unitaire';
        Text011: Label 'Prix unitaire actuel';
        Text013: Label 'Remise facture autorisée';
        Text014: Label 'Prix TTC';
        Text015: Label 'Gpe compta. marché TVA (prix)';
        Text016: Label 'Autoriser remise ligne';
        "Taux de change": Decimal;
        MontantFrs: Decimal;
        TotalMontantFRS: Decimal;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean)
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.INSERT;
    end;
}

