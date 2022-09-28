tableextension 50028 tableextension50028 extends "Purchase Header"
{
    // EDI       22.05.13/LOCO/ChC- New fields 50000..50005
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00652     THM     16.04.14           Test qualifier si group compta. fournisseur= march
    //             THM     23.04.14           add  derogation
    // T-00799     THM     22.06.16   NTO_UpdateForwardingAgent()   add "Port de départ"
    //             THM     16.03.17           Add Field 50008,50009,50010
    //             THM     16.03.17           Add OnInsert
    //             THM     08.09.17           MIG2017
    // THM150118   THM     15.01.18            masquer le msg mise à jour taux de change
    // THM160318   THM     16.03.18           Ship-to Code - OnValidate()
    // GAP2018-002 : MES 18/06/2018 : Requested Delivery Date
    // DEL:SAZ             02.07.19           Add filed 50012
    // DEL.SAZ             12.07.19           Modify Onvalidate "Currency Code"
    // DEL.SAZ             17.07.19           Modify Onvalidate "Posting Date"
    // DEL.SAZ             27.12.19           Modify option field 50000 add option Train
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Sign    : Emil Hr. Hristov = ehh
    // 
    // Version : MGTS10.00.002,MGTS10.00.006,MGTS10.009,MGTS10.010,MGTS10.013,MGTS10.023,MGTS10.024,
    //           MGTS10.025
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.002    08.01.20    mhh     List of changes:
    //                                              Added new field: 50013 "Vendor Shipment Date"
    // 
    // 002     MGTS10.00.006    04.02.20    mhh     List of changes:
    //                                              Created function: UpdateSalesEstimatedDelivery()
    //                                              Changed trigger: Ship Per - OnValidate()
    // -     DEL_QR            30.06.2020  THS      Add Field From 11510 To 11515
    // 
    // 003    MGTS10.009       09.09.20    ehh     List of changes:
    //                                              Added new field: 50014 Type Order ODI
    //                                              Added new field: 50016 Type Order ODI Description
    // 
    // 004    MGTS10.010       09.09.20    ehh     List of changes:
    //                                              Added new field: 50015 GLN
    // 
    // 005     MGTS10.013       09.11.20    mhh     List of changes:
    //                                              Changed function: RecreatePurchLines()
    //                                              Changed function: TransferSavedFieldsSpecialOrder()
    // 
    // 006     MGTS10.023       28.01.21    mhh     List of changes:
    //                                              Changed function: CopyBuyFromVendorAddressFieldsFromVendor()
    //                          02.03.21    mhh     Changed function: UpdateSalesEstimatedDelivery()
    // 
    // 007     MGTS10.024       09.02.21    mhh     List of changes:
    //                                              Added new field: 50017 "Due Date Calculation"
    //                                              Changed function: InitRecord()
    //                                              Changed trigger: Payment Terms Code - OnValidate()
    //                                              Changed trigger: Prepmt. Payment Terms Code - OnValidate()
    //                                              Changed trigger: Posting Date - OnValidate()
    //                          28.04.21    mhh     Changed trigger:
    // 
    // 008     MGTS10.025       17.02.21    mhh     List of changes:
    //                                              Changed type of field: 50004 "Code événement"
    // ------------------------------------------------------------------------------------------
    // 
    // 
    // MGTSEDI10.00.00.00 | 08.10.2020 | EDI Management : C\AL in :  Buy-from Vendor No. - OnValidate(), UpdateSalesEstimatedDelivery
    // 
    // MGTSEDI10.00.00.23 | 21.05.2021 | EDI Management : Add C/AL code function NTO_UpdateForwardingAgent
    //                                                     Add hidedialog condition
    fields
    {


        //Unsupported feature: Code Modification on ""Buy-from Vendor No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "No." = '' THEN
          InitRecord;
        TESTFIELD(Status,Status::Open);
        IF ("Buy-from Vendor No." <> xRec."Buy-from Vendor No.") AND
           (xRec."Buy-from Vendor No." <> '')
        THEN BEGIN
        #7..41
          "VAT Country/Region Code" := Vend."Country/Region Code";
        END;
        "Registration No." := Vend."Registration No.";
        VALIDATE("Lead Time Calculation",Vend."Lead Time Calculation");
        "Responsibility Center" := UserSetupMgt.GetRespCenter(1,Vend."Responsibility Center");
        VALIDATE("Sell-to Customer No.",'');
        VALIDATE("Location Code",UserSetupMgt.GetLocation(1,Vend."Location Code","Responsibility Center"));
        #49..76

        IF NOT SkipBuyFromContact THEN
          UpdateBuyFromCont("Buy-from Vendor No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        //MIG2017 START
        //START T-00652 THM
        IF Vend.GET("Buy-from Vendor No.") THEN
        BEGIN
         IF Vend."Vendor Posting Group"='MARCH' THEN
         IF  (Vend."Qualified vendor"=FALSE) AND (Vend.Derogation=FALSE) THEN
         Vend.TESTFIELD(Vend."Qualified vendor",TRUE);
        END;
        //STOP T-00652 THM
        //MIG2017 END
        #4..44

        //>>MGTSEDI10.00.00.00
        IF NOT Vend."Lead Time Not Allowed" THEN
        //<<MGTSEDI10.00.00.00

          VALIDATE("Lead Time Calculation",Vend."Lead Time Calculation");
        #46..79
        //START MIG2017
        // LOCO/ChC -
        NTO_UpdateForwardingAgent();
        // LOCO/ChC +
        //END MIG2017
        */
        //end;


        //Unsupported feature: Code Modification on ""Ship-to Code"(Field 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Document Type" = "Document Type"::Order) AND
           (xRec."Ship-to Code" <> "Ship-to Code")
        THEN BEGIN
        #4..15
            ShipToAddr.Name,ShipToAddr."Name 2",ShipToAddr.Address,ShipToAddr."Address 2",
            ShipToAddr.City,ShipToAddr."Post Code",ShipToAddr.County,ShipToAddr."Country/Region Code");
          "Ship-to Contact" := ShipToAddr.Contact;
          "Shipment Method Code" := ShipToAddr."Shipment Method Code";
          IF ShipToAddr."Location Code" <> '' THEN
            VALIDATE("Location Code",ShipToAddr."Location Code");
        END ELSE BEGIN
        #23..29
          IF Cust."Location Code" <> '' THEN
            VALIDATE("Location Code",Cust."Location Code");
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..18
          //THM160318
          //"Shipment Method Code" := ShipToAddr."Shipment Method Code"; //STD
          "Shipment Method Code" := ShipToAddr."Purchase Shipment Method Code";
          //THM160318 END
        #20..32
        */
        //end;


        //Unsupported feature: Code Modification on ""Posting Date"(Field 20).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestNoSeriesDate(
          "Posting No.","Posting No. Series",
          FIELDCAPTION("Posting No."),FIELDCAPTION("Posting No. Series"));
        #4..16
          PriceMessageIfPurchLinesExist(FIELDCAPTION("Posting Date"));

        IF "Currency Code" <> '' THEN BEGIN
          UpdateCurrencyFactor;
          IF "Currency Factor" <> xRec."Currency Factor" THEN
            SkipJobCurrFactorUpdate := NOT ConfirmUpdateCurrencyFactor;
        END;
        #24..27

        IF PurchLinesExist THEN
          JobUpdatePurchLines(SkipJobCurrFactorUpdate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..19
            //THM150118
          HideValidationDialog:=TRUE;
          //END THM150118
          UpdateCurrencyFactor;
          //DEL.SAZ 17.07.19
          IF "Currency Factor" <> 0 THEN
            VALIDATE("Relational Exch. Rate Amount",1/"Currency Factor");
          //END DEL.SAZ
        #21..30

        //MGTS10.024; 007; mhh; begin
        //MGTS10.024; 28.04.21; mhh; begin deletion
        {
        IF ("Due Date Calculation" = 0D) OR ("Due Date Calculation" = xRec."Posting Date") THEN
          VALIDATE("Due Date Calculation", "Posting Date");
        }
        //MGTS10.024; 28.04.21; mhh; end deletion
        //MGTS10.024; 007; mhh; end
        */
        //end;


        //Unsupported feature: Code Modification on ""Payment Terms Code"(Field 23).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
          PaymentTerms.GET("Payment Terms Code");
          IF IsCreditDocType AND NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN BEGIN
            VALIDATE("Due Date","Document Date");
            VALIDATE("Pmt. Discount Date",0D);
            VALIDATE("Payment Discount %",0);
          END ELSE BEGIN
            "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
            "Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
            IF NOT UpdateDocumentDate THEN
              VALIDATE("Payment Discount %",PaymentTerms."Discount %")
          END;
        END ELSE BEGIN
          VALIDATE("Due Date","Document Date");
          IF NOT UpdateDocumentDate THEN BEGIN
            VALIDATE("Pmt. Discount Date",0D);
            VALIDATE("Payment Discount %",0);
          END;
        END;
        IF xRec."Payment Terms Code" = "Prepmt. Payment Terms Code" THEN
          VALIDATE("Prepmt. Payment Terms Code","Payment Terms Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3

            //MGTS10.024; 007; mhh; begin
            IF "Due Date Calculation" <> 0D THEN
              VALIDATE("Due Date","Due Date Calculation")
            ELSE
            //MGTS10.024; 007; mhh; end

              VALIDATE("Due Date","Document Date");

        #5..7

            //MGTS10.024; 007; mhh; begin
            IF "Due Date Calculation" <> 0D THEN
              "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Due Date Calculation")
            ELSE
            //MGTS10.024; 007; mhh; end

              "Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");

        #9..13

          //MGTS10.024; 007; mhh; begin
          IF "Due Date Calculation" <> 0D THEN
            VALIDATE("Due Date","Due Date Calculation")
          ELSE
          //MGTS10.024; 007; mhh; end

            VALIDATE("Due Date","Document Date");

        #15..21
        */
        //end;


        //Unsupported feature: Code Modification on ""Location Code"(Field 28).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF ("Location Code" <> xRec."Location Code") AND
           (xRec."Buy-from Vendor No." = "Buy-from Vendor No.")
        #4..12
          IF Location.GET("Location Code") THEN;
          "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..15
        //MIG2017 START
        // LOCO/ChC -
        NTO_UpdateForwardingAgent();
        // LOCO/ChC +
        //MIG2017 END
        */
        //end;


        //Unsupported feature: Code Modification on ""Currency Code"(Field 32).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT (CurrFieldNo IN [0,FIELDNO("Posting Date")]) OR ("Currency Code" <> xRec."Currency Code") THEN
          TESTFIELD(Status,Status::Open);
        IF (CurrFieldNo <> FIELDNO("Currency Code")) AND ("Currency Code" = xRec."Currency Code") THEN
        #4..17
              IF "Currency Factor" <> xRec."Currency Factor" THEN
                ConfirmUpdateCurrencyFactor;
            END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..20
            //Del.SAZ 12.07.18
            IF "Currency Factor" <> 0 THEN
            VALIDATE("Relational Exch. Rate Amount",1/"Currency Factor");
            //End Del.SAZ
        */
        //end;


        //Unsupported feature: Code Modification on ""Currency Factor"(Field 33).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Currency Factor" <> xRec."Currency Factor" THEN
          UpdatePurchLines(FIELDCAPTION("Currency Factor"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Currency Factor" <> xRec."Currency Factor" THEN
          //THM150118
          //UpdatePurchLines(FIELDCAPTION("Currency Factor"),CurrFieldNo <> 0); //STD
          UpdatePurchLines(FIELDCAPTION("Currency Factor"),FALSE);
          //THM150118 END

        */
        //end;


        //Unsupported feature: Code Modification on ""Prepmt. Payment Terms Code"(Field 143).OnValidate".

        //trigger  Payment Terms Code"(Field 143)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Prepmt. Payment Terms Code" <> '') AND ("Document Date" <> 0D) THEN BEGIN
          PaymentTerms.GET("Prepmt. Payment Terms Code");
          IF IsCreditDocType AND NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos" THEN BEGIN
            VALIDATE("Prepayment Due Date","Document Date");
            VALIDATE("Prepmt. Pmt. Discount Date",0D);
            VALIDATE("Prepmt. Payment Discount %",0);
          END ELSE BEGIN
            "Prepayment Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");
            "Prepmt. Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation","Document Date");
            IF NOT UpdateDocumentDate THEN
              VALIDATE("Prepmt. Payment Discount %",PaymentTerms."Discount %")
          END;
        END ELSE BEGIN
          VALIDATE("Prepayment Due Date","Document Date");
          IF NOT UpdateDocumentDate THEN BEGIN
            VALIDATE("Prepmt. Pmt. Discount Date",0D);
            VALIDATE("Prepmt. Payment Discount %",0);
          END;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3

            //MGTS10.024; 007; mhh; begin
            IF "Due Date Calculation" <> 0D THEN
              VALIDATE("Prepayment Due Date", "Due Date Calculation")
            ELSE
            //MGTS10.024; 007; mhh; end

              VALIDATE("Prepayment Due Date","Document Date");

        #5..7

            //MGTS10.024; 007; mhh; begin
            IF "Due Date Calculation" <> 0D THEN
              "Prepayment Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", "Due Date Calculation")
            ELSE
            //MGTS10.024; 007; mhh; end

              "Prepayment Due Date" := CALCDATE(PaymentTerms."Due Date Calculation","Document Date");

        #9..13

          //MGTS10.024; 007; mhh; begin
          IF "Due Date Calculation" <> 0D THEN
            VALIDATE("Prepayment Due Date", "Due Date Calculation")
          ELSE
          //MGTS10.024; 007; mhh; end

            VALIDATE("Prepayment Due Date","Document Date");

        #15..19
        */
        //end;


        //Unsupported feature: Code Modification on ""Payment Reference"(Field 171).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Payment Reference" <> '' THEN
          TESTFIELD("Creditor No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //>>DEL_QR
        {
        IF "Payment Reference" <> '' THEN
          TESTFIELD("Creditor No.");
        }
        //<<DEL_QR
        */
        //end;
        field(11510; "Swiss QRBill"; Boolean)
        {
            Caption = 'Swiss QRBill';
            Description = 'DEL_QR';
            Editable = false;
        }
        field(11511; "Swiss QRBill IBAN"; Code[50])
        {
            Caption = 'IBAN/QR-IBAN';
            Description = 'DEL_QR';
            Editable = false;
        }
        field(11512; "Swiss QRBill Bill Info"; Text[140])
        {
            Caption = 'Billing Information';
            Description = 'DEL_QR';
            Editable = false;
        }
        field(11513; "Swiss QRBill Unstr. Message"; Text[140])
        {
            Caption = 'Unstructured Message';
            Description = 'DEL_QR';
            Editable = false;
        }
        field(11514; "Swiss QRBill Amount"; Decimal)
        {
            Caption = 'Amount';
            Description = 'DEL_QR';
            Editable = false;
        }
        field(11515; "Swiss QRBill Currency"; Code[10])
        {
            Caption = 'Currency';
            Description = 'DEL_QR';
            Editable = false;
        }
        field(50000; "Ship Per"; Option)
        {
            Description = 'EDI';
            OptionMembers = "Air Flight","Sea Vessel","Sea/Air",Truck,Train;

            trigger OnValidate()
            begin

                //MGTS10.00.006; 002; mhh; single
                IF NOT (xRec."Ship Per" = "Ship Per") THEN
                    UpdateSalesEstimatedDelivery();
            end;
        }
        field(50002; "Forwarding Agent Code"; Code[20])
        {
            Caption = 'Forwarding Agent Code';
            Description = 'EDI';
            TableRelation = "Forwarding agent 2";
        }
        field(50003; "Port de départ"; Text[30])
        {
            Description = 'EDI';
            TableRelation = Location.Code;
        }
        field(50004; "Code événement"; Option)
        {
            Description = 'EDI,MGTS10.025';
            OptionCaption = 'NORM,TYRE,SPARE,SMOOVE,ISP,CANCELLED';
            OptionMembers = NORM,TYRE,SPARE,SMOOVE,ISP,CANCELLED;
        }
        field(50005; "Récépissé transitaire"; Text[30])
        {
            Description = 'EDI';
        }
        field(50006; "Port d'arrivée"; Text[30])
        {
            TableRelation = Location.Code;
        }
        field(50007; DealNeedsUpdate; Boolean)
        {
            Description = 'Temp400';
        }
        field(50008; "Create By"; Text[50])
        {
            Caption = 'Create By';
            Editable = false;
        }
        field(50009; "Create Date"; Date)
        {
            Caption = 'Create Date';
            Editable = false;
        }
        field(50010; "Create Time"; Time)
        {
            Caption = 'Create Time';
            Editable = false;
        }
        field(50011; "Requested Delivery Date"; Date)
        {
            AccessByPermission = TableData 99000880 = R;
            Caption = 'Requested Delivery Date';
            Description = 'GAP2018-002';
        }
        field(50012; "Relational Exch. Rate Amount"; Decimal)
        {
            Caption = 'Relational Exch. Rate Amount';
            DecimalPlaces = 1 : 6;
        }
        field(50013; "Vendor Shipment Date"; Date)
        {
            Caption = 'Vendor Shipment Date';
            Description = 'MGTS10.00.002';
        }
        field(50014; "Type Order EDI"; Code[20])
        {
            Caption = 'Type Order EDI';
            Description = 'MGTS10.009';
            TableRelation = "Type Order EDI";
        }
        field(50015; GLN; Text[30])
        {
            Caption = 'GLN';
            Description = 'MGTS10.010';
        }
        field(50016; "Type Order EDI Description"; Text[50])
        {
            CalcFormula = Lookup ("Type Order EDI".Description WHERE (Code = FIELD (Type Order EDI)));
            Caption = 'Type Order EDI Description';
            Description = 'MGTS10.009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "Due Date Calculation"; Date)
        {
            Caption = 'Due Date Calculation';
            Description = 'MGTS10.024';

            trigger OnValidate()
            begin

                //MGTS10.024; 007; mhh; begin
                VALIDATE("Payment Terms Code");
                VALIDATE("Prepmt. Payment Terms Code");
                //MGTS10.024; 007; mhh; end
            end;
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

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


    //Unsupported feature: Code Modification on "OnInsert".

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
        _Vendor: Record "23";
        _ForwardingAgent: Record "50011";
        Text001: Label 'Do you want update the Forwarding Agent from "%1" to "%2" ?';
    begin
        // LOCO/ChC
        IF NOT _ForwardingAgent.GET("Buy-from Vendor No.", "Location Code") THEN
            IF _Vendor.GET("Buy-from Vendor No.") THEN
                _ForwardingAgent."Forwarding Agent" := _Vendor."Forwarding Agent Code";
        ///T-00799
        //IF (_ForwardingAgent."Forwarding Agent" = "Forwarding Agent Code" THEN
        //  EXIT;

        IF "Forwarding Agent Code" <> _ForwardingAgent."Forwarding Agent" THEN
            //T-00799
            //>>MGTSEDI10.00.00.23
            IF NOT HideValidationDialog THEN
                //>>MGTSEDI10.00.00.23
                IF NOT CONFIRM(STRSUBSTNO(Text001, "Forwarding Agent Code", _ForwardingAgent."Forwarding Agent")) THEN
                    EXIT;

        "Forwarding Agent Code" := _ForwardingAgent."Forwarding Agent";
        //T-00799
        "Port de départ" := _ForwardingAgent."Departure port";
        //T-00799
    end;

    procedure NTO_SetPurchDim()
    var
        NTO_DocDim: Record "357";
        NTO_DimVal: Record "349";
    begin
        NTO_GenSetup.GET;
        // Créer nouvelle Dimension Value
        NTO_DimVal.INIT;
        NTO_DimVal."Dimension Code" := NTO_GenSetup."Code Axe Achat";
        NTO_DimVal.Code := "No.";
        NTO_DimVal."Global Dimension No." := 1; // JMO correction
        IF NTO_DimVal.INSERT THEN;

        // Créer nouveau Axe Document
        NTO_DocDim.INIT;
        NTO_DocDim."Table ID" := 38;
        NTO_DocDim."Document Type" := "Document Type";
        NTO_DocDim."Document No." := "No.";
        NTO_DocDim."Dimension Code" := NTO_GenSetup."Code Axe Achat";
        NTO_DocDim."Dimension Value Code" := "No.";
        IF NTO_DocDim.INSERT THEN;
    end;

    procedure NTO_ReportPurchDim2SalesLines(NTO_PurchHead: Record "38")
    var
        NTO_PurchLine: Record "39";
        NTO_ResEntryPurch: Record "337";
        NTO_SalesLine: Record "37";
        NTO_ResEntrySale: Record "337";
        NTO_DocDim: Record "357";
    begin

        NTO_GenSetup.GET;
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
                                NTO_DocDim.INIT;
                                NTO_DocDim."Table ID" := 37;
                                NTO_DocDim."Document Type" := NTO_DocDim."Document Type"::Order;
                                NTO_DocDim."Document No." := NTO_ResEntrySale."Source ID";
                                NTO_DocDim."Dimension Code" := NTO_GenSetup."Code Axe Achat";
                                NTO_DocDim."Dimension Value Code" := NTO_ResEntryPurch."Source ID";
                                NTO_DocDim."Line No." := NTO_ResEntrySale."Source Ref. No.";
                                IF NTO_DocDim.INSERT THEN NTO_DocDim.MODIFY;
                                NTO_SalesLine."Shortcut Dimension 1 Code" := NTO_ResEntryPurch."Source ID";
                                NTO_SalesLine.MODIFY();
                            END;
                            NTO_PurchLine."Shortcut Dimension 1 Code" := NTO_ResEntryPurch."Source ID";
                            NTO_PurchLine.MODIFY();
                        END;
                    UNTIL NTO_ResEntryPurch.NEXT = 0;
            UNTIL NTO_PurchLine.NEXT = 0;
    end;

    procedure UpdateSalesEstimatedDelivery()
    var
        PurchLine: Record "39";
        SalesLine: Record "37";
        Vendor: Record "23";
    begin

        //>>MGTSEDI10.00.00.00
        Vendor.GET("Buy-from Vendor No.");
        IF Vendor."Lead Time Not Allowed" THEN
            EXIT;
        //<<MGTSEDI10.00.00.00

        //MGTS10.00.006; 002; mhh; entire function
        IF NOT PurchSetup.GET THEN
            PurchSetup.INIT;

        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type", "Document Type");
        PurchLine.SETRANGE("Document No.", "No.");
        PurchLine.SETFILTER("Special Order Sales No.", Text50000);
        PurchLine.SETFILTER("Special Order Sales Line No.", Text50001);
        IF PurchLine.FINDSET THEN
            REPEAT
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SETRANGE("Document No.", PurchLine."Special Order Sales No.");
                SalesLine.SETRANGE("Line No.", PurchLine."Special Order Sales Line No.");
                IF SalesLine.FINDFIRST THEN BEGIN
                    CASE "Ship Per" OF
                        "Ship Per"::"Air Flight":
                            BEGIN

                                //MGTS10.023; 006; mhh; begin
                                IF "Requested Delivery Date" <> 0D THEN BEGIN
                                    "Expected Receipt Date" := CALCDATE(PurchSetup."Sales Ship Time By Air Flight", "Requested Delivery Date");
                                    MODIFY;

                                    PurchLine."Expected Receipt Date" := "Expected Receipt Date";
                                    PurchLine.MODIFY;
                                END;
                                //MGTS10.023; 006; mhh; end

                                IF NOT (PurchLine."Expected Receipt Date" = 0D) THEN BEGIN
                                    SalesLine."Estimated Delivery Date" := CALCDATE(PurchSetup."Sales Ship Time By Air Flight", PurchLine."Expected Receipt Date");
                                    SalesLine.MODIFY;
                                END;
                            END;

                        "Ship Per"::"Sea Vessel":
                            BEGIN

                                //MGTS10.023; 006; mhh; begin
                                IF "Requested Delivery Date" <> 0D THEN BEGIN
                                    "Expected Receipt Date" := CALCDATE(PurchSetup."Sales Ship Time By Sea Vessel", "Requested Delivery Date");
                                    MODIFY;

                                    PurchLine."Expected Receipt Date" := "Expected Receipt Date";
                                    PurchLine.MODIFY;
                                END;
                                //MGTS10.023; 006; mhh; end

                                IF NOT (PurchLine."Expected Receipt Date" = 0D) THEN BEGIN
                                    SalesLine."Estimated Delivery Date" := CALCDATE(PurchSetup."Sales Ship Time By Sea Vessel", PurchLine."Expected Receipt Date");
                                    SalesLine.MODIFY;
                                END;
                            END;

                        "Ship Per"::"Sea/Air":
                            BEGIN

                                //MGTS10.023; 006; mhh; begin
                                IF "Requested Delivery Date" <> 0D THEN BEGIN
                                    "Expected Receipt Date" := CALCDATE(PurchSetup."Sales Ship Time By Sea/Air", "Requested Delivery Date");
                                    MODIFY;

                                    PurchLine."Expected Receipt Date" := "Expected Receipt Date";
                                    PurchLine.MODIFY;
                                END;
                                //MGTS10.023; 006; mhh; end

                                IF NOT (PurchLine."Expected Receipt Date" = 0D) THEN BEGIN
                                    SalesLine."Estimated Delivery Date" := CALCDATE(PurchSetup."Sales Ship Time By Sea/Air", PurchLine."Expected Receipt Date");
                                    SalesLine.MODIFY;
                                END;
                            END;

                        "Ship Per"::Train:
                            BEGIN

                                //MGTS10.023; 006; mhh; begin
                                IF "Requested Delivery Date" <> 0D THEN BEGIN
                                    "Expected Receipt Date" := CALCDATE(PurchSetup."Sales Ship Time By Train", "Requested Delivery Date");
                                    MODIFY;

                                    PurchLine."Expected Receipt Date" := "Expected Receipt Date";
                                    PurchLine.MODIFY;
                                END;
                                //MGTS10.023; 006; mhh; end

                                IF NOT (PurchLine."Expected Receipt Date" = 0D) THEN BEGIN
                                    SalesLine."Estimated Delivery Date" := CALCDATE(PurchSetup."Sales Ship Time By Train", PurchLine."Expected Receipt Date");
                                    SalesLine.MODIFY;
                                END;
                            END;

                        "Ship Per"::Truck:
                            BEGIN

                                //MGTS10.023; 006; mhh; begin
                                IF "Requested Delivery Date" <> 0D THEN BEGIN
                                    "Expected Receipt Date" := CALCDATE(PurchSetup."Sales Ship Time By Truck", "Requested Delivery Date");
                                    MODIFY;

                                    PurchLine."Expected Receipt Date" := "Expected Receipt Date";
                                    PurchLine.MODIFY;
                                END;
                                //MGTS10.023; 006; mhh; end

                                IF NOT (PurchLine."Expected Receipt Date" = 0D) THEN BEGIN
                                    SalesLine."Estimated Delivery Date" := CALCDATE(PurchSetup."Sales Ship Time By Truck", PurchLine."Expected Receipt Date");
                                    SalesLine.MODIFY;
                                END;
                            END;
                    END;
                END;
            UNTIL PurchLine.NEXT = 0;
    end;

    var
        NTO_DocDim: Record "357";
        SalesLine: Record "37";

    var
        NTO_GenSetup: Record "50000";
        NameAddressDetails: Text[512];
        NameAddressDetails2: Text[512];
        Text50000: Label '<>''''';
        Text50001: Label '<>0';
}

