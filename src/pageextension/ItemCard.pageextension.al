pageextension 50049 "DEL ItemCard" extends "Item Card" //30
{
    layout
    {
        addafter("Item Category Code")
        {
            field("DEL Item Category Description"; ItemCategoryDesc) { }
        }
        addbefore("Service Item Group")
        {
            field("DEL ProductGroupDesc"; ProductGroupDesc) { }
            // field("DEL Standardartikelgruppe"; Rec."Standardartikelgruppe") { }
            field("DEL Segment Code"; Rec."DEL Segment Code")
            {
                Enabled = True;
                Editable = false;
                Caption = 'Segment Code';
            }
            field("DEL DimensionValueDesc"; DimensionValueDesc)
            {
                Enabled = True;
                Editable = false;
                Caption = 'Dimension Value Description';
            }
        }
        addafter("Automatic Ext. Texts")
        {
            field("DEL Date de creation"; Rec."DEL Date de creation")
            {
                Editable = False;
                Caption = 'Date de creation';
            }
        }
        addafter("Gross Weight")
        {
            field("DEL Risk Item"; Rec."DEL Risk Item") { }
            field("DEL Code motif de suivi"; Rec."DEL Code motif de suivi") { }
        }
        addafter("Use Cross-Docking")
        {
            group("DEL NGTS")
            {
                Caption = 'NGTS';
                field("DEL Marque"; Rec."DEL Marque") { }
                field("DEL MarqueDesc"; "MarqueDesc") { }
                field("DEL OLD marque"; Rec."DEL OLD marque") { }
                field("DEL Affectation vehicule"; Rec."DEL Affectation vehicule") { }
                field("DEL Couleur1"; Rec."DEL Couleur1") { }
                field("DEL Carac. complementaire"; Rec."DEL Carac. complementaire") { }
                field("DEL Caracteristique technique 1"; Rec."DEL Carac. technique 1") { }
                field("DEL Carac. technique 2"; Rec."DEL Carac. technique 2") { }
                field("DEL Carac. technique 3"; Rec."DEL Carac. technique 3") { }
                field("DEL Code EAN 13"; Rec."DEL Code EAN 13") { }
                field("DEL PCB"; Rec."DEL PCB") { }
                field("DEL SPCB"; Rec."DEL SPCB") { }
                field("DEL Droit de douane reduit"; Rec."DEL Droit de douane reduit") { }
                field("DEL Code nomenclature douaniere"; Rec."DEL Code nomenc. douaniere") { }
                field("DEL Certified by QS"; Rec."DEL Certified by QS") { }
                field("DEL Weight net"; Rec."DEL Weight net") { }
                field("DEL Weight brut"; Rec."DEL Weight brut") { }
                field("DEL Vol cbm"; Rec."DEL Vol cbm")
                {
                    Editable = false;
                    DecimalPlaces = 2 : 4;
                }
                field("DEL Vol cbm carton transport"; Rec."DEL Vol cbm carton transport")
                {
                    DecimalPlaces = 2 : 4;
                }
                field("DEL Length.old"; Rec."DEL Length.old") { }
                field("DEL Width.old"; Rec."DEL Width.old") { }
                field("DEL Depth.old"; Rec."DEL Depth.old") { }
                group("DEL Packaging")
                {
                    field("DEL Packaging Language FR"; Rec."DEL Packaging Language FR") { }
                    field("DEL Packaging Language IT"; Rec."DEL Packaging Language IT") { }
                    field("DEL Packaging Language ES"; Rec."DEL Packaging Language ES") { }
                    field("DEL Packaging Language NL"; Rec."DEL Packaging Language NL") { }
                    field("DEL Packaging Language PT"; Rec."DEL Packaging Language PT") { }
                    field("DEL Packaging Language PL"; Rec."DEL Packaging Language PL") { }
                    field("DEL Packaging Language HG"; Rec."DEL Packaging Language HG") { }
                    field("DEL Packaging Language RO"; Rec."DEL Packaging Language RO") { }
                    field("DEL Packaging Language RU"; Rec."DEL Packaging Language RU") { }

                }
            }
        }
    }
    actions
    {
        addafter("Identifiers")
        {
            action("DEL Catalog Item Card NGTS")
            {
                Ellipsis = true;
                //TODO RunObject=Page 50121;
                //RunPageLink="No."=FIELD("No.");
                Promoted = true;
                PromotedIsBig = true;
                Image = Worksheet;
                PromotedCategory = New;
            }
            action("DEL Item Quality")
            {
                RunObject = Page "DEL Item Quality";
                RunPageLink = "No." = FIELD("No.");
                Promoted = true;
                PromotedIsBig = true;
                Image = Agreement;
                PromotedCategory = Process;
            }
            action("DEL Prices")
            {
                RunObject = Page "Purchase Prices";
                RunPageView = SORTING("Item No.");
                RunPageLink = "Item No." = FIELD("No.");
                Image = Price;
            }
            action("DEL Sales_Prices")
            {
                RunObject = Page "Sales Prices";
                RunPageView = SORTING("Item No.");
                RunPageLink = "Item No." = FIELD("No.");
                Image = Price;
            }
        }
    }
    var
        ItemCategory: Record 5722;
        ItemCategoryDesc: Text[50];
        //TODO ProductGroup : Record 5723;
        ProductGroupDesc: Text[50];
        DimensionValue: Record 349;
        DimensionValueDesc: Text[50];
        Marque_Rec: Record 5720;
        MarqueDesc: Text[50];

    trigger OnAfterGetRecord()
    begin
        CLEAR(MarqueDesc);
        CLEAR(ItemCategoryDesc);
        CLEAR(DimensionValueDesc);
        CLEAR(ProductGroupDesc);

        //TODO IF ItemCategory.GET("Item Category Code") THEN ItemCategoryDesc := ItemCategory.Description;

        // IF ProductGroup.GET("Item Category Code", "Product Group Code") THEN BEGIN
        //     ProductGroupDesc := ProductGroup.Description;
        //     IF ProductGroup."Code Segment" <> '' THEN
        //         IF DimensionValue.GET('SEGMENT', ProductGroup."Code Segment") THEN DimensionValueDesc := DimensionValue.Name;
        // END;

        // IF Marque_Rec.GET(Marque) THEN MarqueDesc := Marque_Rec.Name;
    end;
}

