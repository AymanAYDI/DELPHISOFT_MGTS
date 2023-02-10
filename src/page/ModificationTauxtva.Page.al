page 50084 "DEL Modification Taux tva"
{
    PageType = Card;
    SourceTable = "Sales Header";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Taux; Taux)
                {
                    ApplicationArea = All;
                    Caption = 'Nouveau Taux TVA';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Maj TVA")
            {
                ApplicationArea = All;
                Caption = 'Maj TVA';
                Image = VATExemption;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    SalesLine2.SETRANGE("Document Type", SalesLine2."Document Type"::Order);
                    SalesLine2.SETRANGE("Document No.", Rec."No.");

                    IF SalesLine2.FIND('-') THEN
                        REPEAT
                            SalesLine2."VAT %" := Taux;
                            SalesLine2.UpdateAmounts();
                            SalesLine2.MODIFY();
                        UNTIL SalesLine2.NEXT() = 0;

                    MESSAGE('MAJ terminée');
                end;
            }
        }
    }

    var
        SalesLine2: Record "Sales Line";
        Taux: Decimal;
}
