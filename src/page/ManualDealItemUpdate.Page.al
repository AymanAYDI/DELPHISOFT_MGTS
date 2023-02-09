page 50081 "DEL Manual Deal Item Update"
{
    ApplicationArea = all;
    Editable = false;
    PageType = Card;
    SourceTable = Item;
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = true;
            }
            field("Weight net"; Rec."DEL Weight net")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Weight brut"; Rec."DEL Weight brut")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Vol cbm"; Rec.GetVolCBM(TRUE))
            {
                ApplicationArea = All;
            }
            field("Vol cbm carton transport"; Rec."DEL Vol cbm carton transport")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(PCB; Rec."DEL PCB")
            {
                ApplicationArea = All;
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
                ApplicationArea = All;
                Caption = 'Deal(s) update';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    DealItem_Cu.FNC_Manual_Update(Rec."No.");
                end;
            }
            action("Update Batch")
            {
                ApplicationArea = All;
                Caption = 'Update Batch';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

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
