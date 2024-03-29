tableextension 50028 "DEL PurchaseHeader" extends "Purchase Header" //38
{
    fields

    {

        field(50000; "DEL Ship Per"; enum "DEL Ship Per")
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                IF NOT (xRec."DEL Ship Per" = "DEL Ship Per") THEN
                    UpdateSalesEstimatedDelivery();
            end;
        }
        field(50002; "DEL Forwarding Agent Code"; Code[20])
        {
            Caption = 'Forwarding Agent Code';
            DataClassification = CustomerContent;

            TableRelation = "DEL Forwarding agent 2";
        }
        field(50003; "DEL Port de départ"; Text[30])
        {

            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
        field(50004; "DEL Code événement"; Enum "DEL Code Event")
        {
            DataClassification = CustomerContent;
        }
        field(50005; "DEL Récépissé transitaire"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50006; "DEL Port d'arrivée"; Text[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
        field(50007; "DEL DealNeedsUpdate"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50008; "DEL Create By"; Text[50])
        {
            Caption = 'Create By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50009; "DEL Create Date"; Date)
        {
            Caption = 'Create Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50010; "DEL Create Time"; Time)
        {
            Caption = 'Create Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50011; "DEL Requested Delivery Date"; Date)
        {
            AccessByPermission = TableData "Order Promising Line" = R;
            Caption = 'Requested Delivery Date';
            DataClassification = CustomerContent;
        }
        field(50012; "DEL Rel. Exch. Rate Amount"; Decimal)
        {
            Caption = 'Relational Exch. Rate Amount';
            DataClassification = CustomerContent;
            DecimalPlaces = 1 : 6;
        }
        field(50013; "DEL Vendor Shipment Date"; Date)
        {
            Caption = 'Vendor Shipment Date';
            DataClassification = CustomerContent;
        }
        field(50014; "DEL Type Order EDI"; Code[20])
        {
            Caption = 'Type Order EDI';
            DataClassification = CustomerContent;
            TableRelation = "DEL Type Order EDI";
        }
        field(50015; "DEL GLN"; Text[30])
        {
            Caption = 'GLN';
            DataClassification = CustomerContent;
        }
        field(50016; "DEL Type Order EDI Description"; Text[50])
        {
            // TODO CalcFormula = Lookup("Type Order EDI".Description WHERE(Code = FIELD("Type Order EDI")));
            Caption = 'Type Order EDI Description';

            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "DEL Due Date Calculation"; Date)
        {
            Caption = 'Due Date Calculation';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                VALIDATE("Payment Terms Code");
                VALIDATE("Prepmt. Payment Terms Code");
            end;
        }
        field(50052; "DEL Container No."; Code[30])
        {
            Caption = 'Container Number';
            DataClassification = CustomerContent;
        }
        field(50053; "DEL Dispute Reason"; Code[20])
        {
            Caption = 'Dispute Reason';
            DataClassification = CustomerContent;
        }
        field(50054; "DEL Dispute Date"; Date)
        {
            Caption = 'Dispute Date';
            DataClassification = CustomerContent;
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete". TODO: yes

    //trigger (Variable: NTO_DocDim)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnDelete".  

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT UserSetupMgt.CheckRespCenter(1,"Responsibility Center") THEN
      ERROR(
        Text023,
    #4..38
       (PurchCrMemoHeaderPrepmt."No." <> '')
    THEN
      MESSAGE(PostedDocsToPrintCreatedMsg);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..41
    //MIG2017
    // Interne1 -
    SalesLine.SETRANGE("Shortcut Dimension 1 Code","No.");
    IF SalesLine.FIND('-') THEN BEGIN
      REPEAT
        SalesLine.VALIDATE("Shortcut Dimension 1 Code", '');
        SalesLine.MODIFY;
      UNTIL SalesLine.NEXT=0;
    END;
    // Interne1 +
    //MIG2017
    */
    //end;


    //Unsupported feature: Code Modification on "OnInsert". TODO: yes

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT SkipInitialization THEN
      InitInsert;

    IF GETFILTER("Buy-from Vendor No.") <> '' THEN
      IF GETRANGEMIN("Buy-from Vendor No.") = GETRANGEMAX("Buy-from Vendor No.") THEN
        VALIDATE("Buy-from Vendor No.",GETRANGEMIN("Buy-from Vendor No."));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    //MIG2017
    //START THM160317
    "Create By":=USERID;
    "Create Date":=TODAY;
    "Create Time":=TIME;
    //END THM160317
    NTO_SetPurchDim;
    //MIG2017 END
    */
    //end;


    //Unsupported feature: Code Modification on "InitRecord(PROCEDURE 10)".

    //procedure InitRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    PurchSetup.GET;

    CASE "Document Type" OF
    #4..54
    IF PurchSetup."Default Posting Date" = PurchSetup."Default Posting Date"::"No Date" THEN
      "Posting Date" := 0D;

    "Document Date" := WORKDATE;

    VALIDATE("Sell-to Customer No.",'');
    #61..70

    "Responsibility Center" := UserSetupMgt.GetRespCenter(1,"Responsibility Center");
    "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Purchase Header","Document Type","No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..57
    //MGTS10.024; 007; mhh; single
    //MGTS10.024; 28.04.21; mhh; deleted line: "Due Date Calculation" := "Posting Date";

    #58..73
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SpecPurchLine) (VariableCollection) on "RecreatePurchLines(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "RecreatePurchLines(PROCEDURE 4)".

    //procedure RecreatePurchLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF PurchLinesExist THEN BEGIN
      IF HideValidationDialog THEN
        Confirmed := TRUE
      ELSE
        Confirmed :=
          CONFIRM(
            Text016 +
            ConfirmChangeQst,FALSE,ChangedFieldName);
      IF Confirmed THEN BEGIN
        PurchLine.LOCKTABLE;
        ItemChargeAssgntPurch.LOCKTABLE;
    #12..54
            ItemChargeAssgntPurch.DELETEALL;
          END;

          PurchLine.DELETEALL(TRUE);

          PurchLine.INIT;
    #61..140
        ERROR(
          Text018,ChangedFieldName);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4

        //MGTS10.013; 005; mhh; begin
        IF ChangedFieldName = FIELDCAPTION("VAT Bus. Posting Group") THEN
          Confirmed := TRUE
        ELSE
          //MGTS10.013; 005; mhh; end

          Confirmed :=
            CONFIRM(
              Text016 +
              ConfirmChangeQst,FALSE,ChangedFieldName);
    #9..57
          //MGTS10.013; 005; mhh; begin
          IF ChangedFieldName = FIELDCAPTION("VAT Bus. Posting Group") THEN BEGIN
            SpecPurchLine.RESET;
            SpecPurchLine.SETRANGE("Document Type", "Document Type");
            SpecPurchLine.SETRANGE("Document No.", "No.");
            IF SpecPurchLine.FINDSET THEN
              REPEAT
                SpecPurchLine."Special Order Sales Line No." := 0;
                SpecPurchLine.MODIFY;
              UNTIL SpecPurchLine.NEXT = 0;
          END;
          //MGTS10.013; 005; mhh; begin

    #58..143
    */
    //end;


    //Unsupported feature: Code Modification on "TransferSavedFieldsSpecialOrder(PROCEDURE 77)".

    //procedure TransferSavedFieldsSpecialOrder();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine.GET(SalesLine."Document Type"::Order,
      SourcePurchaseLine."Special Order Sales No.",
      SourcePurchaseLine."Special Order Sales Line No.");
    CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine,DestinationPurchaseLine);
    DestinationPurchaseLine."Special Order" := SourcePurchaseLine."Special Order";
    DestinationPurchaseLine."Purchasing Code" := SalesLine."Purchasing Code";
    DestinationPurchaseLine."Special Order Sales No." := SourcePurchaseLine."Special Order Sales No.";
    DestinationPurchaseLine."Special Order Sales Line No." := SourcePurchaseLine."Special Order Sales Line No.";
    DestinationPurchaseLine.VALIDATE("Unit of Measure Code",SourcePurchaseLine."Unit of Measure Code");
    IF SourcePurchaseLine.Quantity <> 0 THEN
      DestinationPurchaseLine.VALIDATE(Quantity,SourcePurchaseLine.Quantity);

    SalesLine.VALIDATE("Unit Cost (LCY)",DestinationPurchaseLine."Unit Cost (LCY)");
    SalesLine."Special Order Purchase No." := DestinationPurchaseLine."Document No.";
    SalesLine."Special Order Purch. Line No." := DestinationPurchaseLine."Line No.";
    SalesLine.MODIFY;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*

    //MGTS10.013; 005; mhh; begin
    SalesLine.LOCKTABLE;

    //deleted line: SalesLine.GET(SalesLine."Document Type"::Order, SourcePurchaseLine."Special Order Sales No.", SourcePurchaseLine."Special Order Sales Line No.");
    IF SalesLine.GET(SalesLine."Document Type"::Order, SourcePurchaseLine."Special Order Sales No.", SourcePurchaseLine."Special Order Sales Line No.") THEN

      CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine,DestinationPurchaseLine);
    DestinationPurchaseLine."Special Order" := SourcePurchaseLine."Special Order";
    DestinationPurchaseLine."Purchasing Code" := SourcePurchaseLine."Purchasing Code";
    #7..12
    //MGTS10.013; 005; mhh; single
    IF SalesLine.GET(SalesLine."Document Type"::Order, SourcePurchaseLine."Special Order Sales No.", SourcePurchaseLine."Special Order Sales Line No.") THEN BEGIN

      SalesLine.VALIDATE("Unit Cost (LCY)",DestinationPurchaseLine."Unit Cost (LCY)");
      SalesLine."Special Order Purchase No." := DestinationPurchaseLine."Document No.";
      SalesLine."Special Order Purch. Line No." := DestinationPurchaseLine."Line No.";
      SalesLine.MODIFY;

    //MGTS10.013; 005; mhh; begin
    END;
    */
    //end;


    //Unsupported feature: Code Modification on "CopyBuyFromVendorAddressFieldsFromVendor(PROCEDURE 62)".

    //procedure CopyBuyFromVendorAddressFieldsFromVendor();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF BuyFromVendorIsReplaced OR ShouldCopyAddressFromBuyFromVendor(BuyFromVendor) THEN BEGIN
      "Buy-from Address" := BuyFromVendor.Address;
      "Buy-from Address 2" := BuyFromVendor."Address 2";
      "Buy-from City" := BuyFromVendor.City;
      "Buy-from Post Code" := BuyFromVendor."Post Code";
      "Buy-from County" := BuyFromVendor.County;
      "Buy-from Country/Region Code" := BuyFromVendor."Country/Region Code";
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7

      //MGTS10.023; 006; mhh; single
      "Ship Per" := BuyFromVendor."Ship Per";

    END;
    */
    //end;

    procedure NTO_UpdateForwardingAgent()
    var
        _ForwardingAgent: Record "DEL Forwarding Agent";
        _Vendor: Record Vendor;
        Text001: Label 'Do you want update the Forwarding Agent from "%1" to "%2" ?';
    begin
        IF NOT _ForwardingAgent.GET("Buy-from Vendor No.", "Location Code") THEN
            IF _Vendor.GET("Buy-from Vendor No.") THEN
                _ForwardingAgent."Forwarding Agent" := _Vendor."DEL Forwarding Agent Code";

        IF "DEL Forwarding Agent Code" <> _ForwardingAgent."Forwarding Agent" THEN
            IF NOT HideValidationDialog THEN
                IF NOT CONFIRM(STRSUBSTNO(Text001, "DEL Forwarding Agent Code", _ForwardingAgent."Forwarding Agent")) THEN
                    EXIT;

        "DEL Forwarding Agent Code" := _ForwardingAgent."Forwarding Agent";
        "DEL Port de départ" := _ForwardingAgent."Departure port";
    end;

    procedure NTO_SetPurchDim()
    var
        //TODO TABLE 357
        NTO_DocDim: Record "Dimension Set Entry"; //357 
        NTO_DimVal: Record "Dimension Value"; //349 

    begin
        NTO_GenSetup.GET();
        // Créer nouvelle Dimension Value
        NTO_DimVal.INIT();
        NTO_DimVal."Dimension Code" := NTO_GenSetup."Code Axe Achat";
        NTO_DimVal.Code := "No.";
        NTO_DimVal."Global Dimension No." := 1; // JMO correction
        IF NTO_DimVal.INSERT() THEN;

        // Créer nouveau Axe Document
        //TODO //DOCDim
        NTO_DocDim.INIT();
        //TODO NTO_DocDim."Table ID" := 38;
        // NTO_DocDim."Document Type" := "Document Type";
        // NTO_DocDim."Document No." := "No.";
        NTO_DocDim."Dimension Code" := NTO_GenSetup."Code Axe Achat";
        NTO_DocDim."Dimension Value Code" := "No.";
        IF NTO_DocDim.INSERT() THEN;
    end;

    procedure NTO_ReportPurchDim2SalesLines(NTO_PurchHead: Record "Purchase Header")
    var
        NTO_DocDim: Record "Gen. Jnl. Dim. Filter";
        NTO_PurchLine: Record "Purchase Line";
        NTO_ResEntryPurch: Record "Reservation Entry";
        NTO_ResEntrySale: Record "Reservation Entry";
        NTO_SalesLine: Record "Sales Line";
    begin

        NTO_GenSetup.GET();
        NTO_PurchLine.SETRANGE("Document Type", NTO_PurchHead."Document Type");
        NTO_PurchLine.SETFILTER("Document No.", NTO_PurchHead."No.");
        IF NTO_PurchLine.FIND('-') THEN
            REPEAT
                NTO_ResEntryPurch.SETRANGE("Item No.", NTO_PurchLine."No.");
                NTO_ResEntryPurch.SETRANGE("Location Code", NTO_PurchLine."Location Code");
                NTO_ResEntryPurch.SETRANGE("Source ID", NTO_PurchLine."Document No.");
                IF NTO_ResEntryPurch.FIND('-') THEN
                    REPEAT
                        NTO_ResEntrySale.SETRANGE("Entry No.", NTO_ResEntryPurch."Entry No.");
                        NTO_ResEntrySale.SETRANGE("Source Type", 37);
                        IF NTO_ResEntrySale.FIND('-') THEN BEGIN
                            IF NTO_SalesLine.GET(NTO_SalesLine."Document Type"::Order,
                               NTO_ResEntrySale."Source ID", NTO_ResEntrySale."Source Ref. No.") THEN BEGIN
                                // Créer Axe Document
                                NTO_DocDim.INIT();
                                //TODO //DOCDim
                                // NTO_DocDim."Table ID" := 37;
                                // NTO_DocDim."Document Type" := NTO_DocDim."Document Type"::Order;
                                // NTO_DocDim."Document No." := NTO_ResEntrySale."Source ID";
                                // NTO_DocDim."Dimension Code" := NTO_GenSetup."Code Axe Achat";
                                // NTO_DocDim."Dimension Value Code" := NTO_ResEntryPurch."Source ID";
                                // NTO_DocDim."Line No." := NTO_ResEntrySale."Source Ref. No.";
                                // IF NTO_DocDim.INSERT() THEN NTO_DocDim.MODIFY();
                                // NTO_SalesLine."Shortcut Dimension 1 Code" := NTO_ResEntryPurch."Source ID";
                                // NTO_SalesLine.MODIFY();
                            END;
                            NTO_PurchLine."Shortcut Dimension 1 Code" := NTO_ResEntryPurch."Source ID";
                            NTO_PurchLine.MODIFY();
                        END;
                    UNTIL NTO_ResEntryPurch.NEXT() = 0;
            UNTIL NTO_PurchLine.NEXT() = 0;
    end;

    procedure UpdateSalesEstimatedDelivery()
    var
        PurchLine: Record "Purchase Line";
        PurchSetup1: Record "Purchases & Payables Setup";
        SalesLine: Record "Sales Line";
        Vendor: Record Vendor;
    begin

        Vendor.GET("Buy-from Vendor No.");
        IF Vendor."DEL Lead Time Not Allowed" THEN
            EXIT;

        IF NOT PurchSetup1.GET() THEN
            PurchSetup1.INIT();

        PurchLine.RESET();
        PurchLine.SETRANGE("Document Type", "Document Type");
        PurchLine.SETRANGE("Document No.", "No.");
        PurchLine.SETFILTER("Special Order Sales No.", Text50000);
        PurchLine.SETFILTER("Special Order Sales Line No.", Text50001);
        IF PurchLine.FINDSET() THEN
            REPEAT
                SalesLine.RESET();
                SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SETRANGE("Document No.", PurchLine."Special Order Sales No.");
                SalesLine.SETRANGE("Line No.", PurchLine."Special Order Sales Line No.");
                IF SalesLine.FINDFIRST() THEN
                    CASE "DEL Ship Per" OF
                        "DEL Ship Per"::"Air Flight":
                            BEGIN

                                IF "DEL Requested Delivery Date" <> 0D THEN BEGIN
                                    "Expected Receipt Date" := CALCDATE(PurchSetup1."DEL SalesShipTimeByAirFlight", "DEL Requested Delivery Date");
                                    MODIFY();

                                    PurchLine."Expected Receipt Date" := "Expected Receipt Date";
                                    PurchLine.MODIFY();
                                END;

                                IF NOT (PurchLine."Expected Receipt Date" = 0D) THEN BEGIN
                                    SalesLine."DEL Estimated Delivery Date" := CALCDATE(PurchSetup1."DEL SalesShipTimeByAirFlight", PurchLine."Expected Receipt Date");
                                    SalesLine.MODIFY();
                                END;
                            END;

                        "DEL Ship Per"::"Sea Vessel":
                            BEGIN

                                IF "DEL Requested Delivery Date" <> 0D THEN BEGIN
                                    "Expected Receipt Date" := CALCDATE(PurchSetup1."DEL SalesShipTimeBySeaVessel", "DEL Requested Delivery Date");
                                    MODIFY();

                                    PurchLine."Expected Receipt Date" := "Expected Receipt Date";
                                    PurchLine.MODIFY();
                                END;

                                IF NOT (PurchLine."Expected Receipt Date" = 0D) THEN BEGIN
                                    SalesLine."DEL Estimated Delivery Date" := CALCDATE(PurchSetup1."DEL SalesShipTimeBySeaVessel", PurchLine."Expected Receipt Date");
                                    SalesLine.MODIFY();
                                END;
                            END;

                        "DEL Ship Per"::"Sea/Air":
                            BEGIN

                                IF "DEL Requested Delivery Date" <> 0D THEN BEGIN
                                    "Expected Receipt Date" := CALCDATE(PurchSetup1."DEL Sales Ship Time By Sea/Air", "DEL Requested Delivery Date");
                                    MODIFY();

                                    PurchLine."Expected Receipt Date" := "Expected Receipt Date";
                                    PurchLine.MODIFY();
                                END;

                                IF NOT (PurchLine."Expected Receipt Date" = 0D) THEN BEGIN
                                    SalesLine."DEL Estimated Delivery Date" := CALCDATE(PurchSetup1."DEL Sales Ship Time By Sea/Air", PurchLine."Expected Receipt Date");
                                    SalesLine.MODIFY();
                                END;
                            END;

                        "DEL Ship Per"::Train:
                            BEGIN

                                IF "DEL Requested Delivery Date" <> 0D THEN BEGIN
                                    "Expected Receipt Date" := CALCDATE(PurchSetup1."DEL Sales Ship Time By Train", "DEL Requested Delivery Date");
                                    MODIFY();

                                    PurchLine."Expected Receipt Date" := "Expected Receipt Date";
                                    PurchLine.MODIFY();
                                END;

                                IF NOT (PurchLine."Expected Receipt Date" = 0D) THEN BEGIN
                                    SalesLine."DEL Estimated Delivery Date" := CALCDATE(PurchSetup1."DEL Sales Ship Time By Train", PurchLine."Expected Receipt Date");
                                    SalesLine.MODIFY();
                                END;
                            END;

                        "DEL Ship Per"::Truck:
                            BEGIN

                                IF "DEL Requested Delivery Date" <> 0D THEN BEGIN
                                    "Expected Receipt Date" := CALCDATE(PurchSetup1."DEL Sales Ship Time By Truck", "DEL Requested Delivery Date");
                                    MODIFY();

                                    PurchLine."Expected Receipt Date" := "Expected Receipt Date";
                                    PurchLine.MODIFY();
                                END;

                                IF NOT (PurchLine."Expected Receipt Date" = 0D) THEN BEGIN
                                    SalesLine."DEL Estimated Delivery Date" := CALCDATE(PurchSetup1."DEL Sales Ship Time By Truck", PurchLine."Expected Receipt Date");
                                    SalesLine.MODIFY();
                                END;
                            END;

                    END;
            UNTIL PurchLine.NEXT() = 0;
    end;

    var
        NTO_GenSetup: Record "DEL General Setup";
        Text50000: Label '<>''''';
        Text50001: Label '<>0';
}

