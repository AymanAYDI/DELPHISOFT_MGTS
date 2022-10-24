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

                IF SalesHeader_Rec.GET("Document Type"::Order, "Special Order Sales No.") THEN BEGIN
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
        ItemCrossReference: Record "Item Reference";
        SalesHeader_Rec: Record "Sales Header";
}

