page 50044 "DEL Logistic"
{
    DataCaptionFields = ID, "BR No.";
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "DEL Logistic";

    layout
    {
        area(content)
        {
            group("P R O F O R M A  I N V O I C E")
            {
                Caption = 'P R O F O R M A  I N V O I C E';
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Editable = false;
                }
                field("N° PI"; Rec."N° PI")
                {
                }
                field("Date PI"; Rec."Date PI")
                {
                }
                field("PI approved by"; Rec."PI approved by")
                {
                }
                field("PI approval date"; Rec."PI approval date")
                {
                }
            }
            group("B A N K I N G  I N F O R M A T I O N")
            {
                Caption = 'B A N K I N G  I N F O R M A T I O N';
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                }
                field("Bank dossier"; Rec."Bank dossier")
                {
                }
                field("Original Doc Receipt date"; Rec."Original Doc Receipt date")
                {
                    Caption = 'Payment date';
                }
                field("OK UBS date"; Rec."OK UBS date")
                {
                }
                field("LC expiry date"; Rec."LC expiry date")
                {
                }
            }
            group("F O R W A R D E R")
            {
                Caption = 'F O R W A R D E R';
                field("Forwarder Name"; Rec."Forwarder Name")
                {
                }
            }
            group("C U S T O M S  C L E A R A N C E")
            {
                Caption = 'C U S T O M S  C L E A R A N C E';
                field("C.Clearance Co.Name"; Rec."C.Clearance Co.Name")
                {
                }
            }
            group("D E G R O U P A G E")
            {
                Caption = 'D E G R O U P A G E';
                field(Applicable; Rec.Applicable)
                {
                }
                field("Company Name"; Rec."Company Name")
                {
                }
            }
            group("S H I P M E N T")
            {
                Caption = 'S H I P M E N T';
                field("Shipping company"; Rec."Shipping company")
                {
                }
                field("Booking Done"; Rec."Booking Done")
                {
                }
                field("BL N°"; Rec."BL N°")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        //grc 1 begin
                        IF PAGE.RUNMODAL(PAGE::"Propostition tracking", TrackingGeneral) = ACTION::LookupOK THEN BEGIN


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
                            //TODO

                            // TrackingGeneral2.SETRANGE(Booking_no, TrackingGeneral.Booking_no);
                            // TrackingGeneral2.SETRANGE(Order_no, TrackingGeneral.Order_no);
                            IF TrackingGeneral2.FINDFIRST() THEN
                                REPEAT
                                    TrackingGeneral2.Statut := Rec.ID;
                                    TrackingGeneral2.MODIFY();
                                UNTIL TrackingGeneral2.NEXT() = 0;



                            TrackingDetail.SETRANGE(Booking_no, TrackingGeneral.Booking_no);
                            TrackingDetail.SETRANGE(Order_no, TrackingGeneral.Order_no);
                            IF TrackingDetail.FINDFIRST() THEN BEGIN
                                REPEAT
                                    TrackingDetail.Statut := Rec.ID;
                                    TrackingDetail.MODIFY();
                                UNTIL TrackingDetail.NEXT() = 0;
                            END;

                        END;









                        //grc 1 end
                    end;

                    trigger OnValidate()
                    begin
                        BLN176OnAfterValidate();
                    end;
                }
                field("Vessel name"; Rec."Vessel name")
                {
                }
                field("N° Container"; Rec."N° Container")
                {
                }
                field("N° Container 2"; Rec."N° Container 2")
                {
                }
                field("N° Container 3"; Rec."N° Container 3")
                {
                }
                field("N° Container 4"; Rec."N° Container 4")
                {
                }
                field("Loading Mode"; Rec."Loading Mode")
                {
                }
            }
            group("Q U A L I T Y")
            {
                Caption = 'Q U A L I T Y';
                field("Quality Company"; Rec."Quality Company")
                {
                }
                field("Quality inspection date"; Rec."Quality inspection date")
                {
                }
                field("Certificate N°"; Rec."Certificate N°")
                {
                }
            }
            group("T R A N S P O R T A T I O N")
            {
                Caption = 'T R A N S P O R T A T I O N ';
                field("Shipment mode"; Rec."Shipment mode")
                {
                }
                field("B/C client"; Rec."B/C client")
                {
                }
                field("Departure Port"; Rec."Departure Port")
                {
                }
                field("ETD Requested"; Rec."ETD Requested")
                {
                }
                field("Actual departure date"; Rec."Actual departure date")
                {
                }
                field("Arrival port"; Rec."Arrival port")
                {
                }
                field("ETA date"; Rec."ETA date")
                {
                }
                field("C.Clearance date"; Rec."C.Clearance date")
                {
                }
                field("Customer Delivery date"; Rec."Customer Delivery date")
                {
                }
                field("Estimated CTNS"; Rec."Estimated CTNS")
                {
                }
                field("Estimated volume"; Rec."Estimated volume")
                {
                }
                field("Estimated Weight"; Rec."Estimated Weight")
                {
                }
                field("Effective Booking date"; Rec."Effective Booking date")
                {
                }
                field("CTR 20'"; Rec."CTR 20'")
                {
                }
                field("qty CTR 20'"; Rec."qty CTR 20'")
                {
                }
                field("CTR 40'"; Rec."CTR 40'")
                {
                }
                field("qty CTR 40'"; Rec."qty CTR 40'")
                {
                }
                field("CTR 40'HQ"; Rec."CTR 40'HQ")
                {
                }
                field("qty CTR 40'HQ"; Rec."qty CTR 40'HQ")
                {
                }
                field("Revised ETD"; Rec."Revised ETD")
                {
                }
                field("Actual Arrival date"; Rec."Actual Arrival date")
                {
                }
                field("Requested Cust. Delivery date"; Rec."Requested Cust. Delivery date")
                {
                }
                field("Real CTNS"; Rec."Real CTNS")
                {
                }
                field("Actual Volume"; Rec."Actual Volume")
                {
                }
                field("Actual Weight"; Rec."Actual Weight")
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

                    // trigger OnAction()
                    // begin
                    //TODO
                    //     TrackingDetail2.SETRANGE(Booking_no, "BL N°");
                    //     TrackingDetail2.SETRANGE(Statut, ID);
                    //     PAGE.RUN(50056, TrackingDetail2);
                    // end;
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
    //todo
    // trigger OnClosePage()
    // begin
    //     AlertMgt_Cu.FNC_GlobalCheck(Deal_ID);
    // end;

    // trigger OnOpenPage()
    // begin
    //     AlertMgt_Cu.FNC_GlobalCheck(Deal_ID);
    // end;

    var
        //TODO  //CODE UNIT // AlertMgt_Cu: Codeunit 50028;
        TrackingGeneral: Record 50013;
        TrackingDetail: Record 50014;
        TrackingGeneral2: Record 50013;
        TrackingDetail2: Record 50014;
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

        IF Rec."BL N°" = '' THEN BEGIN
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
        END;
    end;
}

