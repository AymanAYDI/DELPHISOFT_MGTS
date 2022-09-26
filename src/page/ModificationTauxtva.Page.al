page 50084 "Modification Taux tva"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // |                                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // T-00559             THM        13.08.13      activé le cas TVA=0

    PageType = Card;
    SourceTable = Table36;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Taux; Taux)
                {
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
                Caption = 'Maj TVA';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    // begin  T-00559   THM
                    //IF  (Taux = 0) THEN
                    //  ERROR('le champs Client et Taux doivent être renseigné');
                    // end T-00559 THM

                    SalesLine2.SETRANGE("Document Type", SalesLine2."Document Type"::Order);
                    SalesLine2.SETRANGE("Document No.", "No.");

                    IF SalesLine2.FIND('-') THEN BEGIN
                        REPEAT
                            SalesLine2."VAT %" := Taux;
                            SalesLine2.UpdateAmounts;
                            SalesLine2.MODIFY();

                        UNTIL SalesLine2.NEXT = 0;
                    END;

                    MESSAGE('MAJ terminée');
                end;
            }
        }
    }

    var
        Nclient: Code[20];
        Taux: Decimal;
        customer: Record "18";
        SalesLine2: Record "37";
}

