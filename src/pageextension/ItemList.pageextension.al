pageextension 50034 "DEL ItemList" extends "Item List"
{

    layout
    {

        addafter("Item Tracking Code")
        {
            field("DEL Vol cbm"; Rec.GetVolCBM(TRUE))
            {
                Caption = 'Vol cbm';
                DecimalPlaces = 2 : 4;
            }
            field("DEL Date de peremption"; Rec."DEL Date de peremption")
            {
            }
            field("DEL Estimated next delivery date"; Rec."DEL Est. next delivery date")
            {
            }
            field("DEL Code nomenclature douaniere"; Rec."DEL Code nomenc. douaniere")
            {
            }
            field("DEL Date prochaine commande"; Rec."DEL Date prochaine commande")
            {
            }
            field("DEL Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
            }
            field("DEL Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
            }
            field("DEL Qty. optimale"; Rec."DEL Qty. optimale")
            {
            }
        }
    }
    actions
    {

        addafter("Va&riants")
        {
            action("DEL Catalog Item Card NGTS")
            {
                Caption = 'Catalog Item Card NGTS';
                Ellipsis = true;
                Image = Worksheet;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page 50121;
                RunPageLink = "No." = FIELD("No.");
            }
        }
        addafter("Identifiers")
        {
            action("DEL Item Quality")
            {
                Caption = 'Item Quality';
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50077;
                RunPageLink = "No." = FIELD("No.");
            }
        }
    }
}

