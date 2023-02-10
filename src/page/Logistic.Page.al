page 50044 "DEL Logistic"
{
    DataCaptionFields = ID, "BR No.";
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "DEL Logistic";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group("P R O F O R M A  I N V O I C E")
            {
                Caption = 'P R O F O R M A  I N V O I C E';
                field("Supplier Name"; Rec."Supplier Name")
                {
                    Caption = 'Supplier Name';
                    Editable = false;
                }
                field("N° PI"; Rec."N° PI")
                {
                    Caption = 'No. PI';
                }
                field("Date PI"; Rec."Date PI")
                {
                    Caption = 'Date PI';
                }
                field("PI approved by"; Rec."PI approved by")
                {
                    Caption = 'PI approved by';
                }
                field("PI approval date"; Rec."PI approval date")
                {
                    Caption = 'PI approval date';
                }
            }
            group("B A N K I N G  I N F O R M A T I O N")
            {
                Caption = 'B A N K I N G  I N F O R M A T I O N';
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code';
                }
                field("Bank dossier"; Rec."Bank dossier")
                {
                    Caption = 'Bank dossier';
                }
                field("Original Doc Receipt date"; Rec."Original Doc Receipt date")
                {
                    Caption = 'Payment date';
                }
                field("OK UBS date"; Rec."OK UBS date")
                {
                    Caption = 'OK UBS date';
                }
                field("LC expiry date"; Rec."LC expiry date")
                {
                    Caption = 'LC expiry date';
                }
            }
            group("F O R W A R D E R")
            {
                Caption = 'F O R W A R D E R';
                field("Forwarder Name"; Rec."Forwarder Name")
                {
                    Caption = 'Forwarder Name';
                }
            }
            group("C U S T O M S  C L E A R A N C E")
            {
                Caption = 'C U S T O M S  C L E A R A N C E';
                field("C.Clearance Co.Name"; Rec."C.Clearance Co.Name")
                {
                    Caption = 'C.Clearance Co.Name';
                }
            }
            group("D E G R O U P A G E")
            {
                Caption = 'D E G R O U P A G E';
                field(Applicable; Rec.Applicable)
                {
                    Caption = 'Applicable';
                }
                field("Company Name"; Rec."Company Name")
                {
                    Caption = 'Company Name';
                }
            }
            group("S H I P M E N T")
            {
                Caption = 'S H I P M E N T';
                field("Shipping company"; Rec."Shipping company")
                {
                    Caption = 'Shipping company';
                }
                field("Booking Done"; Rec."Booking Done")
                {
                    Caption = 'Booking Done';
                }
                field("BL N°"; Rec."BL N°")
                {
                    Caption = 'BL N°';

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        //grc 1 begin
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

                    trigger OnValidate()
                    begin
                        BLN176OnAfterValidate();
                    end;
                }
                field("Vessel name"; Rec."Vessel name")
                {
                    Caption = 'Vessel name';
                }
                field("N° Container"; Rec."N° Container")
                {
                    Caption = 'N° Container';
                }
                field("N° Container 2"; Rec."N° Container 2")
                {
                    Caption = 'N° Container 2';
                }
                field("N° Container 3"; Rec."N° Container 3")
                {
                    Caption = 'N° Container 3';
                }
                field("N° Container 4"; Rec."N° Container 4")
                {
                    Caption = 'N° Container 4';
                }
                field("Loading Mode"; Rec."Loading Mode")
                {
                    Caption = 'Loading Mode';
                }
            }
            group("Q U A L I T Y")
            {
                Caption = 'Q U A L I T Y';
                field("Quality Company"; Rec."Quality Company")
                {
                    Caption = 'Quality Company';
                }
                field("Quality inspection date"; Rec."Quality inspection date")
                {
                    Caption = 'Quality inspection date';
                }
                field("Certificate N°"; Rec."Certificate N°")
                {
                    Caption = 'Certificate N°';
                }
            }
            group("T R A N S P O R T A T I O N")
            {
                Caption = 'T R A N S P O R T A T I O N ';
                field("Shipment mode"; Rec."Shipment mode")
                {
                    Caption = 'Shipment mode';
                }
                field("B/C client"; Rec."B/C client")
                {
                    Caption = 'B/C client';
                }
                field("Departure Port"; Rec."Departure Port")
                {
                    Caption = 'Departure Port';
                }
                field("ETD Requested"; Rec."ETD Requested")
                {
                    Caption = 'ETD Requested';
                }
                field("Actual departure date"; Rec."Actual departure date")
                {
                    Caption = 'Actual departure date';
                }
                field("Arrival port"; Rec."Arrival port")
                {
                    Caption = 'Arrival port';
                }
                field("ETA date"; Rec."ETA date")
                {
                    Caption = 'ETA date';
                }
                field("C.Clearance date"; Rec."C.Clearance date")
                {
                    Caption = 'C.Clearance date';
                }
                field("Customer Delivery date"; Rec."Customer Delivery date")
                {
                    Caption = 'Customer Delivery date';
                }
                field("Estimated CTNS"; Rec."Estimated CTNS")
                {
                    Caption = 'Estimated CTNS';
                }
                field("Estimated volume"; Rec."Estimated volume")
                {
                    Caption = 'Estimated volume';
                }
                field("Estimated Weight"; Rec."Estimated Weight")
                {
                    Caption = 'Estimated Weight';
                }
                field("Effective Booking date"; Rec."Effective Booking date")
                {
                    Caption = 'Effective Booking date';
                }
                field("CTR 20'"; Rec."CTR 20'")
                {
                    Caption = 'CTR 20''';
                }
                field("qty CTR 20'"; Rec."qty CTR 20'")
                {
                    Caption = 'qty CTR 20''';
                }
                field("CTR 40'"; Rec."CTR 40'")
                {
                    Caption = 'CTR 40''';
                }
                field("qty CTR 40'"; Rec."qty CTR 40'")
                {
                    Caption = 'qty CTR 40''';
                }
                field("CTR 40'HQ"; Rec."CTR 40'HQ")
                {
                    Caption = 'CTR 40''HQ';
                }
                field("qty CTR 40'HQ"; Rec."qty CTR 40'HQ")
                {
                    Caption = 'qty CTR 40''HQ';
                }
                field("Revised ETD"; Rec."Revised ETD")
                {
                    Caption = 'Revised ETD';
                }
                field("Actual Arrival date"; Rec."Actual Arrival date")
                {
                    Caption = 'Actual Arrival date';
                }
                field("Requested Cust. Delivery date"; Rec."Requested Cust. Delivery date")
                {
                    Caption = 'Requested Cust. Delivery date';
                }
                field("Real CTNS"; Rec."Real CTNS")
                {
                    Caption = 'Real CTNS';
                }
                field("Actual Volume"; Rec."Actual Volume")
                {
                    Caption = 'Actual Volume';
                }
                field("Actual Weight"; Rec."Actual Weight")
                {
                    Caption = 'Actual Weight';
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

                        TrackingDetail2.SETRANGE(Booking_no, Rec."BL N°");
                        TrackingDetail2.SETRANGE(Statut, Rec.ID);
                        PAGE.RUN(Page::"DEL Détails booking", TrackingDetail2);
                    end;
                }
                action("Affaire Non affectée")
                {
                    Caption = 'Affaire Non affectée';
                    Image = CancelAttachment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Affaire non affectée";
                }
            }
        }
    }

    trigger OnClosePage()
    begin
        AlertMgt_Cu.FNC_GlobalCheck(Rec.Deal_ID);
    end;

    trigger OnOpenPage()
    begin
        AlertMgt_Cu.FNC_GlobalCheck(Rec.Deal_ID);
    end;

    var
        TrackingDetail: Record "DEL Tracking détail";
        TrackingDetail2: Record "DEL Tracking détail";
        TrackingGeneral: Record "DEL Tracking général";


        TrackingGeneral2: Record "DEL Tracking général";
        AlertMgt_Cu: Codeunit "DEL Alert and fee copy Mgt";

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

