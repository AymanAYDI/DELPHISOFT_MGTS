
page 50078 "DEL Item Quality List"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00716      THM     27.08.15           Create Object
    // T-00747      THM     17.11.15
    // T-00755      THM     04.01.16           Comment Code
    // T-00757      THM     07.01.16           add and modify Field
    // T-00758      THM     12.01.16           Change PageActions
    //              THM     29.04.16           add fields

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
                field("Item Category Code"; "DEL Item Category Code")
                {
                }
                field("Item Category Label"; "DEL Item Category Label")
                {
                }
                field("Product Group Code"; "Product Group Code")
                {
                }
                field("Product Group Label"; "Product Group Label")
                {
                }
                field("Risque Securitaire"; "Risque Securitaire")
                {
                }
                field("Marque Produit"; "Marque Produit")
                {
                }
                field("Product Description"; "Product Description")
                {
                }
                field("NGTS Quality Expert"; "NGTS Quality Expert")
                {
                }
                field("Regl. Generale"; "Regl. Generale")
                {
                }
                field("Regl. Matiere"; "Regl. Matiere")
                {
                }
                field("Regl. Plan Control"; "Regl. Plan Control")
                {
                }
                field("Marking in the product FR"; "Marking in the product FR")
                {
                }
                field("Marking in the pack FR"; "Marking in the pack FR")
                {
                }
                field("Marking in the product ENU"; "Marking in the product ENU")
                {
                }
                field("Marking in the pack ENU"; "Marking in the pack ENU")
                {
                }
                field("Manuel instruction"; "Manuel instruction")
                {
                }
                field(Warning; Warning)
                {
                }
                field("Nombre Regl. Generale"; "Nombre Regl. Generale")
                {
                }
                field("Nombre Regl. Matiere"; "Nombre Regl. Matiere")
                {
                }
                field("Blocking Quality"; "Blocking Quality")
                {
                }
                field("Nom utilisateur"; "Nom utilisateur")
                {
                }
                field("Date Of Update"; "Date Of Update")
                {
                }
                field(Dispensation; Dispensation)
                {
                }
                field("Nom utlisateur 2"; "Nom utlisateur 2")
                {
                }
                field("Date Of Update 2"; "Date Of Update 2")
                {
                }
                field("Checklist by item"; "Checklist by item")
                {
                    DrillDown = true;
                    DrillDownPageID = "Control list by category 2";
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
                    RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), Mark = FIELD("Marque Produit"), "Product Description" = FIELD("Product Description");
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
                    RunObject = Page "Matrix Substance regul List";
                    RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), Mark = FIELD("Marque Produit"), "Product Description" = FIELD("Product Description");
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
                    RunObject = Page "Matrix Plan of Control List";
                    RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), Mark = FIELD("Marque Produit"), "Product Description" = FIELD("Product Description");
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
        CALCFIELDS("Regl. Generale", "Regl. Matiere", "Regl. Plan Control");
        RegGenerale := "Regl. Generale";
        RegMat := "Regl. Matiere";
        RegPlan := "Regl. Plan Control";
    end;

    trigger OnOpenPage()
    begin
        SETFILTER("Regl. Type Filter", '1|2|3');
        SETFILTER("Regl. No. Filter", '<>%1', '');
    end;

    var
        Item_Rec: Record "Item";
        LiaisseProduit: Record "DEL Item Quality forms";
        RegGenerale: Boolean;
        RegMat: Boolean;
        RegPlan: Boolean;
        Regelect: Boolean;
        i: Integer;
}

