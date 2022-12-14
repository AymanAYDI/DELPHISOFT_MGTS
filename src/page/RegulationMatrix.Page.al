page 50085 "DEL Regulation Matrix"
{


    Caption = 'Regulation Matrix';
    CardPageID = "DEL Regulation matrix Card";
    Editable = false;
    PageType = List;
    SourceTable = "DEL Regulation Matrix";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Caption = 'Product Group Code';
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    Caption = 'Item Category Description';
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    Caption = 'Product Group Description';
                }
                field(Mark; Rec.Mark)
                {
                    Caption = 'Mark';
                }
                field("Product Description"; Rec."Product Description")
                {
                    Caption = 'Description produit';
                }
                field("Risque Quality"; Rec."Risque Quality")
                {
                    Caption = 'Risk Quality';
                }
                field("NGTS Quality Expert"; Rec."NGTS Quality Expert")
                {
                    Caption = 'NGTS Quality Expert';
                }
                field("Regl. Generale"; Rec."Regl. Generale")
                {
                    Caption = 'General Product Regulation';
                }
                field("Regl. Matiere"; Rec."Regl. Matiere")
                {
                    Caption = 'Substance Regulation';
                }
                field("Plan of control"; Rec."Plan of control")
                {
                    Caption = 'Plan of control';
                }
                field("Manuel instruction"; Rec."Manuel instruction")
                {
                    Caption = 'Manuel instruction';
                }
                field("Warning instruction in French"; Rec."Warning instruction in French")
                {
                    Caption = 'Warning instruction in French';
                }
                field("Warning instruction in English"; Rec."Warning instruction in English")
                {
                    Caption = 'Warning instruction in English';
                }
                field("Instruction manual + Warning"; Rec."Instruction manual + Warning")
                {
                    Caption = 'Instruction manual (Yes/No) + Warning';
                }
                field("Marking in the product FR"; Rec."Marking in the product FR")
                {
                    Caption = 'Marking in the product (warning) + Pictogram type in French';
                }
                field("Marking in the pack FR"; Rec."Marking in the pack FR")
                {
                    Caption = 'Marking in the pack (warning + Pictogram) in French';
                }
                field("Marking in the product ENU"; Rec."Marking in the product ENU")
                {
                    Caption = 'Marking in the product (warning) + Pictogram type in English';
                }
                field("Marking in the pack ENU"; Rec."Marking in the pack ENU")
                {
                    Caption = 'Marking in the pack (warning + Pictogram) in English';
                }
                field("List Items Associated"; Rec."List Items Associated")
                {
                    DrillDown = true;
                    DrillDownPageID = "DEL Item Quality List";
                    Caption = 'List Items Associated';
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
                action("R??gl. G??n??rale")
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
                }
                action("R??gl. Mati??re")
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

