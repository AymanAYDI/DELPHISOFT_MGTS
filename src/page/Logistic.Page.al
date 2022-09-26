page 50044 Logistic
{
    // ngts/loco/grc1    15.04.10  add code under Bl N. pour la gestion des tracking transitaire
    // RBO       20.08.19       remove fields "Original doc sending date" + "Doc to client date"
    // RBO       20.08.19       field name change "Payment date"

    DataCaptionFields = ID, "BR No.";
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Table50034;

    layout
    {
        area(content)
        {
            group("P R O F O R M A  I N V O I C E")
            {
                Caption = 'P R O F O R M A  I N V O I C E';
                field("Supplier Name"; "Supplier Name")
                {
                    Editable = false;
                }
                field("N° PI"; "N° PI")
                {
                }
                field("Date PI"; "Date PI")
                {
                }
                field("PI approved by"; "PI approved by")
                {
                }
                field("PI approval date"; "PI approval date")
                {
                }
            }
            group("B A N K I N G  I N F O R M A T I O N")
            {
                Caption = 'B A N K I N G  I N F O R M A T I O N';
                field("Payment Terms Code"; "Payment Terms Code")
                {
                }
                field("Bank dossier"; "Bank dossier")
                {
                }
                field("Original Doc Receipt date"; "Original Doc Receipt date")
                {
                    Caption = 'Payment date';
                }
                field("OK UBS date"; "OK UBS date")
                {
                }
                field("LC expiry date"; "LC expiry date")
                {
                }
            }
            group("F O R W A R D E R")
            {
                Caption = 'F O R W A R D E R';
                field("Forwarder Name"; "Forwarder Name")
                {
                }
            }
            group("C U S T O M S  C L E A R A N C E")
            {
                Caption = 'C U S T O M S  C L E A R A N C E';
                field("C.Clearance Co.Name"; "C.Clearance Co.Name")
                {
                }
            }
            group("D E G R O U P A G E")
            {
                Caption = 'D E G R O U P A G E';
                field(Applicable; Applicable)
                {
                }
                field("Company Name"; "Company Name")
                {
                }
            }
            group("S H I P M E N T")
            {
                Caption = 'S H I P M E N T';
                field("Shipping company"; "Shipping company")
                {
                }
                field("Booking Done"; "Booking Done")
                {
                }
                field("BL N°"; "BL N°")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        //grc 1 begin
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









                        //grc 1 end
                    end;

                    trigger OnValidate()
                    begin
                        BLN176OnAfterValidate;
                    end;
                }
                field("Vessel name"; "Vessel name")
                {
                }
                field("N° Container"; "N° Container")
                {
                }
                field("N° Container 2"; "N° Container 2")
                {
                }
                field("N° Container 3"; "N° Container 3")
                {
                }
                field("N° Container 4"; "N° Container 4")
                {
                }
                field("Loading Mode"; "Loading Mode")
                {
                }
            }
            group("Q U A L I T Y")
            {
                Caption = 'Q U A L I T Y';
                field("Quality Company"; "Quality Company")
                {
                }
                field("Quality inspection date"; "Quality inspection date")
                {
                }
                field("Certificate N°"; "Certificate N°")
                {
                }
            }
            group("T R A N S P O R T A T I O N ")
            {
                Caption = 'T R A N S P O R T A T I O N ';
                field("Shipment mode"; "Shipment mode")
                {
                }
                field("B/C client"; "B/C client")
                {
                }
                field("Departure Port"; "Departure Port")
                {
                }
                field("ETD Requested"; "ETD Requested")
                {
                }
                field("Actual departure date"; "Actual departure date")
                {
                }
                field("Arrival port"; "Arrival port")
                {
                }
                field("ETA date"; "ETA date")
                {
                }
                field("C.Clearance date"; "C.Clearance date")
                {
                }
                field("Customer Delivery date"; "Customer Delivery date")
                {
                }
                field("Estimated CTNS"; "Estimated CTNS")
                {
                }
                field("Estimated volume"; "Estimated volume")
                {
                }
                field("Estimated Weight"; "Estimated Weight")
                {
                }
                field("Effective Booking date"; "Effective Booking date")
                {
                }
                field("CTR 20'"; "CTR 20'")
                {
                }
                field("qty CTR 20'"; "qty CTR 20'")
                {
                }
                field("CTR 40'"; "CTR 40'")
                {
                }
                field("qty CTR 40'"; "qty CTR 40'")
                {
                }
                field("CTR 40'HQ"; "CTR 40'HQ")
                {
                }
                field("qty CTR 40'HQ"; "qty CTR 40'HQ")
                {
                }
                field("Revised ETD"; "Revised ETD")
                {
                }
                field("Actual Arrival date"; "Actual Arrival date")
                {
                }
                field("Requested Cust. Delivery date"; "Requested Cust. Delivery date")
                {
                }
                field("Real CTNS"; "Real CTNS")
                {
                }
                field("Actual Volume"; "Actual Volume")
                {
                }
                field("Actual Weight"; "Actual Weight")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transitaire)
            {
                Caption = 'Transitaire';
                action("Détail booking transitaire")
                {
                    Caption = 'Détail booking transitaire';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        TrackingDetail2.SETRANGE(Booking_no, "BL N°");
                        TrackingDetail2.SETRANGE(Statut, ID);
                        PAGE.RUN(50056, TrackingDetail2);
                    end;
                }
                action("Affaire Non affectée")
                {
                    Caption = 'Affaire Non affectée';
                    Image = CancelAttachment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50057;
                }
            }
        }
    }

    trigger OnClosePage()
    begin
        AlertMgt_Cu.FNC_GlobalCheck(Deal_ID);
    end;

    trigger OnOpenPage()
    begin
        AlertMgt_Cu.FNC_GlobalCheck(Deal_ID);
    end;

    var
        AlertMgt_Cu: Codeunit "50028";
        TrackingGeneral: Record "50013";
        TrackingDetail: Record "50014";
        TrackingGeneral2: Record "50013";
        TrackingDetail2: Record "50014";
        Text19032713: Label 'P R O F O R M A  I N V O I C E';
        Text19071703: Label 'B A N K';
        Text19008693: Label 'F O R W A R D E R';
        Text19024964: Label 'C U S T O M S  C L E A R A N C E';
        Text19042502: Label 'D E G R O U P A G E';
        Text19048656: Label 'S H I P M E N T';
        Text19018051: Label 'Q U A L I T Y';
        Text19058220: Label 'T R A N S P O R T';

    local procedure BLN176OnAfterValidate()
    begin

        IF "BL N°" = '' THEN BEGIN
            "BL N°" := '';
            "Forwarder Name" := '';
            "Supplier Name" := '';
            "Departure Port" := '';
            "ETD Requested" := 0D;
            "Revised ETD" := 0D;
            "Actual departure date" := 0D;
            "Arrival port" := '';
            "Shipping company" := '';
            "Vessel name" := '';
            "Actual Arrival date" := 0D;
            "Customer Delivery date" := 0D;
        END;
    end;
}

