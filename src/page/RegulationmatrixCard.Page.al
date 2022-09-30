page 50086 "DEL Regulation matrix Card"
{

    Caption = 'Regulation matrix Card';
    PageType = Card;
    SourceTable = "DEL Regulation Matrix";

    layout
    {
        area(content)
        {
            group("Record details")
            {
                Caption = 'Record details';
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    Caption = 'Item Category Description';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Caption = 'Product Group Code';
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
                field("Manuel instruction"; Rec."Manuel instruction")
                {
                    Caption = 'Manuel instruction';
                }
                field("Regl. Generale"; Rec."Regl. Generale")
                {
                    Caption = 'General Product Regulation';

                    trigger OnValidate()
                    begin
                        RegGenerale := Rec."Regl. Generale";
                    end;
                }
                field("Regl. Matiere"; Rec."Regl. Matiere")
                {
                    Caption = 'Substance Regulation';

                    trigger OnValidate()
                    begin
                        RegMat := Rec."Regl. Matiere";
                    end;
                }
                field("Plan of control"; Rec."Plan of control")
                {
                    Caption = 'Plan of control';

                    trigger OnValidate()
                    begin
                        PlanControl := Rec."Plan of control";
                    end;
                }
                field("Warning instruction in French"; Rec."Warning instruction in French")
                {
                    Caption = 'Warning instruction in French';
                }
                field("Warning instruction in English"; Rec."Warning instruction in English")
                {
                    Caption = 'Warning instruction in English';
                }
                field("Marking in the product FR"; Rec."Marking in the product FR")
                {
                    MultiLine = true;
                    Caption = 'Marking in the product (warning) + Pictogram type in French';
                }
                field("Marking in the product ENU"; Rec."Marking in the product ENU")
                {
                    MultiLine = true;
                    Caption = 'Marking in the product (warning) + Pictogram type in English';
                }
                field("Marking in the pack FR"; Rec."Marking in the pack FR")
                {
                    MultiLine = true;
                    Caption = 'Marking in the pack (warning + Pictogram) in French';
                }
                field("Marking in the pack ENU"; Rec."Marking in the pack ENU")
                {
                    MultiLine = true;
                    Caption = 'Marking in the pack (warning + Pictogram) in English';
                }
                field("List Items Associated"; Rec."List Items Associated")
                {
                    DrillDown = true;
                    DrillDownPageID = "Item Quality List";
                    Caption = 'List Items Associated';
                }
            }
            part("Matrix General regulation"; "DEL Matrix General regulation")
            {
                SubPageLink = "Item Category Code" = FIELD("Item Category Code"),
                              "Product Group Code" = FIELD("Product Group Code"),
                              Mark = FIELD(Mark),
                              "Product Description" = FIELD("Product Description");
                Visible = RegGenerale;
            }
            part("Matrix Substance regulation"; "DEL Matrix Sub. regulation")
            {
                SubPageLink = "Item Category Code" = FIELD("Item Category Code"),
                              "Product Group Code" = FIELD("Product Group Code"),
                              Mark = FIELD(Mark),
                              "Product Description" = FIELD("Product Description");
                Visible = RegMat;
            }
            part("Matrix Plan of Control"; "DEL Matrix Plan of Control")
            {
                SubPageLink = "Item Category Code" = FIELD("Item Category Code"),
                              "Product Group Code" = FIELD("Product Group Code"),
                              Mark = FIELD(Mark),
                              "Product Description" = FIELD("Product Description");
                Visible = PlanControl;
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
                    Visible = RegGenerale;
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

    trigger OnDeleteRecord(): Boolean
    begin
        deleteVar := TRUE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF deleteVar = FALSE THEN
            IF (Rec."Item Category Code" = '') AND (Rec."Product Group Code" = '') AND (Rec.Mark = Rec.Mark::" ") AND (Rec."Product Description" = '') AND (Rec."Risque Quality" = Rec."Risque Quality"::" ") AND (Rec."NGTS Quality Expert" = Rec."NGTS Quality Expert"::" ") THEN
                EXIT ELSE
                IF (Rec."Item Category Code" = '') OR (Rec."Product Group Code" = '') OR (Rec.Mark = Rec.Mark::" ") OR (Rec."Product Description" = '') OR (Rec."Risque Quality" = Rec."Risque Quality"::" ") OR (Rec."NGTS Quality Expert" = Rec."NGTS Quality Expert"::" ") THEN
                    ERROR(Text0001, Rec.FIELDCAPTION("Item Category Code"), Rec.FIELDCAPTION("Product Group Code"), Rec.FIELDCAPTION(Mark), Rec.FIELDCAPTION("Product Description"), Rec.FIELDCAPTION("Risque Quality"), Rec.FIELDCAPTION("NGTS Quality Expert"));
    end;

    var
        RegGenerale: Boolean;
        RegMat: Boolean;
        PlanControl: Boolean;
        Text0001: Label 'The fields %1, %2, %3, %4, %5, %6 must not be empty.';
        deleteVar: Boolean;
}

