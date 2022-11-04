page 50062 "DEL Fixed deal affected"
{
    Caption = 'Fixed deal affected';
    Editable = false;
    PageType = List;
    SourceTable = "DEL Logistic";
    SourceTableView = WHERE("Display record" = FILTER('No'),
                            "BL N°" = FILTER(<> ''));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(ID; Rec.ID)
                {
                }
                field(Deal_ID; Rec.Deal_ID)
                {
                }
                field("ACO No."; Rec."ACO No.")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field("BL N°"; Rec."BL N°")
                {

                }
                field("Display record"; Rec."Display record")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Affectation manuelle"; Rec."Affectation manuelle")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Delete BL No.")
            {
                Caption = 'Delete BL No.';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Text00001: Label 'Impossible de supprimer ce BL.';
                begin
                    IF NOT CONFIRM(Text0001, FALSE) THEN EXIT;

                    Booking_Num := Rec."BL N°";
                    TrackingGeneral.RESET();
                    TrackingGeneral.SETRANGE(Booking_no, Booking_Num);
                    TrackingGeneral.SETRANGE(Order_no, Rec."ACO No.");
                    IF TrackingGeneral.FINDFIRST() THEN
                        REPEAT
                            TrackingGeneral.Statut := '';
                            TrackingGeneral.MODIFY();
                        UNTIL TrackingGeneral.NEXT() = 0
                    ELSE
                        ERROR(Text00001);


                    TrackingDetail.SETRANGE(Booking_no, Booking_Num);
                    TrackingDetail.SETRANGE(Order_no, Rec."ACO No.");
                    IF TrackingDetail.FINDFIRST() THEN
                        REPEAT
                            TrackingDetail.Statut := '';
                            TrackingDetail.MODIFY();
                        UNTIL TrackingDetail.NEXT() = 0;
                    Rec."BL N°" := '';
                    Rec."Forwarder Name" := '';
                    Rec."Supplier Name" := '';
                    Rec."Departure Port" := '';
                    Rec."ETD Requested" := 0D;
                    Rec."Revised ETD" := 0D;
                    Rec."Actual departure date" := 0D;
                    Rec."Arrival port" := '';
                    Rec."Shipping company" := '';
                    Rec."Vessel name" := '';
                    Rec."Actual Arrival date" := 0D;
                    Rec."Customer Delivery date" := 0D;
                    Rec."Display record" := TRUE;
                    Rec.MODIFY();
                    CurrPage.UPDATE();


                end;
            }
        }
    }



    var
        TrackingDetail: Record "DEL Tracking détail";
        TrackingGeneral: Record "DEL Tracking général";
        Text0001: Label 'Do you want to remove BL No ?';

        Booking_Num: Text[50];
}

