tableextension 50026 tableextension50026 extends "Sales Header"
{
    // THM       16.03.17      add field 50001,50002,50003
    // THM160317 16.03.17      OnInsert
    // THM121217 12.12.17      Validate posting Date
    // THM       16.03.18      add field "Event Code"
    // DEl.SAZ   21.06.19      Add field "Estimated Delivery Date"
    // MHH       23.07.19      Changed field: "Customer Price Group" (Properties: TableRelation, Lenght)
    //                         Changed trigger: Customer Price Group - OnLookup()
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Sign    : Emil Hr. Hristov = ehh
    // 
    // Version : MGTS10.00.001,MGTS10.009,MGTS10.013,MGTS10.014,MGTS10.015,MGTS10.019,MGTS10.022,
    //           MGTS10.025
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.001    18.12.19    mhh     List of changes:
    //                                              Created function: SelectGLEntryForReverse()
    //                                              Created function: ShowSelectedEntriesForReverse
    // 
    // 002    MGTS10.009       09.09.20    ehh     List of changes:
    //                                              Added new field: 50006 Type Order ODI
    //                                              Added new field: 50008 Type Order ODI Description
    // 
    // 003    MGTS10.010       09.09.20    ehh     List of changes:
    //                                              Added new field: 50007 GLN
    // 
    // 004     MGTS10.013       29.10.20    mhh     List of changes:
    //                                              Changed function: RecreateSalesLines()
    //                                              Changed function: CreateSalesLine()
    // 
    // 005     MGTS10.014       23.11.20    mhh     List of changes:
    //                                              Changed trigger: Ship-to Code - OnValidate()
    //                                              Changed function: CreateSalesLine()
    // 
    // 006     MGTS10.015       26.11.20    mhh     List of changes:
    //                                              Added new field: 50009 "Has Spec. Purch. Order"
    // 
    // 007     MGTS10.019       14.12.20    mhh     List of changes:
    //                                              Added new field: 50010 "Export With EDI"
    // 
    // 008     MGTS10.022       28.01.21    mhh     List of changes:
    //                                              Changed function: CreateSalesLine()
    // 
    // 009     MGTS10.025       17.02.21    mhh     List of changes:
    //                                              Changed type of field: 50004 "Event Code"
    // ------------------------------------------------------------------------------------------
    // 
    // MGTSEDI10.00.00.21 | 18.01.2021 | EDI Management : Add table relation field GLN
    // 
    // MGTSEDI10.00.00.22 | 11.02.2021 | EDI Management : Add field 50010
    // 
    // MGTSEDI10.00.00.23 | 21.05.2021 | EDI Management : Add fields
    //                                                     To Create Purchase Order,
    //                                                     Purchase Order Create Date,
    //                                                     Status Purchase Order Create
    //                                                     Text Purch. Order Create
    //                                                   Error Purch. Order Create
    // 
    // MGTS10.029  | 13.07.2021 | Add C\AL :
    // 
    // 
    // MGTS10.031  | 22.07.2021 | Add fields : 50050, 50051

    //Unsupported feature: Property Insertion (Permissions) on ""Sales Header"(Table 36)".

    fields
    {
        modify("Customer Price Group")
        {

            //Unsupported feature: Property Modification (Data type) on ""Customer Price Group"(Field 34)".

            Description = 'MGTS0124';
        }


        //Unsupported feature: Code Modification on ""Sell-to Customer No."(Field 2).OnValidate".

        //trigger "(Field 2)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CheckCreditLimitIfLineNotInsertedYet;
        IF "No." = '' THEN
          InitRecord;
        #4..105

        IF NOT SkipSellToContact THEN
          UpdateSellToCont("Sell-to Customer No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..108
        //MIG2017
        // LOCO/ChC/T-00551-SPEC35 -
        "Fiscal Repr." := Cust."Fiscal Repr.";
        // LOCO/ChC/T-00551-SPEC35 +
        //MIG2017
        */
        //end;


        //Unsupported feature: Code Modification on ""Bill-to Customer No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        BilltoCustomerNoChanged := xRec."Bill-to Customer No." <> "Bill-to Customer No.";
        IF BilltoCustomerNoChanged THEN
        #4..21
          END;

        GetCust("Bill-to Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust,"Document Type",FALSE,FALSE);
        Cust.TESTFIELD("Customer Posting Group");
        CheckCrLimit;
        #28..93

        "Bill-to IC Partner Code" := Cust."IC Partner Code";
        "Send IC Document" := ("Bill-to IC Partner Code" <> '') AND ("IC Direction" = "IC Direction"::Outgoing);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..24
        //>>MGTS10.029
        IF (Cust."Fiscal Repr." <> '') THEN
          "Fiscal Repr." := Cust."Fiscal Repr.";
        //<<MGTS10.029

        #25..96
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
        #4..53
              "Shipping Agent Service Code" := Cust."Shipping Agent Service Code";
            END;

        GetShippingTime(FIELDNO("Ship-to Code"));

        IF (xRec."Sell-to Customer No." = "Sell-to Customer No.") AND
        #60..70
            IF xRec."Tax Liable" <> "Tax Liable" THEN
              VALIDATE("Tax Liable");
          END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..56
        //MGTS10.014; 005; mhh; begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type",SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.","No.");
        IF SalesLine.FINDSET THEN
          REPEAT
            SalesLine."Ship-to Code" := "Ship-to Code";
            SalesLine."Ship-to Name" := "Ship-to Name";
            SalesLine.MODIFY;
          UNTIL SalesLine.NEXT = 0;
        //MGTS10.014; 005; mhh; end

        #57..73
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
          PriceMessageIfSalesLinesExist(FIELDCAPTION("Posting Date"));

        IF "Currency Code" <> '' THEN BEGIN
          UpdateCurrencyFactor;
          IF "Currency Factor" <> xRec."Currency Factor" THEN
            ConfirmUpdateCurrencyFactor;
        #23..25
          IF DeferralHeadersExist THEN
            ConfirmUpdateDeferralDate;
        SynchronizeAsmHeader;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..19
          //THM12.12.17
          HideValidationDialog:=TRUE;
          //END THM121217
        #20..28
        */
        //end;


        //Unsupported feature: Code Insertion on ""Customer Price Group"(Field 34)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*

          //MGTS0124; MHH; begin
          CustPriceGroup.RESET;
          IF PAGE.RUNMODAL(0, CustPriceGroup) = ACTION::LookupOK THEN BEGIN
            IF "Customer Price Group" = '' THEN
              "Customer Price Group" := CustPriceGroup.Code
            ELSE
              "Customer Price Group" := STRSUBSTNO(Text50000, "Customer Price Group", CustPriceGroup.Code);
          END;
          //MGTS0124; MHH; end
        */
        //end;

        //Unsupported feature: Property Deletion (TableRelation) on ""Customer Price Group"(Field 34)".



        //Unsupported feature: Code Modification on ""Campaign No."(Field 5050).OnValidate".

        //trigger "(Field 5050)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CreateDim(
          DATABASE::Campaign,"Campaign No.",
          DATABASE::Customer,"Bill-to Customer No.",
          DATABASE::"Salesperson/Purchaser","Salesperson Code",
          DATABASE::"Responsibility Center","Responsibility Center",
          DATABASE::"Customer Template","Bill-to Customer Template Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..6
        //MIG2017
        // LOCO/ChC/T-00551-SPEC40 -
        IF "Campaign No." <> xRec."Campaign No." THEN
          UpdateSalesLines(FIELDCAPTION("Campaign No."),CurrFieldNo<>0);
        // LOCO/ChC/T-00551-SPEC40 +
        //MIG2017
        */
        //end;


        //Unsupported feature: Code Modification on ""Requested Delivery Date"(Field 5790).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD(Status,Status::Open);
        IF "Promised Delivery Date" <> 0D THEN
          ERROR(
        #4..6

        IF "Requested Delivery Date" <> xRec."Requested Delivery Date" THEN
          UpdateSalesLines(FIELDCAPTION("Requested Delivery Date"),CurrFieldNo <> 0);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
        //DEL.SAZ 21.06.19
        //IF "Estimated Delivery Date"
          VALIDATE("Estimated Delivery Date","Requested Delivery Date");
        //END DEL.SAZ
        */
        //end;
        field(50000; "Fiscal Repr."; Code[10])
        {
            Caption = 'Fiscal Repr.';
            Description = 'T-00551-SPEC35';
            TableRelation = Contact;
        }
        field(50001; "Create By"; Text[50])
        {
            Caption = 'Create By';
            Editable = false;
        }
        field(50002; "Create Date"; Date)
        {
            Caption = 'Create Date';
            Editable = false;
        }
        field(50003; "Create Time"; Time)
        {
            Caption = 'Create Time';
            Editable = false;
        }
        field(50004; "Event Code"; Option)
        {
            Caption = 'Event Code';
            Description = 'EDI,MGTS10.025';
            OptionCaption = 'NORM,TYRE,SPARE,SMOOVE,ISP,CANCELLED';
            OptionMembers = NORM,TYRE,SPARE,SMOOVE,ISP,CANCELLED;
        }
        field(50005; "Estimated Delivery Date"; Date)
        {
            Caption = 'Estimated delivery date';

            trigger OnValidate()
            var
                SalesLine_Rec: Record "37";
            begin
                SalesLine_Rec.SETRANGE(SalesLine_Rec."Document Type", "Document Type");
                SalesLine_Rec.SETRANGE(SalesLine_Rec."Document No.", "No.");
                IF SalesLine_Rec.FINDSET THEN BEGIN
                    REPEAT
                        SalesLine_Rec."Estimated Delivery Date" := "Estimated Delivery Date";
                        SalesLine_Rec.MODIFY;
                    UNTIL SalesLine_Rec.NEXT = 0;
                END;
            end;
        }
        field(50006; "Type Order EDI"; Code[20])
        {
            Caption = 'Type Order EDI';
            Description = 'MGTS10.009';
            TableRelation = "Type Order EDI";
        }
        field(50007; GLN; Text[30])
        {
            Caption = 'Delivery GLN';
            Description = 'MGTS10.010';
            TableRelation = "EDI Delivery GLN Customer";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50008; "Type Order EDI Description"; Text[50])
        {
            CalcFormula = Lookup ("Type Order EDI".Description WHERE (Code = FIELD (Type Order EDI)));
            Caption = 'Type Order EDI Description';
            Description = 'MGTS10.009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "Has Spec. Purch. Order"; Boolean)
        {
            Caption = 'Has special purch. order';
            Description = 'MGTS10.015';
            Editable = false;
        }
        field(50010; "Export With EDI"; Boolean)
        {
            Description = 'MGTS10.019';
        }
        field(50011; "Shipment No."; Text[50])
        {
            Caption = 'Shipment No.';
        }
        field(50020; "To Create Purchase Order"; Boolean)
        {
            Caption = 'Commande d''achat a créer';
            Description = 'MGTSEDI10.00.00.23';
        }
        field(50021; "Purchase Order Create Date"; DateTime)
        {
            Caption = 'Date création commande d''achat';
            Description = 'MGTSEDI10.00.00.23';
            Editable = false;
        }
        field(50022; "Status Purchase Order Create"; Option)
        {
            Caption = 'Statut création commande achat';
            Description = 'MGTSEDI10.00.00.23';
            OptionCaption = ' ,Création demande d''achat,Création affaire,Commande créée';
            OptionMembers = " ","Create Req. Worksheet","Create Deal",Created;
        }
        field(50023; "Error Text Purch. Order Create"; Text[250])
        {
            Caption = 'Texte erreur création commande achat';
            Description = 'MGTSEDI10.00.00.23';
            Editable = false;
        }
        field(50024; "Error Purch. Order Create"; Boolean)
        {
            Caption = 'En erreur création commande achat';
            Description = 'MGTSEDI10.00.00.23';

            trigger OnValidate()
            var
                TextCst001: Label 'This change will reset the purchase order creation status. Do you want to continue?';
            begin
                IF NOT HideValidationDialog THEN
                    IF ("Error Purch. Order Create" = FALSE) AND ("Status Purchase Order Create" <> "Status Purchase Order Create"::Created) THEN
                        IF CONFIRM(TextCst001, FALSE) THEN BEGIN
                            "Error Text Purch. Order Create" := '';
                            "To Create Purchase Order" := TRUE;
                        END;
            end;
        }
        field(50050; "Mention Under Total"; Text[250])
        {
            Caption = 'Mention Under Total';
            Description = 'MGTS10.030';
        }
        field(50051; "Amount Mention Under Total"; Text[30])
        {
            Caption = 'Amount Mention Under Total';
            Description = 'MGTS10.030';
        }
    }


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitInsert;
    InsertMode := TRUE;

    SetSellToCustomerFromFilter;

    IF GetFilterContNo <> '' THEN
      VALIDATE("Sell-to Contact No.",GetFilterContNo);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    //MIG2017
    //START THM160317
      "Create By":=USERID;
      "Create Date":=TODAY;
      "Create Time":=TIME;
    //END THM160317
    //MIG2017
    */
    //end;

    //Unsupported feature: Variable Insertion (Variable: SpecSalesLine) (VariableCollection) on "RecreateSalesLines(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "RecreateSalesLines(PROCEDURE 4)".

    //procedure RecreateSalesLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF SalesLinesExist THEN BEGIN
      IF HideValidationDialog OR NOT GUIALLOWED THEN
        Confirmed := TRUE
      ELSE
        Confirmed :=
          CONFIRM(
            Text015,FALSE,ChangedFieldName);
      IF Confirmed THEN BEGIN
        SalesLine.LOCKTABLE;
        ItemChargeAssgntSales.LOCKTABLE;
        ReservEntry.LOCKTABLE;
        MODIFY;
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type","Document Type");
        SalesLine.SETRANGE("Document No.","No.");
    #16..18
          ItemChargeAssgntSales.SETRANGE("Document Type","Document Type");
          ItemChargeAssgntSales.SETRANGE("Document No.","No.");
          TransferItemChargeAssgntSalesToTemp(ItemChargeAssgntSales,TempItemChargeAssgntSales);
          SalesLine.DELETEALL(TRUE);
          SalesLine.INIT;
          SalesLine."Line No." := 0;
    #25..81
          Text017,ChangedFieldName);
    END;
    SalesLine.BlockDynamicTracking(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4

        //MGTS10.013; 004; mhh; begin
        IF ChangedFieldName = FIELDCAPTION("VAT Bus. Posting Group") THEN
          Confirmed := TRUE
        ELSE
          //MGTS10.013; 004; mhh; end

          Confirmed :=
            CONFIRM(
              Text015,FALSE,ChangedFieldName);
    #8..12

    #13..21

          //MGTS10.013; 004; mhh; begin
          IF ChangedFieldName = FIELDCAPTION("VAT Bus. Posting Group") THEN BEGIN
            SpecSalesLine.RESET;
            SpecSalesLine.SETRANGE("Document Type","Document Type");
            SpecSalesLine.SETRANGE("Document No.","No.");
            IF SpecSalesLine.FINDSET THEN
              REPEAT
                SpecSalesLine."Special Order Purch. Line No." := 0;
                SpecSalesLine."Purch. Order Line No." := 0;
                SpecSalesLine.MODIFY;
              UNTIL SpecSalesLine.NEXT = 0;
          END;
          //MGTS10.013; 004; mhh; end

    #22..84
    */
    //end;


    //Unsupported feature: Code Modification on "UpdateSalesLines(PROCEDURE 15)".

    //procedure UpdateSalesLines();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT SalesLinesExist THEN
      EXIT;

    #4..14
        IF NotRunningOnSaaS THEN
          IF DIALOG.CONFIRM(Question,TRUE) THEN
            CASE ChangedFieldName OF
              FIELDCAPTION("Shipment Date"),
              FIELDCAPTION("Shipping Agent Code"),
              FIELDCAPTION("Shipping Agent Service Code"),
    #21..88
        SalesLineReserve.AssignForPlanning(SalesLine);
        SalesLine.MODIFY(TRUE);
      UNTIL SalesLine.NEXT = 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17

          //MIG2017
          // LOCO/ChC/T-00551-SPEC40 -
          FIELDCAPTION("Campaign No.") : BEGIN
            SalesLine.VALIDATE(SalesLine."Campaign Code","Campaign No.");
            SalesLine.VALIDATE(SalesLine."No.");
          END;
          // LOCO/ChC/T-00551-SPEC40 +
          //MIG2017 END

    #18..91
    */
    //end;


    //Unsupported feature: Code Modification on "CreateSalesLine(PROCEDURE 78)".

    //procedure CreateSalesLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesLine.INIT;
    SalesLine."Line No." := SalesLine."Line No." + 10000;
    SalesLine.VALIDATE(Type,TempSalesLine.Type);
    #4..14
        END;
        SalesLine."Purchase Order No." := TempSalesLine."Purchase Order No.";
        SalesLine."Purch. Order Line No." := TempSalesLine."Purch. Order Line No.";
        SalesLine."Drop Shipment" := SalesLine."Purch. Order Line No." <> 0;
      END;
      SalesLine.VALIDATE("Shipment Date",TempSalesLine."Shipment Date");
    END;
    SalesLine.INSERT;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..17

        //MGTS10.013; 004; mhh; begin
        SalesLine."Special Order Purchase No." := TempSalesLine."Special Order Purchase No.";
        SalesLine."Special Order Purch. Line No." := TempSalesLine."Special Order Purch. Line No.";
        //MGTS10.013; 004; mhh; end

        //MGTS10.014; 005; mhh; begin
        SalesLine."Ship-to Code" := TempSalesLine."Ship-to Code";
        SalesLine."Ship-to Name" := TempSalesLine."Ship-to Name";
        //MGTS10.014; 005; mhh; end

    #18..22

    //MGTS10.022; 008; mhh; begin
    SalesLine.VALIDATE("Purchasing Code", TempSalesLine."Purchasing Code");
    SalesLine.MODIFY;
    //MGTS10.022; 008; mhh; end
    */
    //end;

    procedure SelectGLEntryForReverse()
    var
        GLEntry: Record "17";
        GLEntries: Page "20";
        ReverseGLEntry: Record "17";
        GLSetup: Record "98";
    begin

        //MGTS10.00.001; 001; mhh; entire function
        IF NOT GLSetup.GET THEN
            GLSetup.INIT;

        GLSetup.TESTFIELD("Provision Source Code");
        GLSetup.TESTFIELD("Provision Journal Batch");

        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
        GLEntry.FILTERGROUP(2);
        GLEntry.SETRANGE("Source Code", GLSetup."Provision Source Code");
        GLEntry.SETFILTER("Journal Batch Name", GLSetup."Provision Journal Batch");
        GLEntry.SETRANGE("Customer Provision", "Bill-to Customer No.");
        GLEntry.SETRANGE("Reverse With Doc. No.", Text50001);
        GLEntry.FILTERGROUP(0);

        CLEAR(GLEntries);
        GLEntries.SETTABLEVIEW(GLEntry);
        GLEntries.LOOKUPMODE(TRUE);
        IF GLEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
            GLEntries.SetGLEntry(ReverseGLEntry);
            IF ReverseGLEntry.FINDSET THEN
                REPEAT
                    ReverseGLEntry."Reverse With Doc. No." := "No.";
                    ReverseGLEntry.MODIFY;
                UNTIL ReverseGLEntry.NEXT = 0;
        END;
    end;

    procedure ShowSelectedEntriesForReverse()
    var
        GLEntry: Record "17";
        GLEntriesForReverse: Page "50126";
    begin

        //MGTS10.00.001; 001; mhh; entire function
        TESTFIELD("No.");

        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("Reverse With Doc. No.");
        GLEntry.FILTERGROUP(2);
        GLEntry.SETRANGE("Reverse With Doc. No.", "No.");
        GLEntry.FILTERGROUP(4);

        CLEAR(GLEntriesForReverse);
        GLEntriesForReverse.SetRelatedOrder(Rec);
        GLEntriesForReverse.SETTABLEVIEW(GLEntry);
        GLEntriesForReverse.RUN;
    end;

    var
        CustPriceGroup: Record "6";
        Text50000: Label '%1|%2';
        Text50001: Label '''''';
}

