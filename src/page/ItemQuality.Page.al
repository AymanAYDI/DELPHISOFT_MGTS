page 50077 "DEL Item Quality"
{
   
    Caption = 'Item Quality';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Table27;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Base Unit of Measure"; "Base Unit of Measure")
                {
                    Editable = false;
                }
                field(Blocked; Blocked)
                {
                    Caption = 'Quality Blocked';
                    Editable = false;
                }
                field("Checklist by item"; "Checklist by item")
                {
                    DrillDown = true;
                    DrillDownPageID = "Control list by category";
                }
            }
            group("General quality product ID")
            {
                Caption = 'General quality product ID';
                field("Item Category Code"; "Item Category Code")
                {
                    Editable = false;
                }
                field("Item Category Label"; "Item Category Label")
                {
                }
                field("Product Group Code"; "Product Group Code")
                {
                    Editable = false;
                }
                field("Product Group Label"; "Product Group Label")
                {
                }
                field("Marque Produit"; "Marque Produit")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Product Description"; "Product Description")
                {

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Risque Securitaire"; "Risque Securitaire")
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
            }
            group("Regulation identification of the product")
            {
                Caption = 'Regulation identification of the product';
                field("Nombre Regl. Generale"; "Nombre Regl. Generale")
                {
                    DrillDown = true;
                    DrillDownPageID = "Matrix General regulation List";
                }
                field("Nombre Regl. Matiere"; "Nombre Regl. Matiere")
                {
                    DrillDown = true;
                    DrillDownPageID = "Matrix Substance regul List";
                }
                field("Nbre Regl. Plan control"; "Nbre Regl. Plan control")
                {
                    DrillDown = true;
                    DrillDownPageID = "Matrix Plan of Control List";
                }
            }
            part(; 50046)
            {
                SubPageLink = Item No.=FIELD(No.);
            }
            group("Quality status")
            {
                Caption = 'Quality status';
                field("Blocking Quality"; "Blocking Quality")
                {
                }
                field("Nom utilisateur"; "Nom utilisateur")
                {
                    Editable = false;
                }
                field("Date Of Update"; "Date Of Update")
                {
                    Editable = false;
                }
                field(Dispensation; Dispensation)
                {
                }
                field("Nom utlisateur 2"; "Nom utlisateur 2")
                {
                    Editable = false;
                }
                field("Date Of Update 2"; "Date Of Update 2")
                {
                    Editable = false;
                }
            }
            part(; 124)
            {
                Editable = false;
                SubPageLink = Table Name=FILTER(Item),
                              No.=FIELD(No.);
                SubPageView = SORTING(Table Name,No.,Line No.)
                              ORDER(Descending);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group()
            {
                action("Régl. Générale")
                {
                    Caption = 'General product regulation';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50111;
                                    RunPageLink = Item Category Code=FIELD(Item Category Code),
                                  Product Group Code=FIELD(Product Group Code),
                                  Mark=FIELD(Marque Produit),
                                  Product Description=FIELD(Product Description);
                    RunPageView = SORTING(Item Category Code,Product Group Code,Mark,Product Description,No.,Type)
                                  ORDER(Ascending)
                                  WHERE(Type=FILTER(General product));
                    Visible = RegGenerale;
                }
                action("Régl. Matière")
                {
                    Caption = 'Substance regulation';
                    Image = ItemRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50112;
                                    RunPageLink = Item Category Code=FIELD(Item Category Code),
                                  Product Group Code=FIELD(Product Group Code),
                                  Mark=FIELD(Marque Produit),
                                  Product Description=FIELD(Product Description);
                    RunPageView = SORTING(Item Category Code,Product Group Code,Mark,Product Description,No.,Type)
                                  ORDER(Ascending)
                                  WHERE(Type=FILTER(Materials));
                    Visible = RegMat;
                }
                action("Reg. plan of control")
                {
                    Caption = 'Plan of control regulation';
                    Image = FARegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50113;
                                    RunPageLink = Item Category Code=FIELD(Item Category Code),
                                  Product Group Code=FIELD(Product Group Code),
                                  Mark=FIELD(Marque Produit),
                                  Product Description=FIELD(Product Description);
                    RunPageMode = View;
                    RunPageView = SORTING(Item Category Code,Product Group Code,Mark,Product Description,No.,Type)
                                  ORDER(Ascending)
                                  WHERE(Type=FILTER(Plan of control));
                    Visible = RegPlan;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 124;
                                    RunPageLink = Table Name=CONST(Item),
                                  No.=FIELD(No.);
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        CALCFIELDS("Regl. Generale","Regl. Matiere","Regl. Plan Control");
        RegGenerale:="Regl. Generale";
        RegMat:="Regl. Matiere";
        RegPlan:="Regl. Plan Control";
    end;

    var
        RegGenerale: Boolean;
        RegMat: Boolean;
        RegPlan: Boolean;
        Regelect: Boolean;
        Item_Rec: Record "27";
        LiaisseProduit: Record "50056";
        i: Integer;
        regArticle: Record "50058";
        RegGenerale2: Boolean;
        RegMat2: Boolean;
        RegMachine2: Boolean;
        Regelect2: Boolean;
        GeneralSetup: Record "50000";
        Cat1: Decimal;
        Cat2: Decimal;
        Cat3: Decimal;
}

