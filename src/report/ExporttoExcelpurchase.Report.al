report 50012 "Export to Excel purchase"
{
    // Logico SA - Logiciels & Conseils
    // Status : 11.03.2009
    // Customer / Project NGTS
    // 
    // Version    Requirement        ID       Date           Description
    // -----------------------------------------------------------------
    // NGTS                        GRC      11.03.2009      Create object

    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem3883; Table50038)
        {
            DataItemTableView = SORTING (Item No., Vendor No., Starting Date, Currency Code, Variant Code, Unit of Measure Code, Minimum Quantity, Qty. optimale);

            trigger OnAfterGetRecord()
            begin
                Row += 1;

                EnterCell(Row, 1, FORMAT("Purchase Price Worksheet"."Starting Date"), FALSE, FALSE, FALSE);
                EnterCell(Row, 2, FORMAT("Purchase Price Worksheet"."Ending Date"), FALSE, FALSE, FALSE);
                EnterCell(Row, 3, "Purchase Price Worksheet"."Vendor No.", FALSE, FALSE, FALSE);
                EnterCell(Row, 4, "Purchase Price Worksheet"."Currency Code", FALSE, FALSE, FALSE);
                EnterCell(Row, 5, "Purchase Price Worksheet"."Item No.", FALSE, FALSE, FALSE);
                EnterCell(Row, 6, "Purchase Price Worksheet"."Variant Code", FALSE, FALSE, FALSE);
                EnterCell(Row, 7, "Purchase Price Worksheet"."Unit of Measure Code", FALSE, FALSE, FALSE);
                EnterCell(Row, 8, FORMAT("Purchase Price Worksheet"."Minimum Quantity"), FALSE, FALSE, FALSE);
                EnterCell(Row, 9, FORMAT("Purchase Price Worksheet"."Qty. optimale"), FALSE, FALSE, FALSE);
                EnterCell(Row, 10, FORMAT("Purchase Price Worksheet"."Direct Unit Cost"), FALSE, FALSE, FALSE);
                EnterCell(Row, 11, FORMAT("Purchase Price Worksheet"."New Unit Price"), FALSE, FALSE, FALSE);

                RecNo += 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;

                TempExcelBuffer.CreateBook(Text000, Text000);
                //TempExcelBuffer.CreateSheet(Text000,Text000,COMPANYNAME,USERID);
                TempExcelBuffer.GiveUserControl;
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN(
                  Text001 +
                  '@1@@@@@@@@@@@@@@@@@@@@@\');
                Window.UPDATE(1, 0);
                TotalRecNo := "Purchase Price Worksheet".COUNT;
                RecNo := 0;

                TempExcelBuffer.DELETEALL;
                CLEAR(TempExcelBuffer);
                EnterCell(1, 1, Text000, TRUE, TRUE, FALSE);
                EnterCell(3, 1, Text002, TRUE, TRUE, FALSE); // dd début
                EnterCell(3, 2, Text003, TRUE, TRUE, FALSE); // dd fin
                EnterCell(3, 3, Text004, TRUE, TRUE, FALSE); // n fourni
                EnterCell(3, 4, Text005, TRUE, TRUE, FALSE); //  code devise
                EnterCell(3, 5, Text006, TRUE, TRUE, FALSE); //  n article
                EnterCell(3, 6, Text007, TRUE, TRUE, FALSE); //  code variate
                EnterCell(3, 7, Text008, TRUE, TRUE, FALSE); //    code unité
                EnterCell(3, 8, Text009, TRUE, TRUE, FALSE); //     qu minim
                EnterCell(3, 9, Text010, TRUE, TRUE, FALSE); //   quatité optimal
                EnterCell(3, 10, Text011, TRUE, TRUE, FALSE); //   cu actuel
                EnterCell(3, 11, Text012, TRUE, TRUE, FALSE); //    nouveua cout unit

                Row := 4;
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
        TempExcelBuffer: Record "370" temporary;
        Window: Dialog;
        Row: Integer;
        Text000: Label 'Purchase Price list';
        TotalRecNo: Integer;
        RecNo: Integer;
        Text001: Label 'Analyzing Data...';
        Text002: Label 'Date début';
        Text003: Label 'Date fin';
        Text004: Label 'N. Fournisseur';
        Text005: Label 'Code devise';
        Text006: Label 'N° article';
        Text007: Label 'Code variante';
        Text008: Label 'Code unité';
        Text009: Label 'Quantité minimum';
        Text010: Label 'Quantitée optimal';
        Text011: Label 'Coût unitaire actuel';
        "Taux de change": Decimal;
        MontantFrs: Decimal;
        TotalMontantFRS: Decimal;
        Text012: Label 'Nouveau Coût unitaire';

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

