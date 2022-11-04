
page 50081 "DEL Manual Deal Item Update"
{

    Editable = false;
    PageType = Card;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
            }
            field(Description; Rec.Description)
            {
                Editable = false;
                Enabled = true;
            }
            field("Weight net"; Rec."DEL Weight net")
            {
                Editable = false;
            }
            field("Weight brut"; Rec."DEL Weight brut")
            {
                Editable = false;
            }
            field("Vol cbm"; Rec.GetVolCBM(TRUE))
            {
            }
            field("Vol cbm carton transport"; Rec."DEL Vol cbm carton transport")
            {
                Editable = false;
            }
            field(PCB; Rec."DEL PCB")
            {
                Editable = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Deal(s) update")
            {
                Caption = 'Deal(s) update';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    DealItem_Cu.FNC_Manual_Update(Rec."No.");
                end;
            }
            action("Update Batch")
            {
                Caption = 'Update Batch';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    REPORT.RUN(Report::"DEL Deal items Update");

                end;
            }
        }
    }

    var
        DealItem_Cu: Codeunit "DEL Deal Item";
}



