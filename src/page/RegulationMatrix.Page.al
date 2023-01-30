page 50085 "DEL Regulation Matrix"
{
    Caption = 'Regulation Matrix';
    CardPageID = "DEL Regulation matrix Card";
    Editable = false;
    PageType = List;
    SourceTable = "DEL Regulation Matrix";
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Caption = 'Product Group Code';
                    ApplicationArea = All;
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    Caption = 'Item Category Description';
                    ApplicationArea = All;
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    Caption = 'Product Group Description';
                    ApplicationArea = All;
                }
                field(Mark; Rec.Mark)
                {
                    Caption = 'Mark';
                    ApplicationArea = All;
                }
                field("Product Description"; Rec."Product Description")
                {
                    Caption = 'Description produit';
                    ApplicationArea = All;
                }
                field("Risque Quality"; Rec."Risque Quality")
                {
                    Caption = 'Risk Quality';
                    ApplicationArea = All;
                }
                field("NGTS Quality Expert"; Rec."NGTS Quality Expert")
                {
                    Caption = 'NGTS Quality Expert';
                    ApplicationArea = All;
                }
                field("Regl. Generale"; Rec."Regl. Generale")
                {
                    Caption = 'General Product Regulation';
                    ApplicationArea = All;
                }
                field("Regl. Matiere"; Rec."Regl. Matiere")
                {
                    Caption = 'Substance Regulation';
                    ApplicationArea = All;
                }
                field("Plan of control"; Rec."Plan of control")
                {
                    Caption = 'Plan of control';
                    ApplicationArea = All;
                }
                field("Manuel instruction"; Rec."Manuel instruction")
                {
                    Caption = 'Manuel instruction';
                    ApplicationArea = All;
                }
                field("Warning instruction in French"; Rec."Warning instruction in French")
                {
                    Caption = 'Warning instruction in French';
                    ApplicationArea = All;
                }
                field("Warning instruction in English"; Rec."Warning instruction in English")
                {
                    Caption = 'Warning instruction in English';
                    ApplicationArea = All;
                }
                field("Instruction manual + Warning"; Rec."Instruction manual + Warning")
                {
                    Caption = 'Instruction manual (Yes/No) + Warning';
                    ApplicationArea = All;
                }
                field("Marking in the product FR"; Rec."Marking in the product FR")
                {
                    Caption = 'Marking in the product (warning) + Pictogram type in French';
                    ApplicationArea = All;
                }
                field("Marking in the pack FR"; Rec."Marking in the pack FR")
                {
                    Caption = 'Marking in the pack (warning + Pictogram) in French';
                    ApplicationArea = All;
                }
                field("Marking in the product ENU"; Rec."Marking in the product ENU")
                {
                    Caption = 'Marking in the product (warning) + Pictogram type in English';
                    ApplicationArea = All;
                }
                field("Marking in the pack ENU"; Rec."Marking in the pack ENU")
                {
                    Caption = 'Marking in the pack (warning + Pictogram) in English';
                    ApplicationArea = All;
                }
                field("List Items Associated"; Rec."List Items Associated")
                {
                    DrillDown = true;
                    DrillDownPageID = "DEL Item Quality List";
                    Caption = 'List Items Associated';
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                }
                action("Régl. Matière")
                {
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
                    ApplicationArea = All;
                }
                action("Plan Control")
                {
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
                    ApplicationArea = All;
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

