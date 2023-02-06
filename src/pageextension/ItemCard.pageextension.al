pageextension 50049 "DEL ItemCard" extends "Item Card" //30
{
    layout
    {
        addafter("Item Category Code")
        {
            field("DEL Item Category Description"; ItemCategoryDesc)
            {
                ApplicationArea = All;
            }
        }
        addbefore("Service Item Group")
        {
            field("DEL ProductGroupDesc"; ProductGroupDesc)
            {
                ApplicationArea = All;
            }
            // field("DEL Standardartikelgruppe"; Rec."Standardartikelgruppe") { }
            field("DEL Segment Code"; Rec."DEL Segment Code")
            {
                Enabled = True;
                Editable = false;
                Caption = 'Segment Code';
                ApplicationArea = All;
            }
            field("DEL DimensionValueDesc"; DimensionValueDesc)
            {
                Enabled = True;
                Editable = false;
                Caption = 'Dimension Value Description';
                ApplicationArea = All;
            }
        }
        addafter("Automatic Ext. Texts")
        {
            field("DEL Date de creation"; Rec."DEL Date de creation")
            {
                Editable = False;
                Caption = 'Date de creation';
                ApplicationArea = All;
            }
        }
        addafter("Gross Weight")
        {
            field("DEL Risk Item"; Rec."DEL Risk Item")
            {
                ApplicationArea = All;
            }
            field("DEL Code motif de suivi"; Rec."DEL Code motif de suivi")
            {
                ApplicationArea = All;
            }
        }
        addafter("Use Cross-Docking")
        {
            group("DEL NGTS")
            {
                Caption = 'NGTS';
                field("DEL Marque"; Rec."DEL Marque")
                {
                    ApplicationArea = All;
                }
                field("DEL MarqueDesc"; "MarqueDesc")
                {
                    ApplicationArea = All;
                }
                field("DEL OLD marque"; Rec."DEL OLD marque")
                {
                    ApplicationArea = All;
                }
                field("DEL Affectation vehicule"; Rec."DEL Affectation vehicule")
                {
                    ApplicationArea = All;
                }
                field("DEL Couleur1"; Rec."DEL Couleur1")
                {
                    ApplicationArea = All;
                }
                field("DEL Carac. complementaire"; Rec."DEL Carac. complementaire")
                {
                    ApplicationArea = All;
                }
                field("DEL Caracteristique technique 1"; Rec."DEL Carac. technique 1")
                {
                    ApplicationArea = All;
                }
                field("DEL Carac. technique 2"; Rec."DEL Carac. technique 2")
                {
                    ApplicationArea = All;
                }
                field("DEL Carac. technique 3"; Rec."DEL Carac. technique 3")
                {
                    ApplicationArea = All;
                }
                field("DEL Code EAN 13"; Rec."DEL Code EAN 13")
                {
                    ApplicationArea = All;
                }
                field("DEL PCB"; Rec."DEL PCB")
                {
                    ApplicationArea = All;
                }
                field("DEL SPCB"; Rec."DEL SPCB")
                {
                    ApplicationArea = All;
                }
                field("DEL Droit de douane reduit"; Rec."DEL Droit de douane reduit")
                {
                    ApplicationArea = All;
                }
                field("DEL Code nomenclature douaniere"; Rec."DEL Code nomenc. douaniere")
                {
                    ApplicationArea = All;
                }
                field("DEL Certified by QS"; Rec."DEL Certified by QS")
                {
                    ApplicationArea = All;
                }
                field("DEL Weight net"; Rec."DEL Weight net")
                {
                    ApplicationArea = All;
                }
                field("DEL Weight brut"; Rec."DEL Weight brut")
                {
                    ApplicationArea = All;
                }
                field("DEL Vol cbm"; Rec."DEL Vol cbm")
                {
                    Editable = false;
                    DecimalPlaces = 2 : 4;
                    ApplicationArea = All;
                }
                field("DEL Vol cbm carton transport"; Rec."DEL Vol cbm carton transport")
                {
                    DecimalPlaces = 2 : 4;
                    ApplicationArea = All;
                }
                field("DEL Length.old"; Rec."DEL Length.old")
                {
                    ApplicationArea = All;
                }
                field("DEL Width.old"; Rec."DEL Width.old")
                {
                    ApplicationArea = All;
                }
                field("DEL Depth.old"; Rec."DEL Depth.old")
                {
                    ApplicationArea = All;
                }
                group("DEL Packaging")
                {
                    field("DEL Packaging Language FR"; Rec."DEL Packaging Language FR")
                    {
                        ApplicationArea = All;
                    }
                    field("DEL Packaging Language IT"; Rec."DEL Packaging Language IT")
                    {
                        ApplicationArea = All;
                    }
                    field("DEL Packaging Language ES"; Rec."DEL Packaging Language ES")
                    {
                        ApplicationArea = All;
                    }
                    field("DEL Packaging Language NL"; Rec."DEL Packaging Language NL")
                    {
                        ApplicationArea = All;
                    }
                    field("DEL Packaging Language PT"; Rec."DEL Packaging Language PT")
                    {
                        ApplicationArea = All;
                    }
                    field("DEL Packaging Language PL"; Rec."DEL Packaging Language PL")
                    {
                        ApplicationArea = All;
                    }
                    field("DEL Packaging Language HG"; Rec."DEL Packaging Language HG")
                    {
                        ApplicationArea = All;
                    }
                    field("DEL Packaging Language RO"; Rec."DEL Packaging Language RO")
                    {
                        ApplicationArea = All;
                    }
                    field("DEL Packaging Language RU"; Rec."DEL Packaging Language RU")
                    {
                        ApplicationArea = All;
                    }

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
                ApplicationArea = All;
            }
            action("DEL Item Quality")
            {
                RunObject = Page "DEL Item Quality";
                RunPageLink = "No." = FIELD("No.");
                Promoted = true;
                PromotedIsBig = true;
                Image = Agreement;
                PromotedCategory = Process;
                ApplicationArea = All;
            }
            action("DEL Prices")
            {
                RunObject = Page "Purchase Prices";
                RunPageView = SORTING("Item No.");
                RunPageLink = "Item No." = FIELD("No.");
                Image = Price;
                ApplicationArea = All;
            }
            action("DEL Sales_Prices")
            {
                RunObject = Page "Sales Prices";
                RunPageView = SORTING("Item No.");
                RunPageLink = "Item No." = FIELD("No.");
                Image = Price;
                ApplicationArea = All;
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

