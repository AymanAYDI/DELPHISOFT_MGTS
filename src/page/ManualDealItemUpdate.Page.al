
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
                Caption = 'No.';
            }
            field(Description; Rec.Description)
            {
                Editable = false;
                Enabled = true;
                Caption = 'Description';
            }
            field("Weight net"; Rec."DEL Weight net")
            {
                Editable = false;
                Caption = 'DEL Weight net';
            }
            field("Weight brut"; Rec."DEL Weight brut")
            {
                Editable = false;
                Caption = 'DEL Weight brut';
            }
            field("Vol cbm"; Rec.GetVolCBM(TRUE))
            {
                Caption = 'Vol cbm';
            }
            field("Vol cbm carton transport"; Rec."DEL Vol cbm carton transport")
            {
                Editable = false;
                Caption = 'DEL Vol cbm carton transport';
            }
            field(PCB; Rec."DEL PCB")
            {
                Editable = false;
                Caption = 'DEL PCB';
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
                    //TODO: WE DIDNT BRING YET THE REPORTS 
                    REPORT.RUN(50032);

                end;
            }
        }
    }

    var
        DealItem_Cu: Codeunit "DEL Deal Item";
        Text19021811: Label 'D E A L   I T E M   U P D A T E';
}



