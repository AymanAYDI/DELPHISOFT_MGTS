page 50085 "DEL Regulation Matrix"
{
    ApplicationArea = all;
    Caption = 'Regulation Matrix';
    CardPageID = "DEL Regulation matrix Card";
    Editable = false;
    PageType = List;
    SourceTable = "DEL Regulation Matrix";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Caption = 'Item Category Code';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Product Group Code';
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    ApplicationArea = All;
                    Caption = 'Item Category Description';
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    ApplicationArea = All;
                    Caption = 'Product Group Description';
                }
                field(Mark; Rec.Mark)
                {
                    ApplicationArea = All;
                    Caption = 'Mark';
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = All;
                    Caption = 'Description produit';
                }
                field("Risque Quality"; Rec."Risque Quality")
                {
                    ApplicationArea = All;
                    Caption = 'Risk Quality';
                }
                field("NGTS Quality Expert"; Rec."NGTS Quality Expert")
                {
                    ApplicationArea = All;
                    Caption = 'NGTS Quality Expert';
                }
                field("Regl. Generale"; Rec."Regl. Generale")
                {
                    ApplicationArea = All;
                    Caption = 'General Product Regulation';
                }
                field("Regl. Matiere"; Rec."Regl. Matiere")
                {
                    ApplicationArea = All;
                    Caption = 'Substance Regulation';
                }
                field("Plan of control"; Rec."Plan of control")
                {
                    ApplicationArea = All;
                    Caption = 'Plan of control';
                }
                field("Manuel instruction"; Rec."Manuel instruction")
                {
                    ApplicationArea = All;
                    Caption = 'Manuel instruction';
                }
                field("Warning instruction in French"; Rec."Warning instruction in French")
                {
                    ApplicationArea = All;
                    Caption = 'Warning instruction in French';
                }
                field("Warning instruction in English"; Rec."Warning instruction in English")
                {
                    ApplicationArea = All;
                    Caption = 'Warning instruction in English';
                }
                field("Instruction manual + Warning"; Rec."Instruction manual + Warning")
                {
                    ApplicationArea = All;
                    Caption = 'Instruction manual (Yes/No) + Warning';
                }
                field("Marking in the product FR"; Rec."Marking in the product FR")
                {
                    ApplicationArea = All;
                    Caption = 'Marking in the product (warning) + Pictogram type in French';
                }
                field("Marking in the pack FR"; Rec."Marking in the pack FR")
                {
                    ApplicationArea = All;
                    Caption = 'Marking in the pack (warning + Pictogram) in French';
                }
                field("Marking in the product ENU"; Rec."Marking in the product ENU")
                {
                    ApplicationArea = All;
                    Caption = 'Marking in the product (warning) + Pictogram type in English';
                }
                field("Marking in the pack ENU"; Rec."Marking in the pack ENU")
                {
                    ApplicationArea = All;
                    Caption = 'Marking in the pack (warning + Pictogram) in English';
                }
                field("List Items Associated"; Rec."List Items Associated")
                {
                    ApplicationArea = All;
                    Caption = 'List Items Associated';
                    DrillDown = true;
                    DrillDownPageID = "DEL Item Quality List";
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Control1)
            {
                action("Régl. Générale")
                {
                    ApplicationArea = All;
                    Caption = 'General product regulation';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Matrix General regulation";
                    RunPageLink = "Item Category Code" = FIELD("Item Category Code"),
                                  "Product Group Code" = FIELD("Product Group Code"),
                                  Mark = FIELD(Mark),
                                  "Product Description" = FIELD("Product Description");
                    RunPageView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                                  ORDER(Ascending)
                                  WHERE(Type = FILTER("General product"));
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
                    RunObject = Page "DEL Matrix Sub. regulation";
                    RunPageLink = "Item Category Code" = FIELD("Item Category Code"),
                                  "Product Group Code" = FIELD("Product Group Code"),
                                  Mark = FIELD(Mark),
                                  "Product Description" = FIELD("Product Description");
                    RunPageView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                                  ORDER(Ascending)
                                  WHERE(Type = FILTER(Materials));
                    Visible = RegMat;
                }
                action("Plan Control")
                {
                    ApplicationArea = All;
                    Caption = 'Plan of control';
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Matrix Plan of Control";
                    RunPageLink = "Item Category Code" = FIELD("Item Category Code"),
                                  "Product Group Code" = FIELD("Product Group Code"),
                                  Mark = FIELD(Mark),
                                  "Product Description" = FIELD("Product Description");
                    RunPageView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                                  ORDER(Ascending)
                                  WHERE(Type = FILTER("Plan of control"));
                    Visible = PlanControl;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RegGenerale := Rec."Regl. Generale";
        RegMat := Rec."Regl. Matiere";
        PlanControl := Rec."Plan of control";
    end;

    var
        PlanControl: Boolean;
        RegGenerale: Boolean;
        RegMat: Boolean;
}

