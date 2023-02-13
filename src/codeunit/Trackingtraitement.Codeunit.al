codeunit 50006 "DEL Tracking traitement"
{
    trigger OnRun()
    begin
        InsertionAutomatique();
    end;

    var
        Logistic: Record "DEL Logistic";
        TrackingDetail: Record "DEL Tracking détail";
        TrackingGeneral: Record "DEL Tracking général";
        "TrackingNonTraité": Record "DEL Tracking non traité";
        CodeACo: Text[3];


    procedure InsertionAutomatique()
    begin

        IF TrackingNonTraité.FINDFIRST() THEN
            REPEAT

                TrackingNonTraité.Statut := '';

                CodeACo := COPYSTR(TrackingNonTraité.Order_no, 1, 3);
                IF CodeACo = 'ACO' THEN BEGIN

                    //1 maj fiche logistic begin
                    Logistic.SETRANGE("BL N°", TrackingNonTraité.Booking_no);
                    Logistic.SETRANGE("ACO No.", TrackingNonTraité.Order_no);
                    IF Logistic.FINDFIRST() THEN
                        REPEAT
                            Logistic."Forwarder Name" := TrackingNonTraité.Forwading_agent_no;
                            Logistic."Supplier Name" := TrackingNonTraité.Vendor_no;
                            Logistic."Departure Port" := TrackingNonTraité.Origine_port;
                            Logistic."ETD Requested" := TrackingNonTraité.Etd;
                            Logistic."Revised ETD" := TrackingNonTraité.Actual_Reception_date;
                            Logistic."Actual departure date" := TrackingNonTraité.Shipping_date;
                            Logistic."Arrival port" := TrackingNonTraité.Unloading_port;
                            Logistic."Shipping company" := TrackingNonTraité.Carrier;
                            Logistic."Vessel name" := TrackingNonTraité.Vessel;
                            Logistic."Actual Arrival date" := TrackingNonTraité.ActualDischarge;
                            Logistic."Customer Delivery date" := TrackingNonTraité.ActualDeliveryDate;
                            Logistic.MODIFY();
                            TrackingNonTraité.Statut := Logistic.ID;
                        UNTIL Logistic.NEXT() = 0;


                    //1 maj fiche logistic end

                    //2 maj detail booking begin
                    TrackingDetail.SETRANGE(Order_no, TrackingNonTraité.Order_no);
                    TrackingDetail.SETRANGE(Item_no, TrackingNonTraité.Item_no);
                    TrackingDetail.SETRANGE(Booking_no, TrackingNonTraité.Booking_no);
                    TrackingDetail.SETRANGE(Container_no, TrackingNonTraité.Container_no);
                    IF TrackingDetail.FINDFIRST() THEN BEGIN
                        TrackingDetail.TRANSFERFIELDS(TrackingNonTraité);
                        TrackingDetail.Booking_no := UPPERCASE(TrackingNonTraité.Booking_no);
                        TrackingDetail.MODIFY();
                    END ELSE BEGIN
                        TrackingDetail.TRANSFERFIELDS(TrackingNonTraité);
                        TrackingDetail.Booking_no := UPPERCASE(TrackingNonTraité.Booking_no);
                        TrackingDetail.INSERT();
                    END;
                    //2 maj detail booking end

                    //3 maj General booking begin
                    TrackingGeneral.TRANSFERFIELDS(TrackingNonTraité);
                    TrackingGeneral.Booking_no := UPPERCASE(TrackingNonTraité.Booking_no);
                    TrackingGeneral.INSERT();
                    //3 maj General boking end


                END;
                TrackingNonTraité.DELETE()
            UNTIL TrackingNonTraité.NEXT() = 0;
    end;


}

