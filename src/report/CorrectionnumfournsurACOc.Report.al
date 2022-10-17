report 50062 "Correction num fourn sur ACO c"
{
    Permissions = TableData "DEL ACO Connection" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("DEL ACO Connection"; "DEL ACO Connection")
        {
            DataItemTableView = SORTING (Deal_ID, "ACO No.")
                                WHERE (Status = FILTER ('In order'|'In progress'));
            RequestFilterFields = Deal_ID;

            trigger OnAfterGetRecord()
            begin
                IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, "DEL ACO Connection"."ACO No.") THEN BEGIN
                    "DEL ACO Connection"."Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                    "DEL ACO Connection".MODIFY();
                END;
                PurchaseHeaderArchive.RESET();
                PurchaseHeaderArchive.SETRANGE("Document Type", PurchaseHeaderArchive."Document Type"::Order);
                PurchaseHeaderArchive.SETRANGE("No.", "DEL ACO Connection"."ACO No.");
                IF PurchaseHeaderArchive.FINDFIRST() THEN BEGIN
                    "DEL ACO Connection"."Vendor No." := PurchaseHeaderArchive."Buy-from Vendor No.";
                    "DEL ACO Connection".MODIFY();

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
        PurchaseHeader: Record "Purchase Header";
        Deal: Record "DEL Deal";
        PurchaseHeaderArchive: Record "Purchase Header Archive";
}

