page 50085 "Regulation Matrix"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00716      THM     27.08.15           Create Object
    // T-00755      THM     05.01.16           Add new field
    // T-00757      THM     07.01.16           add and modify Field
    // T-00783      THM     29.04.16           add field

    Caption = 'Regulation Matrix';
    CardPageID = "Regulation matrix Card";
    Editable = false;
    PageType = List;
    SourceTable = Table50050;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; "Item Category Code")
                {
                }
                field("Product Group Code"; "Product Group Code")
                {
                }
                field("Item Category Label"; "Item Category Label")
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
                field("Regl. Generale"; "Regl. Generale")
                {
                }
                field("Regl. Matiere"; "Regl. Matiere")
                {
                }
                field("Plan of control"; "Plan of control")
                {
                }
                field("Manuel instruction"; "Manuel instruction")
                {
                }
                field("Warning instruction in French"; "Warning instruction in French")
                {
                }
                field("Warning instruction in English"; "Warning instruction in English")
                {
                }
                field("Instruction manual + Warning"; "Instruction manual + Warning")
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
                field("List Items Associated"; "List Items Associated")
                {
                    DrillDown = true;
                    DrillDownPageID = "Item Quality List";
                }
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
                    RunObject = Page 50091;
                                    RunPageLink = Item Category Code=FIELD(Item Category Code),
                                  Product Group Code=FIELD(Product Group Code),
                                  Mark=FIELD(Mark),
                                  Product Description=FIELD(Product Description);
                    RunPageView = SORTING(Item Category Code,Product Group Code,Mark,Product Description,No.,Type)
                                  ORDER(Ascending)
                                  WHERE(Type=FILTER(Materials));
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
                    RunPageView = SORTING(Item Category Code,Product Group Code,Mark,Product Description,No.,Type)
                                  ORDER(Ascending)
                                  WHERE(Type=FILTER(Plan of control));
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
    end;

    var
        RegGenerale: Boolean;
        RegMat: Boolean;
        PlanControl: Boolean;
}
