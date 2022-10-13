report 50063 "Modify ext ref"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem100000000; Table39)
        {
            DataItemTableView = SORTING (Document Type, Document No., Line No.)
                                WHERE (Document Type=CONST(Order));
            RequestFilterFields = "Document No.", "Document Type";

            trigger OnAfterGetRecord()
            begin
                /*SalesHeader_Rec.SETRANGE("No.","Special Order Sales No.");
                SalesHeader_Rec.SETRANGE("Document Type","Document Type"::Order);
                IF SalesHeader_Rec.FINDFIRST THEN*/
                //START THM0003

                IF SalesHeader_Rec.GET("Document Type"::Order, "Special Order Sales No.") THEN BEGIN
                    //VALIDATE("External reference NGTS",SalesHeader_Rec."Sell-to Customer No.");
                    ItemCrossReference.RESET;
                    ItemCrossReference.SETRANGE(ItemCrossReference."Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::Customer);
                    ItemCrossReference.SETRANGE(ItemCrossReference."Cross-Reference Type No.", SalesHeader_Rec."Sell-to Customer No.");
                    ItemCrossReference.SETRANGE(ItemCrossReference."Item No.", "No.");
                    IF ItemCrossReference.FINDFIRST THEN
                        "External reference NGTS" := ItemCrossReference."Cross-Reference No."
                    ELSE
                        "External reference NGTS" := '';
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
        Item_Rec: Record "27";
        SalesHeader_Rec: Record "36";
        ItemCrossReference: Record "5717";
}

