tableextension 50029 tableextension50029 extends "Purchase Line"
{
    // 
    // NGTS 1      02.12.2005/LOCO/JMO  -  Field planning flexibility default value set to "none"
    // 
    // Interne1   T-00051       STG  23.06.2008  Change Multiples Sales Order Lines on deleting purchase lines     // DESACTIVE
    // 
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            29.01.09   added deal item handling onInsert and onDelete trigger
    // MIK01                            15.09.09   added key "Document Type", "Document No.", "No."
    // STG01                            15.09.09   delete "Shortcut Dimension 1 Code" on Sales Line
    // CHG02                            26.09.11   adapted deal update function with "updatePlanned" parameter
    // THM0001                          09.07.13   suppression contrôle liaison commande vente /achat
    // SAZ                              04.06.14   Ajout champs total volume et "External reference NGTS"
    // THM0002                          03.07.14   Ajout PCB dans le calcul
    // THM0003                          03.07.14   modification  "External reference NGTS"
    // THM                              11.09.17   Mig2017
    // FirstPurch                       11.06.18   Add fileds 50003..50016
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.006,MGTS10.013
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.006    04.02.20    mhh     List of changes:
    //                                              Created function: UpdateSalesEstimatedDelivery()
    //                                              Changed trigger: Expected Receipt Date - OnValidate()
    // 
    // 002    MGTS10.013        09.11.20    mhh     List of changes:
    //                                              Changed trigger: OnDelete()
    // ------------------------------------------------------------------------------------------
    fields
    {


        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "No." := TypeHelper.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");

        TestStatusOpen;
        #4..221
        UpdateItemReference;

        GetDefaultBin;

        IF JobTaskIsSet THEN BEGIN
          CreateTempJobJnlLine(TRUE);
          UpdateJobPrices;
        END
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..224
        //START MIG2017

        //SAZ 04062014
        IF Item_Rec.GET("No.") THEN
           VALIDATE("Total volume",(Item."Vol cbm carton transport"*Quantity
           //START THM0002
            /Item.PCB)
           //STOP THM0002
           );

         SalesHeader_Rec.SETRANGE("No.","Special Order Sales No.");
         SalesHeader_Rec.SETRANGE("Document Type","Document Type"::Order);

        IF SalesHeader_Rec.FINDFIRST THEN
        //START THM0003
        BEGIN
           //VALIDATE("External reference NGTS",SalesHeader_Rec."Sell-to Customer No.");
           ItemCrossReference.RESET;
           ItemCrossReference.SETRANGE(ItemCrossReference."Cross-Reference Type",ItemCrossReference."Cross-Reference Type"::Customer);
           ItemCrossReference.SETRANGE(ItemCrossReference."Cross-Reference Type No.",SalesHeader_Rec."Sell-to Customer No.");
           ItemCrossReference.SETRANGE(ItemCrossReference."Item No.","No.");
           IF ItemCrossReference.FINDFIRST THEN
           "External reference NGTS":=ItemCrossReference."Cross-Reference No."
           ELSE
           "External reference NGTS":='';
        END;
        //START THM0003
        //SAZ END 04062014
        //END MIG2017
        //FirstPurch 11.06.2018
        IF Type = Type::Item THEN BEGIN
          IF ExistOldPurch("No.","Document No.") THEN
             "First Purch. Order" :=TRUE;
        //END FirstPurch
        //ItemRisk 11.06.2018
        IF Item_Rec."Risk Item" = TRUE THEN
           "Risk Item" := TRUE
        ELSE
           "Risk Item" := FALSE;
          //Risk Item
        //END ItemRisk
          IF JobTaskIsSet THEN BEGIN
            CreateTempJobJnlLine(TRUE);
            UpdateJobPrices;
          END;
        END;
        */
        //end;


        //Unsupported feature: Code Modification on ""Location Code"(Field 7).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        IF "Location Code" <> '' THEN
        #4..19
          ERROR(
            Text001,
            FIELDCAPTION("Location Code"),"Sales Order No.");
        IF "Special Order" THEN
          ERROR(
            Text001,
            FIELDCAPTION("Location Code"),"Special Order Sales No.");

        IF "Location Code" <> xRec."Location Code" THEN
          InitItemAppl;

        #31..52

        IF "Document Type" = "Document Type"::"Return Order" THEN
          ValidateReturnReasonCode(FIELDNO("Location Code"));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..22

        //START MIG2017

        // THM0001
        {
        #23..27
         }
         // end THM0001
        //END MIG2017
        #28..55
        */
        //end;


        //Unsupported feature: Code Modification on ""Expected Receipt Date"(Field 10).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT TrackingBlocked THEN
          CheckDateConflict.PurchLineCheck(Rec,CurrFieldNo <> 0);

        IF "Expected Receipt Date" <> 0D THEN
          VALIDATE(
            "Planned Receipt Date",
            CalendarMgmt.CalcDateBOC2(InternalLeadTimeDays("Expected Receipt Date"),"Expected Receipt Date",
              CalChange."Source Type"::Location,"Location Code",'',
              CalChange."Source Type"::Location,"Location Code",'',FALSE))
        ELSE
          VALIDATE("Planned Receipt Date","Expected Receipt Date");

        IF CurrFieldNo IN [FIELDNO("Expected Receipt Date"),FIELDNO("Planned Receipt Date")] THEN
          IF Type IN [Type::"G/L Account",Type::Item,Type::"Fixed Asset",Type::"Charge (Item)"] THEN
            VALIDATE("VAT Prod. Posting Group");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4

          //MGTS10.00.006; 001; mhh; single
          BEGIN

            VALIDATE(
              "Planned Receipt Date",
              CalendarMgmt.CalcDateBOC2(InternalLeadTimeDays("Expected Receipt Date"),"Expected Receipt Date",
                CalChange."Source Type"::Location,"Location Code",'',
                CalChange."Source Type"::Location,"Location Code",'',FALSE));

          //MGTS10.00.006; 001; mhh; begin
            IF NOT (xRec."Expected Receipt Date" = "Expected Receipt Date") THEN
              UpdateSalesEstimatedDelivery;
          END
          //MGTS10.00.006; 001; mhh; end

          ELSE
            VALIDATE("Planned Receipt Date","Expected Receipt Date");
        #12..15
        */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestStatusOpen;

        IF "Drop Shipment" AND ("Document Type" <> "Document Type"::Invoice) THEN
        #4..78
          CreateTempJobJnlLine(TRUE);
          UpdateJobPrices;
        END;

        CheckWMS;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..81
        //START MIG2017

        //SAZ 04062014
        IF Item_Rec.GET("No.") THEN
           VALIDATE("Total volume",(Item."Vol cbm carton transport"*Quantity
           //START THM0002
            /Item.PCB)
           //STOP THM0002
           );
        //SAZ END 04062014
        //END MIG2017
        CheckWMS;
        */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Direct Unit Cost"(Field 22).OnValidate".

        //trigger (Variable: ACOConnection_Re_Loc)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Direct Unit Cost"(Field 22).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VALIDATE("Line Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VALIDATE("Line Discount %");

        //START MIG2017

        //START CHG01
        IF MODIFY() THEN;
        //cette fonction synchronise les éléments dans la table Deal Item pour cette ACO et lance un recalul de l'affaire si nécessaire
        DealItem_Cu.FNC_UpdateWithACOLine('Unit Cost', Rec, xRec);
        //STOP CHG01

        //END MIG2017
        */
        //end;
        field(50001; "Total volume"; Decimal)
        {
            Caption = 'Total volume';
            DecimalPlaces = 2 : 5;
        }
        field(50002; "External reference NGTS"; Text[30])
        {
            Caption = 'External reference NGTS';
        }
        field(50003; "First Purch. Order"; Boolean)
        {
            Caption = 'New product';
            Editable = false;
        }
        field(50004; "Sample Collected"; Boolean)
        {
            Caption = 'Sample picked';

            trigger OnValidate()
            begin
                IF ("Sample Collected" = TRUE) AND (Type = Type::Item) THEN BEGIN
                    "Collected Date" := WORKDATE;
                    "Sample Collected by" := USERID;
                    //IF "Photo Taked" THEN "Photo And DDoc" := TRUE;//SAZ 30.10.18
                END
                ELSE
                    IF ("Sample Collected" = FALSE) AND (Type = Type::Item) THEN BEGIN
                        "Collected Date" := 0D;
                        "Sample Collected by" := '';
                        //"Photo And DDoc" := FALSE; //SAZ 30.10.18
                    END;
            end;
        }
        field(50005; "Collected Date"; Date)
        {
            Caption = 'Collected Date';
            Editable = false;
        }
        field(50006; "Sample Collected by"; Code[50])
        {
            Caption = 'Sample Collected by';
            Editable = false;
        }
        field(50007; "Photo Taked"; Boolean)
        {
            Caption = 'Picture Taken';

            trigger OnValidate()
            begin
                IF ("Photo Taked" = TRUE) AND (Type = Type::Item) THEN BEGIN
                    "Photo Date" := WORKDATE;
                    "Photo Taked By" := USERID;
                    //IF "Sample Collected" THEN "Photo And DDoc" := TRUE;//SAZ 30.10.18
                END
                ELSE
                    IF ("Photo Taked" = FALSE) AND (Type = Type::Item) THEN BEGIN
                        "Photo Date" := 0D;
                        "Photo Taked By" := '';
                        //"Photo And DDoc" := FALSE; //SAZ 30.10.18
                    END;
            end;
        }
        field(50008; "Photo Date"; Date)
        {
            Caption = 'Photo Date';
            Editable = false;
        }
        field(50009; "Photo Taked By"; Code[50])
        {
            Caption = 'Photo Taked By';
            Editable = false;
        }
        field(50010; "Risk Item"; Boolean)
        {
            Caption = 'Traked item';
            Editable = false;
        }
        field(50011; "Photo Risk Item Taked"; Boolean)
        {
            Caption = 'Follow-up effect';

            trigger OnValidate()
            begin
                IF ("Photo Risk Item Taked" = TRUE) AND (Type = Type::Item) THEN BEGIN
                    "Photo Risk Item Date" := WORKDATE;
                    "Photo Risk Item Taked By" := USERID;
                END
                ELSE
                    IF ("Photo Risk Item Taked" = FALSE) AND (Type = Type::Item) THEN BEGIN
                        "Photo Risk Item Date" := 0D;
                        "Photo Risk Item Taked By" := '';
                    END;
            end;
        }
        field(50012; "Photo Risk Item Date"; Date)
        {
            Caption = 'Traked item Date';
            Editable = false;
        }
        field(50013; "Photo Risk Item Taked By"; Code[50])
        {
            Caption = 'Traked item Taked By';
            Editable = false;
        }
        field(50014; "Photo And DDoc"; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Document Type", "Document No.", "No.")
        {
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: requestID_Co_Loc)()
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
    TestStatusOpen;
    IF NOT StatusCheckSuspended AND (PurchHeader.Status = PurchHeader.Status::Released) AND
       (Type IN [Type::"G/L Account",Type::"Charge (Item)"])
    #4..31
      LOCKTABLE;
      SalesOrderLine.LOCKTABLE;
      IF "Document Type" = "Document Type"::Order THEN BEGIN
        SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.");
        SalesOrderLine."Special Order Purchase No." := '';
        SalesOrderLine."Special Order Purch. Line No." := 0;
        SalesOrderLine.MODIFY;
      END ELSE
        IF SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.") THEN
          BEGIN
          SalesOrderLine."Special Order Purchase No." := '';
          SalesOrderLine."Special Order Purch. Line No." := 0;
          SalesOrderLine.MODIFY;
        END;
    END;

    NonstockItemMgt.DelNonStockPurch(Rec);
    #49..68
      PurchLine2.SETRANGE("Attached to Line No.","Line No.");
      PurchLine2.SETFILTER("Line No.",'<>%1',"Line No.");
      PurchLine2.DELETEALL(TRUE);
    END;

    PurchCommentLine.SETRANGE("Document Type","Document Type");
    #75..88
      DeferralUtilities.DeferralCodeOnDelete(
        DeferralUtilities.GetPurchDeferralDocType,'','',
        "Document Type","Document No.","Line No.");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..34
        //START MIG2017
        //SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.");
        SalesOrderLine.RESET;
        SalesOrderLine.SETRANGE("Document Type","Document Type"::Order);
        SalesOrderLine.SETRANGE("Special Order Purchase No.","Document No.");
        SalesOrderLine.SETRANGE("No.","No.");
    //    SalesOrderLine."Special Order Purchase No." := '';
    //    SalesOrderLine."Special Order Purch. Line No." := 0;
    //    SalesOrderLine.MODIFY;
    //  END ELSE
    //    IF SalesOrderLine.GET(SalesOrderLine."Document Type"::Order,"Special Order Sales No.","Special Order Sales Line No.") THEN
    //      BEGIN
    //         SalesOrderLine."Special Order Purchase No." := '';
    //         SalesOrderLine."Special Order Purch. Line No." := 0;
    //         SalesOrderLine.MODIFY;
     //    END;

        IF SalesOrderLine.FIND('-') THEN
         REPEAT
    #42..44
         UNTIL SalesOrderLine.NEXT=0;
         // STOP Interne1
    //END MIG2017
    END;
    #46..71
    //MIG2017
    //START CHG01
    ACOConnection_Re_Loc.RESET();
    ACOConnection_Re_Loc.SETCURRENTKEY("ACO No.");
    ACOConnection_Re_Loc.SETRANGE("ACO No.", Rec."Document No.");
    IF ACOConnection_Re_Loc.FIND('-') THEN BEGIN

      requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
        ACOConnection_Re_Loc.Deal_ID,
        urm_Re_Loc.Requested_By_Type::"Purchase Header",
        Rec."Document No.",
        CURRENTDATETIME
      );

      //MGTS10.013; 002; mhh; deleted line: Rec.DELETE();

      urm_Re_Loc.GET(requestID_Co_Loc);
      UpdateRequestManager_Cu.FNC_Process_Requests(urm_Re_Loc,FALSE,FALSE,TRUE);

      EXIT;
      END;
      //STOP CHG01
      // END MIG2017
    #72..91
    */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnInsert".

    //trigger (Variable: ACOConnection_Re_Loc)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TestStatusOpen;
    IF Quantity <> 0 THEN
      ReservePurchLine.VerifyQuantity(Rec,xRec);

    LOCKTABLE;
    PurchHeader."No." := '';
    IF ("Deferral Code" <> '') AND (GetDeferralAmount <> 0) THEN
      UpdateDeferralAmounts;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    //START MIG2017

    //START CHG01
    ACOConnection_Re_Loc.RESET();
    ACOConnection_Re_Loc.SETCURRENTKEY("ACO No.");
    ACOConnection_Re_Loc.SETRANGE("ACO No.", Rec."Document No.");
    IF ACOConnection_Re_Loc.FINDFIRST THEN BEGIN

      requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
        ACOConnection_Re_Loc.Deal_ID,
        urm_Re_Loc.Requested_By_Type::"Purchase Header",
        Rec."Document No.",
        CURRENTDATETIME
      );

      Rec.INSERT();

      urm_Re_Loc.GET(requestID_Co_Loc);
      UpdateRequestManager_Cu.FNC_Process_Requests(urm_Re_Loc,FALSE,FALSE,TRUE);

      Rec.DELETE();

    END;

    //STOP CHG01
    //END MIG2017
    */
    //end;

    local procedure ExistOldPurch(ItemNo: Code[20]; DocNo: Code[20]): Boolean
    var
        PurchaseLine: Record "39";
        PurchInvLine: Record "123";
    begin
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETRANGE("No.", ItemNo);
        PurchaseLine.SETFILTER("Document No.", '<>%1', DocNo);
        PurchInvLine.SETRANGE("No.", ItemNo);
        PurchInvLine.SETRANGE(Type, PurchInvLine.Type::Item);
        IF (PurchaseLine.FINDFIRST OR PurchInvLine.FINDFIRST) THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;

    procedure UpdateSalesEstimatedDelivery()
    var
        SalesLine: Record "37";
    begin

        //MGTS10.00.006; 001; mhh; entire function
        IF ("Special Order Sales No." = '') OR ("Special Order Sales Line No." = 0) OR ("Expected Receipt Date" = 0D) THEN
            EXIT;

        IF NOT PurchSetup.GET THEN
            PurchSetup.INIT;

        GetPurchHeader();

        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", "Special Order Sales No.");
        SalesLine.SETRANGE("Line No.", "Special Order Sales Line No.");
        IF SalesLine.FINDFIRST THEN BEGIN
            CASE PurchHeader."Ship Per" OF
                PurchHeader."Ship Per"::"Air Flight":
                    BEGIN
                        SalesLine."Estimated Delivery Date" := CALCDATE(PurchSetup."Sales Ship Time By Air Flight", "Expected Receipt Date");
                        SalesLine.MODIFY;
                    END;

                PurchHeader."Ship Per"::"Sea Vessel":
                    BEGIN
                        SalesLine."Estimated Delivery Date" := CALCDATE(PurchSetup."Sales Ship Time By Sea Vessel", "Expected Receipt Date");
                        SalesLine.MODIFY;
                    END;

                PurchHeader."Ship Per"::"Sea/Air":
                    BEGIN
                        SalesLine."Estimated Delivery Date" := CALCDATE(PurchSetup."Sales Ship Time By Sea/Air", "Expected Receipt Date");
                        SalesLine.MODIFY;
                    END;

                PurchHeader."Ship Per"::Train:
                    BEGIN
                        SalesLine."Estimated Delivery Date" := CALCDATE(PurchSetup."Sales Ship Time By Train", "Expected Receipt Date");
                        SalesLine.MODIFY;
                    END;

                PurchHeader."Ship Per"::Truck:
                    BEGIN
                        SalesLine."Estimated Delivery Date" := CALCDATE(PurchSetup."Sales Ship Time By Truck", "Expected Receipt Date");
                        SalesLine.MODIFY;
                    END;
            END;
        END;
    end;

    var
        ACOConnection_Re_Loc: Record "50026";
        DealItem_Cu: Codeunit "50024";
        Deal_Cu: Codeunit "50020";

    var
        requestID_Co_Loc: Code[20];
        element_Re_Loc: Record "50021";
        urm_Re_Loc: Record "50039";
        ACOConnection_Re_Loc: Record "50026";

    var
        ACOConnection_Re_Loc: Record "50026";
        DealItem_Cu: Codeunit "50024";
        requestID_Co_Loc: Code[20];
        element_Re_Loc: Record "50021";
        urm_Re_Loc: Record "50039";


        //Unsupported feature: Property Modification (Id) on "UpdateFromVAT(Variable 1000000004)".

        //var
        //>>>> ORIGINAL VALUE:
        //UpdateFromVAT : 1087;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //UpdateFromVAT : 1000000004;
        //Variable type has not been exported.


        //Unsupported feature: Property Modification (Id) on "PrePaymentLineAmountEntered(Variable 1000000003)".

        //var
        //>>>> ORIGINAL VALUE:
        //PrePaymentLineAmountEntered : 1042;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //PrePaymentLineAmountEntered : 1000000003;
        //Variable type has not been exported.

    var
        Deal_Cu: Codeunit "50020";
        DealItem_Cu: Codeunit "50024";
        UpdateRequestManager_Cu: Codeunit "50032";

    var
        Item_Rec: Record "27";
        SalesHeader_Rec: Record "36";
        ItemCrossReference: Record "5717";
}

