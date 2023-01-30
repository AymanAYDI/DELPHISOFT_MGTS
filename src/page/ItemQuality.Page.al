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
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Quality Blocked';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Checklist by item"; Rec."DEL Checklist by item")
                {
                    DrillDown = true;
                    DrillDownPageID = "DEL Control list by category";
                    ApplicationArea = All;
                }
            }
            group("General quality product ID")
            {
                Caption = 'General quality product ID';
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    ApplicationArea = All;
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
                    DrillDown = true;
                    DrillDownPageID = "Matrix General regulation List";
                    ApplicationArea = All;
                }
                field("Nombre Regl. Matiere"; Rec."DEL Nombre Regl. Matiere")
                {
                    DrillDown = true;
                    DrillDownPageID = "DEL Matrix Sub. regul List";
                    ApplicationArea = All;
                }
                field("Nbre Regl. Plan control"; Rec."DEL Nbre Regl. Plan control")
                {
                    DrillDown = true;
                    DrillDownPageID = "DEL Matrix Plan of Cont. List";
                    ApplicationArea = All;
                }
            }
            part(Quality_status; "DEL Quality forms")
            {
                SubPageLink = "Item No." = FIELD("No.");
                ApplicationArea = All;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Of Update"; Rec."DEL Date Of Update")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Dispensation; Rec."DEL Dispensation")
                {
                    ApplicationArea = All;
                }
                field("Nom utlisateur 2"; Rec."DEL Nom utlisateur 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Date Of Update 2"; Rec."DEL Date Of Update 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part("Comment Sheet"; "Comment Sheet")
            {
                Editable = false;
                SubPageLink = "Table Name" = FILTER(Item), "No." = FIELD("No.");
                SubPageView = SORTING("Table Name", "No.", "Line No.") ORDER(Descending);
                ApplicationArea = All;
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
                    Caption = 'General product regulation';
                    Image = Register;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Matrix General regulation List";
                    // RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), Mark = FIELD("Marque Produit"), "Product Description" = FIELD("Product Description"); // TODO: Field 'Product Group Code' is removed. Reason: Product Groups became first level children of Item Categories
                    RunPageView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type) ORDER(Ascending) WHERE(Type = FILTER("General product"));
                    Visible = RegGenerale;
                    ApplicationArea = All;
                }
                action("Régl. Matière")
                {
                    Caption = 'Substance regulation';
                    Image = ItemRegisters;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Matrix Sub. regul List";
                    // RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), Mark = FIELD("Marque Produit"), "Product Description" = FIELD("Product Description"); // TODO: Field 'Product Group Code' is removed. Reason: Product Groups became first level children of Item Categories
                    RunPageView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type) ORDER(Ascending) WHERE(Type = FILTER(Materials));
                    Visible = RegMat;
                    ApplicationArea = All;
                }
                action("Reg. plan of control")
                {
                    Caption = 'Plan of control regulation';
                    Image = FARegisters;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Matrix Plan of Cont. List";
                    //RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), Mark = FIELD("Marque Produit"), "Product Description" = FIELD("Product Description"); // TODO: Field 'Product Group Code' is removed. Reason: Product Groups became first level children of Item Categories
                    RunPageMode = View;
                    RunPageView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                                  ORDER(Ascending)
                                  WHERE(Type = FILTER("Plan of control"));
                    Visible = RegPlan;
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedIsBig = true;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
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
