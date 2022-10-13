pageextension 50034 pageextension50034 extends "Item List"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 14.10.13                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     USER    Date       Description
    // ---------------------------------------------------------------------------------
    // T-00716            THM   24.08.15    add Qualité produit page action
    // T-00716            THM   27.08.15    add CaptionML PageAction Item Quality
    // PIM                ChC   22.05.16    New button "Catalog Item Card NGTS"
    // 
    // Mgts10.00.05.00      04.01.2022 : Replace "Vol cbm" GetVolCBM
    layout
    {

        //Unsupported feature: Property Modification (SubPageLink) on "Control 3".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 26".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1901314507".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1903326807".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1906840407".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1901796907".

        addafter("Control 1102601026")
        {
            field("Vol cbm"; GetVolCBM(TRUE))
            {
                Caption = 'Vol cbm';
                DecimalPlaces = 2 : 4;
            }
            field("Date de peremption"; "Date de peremption")
            {
            }
            field("Estimated next delivery date"; "Estimated next delivery date")
            {
            }
            field("Code nomenclature douaniere"; "Code nomenclature douaniere")
            {
            }
            field("Date prochaine commande"; "Date prochaine commande")
            {
            }
            field("Qty. on Purch. Order"; "Qty. on Purch. Order")
            {
            }
            field("Qty. on Sales Order"; "Qty. on Sales Order")
            {
            }
            field("Qty. optimale"; "Qty. optimale")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 500".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 28".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 27".


        //Unsupported feature: Property Modification (RunPageLink) on "DimensionsSingle(Action 184)".


        //Unsupported feature: Property Modification (RunPageView) on "Action 14".


        //Unsupported feature: Property Modification (RunPageLink) on ""Prices_LineDiscounts"(Action 1900869004)".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 21".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 80".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 78".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 47".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 77".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 17".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 22".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 15".


        //Unsupported feature: Property Modification (RunPageLink) on ""Sales_LineDiscounts"(Action 34)".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 37".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 114".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 40".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 115".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 105".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 108".

        addafter("Action 30")
        {
            action("Catalog Item Card NGTS")
            {
                Caption = 'Catalog Item Card NGTS';
                Ellipsis = true;
                Image = Worksheet;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page 50121;
                RunPageLink = No.=FIELD(No.);
            }
        }
        addafter("Action 121")
        {
            action("Item Quality")
            {
                Caption = 'Item Quality';
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50077;
                                RunPageLink = No.=FIELD(No.);
            }
        }
    }
}

