table 50034 Logistic
{
    // 
    // Ngts/loco/grc   14.04.10  add field 500  + code under validate deal id
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:29.08.2013                                             |
    // | Customer/Project:NGTS                                         |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // ------------------------------------------------------------------------------
    //              THM     24.10.2013          change "Supplier Name" length 30 to 50
    //              THM     13.12.13            ADD Field  Affectation manuelle
    // 
    // Mgts10.00.05.00      04.01.2022 : Replace "Vol cbm" GetVolCBM

    DataCaptionFields = ID, "BR No.";
    Caption = 'Logistic';

    fields
    {
        field(1; ID; Code[20])
        {
        }
        field(10; Deal_ID; Code[20])
        {
            TableRelation = Deal.ID;

            trigger OnValidate()
            begin

                Aco_Connect.SETRANGE(Deal_ID, Deal_ID);
                IF Aco_Connect.FIND('-') THEN
                    "ACO No." := Aco_Connect."ACO No.";
            end;
        }
        field(30; "BR No."; Code[20])
        {
            TableRelation = "Purch. Rcpt. Header".No.;
        }
        field(40;"Supplier Name";Text[50])
        {
            Caption = 'Supplier Name';
        }
        field(50;"N° PI";Code[20])
        {
            Caption = 'No. PI';
        }
        field(60;"Date PI";Date)
        {
        }
        field(70;"PI approved by";Text[30])
        {
            Caption = 'PI approved by';
        }
        field(80;"PI approval date";Date)
        {
            Caption = 'PI approval date';
        }
        field(81;"Original Doc Receipt date";Date)
        {
        }
        field(90;"OK UBS date";Date)
        {
            Caption = 'OK UBS date';
        }
        field(100;"Doc to Client date";Date)
        {
            Caption = 'Doc to Client date';
        }
        field(110;"LC expiry date";Date)
        {
            Caption = 'LC expiry date';
        }
        field(119;"Payment Terms Code";Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
        }
        field(120;"Bank dossier";Code[30])
        {
            Caption = 'Bank dossier';
        }
        field(130;"Forwarder Name";Text[30])
        {
            Caption = 'Forwarder Name';
        }
        field(131;"C.Clearance Co.Name";Text[30])
        {
        }
        field(140;"Company Name";Text[30])
        {
        }
        field(141;Applicable;Text[5])
        {
        }
        field(150;"Shipping company";Text[50])
        {
        }
        field(160;"Booking Done";Boolean)
        {
        }
        field(161;"Effective Booking date";Date)
        {
        }
        field(170;"BL N°";Code[30])
        {
        }
        field(180;"Vessel name";Text[30])
        {
        }
        field(181;"CTR 20'";Boolean)
        {
        }
        field(182;"CTR 40'";Boolean)
        {
        }
        field(183;"CTR 40'HQ";Boolean)
        {
        }
        field(184;"Loading Mode";Text[15])
        {
        }
        field(190;"Quality Company";Text[30])
        {
        }
        field(191;"Quality inspection date";Date)
        {
        }
        field(200;"Certificate N°";Text[30])
        {
        }
        field(210;"Shipment mode";Option)
        {
            OptionMembers = "Air Flight","Sea Vessel";

            trigger OnValidate()
            begin
                FNC_DateValidate;
            end;
        }
        field(220;"B/C client";Boolean)
        {
        }
        field(230;"Departure Port";Text[30])
        {
        }
        field(240;"ETD Requested";Date)
        {

            trigger OnValidate()
            begin
                FNC_DateValidate;
            end;
        }
        field(250;"Revised ETD";Date)
        {

            trigger OnValidate()
            begin
                FNC_DateValidate;
            end;
        }
        field(260;"Actual departure date";Date)
        {
        }
        field(270;"Arrival port";Text[30])
        {
        }
        field(280;"ETA date";Date)
        {
        }
        field(290;"Actual Arrival date";Date)
        {
        }
        field(291;"Customer Delivery date";Date)
        {
        }
        field(300;"C.Clearance date";Date)
        {
        }
        field(310;"Estimated CTNS";Decimal)
        {
            Editable = false;
        }
        field(320;"Real CTNS";Decimal)
        {
        }
        field(330;"Estimated volume";Decimal)
        {
            Editable = false;
        }
        field(340;"Actual Volume";Decimal)
        {
        }
        field(350;"Estimated Weight";Decimal)
        {
            Editable = false;
        }
        field(360;"Actual Weight";Decimal)
        {
        }
        field(400;"N° Container";Code[30])
        {
        }
        field(410;"Fact. VCO émise";Boolean)
        {
        }
        field(411;"N° Container 2";Code[30])
        {
        }
        field(412;"N° Container 3";Code[30])
        {
        }
        field(413;"N° Container 4";Code[30])
        {
        }
        field(414;"Requested Cust. Delivery date";Date)
        {
        }
        field(415;"qty CTR 20'";Integer)
        {
        }
        field(416;"qty CTR 40'";Integer)
        {
        }
        field(417;"qty CTR 40'HQ";Integer)
        {
        }
        field(418;"Original doc sending date";Date)
        {
        }
        field(500;"ACO No.";Code[20])
        {
            TableRelation = "Purchase Header".No.;
            ValidateTableRelation = false;
        }
        field(501;"Display record";Boolean)
        {
        }
        field(502;"Affectation manuelle";Boolean)
        {
            CalcFormula = Exist("Tracking général" WHERE (Booking_no=FIELD(BL N°)));
            Caption = 'Manual assignment';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;ID,Deal_ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PurchRcpt_Re: Record "120";
        Vendor_Re: Record "23";
        PurchHead_Re: Record "38";
        PurchRcptLine_Re: Record "121";
        Item_Re: Record "27";
        PurchArchHead_Re: Record "5109";
        PurchLine_Re: Record "39";
        Element_Re: Record "50021";
        Aco_Connect: Record "50026";


    procedure FNC_GetInfo(Logistic_Re_Par: Record "50034")
    var
        PackNumber_De_Loc: Decimal;
        Cubic_De_Loc: Decimal;
        Weight_De_Loc: Decimal;
        AcoNo_Co_Loc: Code[20];
    begin
        Element_Re.SETRANGE(Deal_ID,Logistic_Re_Par.Deal_ID);
        Element_Re.SETRANGE(Element_Re.Type,Element_Re.Type::ACO);
        IF Element_Re.FIND('-') THEN BEGIN
          AcoNo_Co_Loc := Element_Re."Type No.";
        END;

        IF PurchHead_Re.GET(PurchHead_Re."Document Type"::Order,AcoNo_Co_Loc) THEN BEGIN
          IF Vendor_Re.GET(PurchHead_Re."Buy-from Vendor No.") THEN
            Logistic_Re_Par."Supplier Name" := Vendor_Re.Name;

          Logistic_Re_Par."Forwarder Name" := PurchHead_Re."Forwarding Agent Code";
          Logistic_Re_Par.VALIDATE("Shipment mode",PurchHead_Re."Ship Per");
          Logistic_Re_Par."ETD Requested" := PurchHead_Re."Requested Receipt Date";
          //Changer port
          Logistic_Re_Par."Arrival port" := PurchHead_Re."Port d'arrivée";
          Logistic_Re_Par."Departure Port" := PurchHead_Re."Port de départ";
          Logistic_Re_Par."Payment Terms Code" := PurchHead_Re."Payment Terms Code";
        END;


        // + Pièce par cartons Total + calcul M3 + poids
        PurchLine_Re.SETRANGE("Document No.",PurchHead_Re."No.");
        PurchLine_Re.SETFILTER(Quantity,'<>0');
        IF PurchLine_Re.FIND('-') THEN REPEAT
          IF (Item_Re.GET(PurchLine_Re."No.")) AND (PurchLine_Re.Type=PurchRcptLine_Re.Type::Item) THEN BEGIN

            IF Item_Re.PCB <> 0 THEN
              PackNumber_De_Loc := PackNumber_De_Loc +(PurchLine_Re.Quantity / Item_Re.PCB)
            ELSE
              PackNumber_De_Loc := PackNumber_De_Loc + PurchLine_Re.Quantity;
              //>>

        //<<Mgts10.00.05.00
             //IF Item_Re."vol cbm" <> 0 THEN
              //Cubic_De_Loc := Cubic_De_Loc + (Item_Re."vol cbm" * PurchLine_Re.Quantity)

             IF Item_Re.GetVolCBM(TRUE) <> 0 THEN
              Cubic_De_Loc := Cubic_De_Loc + (Item_Re.GetVolCBM(TRUE) * PurchLine_Re.Quantity)
              //<<

        //<<Mgts10.00.05.00
            ELSE
              Cubic_De_Loc := Cubic_De_Loc + PurchLine_Re.Quantity;
             IF Item_Re."Weight brut" <> 0 THEN
              Weight_De_Loc := Weight_De_Loc + (Item_Re."Weight brut" * PurchLine_Re.Quantity)
            ELSE
              Weight_De_Loc := Weight_De_Loc + PurchLine_Re.Quantity;
            END;
        UNTIL PurchLine_Re.NEXT = 0;


        IF Logistic_Re_Par."Shipment mode" = Logistic_Re_Par."Shipment mode"::"Sea Vessel" THEN BEGIN
          IF Logistic_Re_Par."Revised ETD" = 0D THEN
            IF Logistic_Re_Par."ETD Requested" <> 0D THEN
              Logistic_Re_Par."ETA date" := CALCDATE('<30D>',Logistic_Re_Par."ETD Requested")
          ELSE
            IF Logistic_Re_Par."ETD Requested" <> 0D THEN
             Logistic_Re_Par."Revised ETD" := CALCDATE('<30D>',Logistic_Re_Par."ETD Requested");
        END ELSE BEGIN
          IF Logistic_Re_Par."Revised ETD" = 0D THEN
            IF Logistic_Re_Par."ETD Requested" <> 0D THEN
              Logistic_Re_Par."ETA date" := CALCDATE('<1D>',Logistic_Re_Par."ETD Requested")
          ELSE
            IF Logistic_Re_Par."ETD Requested" <> 0D THEN
             Logistic_Re_Par."Revised ETD" := CALCDATE('<1D>',Logistic_Re_Par."ETD Requested");

        END;

        Logistic_Re_Par."Estimated CTNS" := PackNumber_De_Loc;
        Logistic_Re_Par."Estimated volume" := Cubic_De_Loc;
        Logistic_Re_Par."Estimated Weight" := Weight_De_Loc;


        Logistic_Re_Par.VALIDATE(Deal_ID);//grc new

        Logistic_Re_Par.INSERT;
    end;


    procedure FNC_DateValidate()
    begin
        IF "Shipment mode" = "Shipment mode"::"Sea Vessel" THEN BEGIN
          IF "Revised ETD" = 0D THEN
            IF "ETD Requested" <> 0D THEN
              "ETA date" := CALCDATE('<30D>',"ETD Requested")
          ELSE
            IF "ETD Requested" <> 0D THEN
             "Revised ETD" := CALCDATE('<30D>',"ETD Requested");
        END ELSE BEGIN
          IF "Revised ETD" = 0D THEN
            IF "ETD Requested" <> 0D THEN
              "ETA date" := CALCDATE('<1D>',"ETD Requested")
          ELSE
            IF "ETD Requested" <> 0D THEN
             "Revised ETD" := CALCDATE('<1D>',"ETD Requested");

        END;
    end;


    procedure FNC_PackEstim(Logistic_Re_Par: Record "50034")
    var
        PackNumber_De_Loc: Decimal;
        Cubic_De_Loc: Decimal;
        Weight_De_Loc: Decimal;
    begin
        IF PurchRcpt_Re.GET(Logistic_Re_Par."BR No.") THEN BEGIN

          PurchRcptLine_Re.SETRANGE("Document No.",PurchRcpt_Re."No.");
          PurchRcptLine_Re.SETFILTER(Quantity,'<>0');
          IF PurchRcptLine_Re.FINDFIRST THEN REPEAT
            IF (Item_Re.GET(PurchRcptLine_Re."No.")) AND (PurchRcptLine_Re.Type=PurchRcptLine_Re.Type::Item) THEN BEGIN

              IF Item_Re.PCB <> 0 THEN
                PackNumber_De_Loc := PackNumber_De_Loc +(PurchRcptLine_Re.Quantity / Item_Re.PCB)
              ELSE
                PackNumber_De_Loc := PackNumber_De_Loc + PurchRcptLine_Re.Quantity;
                //>>

        //<<Mgts10.00.05.00
              // IF Item_Re."vol cbm" <> 0 THEN
                //Cubic_De_Loc := Cubic_De_Loc + (Item_Re."vol cbm" * PurchRcptLine_Re.Quantity)
               IF Item_Re.GetVolCBM(TRUE) <> 0 THEN
                Cubic_De_Loc := Cubic_De_Loc + (Item_Re.GetVolCBM(TRUE) * PurchRcptLine_Re.Quantity)
                //<<

        //<<Mgts10.00.05.00
              ELSE
                Cubic_De_Loc := Cubic_De_Loc + PurchRcptLine_Re.Quantity;
               IF Item_Re."Weight brut" <> 0 THEN
                Weight_De_Loc := Weight_De_Loc + (Item_Re."Weight brut" * PurchRcptLine_Re.Quantity)
              ELSE
                Weight_De_Loc := Weight_De_Loc + PurchRcptLine_Re.Quantity;
              END;
          UNTIL PurchRcptLine_Re.NEXT = 0;

        END;

        Logistic_Re_Par."Estimated CTNS" := PackNumber_De_Loc;
        Logistic_Re_Par."Estimated volume" := Cubic_De_Loc;
        Logistic_Re_Par."Estimated Weight" := Weight_De_Loc;
        Logistic_Re_Par.MODIFY;
    end;
}

