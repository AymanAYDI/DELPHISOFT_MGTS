page 50051 "Outils de Corrections"
{
    // 
    // +------------------------------------------------------------------------------------------+
    // | Logico SA                                                                                |
    // | Status:                                                                                  |
    // | Customer/Project:                                                                        |
    // +------------------------------------------------------------------------------------------+
    // Requirement  UserID   Date       Where             Description
    // -------------------------------------------------------------------------------------------+
    //             THM      23.09.13          ADD Page Correctif Purchase Invoice
    // T-00664     THM      02.06.14          Add Update deal status
    //             THM      21.04.18          add 2 pages actions

    Caption = 'Outils de Correction';
    PageType = Card;
    SourceTable = Table2000000026;

    layout
    {
        area(content)
        {
        }
    }

    actions
    {
        area(processing)
        {
            action("Supprimer un ""Element"" d'une affaire")
            {
                Caption = 'Supprimer un "Element" d''une affaire';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report 50017;
            }
            action("Re-assigner une NC Vente à une affaire/shipment")
            {
                Caption = 'Re-assigner une NC Vente à une affaire/shipment';
                Image = StepInto;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50082;
            }
            action("Re-assigner les lignes d'une Facture de vente à un ""code achat""")
            {
                Caption = 'Re-assigner les lignes d''une Facture de vente à un "code achat"';
                Image = Purchasing;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50015;
            }
            action("Re-assigner une NC achat à une affaire/shipment")
            {
                Caption = 'Re-assigner une NC achat à une affaire/shipment';
                Image = CreateCreditMemo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50083;
            }
            action("Re-assigner une facture de frais achat à une affaire/shipment/code de frais")
            {
                Caption = 'Re-assigner une facture de frais achat à une affaire/shipment/code de frais';
                Image = ShowList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50080;
            }
            action("Re-assigner les lignes d'une Facture de achat à un ""code achat""")
            {
                Caption = 'Re-assigner les lignes d''une Facture de achat à un "code achat"';
                Image = Purchasing;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50060;
            }
            action("Update Deal status")
            {
                Caption = 'Update Deal status';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report 50022;
            }
            action("Update facture vente/Affaire")
            {
                Image = AdministrationSalesPurchases;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report 50018;
            }
            action("Add Item To Deal")
            {
                Caption = 'add intem to Deal';
                Image = ItemSubstitution;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report 50030;
            }
            action("Mise à 0 qte Fact et Liv base")
            {
                Image = Purchasing;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report 50045;
            }
        }
    }
}
