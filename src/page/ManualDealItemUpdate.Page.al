page 50081 "DEL Manual Deal Item Update"
{
    Editable = false;
    PageType = Card;
    SourceTable = Item;
    UsageCategory = Tasks;
    ApplicationArea = all;
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
                Editable = false;
                Enabled = true;
                ApplicationArea = All;
            }
            field("Weight net"; Rec."DEL Weight net")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Weight brut"; Rec."DEL Weight brut")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Vol cbm"; Rec.GetVolCBM(TRUE))
            {
                ApplicationArea = All;
            }
            field("Vol cbm carton transport"; Rec."DEL Vol cbm carton transport")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(PCB; Rec."DEL PCB")
            {
                Editable = false;
                ApplicationArea = All;
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
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;

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
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;

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
