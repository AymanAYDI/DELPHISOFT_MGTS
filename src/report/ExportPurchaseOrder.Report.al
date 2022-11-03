report 50053 "DEL Export Purchase Order"
{

    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "Document Type", "No.";

            trigger OnAfterGetRecord()
            begin

                Vendor.GET("Buy-from Vendor No.");

                ColNo += 1;
                RowNo += 2;
                InsertExcelCell(ColNo, RowNo, Text003, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, FORMAT("DEL Requested Delivery Date"), '', FALSE, FALSE, FALSE);

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
                InsertExcelCell(ColNo, RowNo, "DEL GLN", '@', FALSE, FALSE, FALSE);

                ColNo := 1;
                RowNo += 1;
                InsertExcelCell(ColNo, RowNo, Text021, '', FALSE, FALSE, FALSE);

                ColNo += 1;
                InsertExcelCell(ColNo, RowNo, FORMAT("Your Reference"), '', FALSE, FALSE, FALSE);

                RowNo += 1;
                ColNo := 1;
                InsertExcelCell(ColNo, RowNo, Text008, '', FALSE, FALSE, FALSE);

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

                PurchaseLine.RESET();
                PurchaseLine.SETRANGE("Document Type", "Document Type");
                PurchaseLine.SETRANGE("Document No.", "No.");
                PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
                IF PurchaseLine.FINDSET() THEN
                    REPEAT

                        Item.GET(PurchaseLine."No.");
                        // TODO 
                        //     ANVEDICrossReference.RESET;
                        //    TODO // ANVEDICrossReference.SETRANGE("External No.", "Purchase Header"."DEL GLN");
                        //     IF NOT ANVEDICrossReference.FINDFIRST THEN
                        //         ANVEDICrossReference.INIT;

                        //     ShiptoAddress.INIT;
                        //     IF NOT (ANVEDICrossReference."Internal No." = '') THEN BEGIN
                        //         ShiptoAddress.RESET;
                        //         ShiptoAddress.SETRANGE("Customer No.", ANVEDICrossReference."Table Relation Par 1");
                        //         ShiptoAddress.SETRANGE(Code, ANVEDICrossReference."Internal No.");
                        //         IF NOT ShiptoAddress.FINDFIRST THEN
                        //             ShiptoAddress.INIT;
                        //     END;

                        RowNo += 1;
                        ColNo := 1;
                        InsertExcelCell(ColNo, RowNo, "No.", '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, "DEL Type Order EDI", '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, Vendor."No.", '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, Vendor.Name, '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, PurchaseLine."No.", '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, PurchaseLine.Description, '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, Item."DEL Code EAN 13", '@', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, PurchaseLine."Item Reference No.", '@', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, FORMAT(PurchaseLine.Quantity), '', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, PurchaseLine."Unit of Measure Code", '@', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        //   TODO      // InsertExcelCell(ColNo, RowNo, ANVEDICrossReference."Internal No.", '@', FALSE, FALSE, FALSE);

                        ColNo += 1;
                        InsertExcelCell(ColNo, RowNo, ShiptoAddress.Name, '@', FALSE, FALSE, FALSE);

                    UNTIL PurchaseLine.NEXT() = 0;

            end;

            trigger OnPostDataItem()
            begin

                IF GUIALLOWED THEN
                    Window.CLOSE();

                // TODO: The application objects or methods have scope 'OnPrem' 
                // ExcelBuffer.CreateBookAndOpenExcel('', Text001, Text002, COMPANYNAME, USERID);
                // ExcelBuffer.GiveUserControl(); 
                ////// à corriger 
                temp_ExcelBuffer.CreateNewBook('');
                temp_ExcelBuffer.WriteSheet('', COMPANYNAME(), USERID());
                temp_ExcelBuffer.CloseBook();
                temp_ExcelBuffer.OpenExcel();
                Error('');
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
        CompanyInformation: Record "Company Information";
        temp_ExcelBuffer: Record "Excel Buffer" temporary;
        Item: Record Item;
        PurchaseLine: Record "Purchase Line";
        ShiptoAddress: Record "Ship-to Address";
        Vendor: Record Vendor;
        Window: Dialog;
        ColNo: Integer;
        RowNo: Integer;
        Text003: Label 'Date de livraison';
        Text004: Label 'Processing data ...\Please wait ...';
        Text005: Label 'Emetteur';
        Text006: Label 'Fournisseur';
        Text007: Label 'Livre';
        Text008: Label 'Commande';
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
        //   TODO  // ANVEDICrossReference: Record 5327362; // TODO: Record not exist
        Text021: Label 'Réference cde';

    local procedure InsertExcelCell(InsertColNo: Integer; InsertRowNo: Integer; InsertValue: Text; InsertFormat: Text; InsertBold: Boolean; InsertItalic: Boolean; InsertUnderline: Boolean)
    begin

        temp_ExcelBuffer.INIT();
        temp_ExcelBuffer.VALIDATE("Column No.", InsertColNo);
        temp_ExcelBuffer.VALIDATE("Row No.", InsertRowNo);
        temp_ExcelBuffer."Cell Value as Text" := InsertValue;
        temp_ExcelBuffer.NumberFormat := InsertFormat;
        temp_ExcelBuffer.Bold := InsertBold;
        temp_ExcelBuffer.Italic := InsertItalic;
        temp_ExcelBuffer.Underline := InsertUnderline;

        IF temp_ExcelBuffer.NumberFormat = '@' THEN
            temp_ExcelBuffer."Cell Type" := temp_ExcelBuffer."Cell Type"::Text;

        temp_ExcelBuffer.INSERT();
    end;
}

