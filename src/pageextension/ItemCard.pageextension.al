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
                ApplicationArea = All;
                Caption = 'Segment Code';
                Editable = false;
                Enabled = True;
            }
            field("DEL DimensionValueDesc"; DimensionValueDesc)
            {
                ApplicationArea = All;
                Caption = 'Dimension Value Description';
                Editable = false;
                Enabled = True;
            }
        }
        addafter("Automatic Ext. Texts")
        {
            field("DEL Date de creation"; Rec."DEL Date de creation")
            {
                ApplicationArea = All;
                Caption = 'Date de creation';
                Editable = False;
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
                    ApplicationArea = All;
                    DecimalPlaces = 2 : 4;
                    Editable = false;
                }
                field("DEL Vol cbm carton transport"; Rec."DEL Vol cbm carton transport")
                {
                    ApplicationArea = All;
                    DecimalPlaces = 2 : 4;
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
                ApplicationArea = All;
                Ellipsis = true;
                Image = Worksheet;
                //TODO RunObject=Page 50121;
                //RunPageLink="No."=FIELD("No.");
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
            }
            action("DEL Item Quality")
            {
                ApplicationArea = All;
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Item Quality";
                RunPageLink = "No." = FIELD("No.");
            }
            action("DEL Prices")
            {
                ApplicationArea = All;
                Image = Price;
                RunObject = Page "Purchase Prices";
                RunPageLink = "Item No." = FIELD("No.");
                RunPageView = SORTING("Item No.");
            }
            action("DEL Sales_Prices")
            {
                ApplicationArea = All;
                Image = Price;
                RunObject = Page "Sales Prices";
                RunPageLink = "Item No." = FIELD("No.");
                RunPageView = SORTING("Item No.");
            }
        }
    }
    var
        DimensionValue: Record "Dimension Value";
        Marque_Rec: Record Manufacturer;
        ItemCategory: Record "Item Category";
        //TODO ProductGroup : Record 5723;
        DimensionValueDesc: Text[50];
        ItemCategoryDesc: Text[50];
        MarqueDesc: Text[50];
        ProductGroupDesc: Text[50];

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

