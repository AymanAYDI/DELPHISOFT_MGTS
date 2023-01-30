page 50051 "DEL Outils de Corrections"
{
    Caption = 'Outils de Correction';
    PageType = Card;
    SourceTable = Integer;
    UsageCategory = Tasks;
    ApplicationArea = all;

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
                RunObject = Report "DEL Delete Elements";
            }
            action("Re-assigner une NC Vente à une affaire/shipment")
            {
                Caption = 'Re-assigner une NC Vente à une affaire/shipment';
                Image = StepInto;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL M Deal Cr. Memo Linking";
            }
            action("Re-assigner les lignes d'une Facture de vente à un ""code achat""")
            {
                Caption = 'Re-assigner les lignes d''une Facture de vente à un "code achat"';
                Image = Purchasing;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Corr. Facture enregistée";
            }
            action("Re-assigner une NC achat à une affaire/shipment")
            {
                Caption = 'Re-assigner une NC achat à une affaire/shipment';
                Image = CreateCreditMemo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL M Deal Pur. Cr. Memo Link";
            }
            action("Re-assigner une facture de frais achat à une affaire/shipment/code de frais")
            {
                Caption = 'Re-assigner une facture de frais achat à une affaire/shipment/code de frais';
                Image = ShowList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Manual Deal Invoice Link.";
            }
            action("Re-assigner les lignes d'une Facture de achat à un ""code achat""")
            {
                Caption = 'Re-assigner les lignes d''une Facture de achat à un "code achat"';
                Image = Purchasing;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Correctif Purchase Invoice";
            }
            action("Update Deal status")
            {
                Caption = 'Update Deal status';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "DEL Mise à jour statut";
            }
            action("Update facture vente/Affaire")
            {
                Image = AdministrationSalesPurchases;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "DEL update fact vente/affaires";
            }
            action("Add Item To Deal")
            {
                Caption = 'add intem to Deal';
                Image = ItemSubstitution;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "DEL Add Item to Deal";
            }
            action("Mise à 0 qte Fact et Liv base")
            {
                Image = Purchasing;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "DEL Miseà0 qteFact et Livbase";
            }
        }
    }
}
