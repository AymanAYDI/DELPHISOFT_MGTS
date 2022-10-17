report 50063 "DEL Modify ext ref"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem100000000; "Purchase Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "Document No.", "Document Type";

            trigger OnAfterGetRecord()
            begin
                /*SalesHeader_Rec.SETRANGE("No.","Special Order Sales No.");
                SalesHeader_Rec.SETRANGE("Document Type","Document Type"::Order);
                IF SalesHeader_Rec.FINDFIRST THEN*/
                //START THM0003

                IF SalesHeader_Rec.GET("Document Type"::Order, "Special Order Sales No.") THEN BEGIN
                    //VALIDATE("External reference NGTS",SalesHeader_Rec."Sell-to Customer No.");
                    ItemCrossReference.RESET();
                    ItemCrossReference.SETRANGE(ItemCrossReference."Reference Type", ItemCrossReference."Reference Type"::Customer);
                    ItemCrossReference.SETRANGE(ItemCrossReference."Reference Type No.", SalesHeader_Rec."Sell-to Customer No.");
                    ItemCrossReference.SETRANGE(ItemCrossReference."Item No.", "No.");
                    IF ItemCrossReference.FINDFIRST() THEN
                        "DEL External reference NGTS" := ItemCrossReference."Reference No."
                    ELSE
                        "DEL External reference NGTS" := '';
                    MODIFY(TRUE);

                END;

                /*
                IF Item_Rec.GET("No.") THEN BEGIN
                   IF "Purchase Line"."Buy-from Vendor No." = Item_Rec."Vendor No." THEN BEGIN
                     "Cross-Reference No.":= Item_Rec."Vendor Item No.";
                     MODIFY;
                   END;
                END;
                */

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
        Item_Rec: Record Item;
        SalesHeader_Rec: Record "Sales Header";
        ItemCrossReference: Record "Item Reference";
}

