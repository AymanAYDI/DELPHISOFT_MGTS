page 50078 "DEL Item Quality List"
{
    ApplicationArea = all;
    Caption = 'Item Quality List';
    CardPageID = "DEL Item Quality";
    DataCaptionFields = "DEL Regl. Type Filter", "DEL Regl. No. Filter";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    RefreshOnActivate = true;
    SaveValues = true;
    ShowFilter = true;
    SourceTable = "Item";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater("Général")
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
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Item Category Label"; Rec."DEL Item Category Label")
                {
                    ApplicationArea = All;
                }
                // field("Product Group Code"; Rec."Product Group Code") // TODO: Field 'Product Group Code' is removed. Reason: Product Groups became first level children of Item Categories
                // {
                // }
                field("Product Group Label"; Rec."DEL Product Group Label")
                {
                    ApplicationArea = All;
                }
                field("Risque Securitaire"; Rec."DEL Risque Securitaire")
                {
                    ApplicationArea = All;
                }
                field("Marque Produit"; Rec."DEL Marque Produit")
                {
                    ApplicationArea = All;
                }
                field("Product Description"; Rec."DEL Product Description")
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
                field("Nombre Regl. Generale"; Rec."DEL Nombre Regl. Generale")
                {
                    ApplicationArea = All;
                }
                field("Nombre Regl. Matiere"; Rec."DEL Nombre Regl. Matiere")
                {
                    ApplicationArea = All;
                }
                field("Blocking Quality"; Rec."DEL Blocking Quality")
                {
                    ApplicationArea = All;
                }
                field("Nom utilisateur"; Rec."DEL Nom utilisateur")
                {
                    ApplicationArea = All;
                }
                field("Date Of Update"; Rec."DEL Date Of Update")
                {
                    ApplicationArea = All;
                }
                field(Dispensation; Rec."DEL Dispensation")
                {
                    ApplicationArea = All;
                }
                field("Nom utlisateur 2"; Rec."DEL Nom utlisateur 2")
                {
                    ApplicationArea = All;
                }
                field("Date Of Update 2"; Rec."DEL Date Of Update 2")
                {
                    ApplicationArea = All;
                }
                field("Checklist by item"; Rec."DEL Checklist by item")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageID = "DEL Control list by category 2";
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(group)
            {
                action("Régl. Générale")
                {
                    ApplicationArea = All;
                    Caption = 'General product regulation';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Matrix General regulation List";
                    //TODO RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), Mark = FIELD("Marque Produit"), "Product Description" = FIELD("Product Description"); // TODO: Field 'Product Group Code' is removed. Reason: Product Groups became first level children of Item Categories
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
                    RunObject = Page "DEL Matrix Sub. regul List";
                    //TODO RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), Mark = FIELD("Marque Produit"), "Product Description" = FIELD("Product Description"); // TODO: Field 'Product Group Code' is removed. Reason: Product Groups became first level children of Item Categories
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
                    RunObject = Page "DEL Matrix Plan of Cont. List";
                    //TODO RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), Mark = FIELD("Marque Produit"), "Product Description" = FIELD("Product Description"); // TODO: Field 'Product Group Code' is removed. Reason: Product Groups became first level children of Item Categories
                    RunPageMode = View;
                    RunPageView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                                  ORDER(Ascending)
                                  WHERE(Type = FILTER("Plan of control"));
                    Visible = Regplan;
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

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("DEL Regl. Type Filter", '1|2|3');
        Rec.SETFILTER("DEL Regl. No. Filter", '<>%1', '');
    end;

    var
        RegGenerale: Boolean;
        RegMat: Boolean;
        RegPlan: Boolean;
}
