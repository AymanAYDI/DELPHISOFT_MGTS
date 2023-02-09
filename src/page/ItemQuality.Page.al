page 50077 "DEL Item Quality"
{
    Caption = 'Item Quality';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Item;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Caption = 'Quality Blocked';
                    Editable = false;
                }
                field("Checklist by item"; Rec."DEL Checklist by item")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageID = "DEL Control list by category";
                }
            }
            group("General quality product ID")
            {
                Caption = 'General quality product ID';
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item Category Label"; Rec."DEL Item Category Label")
                {
                    ApplicationArea = All;
                }
                // field("Product Group Code"; Rec."Product Group Code") // TODO: Field 'Product Group Code' is removed. Reason: Product Groups became first level children of Item Categories
                // {
                //     Editable = false;
                // }
                field("Product Group Label"; Rec."DEL Product Group Label")
                {
                    ApplicationArea = All;
                }
                field("Marque Produit"; Rec."DEL Marque Produit")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE();
                    end;
                }
                field("Product Description"; Rec."DEL Product Description")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE();
                    end;
                }
                field("Risque Securitaire"; Rec."DEL Risque Securitaire")
                {
                    ApplicationArea = All;
                }
                field("NGTS Quality Expert"; Rec."DEL NGTS Quality Expert")
                {
                    ApplicationArea = All;
                }
                field("Regl. Generale"; Rec."DEL Regl. Generale")
                {
                    ApplicationArea = All;
                }
                field("Regl. Matiere"; Rec."DEL Regl. Matiere")
                {
                    ApplicationArea = All;
                }
                field("Regl. Plan Control"; Rec."DEL Regl. Plan Control")
                {
                    ApplicationArea = All;
                }
                field("Marking in the product FR"; Rec."DEL Marking in the product FR")
                {
                    ApplicationArea = All;
                }
                field("Marking in the pack FR"; Rec."DEL Marking in the pack FR")
                {
                    ApplicationArea = All;
                }
                field("Marking in the product ENU"; Rec."DEL Marking in the product ENU")
                {
                    ApplicationArea = All;
                }
                field("Marking in the pack ENU"; Rec."DEL Marking in the pack ENU")
                {
                    ApplicationArea = All;
                }
                field("Manuel instruction"; Rec."DEL Manuel instruction")
                {
                    ApplicationArea = All;
                }
                field(Warning; Rec."DEL Warning")
                {
                    ApplicationArea = All;
                }
            }
            group("Regulation identification of the product")
            {
                Caption = 'Regulation identification of the product';
                field("Nombre Regl. Generale"; Rec."DEL Nombre Regl. Generale")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageID = "Matrix General regulation List";
                }
                field("Nombre Regl. Matiere"; Rec."DEL Nombre Regl. Matiere")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageID = "DEL Matrix Sub. regul List";
                }
                field("Nbre Regl. Plan control"; Rec."DEL Nbre Regl. Plan control")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageID = "DEL Matrix Plan of Cont. List";
                }
            }
            part(Quality_status; "DEL Quality forms")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = FIELD("No.");
            }
            group("Quality status")
            {
                Caption = 'Quality status';
                field("Blocking Quality"; Rec."DEL Blocking Quality")
                {
                    ApplicationArea = All;
                }
                field("Nom utilisateur"; Rec."DEL Nom utilisateur")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Of Update"; Rec."DEL Date Of Update")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Dispensation; Rec."DEL Dispensation")
                {
                    ApplicationArea = All;
                }
                field("Nom utlisateur 2"; Rec."DEL Nom utlisateur 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Of Update 2"; Rec."DEL Date Of Update 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part("Comment Sheet"; "Comment Sheet")
            {
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Table Name" = FILTER(Item), "No." = FIELD("No.");
                SubPageView = SORTING("Table Name", "No.", "Line No.") ORDER(Descending);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1)
            {
                action("Régl. Générale")
                {
                    ApplicationArea = All;
                    Caption = 'General product regulation';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Matrix General regulation List";
                    // RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), Mark = FIELD("Marque Produit"), "Product Description" = FIELD("Product Description"); // TODO: Field 'Product Group Code' is removed. Reason: Product Groups became first level children of Item Categories
                    RunPageView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type) ORDER(Ascending) WHERE(Type = FILTER("General product"));
                    Visible = RegGenerale;
                }
                action("Régl. Matière")
                {
                    ApplicationArea = All;
                    Caption = 'Substance regulation';
                    Image = ItemRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "DEL Matrix Sub. regul List";
                    // RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), Mark = FIELD("Marque Produit"), "Product Description" = FIELD("Product Description"); // TODO: Field 'Product Group Code' is removed. Reason: Product Groups became first level children of Item Categories
                    RunPageView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type) ORDER(Ascending) WHERE(Type = FILTER(Materials));
                    Visible = RegMat;
                }
                action("Reg. plan of control")
                {
                    ApplicationArea = All;
                    Caption = 'Plan of control regulation';
                    Image = FARegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "DEL Matrix Plan of Cont. List";
                    //RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), Mark = FIELD("Marque Produit"), "Product Description" = FIELD("Product Description"); // TODO: Field 'Product Group Code' is removed. Reason: Product Groups became first level children of Item Categories
                    RunPageMode = View;
                    RunPageView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                                  ORDER(Ascending)
                                  WHERE(Type = FILTER("Plan of control"));
                    Visible = RegPlan;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        Rec.CALCFIELDS("DEL Regl. Generale", "DEL Regl. Matiere", "DEL Regl. Plan Control");
        RegGenerale := Rec."DEL Regl. Generale";
        RegMat := Rec."DEL Regl. Matiere";
        RegPlan := Rec."DEL Regl. Plan Control";
    end;

    var
        RegGenerale: Boolean;
        RegMat: Boolean;
        RegPlan: Boolean;
}
