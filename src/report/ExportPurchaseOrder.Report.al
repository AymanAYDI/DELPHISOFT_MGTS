report 50053 "Export Purchase Order"
{
    // 
    //   MGTS10.009; Created object

    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table38)
        {
            RequestFilterFields = "Document Type", "No.";

            trigger OnAfterGetRecord()
            begin

                Vendor.GET("Buy-from Vendor No.");

                ColNo += 1;
                RowNo += 2;
                InsertExcelCell(ColNo, RowNo, Text003, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, FORMAT("Requested Delivery Date"), '', FALSE, FALSE, FALSE);

                ColNo := 1;
                RowNo += 1;
                InsertExcelCell(ColNo, RowNo, Text005, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text006, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text007, '', FALSE, FALSE, FALSE);

                RowNo += 1;
                ColNo := 1;
                InsertExcelCell(ColNo, RowNo, CompanyInformation.GLN, '@', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Vendor.GLN, '@', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, GLN, '@', FALSE, FALSE, FALSE);

                ColNo := 1;
                RowNo += 1;
                InsertExcelCell(ColNo, RowNo, Text021, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, FORMAT("Your Reference"), '', FALSE, FALSE, FALSE);

                RowNo += 1;
                ColNo := 1;
                InsertExcelCell(ColNo, RowNo, Text008, '', FALSE, FALSE, FALSE);

                //ColNo += 1;
                //InsertExcelCell(ColNo, RowNo, Text009, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text010, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text011, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text012, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text013, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text014, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text015, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text016, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text017, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text018, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text019, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, Text020, '', FALSE, FALSE, FALSE);

                PurchaseLine.RESET;
                PurchaseLine.SETRANGE("Document Type", "Document Type");
                PurchaseLine.SETRANGE("Document No.", "No.");
                PurchaseLine.SETRANGE("Customer/Vendor", PurchaseLine.Type::Item);
                IF PurchaseLine.FINDSET THEN
                    REPEAT

                        Item.GET(PurchaseLine."No.");

                        ANVEDICrossReference.RESET;
                        ANVEDICrossReference.SETRANGE("External No.", "Purchase Header".GLN);
                        IF NOT ANVEDICrossReference.FINDFIRST THEN
                            ANVEDICrossReference.INIT;

                        ShiptoAddress.INIT;
                        IF NOT (ANVEDICrossReference."Internal No." = '') THEN BEGIN
                            ShiptoAddress.RESET;
                            ShiptoAddress.SETRANGE("Customer No.", ANVEDICrossReference."Table Relation Par 1");
                            ShiptoAddress.SETRANGE(Code, ANVEDICrossReference."Internal No.");
                            IF NOT ShiptoAddress.FINDFIRST THEN
                                ShiptoAddress.INIT;
                        END;

                        RowNo += 1;
                        ColNo := 1;
                        InsertExcelCell(ColNo, RowNo, "No.", '', FALSE, FALSE, FALSE);

                        //ColNo += 1;
                        //InsertExcelCell(ColNo, RowNo, FORMAT(PurchaseLine."Requested Receipt Date"), '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, "Type Order EDI", '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, Vendor."No.", '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, Vendor.Name, '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, PurchaseLine."No.", '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, PurchaseLine.Description, '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, Item."Code EAN 13", '@', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, PurchaseLine."Cross-Reference No.", '@', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, FORMAT(PurchaseLine.Quantity), '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, PurchaseLine."Unit of Measure Code", '@', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, ANVEDICrossReference."Internal No.", '@', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, ShiptoAddress.Name, '@', FALSE, FALSE, FALSE);

                    UNTIL PurchaseLine.NEXT = 0;

            end;

            trigger OnPostDataItem()
            begin

                IF GUIALLOWED THEN
                    Window.CLOSE;

                ExcelBuffer.CreateBookAndOpenExcel('', Text001, Text002, COMPANYNAME, USERID);
                ExcelBuffer.GiveUserControl();
            end;

            trigger OnPreDataItem()
            begin

                IF GUIALLOWED THEN
                    Window.OPEN(Text004);

                CompanyInformation.GET();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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
        ExcelBuffer: Record "370" temporary;
        Text001: Label 'Exported Data';
        Text002: Label 'Purchase Order';
        ColNo: Integer;
        RowNo: Integer;
        Text003: Label 'Date de livraison';
        Text004: Label 'Processing data ...\Please wait ...';
        Window: Dialog;
        Text005: Label 'Emetteur';
        Text006: Label 'Fournisseur';
        Text007: Label 'Livre';
        CompanyInformation: Record "79";
        Vendor: Record "23";
        Text008: Label 'Commande';
        Text009: Label 'Date';
        Text010: Label 'Type code';
        Text011: Label 'Fournisseur';
        Text012: Label 'Désignation';
        Text013: Label 'Article';
        Text014: Label 'Désignation article';
        Text015: Label 'Code EAN';
        Text016: Label 'N° art FRN';
        Text017: Label 'Quantité';
        Text018: Label 'Unité de qté';
        Text019: Label 'Entrepôt à livrer';
        Text020: Label 'Désignation';
        PurchaseLine: Record "39";
        Item: Record "27";
        ShiptoAddress: Record "222";
        ANVEDICrossReference: Record "5327362";
        Text021: Label 'Réference cde';

    local procedure InsertExcelCell(InsertColNo: Integer; InsertRowNo: Integer; InsertValue: Text; InsertFormat: Text; InsertBold: Boolean; InsertItalic: Boolean; InsertUnderline: Boolean)
    begin

        ExcelBuffer.INIT;
        ExcelBuffer.VALIDATE("Column No.", InsertColNo);
        ExcelBuffer.VALIDATE("Row No.", InsertRowNo);
        ExcelBuffer."Cell Value as Text" := InsertValue;
        ExcelBuffer.NumberFormat := InsertFormat;
        ExcelBuffer.Bold := InsertBold;
        ExcelBuffer.Italic := InsertItalic;
        ExcelBuffer.Underline := InsertUnderline;

        IF ExcelBuffer.NumberFormat = '@' THEN
            ExcelBuffer."Cell Type" := ExcelBuffer."Cell Type"::Text;

        ExcelBuffer.INSERT;
    end;
}

