table 50034 "DEL Logistic"
{
    DataCaptionFields = ID, "BR No.";
    Caption = 'Logistic';

    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
        }
        field(10; Deal_ID; Code[20])

        {
            TableRelation = "DEL Deal".ID;
            Caption = 'Deal_ID';

            trigger OnValidate()
            begin

                Aco_Connect.SETRANGE(Deal_ID, Deal_ID);
                IF Aco_Connect.FIND('-') THEN
                    "ACO No." := Aco_Connect."ACO No.";
            end;
        }
        field(30; "BR No."; Code[20])
        {
            TableRelation = "Purch. Rcpt. Header"."No.";
            Caption = 'BR No.';
        }
        field(40; "Supplier Name"; Text[50])
        {
            Caption = 'Supplier Name';
        }
        field(50; "N° PI"; Code[20])
        {
            Caption = 'No. PI';
        }
        field(60; "Date PI"; Date)
        {
            Caption = 'Date PI';
        }
        field(70; "PI approved by"; Text[30])
        {
            Caption = 'PI approved by';
        }
        field(80; "PI approval date"; Date)
        {
            Caption = 'PI approval date';
        }
        field(81; "Original Doc Receipt date"; Date)
        {
            Caption = 'Original Doc Receipt date';
        }
        field(90; "OK UBS date"; Date)
        {
            Caption = 'OK UBS date';
        }
        field(100; "Doc to Client date"; Date)
        {
            Caption = 'Doc to Client date';
        }
        field(110; "LC expiry date"; Date)
        {
            Caption = 'LC expiry date';
        }
        field(119; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(120; "Bank dossier"; Code[30])
        {
            Caption = 'Bank dossier';
        }
        field(130; "Forwarder Name"; Text[30])
        {
            Caption = 'Forwarder Name';
        }
        field(131; "C.Clearance Co.Name"; Text[30])
        {
            Caption = 'C.Clearance Co.Name';
        }
        field(140; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
        }
        field(141; Applicable; Text[5])
        {
            Caption = 'Applicable';
        }
        field(150; "Shipping company"; Text[50])
        {
            Caption = 'Shipping company';
        }
        field(160; "Booking Done"; Boolean)
        {
            Caption = 'Booking Done';
        }
        field(161; "Effective Booking date"; Date)
        {
            Caption = 'Effective Booking date';
        }
        field(170; "BL N°"; Code[30])
        {
            Caption = 'BL N°';
        }
        field(180; "Vessel name"; Text[30])
        {
            Caption = 'Vessel name';
        }
        field(181; "CTR 20'"; Boolean)
        {
            Caption = 'CTR 20''';
        }
        field(182; "CTR 40'"; Boolean)
        {
            Caption = 'CTR 40''';
        }
        field(183; "CTR 40'HQ"; Boolean)
        {
            Caption = 'CTR 40''HQ';
        }
        field(184; "Loading Mode"; Text[15])
        {
            Caption = 'Loading Mode';
        }
        field(190; "Quality Company"; Text[30])
        {
            Caption = 'Quality Company';
        }
        field(191; "Quality inspection date"; Date)
        {
            Caption = 'Quality inspection date';
        }
        field(200; "Certificate N°"; Text[30])
        {
            Caption = 'Certificate N°';
        }
        field(210; "Shipment mode"; Enum "DEL Ship Per")
        {

            Caption = 'Shipment mode';

            trigger OnValidate()
            begin
                FNC_DateValidate();
            end;
        }
        field(220; "B/C client"; Boolean)
        {
            Caption = 'B/C client';
        }
        field(230; "Departure Port"; Text[30])
        {
            Caption = 'Departure Port';
        }
        field(240; "ETD Requested"; Date)
        {
            Caption = 'ETD Requested';

            trigger OnValidate()
            begin
                FNC_DateValidate();
            end;
        }
        field(250; "Revised ETD"; Date)
        {
            Caption = 'Revised ETD';

            trigger OnValidate()
            begin
                FNC_DateValidate();
            end;
        }
        field(260; "Actual departure date"; Date)
        {
            Caption = 'Actual departure date';
        }
        field(270; "Arrival port"; Text[30])
        {
            Caption = 'Arrival port';
        }
        field(280; "ETA date"; Date)
        {
            Caption = 'ETA date';
        }
        field(290; "Actual Arrival date"; Date)
        {
            Caption = 'Actual Arrival date';
        }
        field(291; "Customer Delivery date"; Date)
        {
            Caption = 'Customer Delivery date';
        }
        field(300; "C.Clearance date"; Date)
        {
            Caption = 'C.Clearance date';
        }
        field(310; "Estimated CTNS"; Decimal)
        {
            Editable = false;
            Caption = 'Estimated CTNS';
        }
        field(320; "Real CTNS"; Decimal)
        {
            Caption = 'Real CTNS';
        }
        field(330; "Estimated volume"; Decimal)
        {
            Editable = false;
            Caption = 'Estimated volume';
        }
        field(340; "Actual Volume"; Decimal)
        {
            Caption = 'Actual Volume';
        }
        field(350; "Estimated Weight"; Decimal)
        {
            Editable = false;
            Caption = 'Estimated Weight';
        }
        field(360; "Actual Weight"; Decimal)
        {
            Caption = 'Actual Weight';
        }
        field(400; "N° Container"; Code[30])
        {
            Caption = 'N° Container';
        }
        field(410; "Fact. VCO émise"; Boolean)
        {
            Caption = 'Fact. VCO émise';
        }
        field(411; "N° Container 2"; Code[30])
        {
            Caption = 'N° Container 2';
        }
        field(412; "N° Container 3"; Code[30])
        {
            Caption = 'N° Container 3';
        }
        field(413; "N° Container 4"; Code[30])
        {
            Caption = 'N° Container 4';
        }
        field(414; "Requested Cust. Delivery date"; Date)
        {
            Caption = 'Requested Cust. Delivery date';
        }
        field(415; "qty CTR 20'"; Integer)
        {
            Caption = 'qty CTR 20''';
        }
        field(416; "qty CTR 40'"; Integer)
        {
            Caption = 'qty CTR 40''';
        }
        field(417; "qty CTR 40'HQ"; Integer)
        {
            Caption = 'qty CTR 40''HQ';
        }
        field(418; "Original doc sending date"; Date)
        {
            Caption = 'Original doc sending date';
        }
        field(500; "ACO No."; Code[20])
        {
            TableRelation = "Purchase Header"."No.";
            ValidateTableRelation = false;
            Caption = 'ACO No.';
        }
        field(501; "Display record"; Boolean)
        {
            Caption = 'Display record';
        }
        field(502; "Affectation manuelle"; Boolean)
        {
            CalcFormula = Exist("DEL Tracking général" WHERE(Booking_no = FIELD("BL N°")));
            Caption = 'Manual assignment';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; ID, Deal_ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PurchRcpt_Re: Record "Purch. Rcpt. Header";
        Vendor_Re: Record Vendor;
        PurchHead_Re: Record "Purchase Header";
        PurchRcptLine_Re: Record "Purch. Rcpt. Line";
        Item_Re: Record Item;
        PurchArchHead_Re: Record "Purchase Header Archive";
        PurchLine_Re: Record "Purchase Line";
        Element_Re: Record "DEL Element";
        Aco_Connect: Record "DEL ACO Connection";


    procedure FNC_GetInfo(Logistic_Re_Par: Record "DEL Logistic")
    var
        PackNumber_De_Loc: Decimal;
        Cubic_De_Loc: Decimal;
        Weight_De_Loc: Decimal;
        AcoNo_Co_Loc: Code[20];
    begin
        Element_Re.SETRANGE(Deal_ID, Logistic_Re_Par.Deal_ID);
        Element_Re.SETRANGE(Element_Re.Type, Element_Re.Type::ACO);
        IF Element_Re.FIND('-') THEN
            AcoNo_Co_Loc := Element_Re."Type No.";


        IF PurchHead_Re.GET(PurchHead_Re."Document Type"::Order, AcoNo_Co_Loc) THEN BEGIN
            IF Vendor_Re.GET(PurchHead_Re."Buy-from Vendor No.") THEN
                Logistic_Re_Par."Supplier Name" := Vendor_Re.Name;

            Logistic_Re_Par."Forwarder Name" := PurchHead_Re."DEL Forwarding Agent Code";
            Logistic_Re_Par.VALIDATE("Shipment mode", PurchHead_Re."DEL Ship Per");
            Logistic_Re_Par."ETD Requested" := PurchHead_Re."Requested Receipt Date";

            Logistic_Re_Par."Arrival port" := PurchHead_Re."Port d'arrivée";
            Logistic_Re_Par."Departure Port" := PurchHead_Re."Port de départ";
            Logistic_Re_Par."Payment Terms Code" := PurchHead_Re."Payment Terms Code";
        END;

        PurchLine_Re.SETRANGE("Document No.", PurchHead_Re."No.");
        PurchLine_Re.SETFILTER(Quantity, '<>0');
        IF PurchLine_Re.FIND('-') THEN
            REPEAT
                IF (Item_Re.GET(PurchLine_Re."No.")) AND (PurchLine_Re.Type = PurchRcptLine_Re.Type::Item) THEN BEGIN

                    IF Item_Re."DEL PCB" <> 0 THEN
                        PackNumber_De_Loc := PackNumber_De_Loc + (PurchLine_Re.Quantity / Item_Re."DEL PCB")
                    ELSE
                        PackNumber_De_Loc := PackNumber_De_Loc + PurchLine_Re.Quantity;


                    IF Item_Re.GetVolCBM(TRUE) <> 0 THEN
                        Cubic_De_Loc := Cubic_De_Loc + (Item_Re.GetVolCBM(TRUE) * PurchLine_Re.Quantity)

                    ELSE
                        Cubic_De_Loc := Cubic_De_Loc + PurchLine_Re.Quantity;
                    IF Item_Re."DEL Weight brut" <> 0 THEN
                        Weight_De_Loc := Weight_De_Loc + (Item_Re."DEL Weight brut" * PurchLine_Re.Quantity)
                    ELSE
                        Weight_De_Loc := Weight_De_Loc + PurchLine_Re.Quantity;
                END;
            UNTIL PurchLine_Re.NEXT = 0;


        IF Logistic_Re_Par."Shipment mode" = Logistic_Re_Par."Shipment mode"::"Sea Vessel" THEN BEGIN
            IF Logistic_Re_Par."Revised ETD" = 0D THEN
                IF Logistic_Re_Par."ETD Requested" <> 0D THEN
                    Logistic_Re_Par."ETA date" := CALCDATE('<30D>', Logistic_Re_Par."ETD Requested")
                ELSE
                    IF Logistic_Re_Par."ETD Requested" <> 0D THEN
                        Logistic_Re_Par."Revised ETD" := CALCDATE('<30D>', Logistic_Re_Par."ETD Requested");
        END ELSE
            IF Logistic_Re_Par."Revised ETD" = 0D THEN
                IF Logistic_Re_Par."ETD Requested" <> 0D THEN
                    Logistic_Re_Par."ETA date" := CALCDATE('<1D>', Logistic_Re_Par."ETD Requested")
                ELSE
                    IF Logistic_Re_Par."ETD Requested" <> 0D THEN
                        Logistic_Re_Par."Revised ETD" := CALCDATE('<1D>', Logistic_Re_Par."ETD Requested");

        Logistic_Re_Par."Estimated CTNS" := PackNumber_De_Loc;
        Logistic_Re_Par."Estimated volume" := Cubic_De_Loc;
        Logistic_Re_Par."Estimated Weight" := Weight_De_Loc;


        Logistic_Re_Par.VALIDATE(Deal_ID);

        Logistic_Re_Par.INSERT();
    end;


    procedure FNC_DateValidate()
    begin
        IF "Shipment mode" = "Shipment mode"::"Sea Vessel" THEN BEGIN
            IF "Revised ETD" = 0D THEN
                IF "ETD Requested" <> 0D THEN
                    "ETA date" := CALCDATE('<30D>', "ETD Requested")
                ELSE
                    IF "ETD Requested" <> 0D THEN
                        "Revised ETD" := CALCDATE('<30D>', "ETD Requested");
        END ELSE
            IF "Revised ETD" = 0D THEN
                IF "ETD Requested" <> 0D THEN
                    "ETA date" := CALCDATE('<1D>', "ETD Requested")
                ELSE
                    IF "ETD Requested" <> 0D THEN
                        "Revised ETD" := CALCDATE('<1D>', "ETD Requested");
    end;


    procedure FNC_PackEstim(Logistic_Re_Par: Record "DEL Logistic")
    var
        PackNumber_De_Loc: Decimal;
        Cubic_De_Loc: Decimal;
        Weight_De_Loc: Decimal;
    begin
        IF PurchRcpt_Re.GET(Logistic_Re_Par."BR No.") THEN BEGIN

            PurchRcptLine_Re.SETRANGE("Document No.", PurchRcpt_Re."No.");
            PurchRcptLine_Re.SETFILTER(Quantity, '<>0');
            IF PurchRcptLine_Re.FINDFIRST() THEN
                REPEAT

                    IF (Item_Re.GET(PurchRcptLine_Re."No.")) AND (PurchRcptLine_Re.Type = PurchRcptLine_Re.Type::Item) THEN BEGIN

                        IF Item_Re."DEL PCB" <> 0 THEN
                            PackNumber_De_Loc := PackNumber_De_Loc + (PurchRcptLine_Re.Quantity / Item_Re."DEL PCB")
                        ELSE
                            PackNumber_De_Loc := PackNumber_De_Loc + PurchRcptLine_Re.Quantity;

                        IF Item_Re.GetVolCBM(TRUE) <> 0 THEN
                            Cubic_De_Loc := Cubic_De_Loc + (Item_Re.GetVolCBM(TRUE) * PurchRcptLine_Re.Quantity)

                        ELSE
                            Cubic_De_Loc := Cubic_De_Loc + PurchRcptLine_Re.Quantity;
                        IF Item_Re."DEL Weight brut" <> 0 THEN
                            Weight_De_Loc := Weight_De_Loc + (Item_Re."DEL Weight brut" * PurchRcptLine_Re.Quantity)
                        ELSE
                            Weight_De_Loc := Weight_De_Loc + PurchRcptLine_Re.Quantity;
                    END;
                UNTIL PurchRcptLine_Re.NEXT() = 0;

        END;

        Logistic_Re_Par."Estimated CTNS" := PackNumber_De_Loc;
        Logistic_Re_Par."Estimated volume" := Cubic_De_Loc;
        Logistic_Re_Par."Estimated Weight" := Weight_De_Loc;
        Logistic_Re_Par.MODIFY();
    end;
}

