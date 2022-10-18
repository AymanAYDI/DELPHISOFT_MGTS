report 50045 "DEL Miseà0 qteFact et Livbase"
{
    ProcessingOnly = true;

    dataset
    {

        dataitem("Purchase Header"; "Purchase Header")

        {
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            begin
                PurchaseLine2.RESET();
                PurchaseLine2.SETRANGE("Document Type", PurchaseLine2."Document Type"::Order);
                PurchaseLine2.SETRANGE("Document No.", "No.");
                IF PurchaseLine2.FINDFIRST() THEN
                    REPEAT
                        IF PurchaseLine2."Quantity Received" <> PurchaseLine2."Qty. Received (Base)" THEN BEGIN
                            PurchaseLine2.VALIDATE("Qty. Received (Base)", PurchaseLine2."Quantity Received");
                            PurchaseLine2.MODIFY();
                        END;
                        IF PurchaseLine2."Qty. to Receive" <> PurchaseLine2."Qty. to Receive (Base)" THEN BEGIN
                            PurchaseLine2.VALIDATE("Qty. to Receive (Base)", PurchaseLine2."Qty. to Receive");
                            PurchaseLine2.MODIFY();
                        END;
                    UNTIL PurchaseLine2.NEXT() = 0;


                PurchaseLine.RESET();
                PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SETRANGE("Document No.", "No.");
                IF PurchaseLine.FINDFIRST() THEN
                    REPEAT
                        IF PurchaseLine."Quantity Invoiced" <> PurchaseLine."Qty. Invoiced (Base)" THEN BEGIN
                            PurchaseLine.VALIDATE("Qty. Invoiced (Base)", PurchaseLine."Quantity Invoiced");
                            PurchaseLine.MODIFY();
                        END;
                        IF PurchaseLine."Qty. to Invoice" <> PurchaseLine."Qty. to Invoice (Base)" THEN BEGIN
                            PurchaseLine.VALIDATE("Qty. to Invoice (Base)", PurchaseLine."Qty. to Invoice");
                            PurchaseLine.MODIFY();
                        END;
                    UNTIL PurchaseLine.NEXT() = 0;
                MESSAGE(Text0001);
            end;

            trigger OnPreDataItem()
            begin
                IF GETFILTER("No.") = '' THEN MESSAGE(Text0002);
            end;
        }
    }


    var
        PurchaseLine: Record "Purchase Line";
        PurchaseLine2: Record "Purchase Line";
        Text0001: Label 'Update Successfully Completed';
        Text0002: Label 'Vous devez choisir un numéro de document';
        PurchaseLine3: Record "Purchase Line";

}

