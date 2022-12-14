report 50011 "DEL Impl. Purch Price Change"
{

    Caption = 'Implement Price Change';
    ProcessingOnly = true;

    dataset
    {
        dataitem("DEL Purchase Price Worksheet"; "DEL Purchase Price Worksheet")
        {
            DataItemTableView = SORTING("Item No.", "Vendor No.", "Starting Date", "Currency Code",
             "Variant Code",
             "Unit of Measure Code", "Minimum Quantity", "Qty. optimale");
            RequestFilterFields = "Item No.", "Vendor No.", "Unit of Measure Code", "Currency Code";

            trigger OnAfterGetRecord()
            begin

                Window.UPDATE(1, "Item No.");
                Window.UPDATE(2, 'Vendor');
                Window.UPDATE(3, "Vendor No.");
                Window.UPDATE(4, "Currency Code");
                Window.UPDATE(5, "Starting Date");

                PurchPrice.INIT();
                PurchPrice.VALIDATE("Item No.", "Item No.");
                PurchPrice.VALIDATE("Vendor No.", "Vendor No.");
                PurchPrice.VALIDATE("Starting Date", "Starting Date");
                PurchPrice."Currency Code" := "Currency Code";
                PurchPrice.VALIDATE("Variant Code", "Variant Code");
                PurchPrice.VALIDATE("Unit of Measure Code", "Unit of Measure Code");
                PurchPrice."Minimum Quantity" := "Minimum Quantity";
                PurchPrice."DEL Qty. optimale" := "Qty. optimale";

                PurchPrice.VALIDATE("Ending Date", "Ending Date");


                PurchPrice."Direct Unit Cost" := "New Unit Price";

                IF PurchPrice."Direct Unit Cost" <> 0 THEN
                    IF NOT PurchPrice.INSERT(TRUE) THEN
                        PurchPrice.MODIFY(TRUE);
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN(
                  Text000 +
                  Text007 +
                  Text008 +
                  Text009 +
                  Text010 +
                  Text011);
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
        PurchPrice: Record "Purchase Price";
        DeleteWhstLine: Boolean;
        Window: Dialog;


        Text000: Label 'Updating Unit Prices...\\';
        Text007: Label 'Item No.               #1##########\';
        Text008: Label 'Purchase Type             #2##########\';
        Text009: Label 'Purchase Code             #3##########\';
        Text010: Label 'Currency Code          #4##########\';
        Text011: Label 'Starting Date          #5######';

    procedure InitializeRequest(NewDeleteWhstLine: Boolean)
    begin
        DeleteWhstLine := NewDeleteWhstLine;
    end;
}

