tableextension 50044 "DEL GenJournalLine" extends "Gen. Journal Line"
{
    fields
    {


        //Unsupported feature: Code Insertion (VariableCollection) on ""Account No."(Field 4).OnValidate".

        //trigger (Variable: dealShipmentSelection_Re_Loc)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Account No."(Field 4).OnValidate".

        //trigger "(Field 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Account No." <> xRec."Account No." THEN BEGIN
          ClearAppliedAutomatically;
          VALIDATE("Job No.",'');
        #4..49

        VALIDATE("IC Partner G/L Acc. No.",GetDefaultICPartnerGLAccNo);
        ValidateApplyRequirements(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..52

        //START CHG01
        dealShipmentSelection_Re_Loc.RESET();
        dealShipmentSelection_Re_Loc.SETFILTER("Journal Template Name", "Journal Template Name");
        dealShipmentSelection_Re_Loc.SETFILTER("Journal Batch Name", "Journal Batch Name");
        dealShipmentSelection_Re_Loc.SETRANGE("Line No.", "Line No.");
        dealShipmentSelection_Re_Loc.DELETEALL();
        //STOP CHG01
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


        //Unsupported feature: Code Modification on ""Dimension Set ID"(Field 480).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        //>>MGTS10.00.06.00
        DimMgt.UpdateAllShortDimFromDimSetID("Dimension Set ID", "Shortcut Dim 3 Code", "Shortcut Dim 4 Code", "Shortcut Dim 5 Code",
                                              "Shortcut Dim 6 Code", "Shortcut Dim 7 Code", "Shortcut Dim 8 Code");
        //<<MGTS10.00.06.00
        */
        //end;
        field(11510; "DEL Swiss QRBill"; Boolean)
        {
            Caption = 'Swiss QRBill';
            Editable = false;
        }
        field(50001; "DEL Shipment Selection"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("DEL Deal Shipment Selection" WHERE(Checked = FILTER('Yes'),
                                                                 "Document No." = FIELD(FILTER("Document No.")),
                                                                 "Journal Template Name" = FIELD(FILTER("Journal Template Name")),
                                                                 "Journal Batch Name" = FIELD(FILTER("Journal Batch Name")),
                                                                 "Line No." = FIELD("Line No."),
                                                                 USER_ID = FIELD("DEL User ID Filter")));
            Editable = false;

        }
        field(50002; "DEL User ID Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = User;
        }
        field(50003; "DEL Customer Provision"; Code[20])
        {
            Caption = 'Customer Provision';
            TableRelation = Customer."No.";
        }
        field(50010; "DEL Shortcut Dim 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "DEL Shortcut Dim 3 Code");
            end;
        }
        field(50011; "DEL Shortcut Dim 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "DEL Shortcut Dim 4 Code");
            end;
        }
        field(50012; "DEL Shortcut Dim 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "DEL Shortcut Dim 5 Code");
            end;
        }
        field(50013; "DEL Shortcut Dim 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "DEL Shortcut Dim 6 Code");
            end;
        }
        field(50014; "DEL Shortcut Dim 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "DEL Shortcut Dim 7 Code");
            end;
        }
        field(50015; "DEL Shortcut Dim 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "DEL Shortcut Dim 8 Code");
            end;
        }
    }


    //Unsupported feature: Code Insertion (VariableCollection) on "OnDelete".

    //trigger (Variable: dealShipmentSelection_Re_Loc)()
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
    ApprovalsMgmt.OnCancelGeneralJournalLineApprovalRequest(Rec);

    TESTFIELD("Check Printed",FALSE);
    #4..23

    IF LSVSetup.READPERMISSION THEN
      LSVMgt.ReleaseCustLedgEntries(Rec);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..26

    //START MIG2017
    //START CHG01
    dealShipmentSelection_Re_Loc.RESET();
    dealShipmentSelection_Re_Loc.SETRANGE("Journal Template Name", "Journal Template Name");
    dealShipmentSelection_Re_Loc.SETRANGE("Journal Batch Name", "Journal Batch Name");
    dealShipmentSelection_Re_Loc.SETRANGE("Line No.", "Line No.");
    dealShipmentSelection_Re_Loc.DELETEALL();
    //STOP CHG01
    //END MIG2017
    */
    //end;


    //Unsupported feature: Code Modification on "InitNewLine(PROCEDURE 94)".

    //procedure InitNewLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    INIT;
    "Posting Date" := PostingDate;
    "Document Date" := DocumentDate;
    Description := PostingDescription;
    "Shortcut Dimension 1 Code" := ShortcutDim1Code;
    "Shortcut Dimension 2 Code" := ShortcutDim2Code;
    "Dimension Set ID" := DimSetID;
    "Reason Code" := ReasonCode;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..8
    //>>MGTS10.00.06.00
    DimMgt.UpdateAllShortDimFromDimSetID("Dimension Set ID", "Shortcut Dim 3 Code", "Shortcut Dim 4 Code", "Shortcut Dim 5 Code",
                                          "Shortcut Dim 6 Code", "Shortcut Dim 7 Code", "Shortcut Dim 8 Code");
    //<<MGTS10.00.06.00
    */
    //end;


    //Unsupported feature: Code Modification on "CreateDim(PROCEDURE 13)".

    //procedure CreateDim();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TableID[1] := Type1;
    No[1] := No1;
    TableID[2] := Type2;
    #4..12
    "Dimension Set ID" :=
      DimMgt.GetDefaultDimID(
        TableID,No,"Source Code","Shortcut Dimension 1 Code","Shortcut Dimension 2 Code",0,0);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..15
    //>>MGTS10.00.06.00
    DimMgt.UpdateAllShortDimFromDimSetID("Dimension Set ID", "Shortcut Dim 3 Code", "Shortcut Dim 4 Code", "Shortcut Dim 5 Code",
                                          "Shortcut Dim 6 Code", "Shortcut Dim 7 Code", "Shortcut Dim 8 Code");
    //<<MGTS10.00.06.00
    */
    //end;


    //Unsupported feature: Code Modification on "ValidateShortcutDimCode(PROCEDURE 14)".

    //procedure ValidateShortcutDimCode();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Check Printed",FALSE);
    DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    TESTFIELD("Check Printed",FALSE);
    DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");

    //>>MGTS10.00.06.00
    DimMgt.UpdateAllShortDimFromDimSetID("Dimension Set ID", "Shortcut Dim 3 Code", "Shortcut Dim 4 Code", "Shortcut Dim 5 Code",
                                          "Shortcut Dim 6 Code", "Shortcut Dim 7 Code", "Shortcut Dim 8 Code");
    //<<MGTS10.00.06.00
    */
    //end;


    //Unsupported feature: Code Modification on "ShowDimensions(PROCEDURE 26)".

    //procedure ShowDimensions();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Dimension Set ID" :=
      DimMgt.EditDimensionSet2(
        "Dimension Set ID",STRSUBSTNO('%1 %2 %3',"Journal Template Name","Journal Batch Name","Line No."),
        "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4

    //>>MGTS10.00.06.00
    DimMgt.UpdateAllShortDimFromDimSetID("Dimension Set ID", "Shortcut Dim 3 Code", "Shortcut Dim 4 Code", "Shortcut Dim 5 Code",
                                          "Shortcut Dim 6 Code", "Shortcut Dim 7 Code", "Shortcut Dim 8 Code");
    //<<MGTS10.00.06.00
    */
    //end;

    var
        dealShipmentSelection_Re_Loc: Record "IC Outbox Purchase Header";


}

