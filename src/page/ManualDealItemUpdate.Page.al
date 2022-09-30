
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
                Caption = 'Vol cbm';
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
                // todo 
                // trigger OnAction()
                // begin
                //     DealItem_Cu.FNC_Manual_Update(Rec."No.");
                // end;
            }
            action("Update Batch")
            {
                Caption = 'Update Batch';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //START THM
                    REPORT.RUN(50032);
                    //END THM 250817
                end;
            }
        }
    }

    var
        // DealItem_Cu: Codeunit "50024"; TODO: 
        Text19021811: Label 'D E A L   I T E M   U P D A T E';
}

#pragma implicitwith restore

