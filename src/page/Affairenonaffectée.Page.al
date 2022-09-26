page 50057 "Affaire non affectée"
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = Table50034;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(ID; ID)
                {
                }
                field(Deal_ID; Deal_ID)
                {
                }
                field("ACO No."; "ACO No.")
                {
                }
                field("Supplier Name"; "Supplier Name")
                {
                }
                field("BL N°"; "BL N°")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //grc 1 begin
                        TrackingGeneral.SETRANGE(Order_no, "ACO No.");

                        IF PAGE.RUNMODAL(PAGE::"Propostition tracking", TrackingGeneral) = ACTION::LookupOK THEN BEGIN

                            "BL N°" := TrackingGeneral.Booking_no;
                            "Forwarder Name" := TrackingGeneral.Forwading_agent_no;
                            "Supplier Name" := TrackingGeneral.Vendor_no;
                            "Departure Port" := TrackingGeneral.Origine_port;
                            "ETD Requested" := TrackingGeneral.Etd;
                            "Revised ETD" := TrackingGeneral.Actual_Reception_date;
                            "Actual departure date" := TrackingGeneral.Shipping_date;
                            "Arrival port" := TrackingGeneral.Unloading_port;
                            "Shipping company" := TrackingGeneral.Carrier;
                            "Vessel name" := TrackingGeneral.Vessel;
                            "Actual Arrival date" := TrackingGeneral.ActualDischarge;
                            "Customer Delivery date" := TrackingGeneral.ActualDeliveryDate;


                            TrackingGeneral2.SETRANGE(Booking_no, TrackingGeneral.Booking_no);
                            TrackingGeneral2.SETRANGE(Order_no, TrackingGeneral.Order_no);
                            IF TrackingGeneral2.FINDFIRST THEN BEGIN
                                REPEAT
                                    TrackingGeneral2.Statut := ID;
                                    TrackingGeneral2.MODIFY();
                                UNTIL TrackingGeneral2.NEXT = 0;
                            END;


                            TrackingDetail.SETRANGE(Booking_no, TrackingGeneral.Booking_no);
                            TrackingDetail.SETRANGE(Order_no, TrackingGeneral.Order_no);
                            IF TrackingDetail.FINDFIRST THEN BEGIN
                                REPEAT
                                    TrackingDetail.Statut := ID;
                                    TrackingDetail.MODIFY();
                                UNTIL TrackingDetail.NEXT = 0;
                            END;

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
                    IF Rec.FIND('-') THEN BEGIN
                        REPEAT
                            Rec."Display record" := FALSE;
                            Rec.MODIFY();
                        UNTIL Rec.NEXT = 0;
                    END;
                    Rec.RESET();

                    COMMIT();


                    Logistic2.SETRANGE("BL N°", '');
                    IF Logistic2.FIND('-') THEN BEGIN
                        REPEAT
                            TrackingGeneral2.SETRANGE(Order_no, Logistic2."ACO No.");
                            TrackingGeneral2.SETRANGE(Statut, '');
                            IF (TrackingGeneral2.FIND('-')) AND (Logistic2."BL N°" = '') THEN
                                Logistic2."Display record" := TRUE;
                            Logistic2.MODIFY();
                        UNTIL Logistic2.NEXT = 0;
                    END;
                    COMMIT();
                    MESSAGE('Mise à jour effectuée');

                    Rec.SETRANGE("Display record", TRUE);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        //filtre selectif sur la table logistic, on n'affiche que les affaires dont un fichier xml vient d'arriver begin

        Rec.SETRANGE("Display record", TRUE);

        //filtre selectif sur la table logistic, on n'affiche que les affaires dont un fichier xml vient d'arriver end
    end;

    var
        TrackingGeneral: Record "50013";
        TrackingGeneral2: Record "50013";
        TrackingDetail: Record "50014";
        Logistic2: Record "50034";
}

