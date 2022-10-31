page 50078 "DEL Item Quality List"
{

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

    layout
    {
        area(content)
        {
            repeater("Général")
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    Caption = 'Quality Blocked';
                    Editable = false;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                }
                field("Item Category Label"; Rec."DEL Item Category Label")
                {
                }
                // field("Product Group Code"; Rec."Product Group Code") // TODO: Field 'Product Group Code' is removed. Reason: Product Groups became first level children of Item Categories
                // {
                // }
                field("Product Group Label"; Rec."DEL Product Group Label")
                {
                }
                field("Risque Securitaire"; Rec."DEL Risque Securitaire")
                {
                }
                field("Marque Produit"; Rec."DEL Marque Produit")
                {
                }
                field("Product Description"; Rec."DEL Product Description")
                {
                }
                field("NGTS Quality Expert"; Rec."DEL NGTS Quality Expert")
                {
                }
                field("Regl. Generale"; Rec."DEL Regl. Generale")
                {
                }
                field("Regl. Matiere"; Rec."DEL Regl. Matiere")
                {
                }
                field("Regl. Plan Control"; Rec."DEL Regl. Plan Control")
                {
                }
                field("Marking in the product FR"; Rec."DEL Marking in the product FR")
                {
                }
                field("Marking in the pack FR"; Rec."DEL Marking in the pack FR")
                {
                }
                field("Marking in the product ENU"; Rec."DEL Marking in the product ENU")
                {
                }
                field("Marking in the pack ENU"; Rec."DEL Marking in the pack ENU")
                {
                }
                field("Manuel instruction"; Rec."DEL Manuel instruction")
                {
                }
                field(Warning; Rec."DEL Warning")
                {
                }
                field("Nombre Regl. Generale"; Rec."DEL Nombre Regl. Generale")
                {
                }
                field("Nombre Regl. Matiere"; Rec."DEL Nombre Regl. Matiere")
                {
                }
                field("Blocking Quality"; Rec."DEL Blocking Quality")
                {
                }
                field("Nom utilisateur"; Rec."DEL Nom utilisateur")
                {
                }
                field("Date Of Update"; Rec."DEL Date Of Update")
                {
                }
                field(Dispensation; Rec."DEL Dispensation")
                {
                }
                field("Nom utlisateur 2"; Rec."DEL Nom utlisateur 2")
                {
                }
                field("Date Of Update 2"; Rec."DEL Date Of Update 2")
                {
                }
                field("Checklist by item"; Rec."DEL Checklist by item")
                {
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
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedIsBig = true;
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

