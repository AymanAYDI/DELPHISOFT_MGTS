tableextension 50044 tableextension50044 extends "Gen. Journal Line"
{
    // THM       11.09.17        MIG2017
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.001
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version         Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.001   18.12.19    mhh     List of changes:
    //                                             Added new field: 50003 "Customer Provision"
    // MGTS10.00.06.00    | 07.01.2022 | Send Payment Advice : List of changes:
    //                                              Added new fields: 50010..50015
    //                                              Add C/AL :
    //                                                     Dimension Set ID - OnValidate()
    //                                                     ShowDimensions
    //                                                     InitNewLine
    //                                                     CreateDim
    // 
    // ------------------------------------------------------------------------------------------
    // - DEL_QR1.00.00.01          02.11.20    RLA    Add field 11510 SwissQRBill, C\AL in : Payment Reference - OnValidate()
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
        field(11510; "Swiss QRBill"; Boolean)
        {
            Caption = 'Swiss QRBill';
            Description = 'DEL|QR';
            Editable = false;
        }
        field(50001; "Shipment Selection"; Integer)
        {
            CalcFormula = Count ("Deal Shipment Selection" WHERE (Checked = FILTER (Yes),
                                                                 Document No.=FIELD(FILTER(Document No.)),
                                                                 Journal Template Name=FIELD(FILTER(Journal Template Name)),
                                                                 Journal Batch Name=FIELD(FILTER(Journal Batch Name)),
                                                                 Line No.=FIELD(Line No.),
                                                                 USER_ID=FIELD(User ID Filter)));
            Description = 'Temp400';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002;"User ID Filter";Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = User;
        }
        field(50003;"Customer Provision";Code[20])
        {
            Caption = 'Customer Provision';
            Description = 'MGTS10.00.001';
            TableRelation = Customer.No.;
        }
        field(50010;"Shortcut Dim 3 Code";Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Description = 'MGTS10.00.06.00';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3,"Shortcut Dim 3 Code");
            end;
        }
        field(50011;"Shortcut Dim 4 Code";Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Description = 'MGTS10.00.06.00';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4,"Shortcut Dim 4 Code");
            end;
        }
        field(50012;"Shortcut Dim 5 Code";Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            Description = 'MGTS10.00.06.00';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5,"Shortcut Dim 5 Code");
            end;
        }
        field(50013;"Shortcut Dim 6 Code";Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            Description = 'MGTS10.00.06.00';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6,"Shortcut Dim 6 Code");
            end;
        }
        field(50014;"Shortcut Dim 7 Code";Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            Description = 'MGTS10.00.06.00';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7,"Shortcut Dim 7 Code");
            end;
        }
        field(50015;"Shortcut Dim 8 Code";Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            Description = 'MGTS10.00.06.00';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8,"Shortcut Dim 8 Code");
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
        dealShipmentSelection_Re_Loc: Record "50031";

    var
        dealShipmentSelection_Re_Loc: Record "50031";
}

