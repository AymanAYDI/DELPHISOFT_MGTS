table 50034 "DEL Logistic"
{
    DataCaptionFields = ID, "BR No.";
    Caption = 'Logistic';
    DataClassification = CustomerContent;
    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(10; Deal_ID; Code[20])

        {
            TableRelation = "DEL Deal".ID;
            Caption = 'Deal_ID';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(40; "Supplier Name"; Text[100])
        {
            Caption = 'Supplier Name';
            DataClassification = CustomerContent;
        }
        field(50; "N° PI"; Code[20])
        {
            Caption = 'No. PI';
            DataClassification = CustomerContent;
        }
        field(60; "Date PI"; Date)
        {
            Caption = 'Date PI';
            DataClassification = CustomerContent;
        }
        field(70; "PI approved by"; Text[30])
        {
            Caption = 'PI approved by';
            DataClassification = CustomerContent;
        }
        field(80; "PI approval date"; Date)
        {
            Caption = 'PI approval date';
            DataClassification = CustomerContent;
        }
        field(81; "Original Doc Receipt date"; Date)
        {
            Caption = 'Original Doc Receipt date';
            DataClassification = CustomerContent;
        }
        field(90; "OK UBS date"; Date)
        {
            Caption = 'OK UBS date';
            DataClassification = CustomerContent;
        }
        field(100; "Doc to Client date"; Date)
        {
            Caption = 'Doc to Client date';
            DataClassification = CustomerContent;
        }
        field(110; "LC expiry date"; Date)
        {
            Caption = 'LC expiry date';
            DataClassification = CustomerContent;
        }
        field(119; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            DataClassification = CustomerContent;
        }
        field(120; "Bank dossier"; Code[30])
        {
            Caption = 'Bank dossier';
            DataClassification = CustomerContent;
        }
        field(130; "Forwarder Name"; Text[30])
        {
            Caption = 'Forwarder Name';
            DataClassification = CustomerContent;
        }
        field(131; "C.Clearance Co.Name"; Text[30])
        {
            Caption = 'C.Clearance Co.Name';
            DataClassification = CustomerContent;
        }
        field(140; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            DataClassification = CustomerContent;
        }
        field(141; Applicable; Text[5])
        {
            Caption = 'Applicable';
            DataClassification = CustomerContent;
        }
        field(150; "Shipping company"; Text[50])
        {
            Caption = 'Shipping company';
            DataClassification = CustomerContent;
        }
        field(160; "Booking Done"; Boolean)
        {
            Caption = 'Booking Done';
            DataClassification = CustomerContent;
        }
        field(161; "Effective Booking date"; Date)
        {
            Caption = 'Effective Booking date';
            DataClassification = CustomerContent;
        }
        field(170; "BL N°"; Code[50])
        {
            Caption = 'BL N°';
            DataClassification = CustomerContent;
        }
        field(180; "Vessel name"; Text[30])
        {
            Caption = 'Vessel name';
            DataClassification = CustomerContent;
        }
        field(181; "CTR 20'"; Boolean)
        {
            Caption = 'CTR 20''';
            DataClassification = CustomerContent;
        }
        field(182; "CTR 40'"; Boolean)
        {
            Caption = 'CTR 40''';
            DataClassification = CustomerContent;
        }
        field(183; "CTR 40'HQ"; Boolean)
        {
            Caption = 'CTR 40''HQ';
            DataClassification = CustomerContent;
        }
        field(184; "Loading Mode"; Text[15])
        {
            Caption = 'Loading Mode';
            DataClassification = CustomerContent;
        }
        field(190; "Quality Company"; Text[30])
        {
            Caption = 'Quality Company';
            DataClassification = CustomerContent;
        }
        field(191; "Quality inspection date"; Date)
        {
            Caption = 'Quality inspection date';
            DataClassification = CustomerContent;
        }
        field(200; "Certificate N°"; Text[30])
        {
            Caption = 'Certificate N°';
            DataClassification = CustomerContent;
        }
        field(210; "Shipment mode"; Enum "DEL Ship Per")
        {

            Caption = 'Shipment mode';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                FNC_DateValidate();
            end;
        }
        field(220; "B/C client"; Boolean)
        {
            Caption = 'B/C client';
            DataClassification = CustomerContent;
        }
        field(230; "Departure Port"; Text[30])
        {
            Caption = 'Departure Port';
            DataClassification = CustomerContent;
        }
        field(240; "ETD Requested"; Date)
        {
            Caption = 'ETD Requested';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                FNC_DateValidate();
            end;
        }
        field(250; "Revised ETD"; Date)
        {
            Caption = 'Revised ETD';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                FNC_DateValidate();
            end;
        }
        field(260; "Actual departure date"; Date)
        {
            Caption = 'Actual departure date';
            DataClassification = CustomerContent;
        }
        field(270; "Arrival port"; Text[30])
        {
            Caption = 'Arrival port';
            DataClassification = CustomerContent;
        }
        field(280; "ETA date"; Date)
        {
            Caption = 'ETA date';
            DataClassification = CustomerContent;
        }
        field(290; "Actual Arrival date"; Date)
        {
            Caption = 'Actual Arrival date';
            DataClassification = CustomerContent;
        }
        field(291; "Customer Delivery date"; Date)
        {
            Caption = 'Customer Delivery date';
            DataClassification = CustomerContent;
        }
        field(300; "C.Clearance date"; Date)
        {
            Caption = 'C.Clearance date';
            DataClassification = CustomerContent;
        }
        field(310; "Estimated CTNS"; Decimal)
        {
            Editable = false;
            Caption = 'Estimated CTNS';
            DataClassification = CustomerContent;
        }
        field(320; "Real CTNS"; Decimal)
        {
            Caption = 'Real CTNS';
            DataClassification = CustomerContent;
        }
        field(330; "Estimated volume"; Decimal)
        {
            Editable = false;
            Caption = 'Estimated volume';
            DataClassification = CustomerContent;
        }
        field(340; "Actual Volume"; Decimal)
        {
            Caption = 'Actual Volume';
            DataClassification = CustomerContent;
        }
        field(350; "Estimated Weight"; Decimal)
        {
            Editable = false;
            Caption = 'Estimated Weight';
            DataClassification = CustomerContent;
        }
        field(360; "Actual Weight"; Decimal)
        {
            Caption = 'Actual Weight';
            DataClassification = CustomerContent;
        }
        field(400; "N° Container"; Code[30])
        {
            Caption = 'N° Container';
            DataClassification = CustomerContent;
        }
        field(410; "Fact. VCO émise"; Boolean)
        {
            Caption = 'Fact. VCO émise';
            DataClassification = CustomerContent;
        }
        field(411; "N° Container 2"; Code[30])
        {
            Caption = 'N° Container 2';
            DataClassification = CustomerContent;
        }
        field(412; "N° Container 3"; Code[30])
        {
            Caption = 'N° Container 3';
            DataClassification = CustomerContent;
        }
        field(413; "N° Container 4"; Code[30])
        {
            Caption = 'N° Container 4';
            DataClassification = CustomerContent;
        }
        field(414; "Requested Cust. Delivery date"; Date)
        {
            Caption = 'Requested Cust. Delivery date';
            DataClassification = CustomerContent;
        }
        field(415; "qty CTR 20'"; Integer)
        {
            Caption = 'qty CTR 20''';
            DataClassification = CustomerContent;
        }
        field(416; "qty CTR 40'"; Integer)
        {
            Caption = 'qty CTR 40''';
            DataClassification = CustomerContent;
        }
        field(417; "qty CTR 40'HQ"; Integer)
        {
            Caption = 'qty CTR 40''HQ';
            DataClassification = CustomerContent;
        }
        field(418; "Original doc sending date"; Date)
        {
            Caption = 'Original doc sending date';
            DataClassification = CustomerContent;
        }
        field(500; "ACO No."; Code[20])
        {
            TableRelation = "Purchase Header"."No.";
            ValidateTableRelation = false;
            Caption = 'ACO No.';
            DataClassification = CustomerContent;
        }
        field(501; "Display record"; Boolean)
        {
            Caption = 'Display record';
            DataClassification = CustomerContent;
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
        Aco_Connect: Record "DEL ACO Connection";
        Element_Re: Record "DEL Element";
        Item_Re: Record Item;
        PurchRcpt_Re: Record "Purch. Rcpt. Header";
        PurchRcptLine_Re: Record "Purch. Rcpt. Line";
        PurchHead_Re: Record "Purchase Header";
        PurchLine_Re: Record "Purchase Line";
        Vendor_Re: Record Vendor;


    procedure FNC_GetInfo(Logistic_Re_Par: Record "DEL Logistic")
    var
        AcoNo_Co_Loc: Code[20];
        Cubic_De_Loc: Decimal;
        PackNumber_De_Loc: Decimal;
        Weight_De_Loc: Decimal;
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
            UNTIL PurchLine_Re.NEXT() = 0;


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
        Cubic_De_Loc: Decimal;
        PackNumber_De_Loc: Decimal;
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

