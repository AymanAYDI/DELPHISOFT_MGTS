report 50062 "Correction num fourn sur ACO c"
{
    Permissions = TableData 50026 = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table50026)
        {
            DataItemTableView = SORTING (Deal_ID, ACO No.)
                                WHERE (Status = FILTER (In order|In progress));
            RequestFilterFields = Deal_ID;

            trigger OnAfterGetRecord()
            begin
                IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, "ACO Connection"."ACO No.") THEN BEGIN
                    "ACO Connection"."Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                    "ACO Connection".MODIFY;
                END;
                PurchaseHeaderArchive.RESET;
                PurchaseHeaderArchive.SETRANGE("Document Type", PurchaseHeaderArchive."Document Type"::Order);
                PurchaseHeaderArchive.SETRANGE("No.", "ACO Connection"."ACO No.");
                IF PurchaseHeaderArchive.FINDFIRST THEN BEGIN
                    "ACO Connection"."Vendor No." := PurchaseHeaderArchive."Buy-from Vendor No.";
                    "ACO Connection".MODIFY;

                END;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Fin traitement');
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
        PurchaseHeader: Record "38";
        Deal: Record "50020";
        PurchaseHeaderArchive: Record "5109";
}

