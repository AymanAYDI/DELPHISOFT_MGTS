page 50057 "DEL Affaire non affectée"
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = "DEL Logistic";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(ID; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(Deal_ID; Rec.Deal_ID)
                {
                    Caption = 'Deal_ID';
                }
                field("ACO No."; Rec."ACO No.")
                {
                    Caption = 'ACO No.';
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Caption = 'Supplier Name';
                }
                field("BL N°"; Rec."BL N°")
                {
                    Caption = 'BL N°';

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        TrackingGeneral.SETRANGE(Order_no, Rec."ACO No.");

                        IF PAGE.RUNMODAL(PAGE::"DEL Propostition tracking", TrackingGeneral) = ACTION::LookupOK THEN BEGIN

                            Rec."BL N°" := TrackingGeneral.Booking_no;
                            Rec."Forwarder Name" := TrackingGeneral.Forwading_agent_no;
                            Rec."Supplier Name" := TrackingGeneral.Vendor_no;
                            Rec."Departure Port" := TrackingGeneral.Origine_port;
                            Rec."ETD Requested" := TrackingGeneral.Etd;
                            Rec."Revised ETD" := TrackingGeneral.Actual_Reception_date;
                            Rec."Actual departure date" := TrackingGeneral.Shipping_date;
                            Rec."Arrival port" := TrackingGeneral.Unloading_port;
                            Rec."Shipping company" := TrackingGeneral.Carrier;
                            Rec."Vessel name" := TrackingGeneral.Vessel;
                            Rec."Actual Arrival date" := TrackingGeneral.ActualDischarge;
                            Rec."Customer Delivery date" := TrackingGeneral.ActualDeliveryDate;


                            TrackingGeneral2.SETRANGE(Booking_no, TrackingGeneral.Booking_no);
                            TrackingGeneral2.SETRANGE(Order_no, TrackingGeneral.Order_no);
                            IF TrackingGeneral2.FINDFIRST() THEN
                                REPEAT
                                    TrackingGeneral2.Statut := Rec.ID;
                                    TrackingGeneral2.MODIFY();
                                UNTIL TrackingGeneral2.NEXT() = 0;


                            TrackingDetail.SETRANGE(Booking_no, TrackingGeneral.Booking_no);
                            TrackingDetail.SETRANGE(Order_no, TrackingGeneral.Order_no);
                            IF TrackingDetail.FINDFIRST() THEN
                                REPEAT
                                    TrackingDetail.Statut := Rec.ID;
                                    TrackingDetail.MODIFY();
                                UNTIL TrackingDetail.NEXT() = 0;

                        END;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("MAJ de la liste")
            {
                Caption = 'MAJ de la liste';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin


                    Rec.SETRANGE("Display record", TRUE);
                    IF Rec.FIND('-') THEN
                        REPEAT
                            Rec."Display record" := FALSE;
                            Rec.MODIFY();
                        UNTIL Rec.NEXT() = 0;
                    Rec.RESET();

                    COMMIT();


                    Logistic2.SETRANGE("BL N°", '');
                    IF Logistic2.FIND('-') THEN
                        REPEAT
                            TrackingGeneral2.SETRANGE(Order_no, Logistic2."ACO No.");
                            TrackingGeneral2.SETRANGE(Statut, '');
                            IF (TrackingGeneral2.FIND('-')) AND (Logistic2."BL N°" = '') THEN
                                Logistic2."Display record" := TRUE;
                            Logistic2.MODIFY();
                        UNTIL Logistic2.NEXT() = 0;
                    COMMIT();
                    MESSAGE('Mise à jour effectuée');

                    Rec.SETRANGE("Display record", TRUE);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin



        Rec.SETRANGE("Display record", TRUE);


    end;

    var
        Logistic2: Record "DEL Logistic";
        TrackingDetail: Record "DEL Tracking détail";
        TrackingGeneral: Record "DEL Tracking général";
        TrackingGeneral2: Record "DEL Tracking général";
}

