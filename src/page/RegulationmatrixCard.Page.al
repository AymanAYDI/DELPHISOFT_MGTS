page 50086 "Regulation matrix Card"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00716      THM     27.08.15           Create Object
    // T-00757      THM     07.01.16           add and modify Field
    // T-00758      THM     12.01.16           add new field
    // T-00783      THM     19.04.16           Ajout contrôle si tous les champs sont vide
    // T-00783      THM     29.04.16           Add field
    //              THM     26.08.16           modify captionML

    Caption = 'Regulation matrix Card';
    PageType = Card;
    SourceTable = Table50050;

    layout
    {
        area(content)
        {
            group("Record details")
            {
                Caption = 'Record details';
                field("Item Category Code"; "Item Category Code")
                {
                }
                field("Item Category Label"; "Item Category Label")
                {
                }
                field("Product Group Code"; "Product Group Code")
                {
                }
                field("Product Group Label"; "Product Group Label")
                {
                }
                field(Mark; Mark)
                {
                }
                field("Product Description"; "Product Description")
                {
                }
                field("Risque Quality"; "Risque Quality")
                {
                }
                field("NGTS Quality Expert"; "NGTS Quality Expert")
                {
                }
                field("Manuel instruction"; "Manuel instruction")
                {
                }
                field("Regl. Generale"; "Regl. Generale")
                {

                    trigger OnValidate()
                    begin
                        RegGenerale := "Regl. Generale";
                    end;
                }
                field("Regl. Matiere"; "Regl. Matiere")
                {

                    trigger OnValidate()
                    begin
                        RegMat := "Regl. Matiere";
                    end;
                }
                field("Plan of control"; "Plan of control")
                {

                    trigger OnValidate()
                    begin
                        PlanControl := "Plan of control";
                    end;
                }
                field("Warning instruction in French"; "Warning instruction in French")
                {
                }
                field("Warning instruction in English"; "Warning instruction in English")
                {
                }
                field("Marking in the product FR"; "Marking in the product FR")
                {
                    MultiLine = true;
                }
                field("Marking in the product ENU"; "Marking in the product ENU")
                {
                    MultiLine = true;
                }
                field("Marking in the pack FR"; "Marking in the pack FR")
                {
                    MultiLine = true;
                }
                field("Marking in the pack ENU"; "Marking in the pack ENU")
                {
                    MultiLine = true;
                }
                field("List Items Associated"; "List Items Associated")
                {
                    DrillDown = true;
                    DrillDownPageID = "Item Quality List";
                }
            }
            part(; 50090)
            {
                SubPageLink = Item Category Code=FIELD(Item Category Code),
                              Product Group Code=FIELD(Product Group Code),
                              Mark=FIELD(Mark),
                              Product Description=FIELD(Product Description);
                Visible = RegGenerale;
            }
            part(;50091)
            {
                SubPageLink = Item Category Code=FIELD(Item Category Code),
                              Product Group Code=FIELD(Product Group Code),
                              Mark=FIELD(Mark),
                              Product Description=FIELD(Product Description);
                Visible = RegMat;
            }
            part(;50092)
            {
                SubPageLink = Item Category Code=FIELD(Item Category Code),
                              Product Group Code=FIELD(Product Group Code),
                              Mark=FIELD(Mark),
                              Product Description=FIELD(Product Description);
                Visible = PlanControl;
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
                    RunObject = Page 50090;
                                    RunPageLink = Item Category Code=FIELD(Item Category Code),
                                  Product Group Code=FIELD(Product Group Code),
                                  Mark=FIELD(Mark),
                                  Product Description=FIELD(Product Description);
                    Visible = RegGenerale;
                }
                action("Régl. Matière")
                {
                    Caption = 'Substance regulation';
                    Image = ItemRegisters;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50091;
                                    RunPageLink = Item Category Code=FIELD(Item Category Code),
                                  Product Group Code=FIELD(Product Group Code),
                                  Mark=FIELD(Mark),
                                  Product Description=FIELD(Product Description);
                    Visible = RegMat;
                }
                action("Plan Control")
                {
                    Caption = 'Plan of control';
                    Image = Planning;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50092;
                                    RunPageLink = Item Category Code=FIELD(Item Category Code),
                                  Product Group Code=FIELD(Product Group Code),
                                  Mark=FIELD(Mark),
                                  Product Description=FIELD(Product Description);
                    Visible = PlanControl;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RegGenerale:="Regl. Generale";
        RegMat:="Regl. Matiere";
        PlanControl:="Plan of control";
        //deleteVar:=FALSE;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        deleteVar:=TRUE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF deleteVar=FALSE THEN
        BEGIN
          IF ("Item Category Code"='') AND ("Product Group Code"='') AND (Mark=Mark::" ") AND ("Product Description"='') AND ("Risque Quality"="Risque Quality"::" ") AND ("NGTS Quality Expert"="NGTS Quality Expert"::" ")THEN
          EXIT ELSE
          IF ("Item Category Code"='') OR ("Product Group Code"='') OR (Mark=Mark::" ") OR ("Product Description"='') OR ("Risque Quality"="Risque Quality"::" ") OR ("NGTS Quality Expert"="NGTS Quality Expert"::" ")THEN
          ERROR(Text0001,FIELDCAPTION("Item Category Code"),FIELDCAPTION("Product Group Code"),FIELDCAPTION(Mark),FIELDCAPTION("Product Description"),FIELDCAPTION("Risque Quality"),FIELDCAPTION("NGTS Quality Expert"))
        END;
    end;

    var
        RegGenerale: Boolean;
        RegMat: Boolean;
        PlanControl: Boolean;
        Text0001: Label 'The fields %1, %2, %3, %4, %5, %6 must not be empty.';
        deleteVar: Boolean;
}

