tableextension 50027 tableextension50027 extends "Sales Line"
{
    // 
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // ------------------------------------------------------------------------------
    // T-00589     THM   03.10.2013            Desactivate Sale blocked
    //             THM   28.05.2013            Added key"Special Order Purchase No."
    //             THM   08.09.17              MIG2017
    // DEL.SAZ HistQte   17.05.19              Add field "Historiques Qte"
    // DEl.SAZ           21.06.19      Add field "Estimated Delivery Date"
    // 
    // MGTS0124    MHH   23.07.19              Changed field: "Customer Price Group" (Properties: TableRelation, Lenght)
    //                                         Changed trigger: Customer Price Group - OnLookup()
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.003,MGTS10.013,MGTS10.014
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.003    13.01.20    mhh     List of changes:
    //                                              Added new field: 50006 "Post With Purch. Order No."
    //                          26.03.20    mhh     Added new field: 50007 "Shipped With Difference"
    // 
    // 002     MGTS10.013       09.11.20    mhh     List of changes:
    //                                              Changd trigger: OnDelete()
    // 
    // 003     MGTS10.014       23.11.20    mhh     List of changes:
    //                                              Added new field: 50008 "Ship-to Code"
    //                                              Added new field: 50009 "Ship-to Name"
    //                          09.12.20    mhh     Changed trigger: OnInsert()
    // ------------------------------------------------------------------------------------------
    fields
    {
        modify("Customer Price Group")
        {

            //Unsupported feature: Property Modification (Data type) on ""Customer Price Group"(Field 42)".

            Description = 'MGTS0124';
        }


        //Unsupported feature: Code Modification on ""No."(Field 6).OnValidate".

        //trigger "(Field 6)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        "No." := TypeHelper.FindNoFromTypedValue(Type,"No.",NOT "System-Created Entry");

        TestJobPlanningLine;
        #4..83
              GetItem;
              Item.TESTFIELD(Blocked,FALSE);
              Item.TESTFIELD("Gen. Prod. Posting Group");
              Item.TESTFIELD("Sale blocked",FALSE);
              IF Item.Type = Item.Type::Inventory THEN BEGIN
                Item.TESTFIELD("Inventory Posting Group");
        #90..196
        END;

        UpdateItemCrossRef;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..86
              //START MIG2017
              // Begin  T-00589   THM
              IF "Document Type"="Document Type"::Order THEN
              // END T-00589 THM
              //MIG2017 END
        #87..199
        */
        //end;


        //Unsupported feature: Code Modification on "Quantity(Field 15).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;

        #4..89
        CheckWMS;

        UpdatePlanned;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..92


        //DEL.SAZ HistQte 17.05.19
        IF Type = Type::Item THEN
          IF xRec.Quantity <> 0  THEN
            IF xRec.Quantity <> Quantity  THEN
              IF  CONFIRM(ArchQte,TRUE,FALSE)  THEN
                  "Requested qtity" := xRec.Quantity;
        //END DEL.SAZ
        */
        //end;


        //Unsupported feature: Code Insertion (VariableCollection) on ""Unit Price"(Field 22).OnValidate".

        //trigger (Variable: ACOConnection_Re_Loc)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Unit Price"(Field 22).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestJobPlanningLine;
        TestStatusOpen;
        VALIDATE("Line Discount %");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3

        //START MIG2017
        // T-00551-DEAL -
        IF MODIFY() THEN;
        //cette fonction synchronise les éléments dans la table Deal Item pour cette ACO et lance un recalul de l'affaire si nécessaire
        DealItem_Cu.FNC_UpdateWithVCOLine('Unit Cost', Rec, xRec);
        // T-00551-DEAL +
        //END MIG2017
        */
        //end;


        //Unsupported feature: Code Insertion on ""Customer Price Group"(Field 42)".

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

        //Unsupported feature: Property Deletion (TableRelation) on ""Customer Price Group"(Field 42)".

        field(50000; "Customer line reference2"; Text[30])
        {
            Caption = 'Kundenreferenz';
            Description = 'Temp400';
        }
        field(50001; "Qty. Init. Client"; Decimal)
        {
            Description = 'Temp400';
        }
        field(50002; "Campaign Code"; Code[20])
        {
            Description = 'T-00551-SPEC40';
        }
        field(50003; "Requested qtity"; Decimal)
        {
            Caption = 'Requested qtity';
        }
        field(50005; "Estimated Delivery Date"; Date)
        {
            Caption = 'Estimated delivery date';
        }
        field(50006; "Post With Purch. Order No."; Code[20])
        {
            Caption = 'Post with purchase order No.';
            Description = 'MGTS10.00.003';
        }
        field(50007; "Shipped With Difference"; Boolean)
        {
            Caption = 'Shipped with difference';
            Description = 'MGTS10.00.003';
            Editable = false;
        }
        field(50008; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            Description = 'MGTS10.014';
            Editable = false;
            TableRelation = "Ship-to Address".Code WHERE (Customer No.=FIELD(Sell-to Customer No.));

            trigger OnValidate()
            var
                ShipToAddr: Record "222";
            begin
            end;
        }
        field(50009;"Ship-to Name";Text[50])
        {
            Caption = 'Ship-to Name';
            Description = 'MGTS10.014';
            Editable = false;
        }
    }
    keys
    {
        key(Key1;"Special Order Purchase No.")
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
        IF NOT StatusCheckSuspended AND (SalesHeader.Status = SalesHeader.Status::Released) AND
           (Type IN [Type::"G/L Account",Type::"Charge (Item)",Type::Resource])
        #4..57
        IF NOT SalesCommentLine.ISEMPTY THEN
          SalesCommentLine.DELETEALL;

        IF ("Line No." <> 0) AND ("Attached to Line No." = 0) THEN BEGIN
          SalesLine2.COPY(Rec);
          IF SalesLine2.FIND('<>') THEN BEGIN
            SalesLine2.VALIDATE("Recalculate Invoice Disc.",TRUE);
            SalesLine2.MODIFY;
          END;
        END;

        IF "Deferral Code" <> '' THEN
          DeferralUtilities.DeferralCodeOnDelete(
            DeferralUtilities.GetSalesDeferralDocType,'','',
            "Document Type","Document No.","Line No.");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..60
        //START MIG2017
        // T-00551-DEAL +
        ACOConnection_Re_Loc.RESET();
        ACOConnection_Re_Loc.SETCURRENTKEY("ACO No.");
        ACOConnection_Re_Loc.SETRANGE("ACO No.", Rec."Shortcut Dimension 1 Code");
        IF ACOConnection_Re_Loc.FIND('-') THEN BEGIN
          requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
            ACOConnection_Re_Loc.Deal_ID,
            urm_Re_Loc.Requested_By_Type::"Sales Header",
            Rec."Document No.",
            CURRENTDATETIME
          );

          //MGTS10.013; 002; mhh; deleted line: Rec.DELETE();

          urm_Re_Loc.GET(requestID_Co_Loc);
          UpdateRequestManager_Cu.FNC_Process_Requests(urm_Re_Loc,FALSE,FALSE,TRUE);
          EXIT;
        END;
        // T-00551-DEAL +

        #61..67
        //END MIG2017
        #69..72
        */
    //end;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnInsert".

    //trigger (Variable: GeneralSetup)()
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
          ReserveSalesLine.VerifyQuantity(Rec,xRec);
        #4..26
        END;
        IF ("Deferral Code" <> '') AND (GetDeferralAmount <> 0) THEN
          UpdateDeferralAmounts;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..29

        //MIG2017
        // T-00551-T-00051 -
        IF ("Document Type" = "Document Type"::Order) AND (Type = Type::Item) THEN BEGIN
          GeneralSetup.GET;
          VALIDATE("Purchasing Code",GeneralSetup."Default Purchasing Code");
        END;
        // T-00551-T-00051 +

        //MGTS10.014; 003; mhh; begin
        SalesHeader.RESET;
        SalesHeader.SETRANGE("Document Type", "Document Type");
        SalesHeader.SETRANGE("No.", "Document No.");
        IF (SalesHeader.FINDFIRST) AND (SalesHeader."Ship-to Code" <> '') THEN BEGIN
          "Ship-to Code" := SalesHeader."Ship-to Code";
          "Ship-to Name" := SalesHeader."Ship-to Name";
        END;
        //MGTS10.014; 003; mhh; end

        // T-00551-DEAL -
        ACOConnection_Re_Loc.RESET();
        ACOConnection_Re_Loc.SETCURRENTKEY("ACO No.");
        ACOConnection_Re_Loc.SETRANGE("ACO No.", Rec."Shortcut Dimension 1 Code");
        IF ACOConnection_Re_Loc.FIND('-') THEN BEGIN

          requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
            ACOConnection_Re_Loc.Deal_ID,
            urm_Re_Loc.Requested_By_Type::"Sales Header",
            Rec."Document No.",
            CURRENTDATETIME
          );

          Rec.INSERT();
          urm_Re_Loc.GET(requestID_Co_Loc);
          UpdateRequestManager_Cu.FNC_Process_Requests(urm_Re_Loc,FALSE,FALSE,TRUE);
          Rec.DELETE();
        END;
        // T-00551-DEAL +
        //MIG2017
        */
    //end;


    //Unsupported feature: Code Modification on "InitHeaderDefaults(PROCEDURE 107)".

    //procedure InitHeaderDefaults();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Quote THEN BEGIN
          IF (SalesHeader."Sell-to Customer No." = '') AND
             (SalesHeader."Sell-to Customer Template Code" = '')
        #4..37
        "Prepayment Tax Area Code" := SalesHeader."Tax Area Code";
        "Prepayment Tax Liable" := SalesHeader."Tax Liable";
        "Responsibility Center" := SalesHeader."Responsibility Center";

        "Shipping Agent Code" := SalesHeader."Shipping Agent Code";
        "Shipping Agent Service Code" := SalesHeader."Shipping Agent Service Code";
        "Outbound Whse. Handling Time" := SalesHeader."Outbound Whse. Handling Time";
        "Shipping Time" := SalesHeader."Shipping Time";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..40
        //MIG2017
        // LOCO/ChC/T-00551-SPEC40 -
        "Campaign Code"  := SalesHeader."Campaign No.";
        // LOCO/ChC/T-00551-SPEC40 +
        //END MIG2017
        #42..45
        */
    //end;

    var
        ACOConnection_Re_Loc: Record "50026";
        DealItem_Cu: Codeunit "50024";
        Deal_Cu: Codeunit "50020";

    var
        requestID_Co_Loc: Code[20];
        element_Re_Loc: Record "50021";
        urm_Re_Loc: Record "50039";
        ACOConnection_Re_Loc: Record "50026";
        UpdateRequestManager_Cu: Codeunit "50032";

    var
        GeneralSetup: Record "50000";
        ACOConnection_Re_Loc: Record "50026";
        DealItem_Cu: Codeunit "50024";
        requestID_Co_Loc: Code[20];
        element_Re_Loc: Record "50021";
        urm_Re_Loc: Record "50039";
        UpdateRequestManager_Cu: Codeunit "50032";

    var
        ArchQte: Label 'Voulez vous archivé l''ancienne quantité';
        CustPriceGroup: Record "6";
        Text50000: Label '%1|%2';
}

