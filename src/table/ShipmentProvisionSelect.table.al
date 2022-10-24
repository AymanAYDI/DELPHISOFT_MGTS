table 50042 "DEL Shipment Provision Select."
{
    Caption = 'DEL Shipment Provision Select.';
    fields
    {
        field(10; Deal_ID; Code[20])
        {
            Caption = 'Deal';
            TableRelation = "DEL Deal".ID;
        }
        field(20; Deal_Shipment_ID; Code[20])
        {
            Caption = 'Deal Shipment';
            TableRelation = "DEL Deal Shipment".ID WHERE(Deal_ID = FIELD(Deal_ID));
        }
        field(30; Fee_Connection_ID; Code[20])
        {
            TableRelation = "DEL Fee Connection".ID;
            Caption = 'Fee_Connection_ID';

            trigger OnValidate()
            var
                feeConnection_Re_Loc: Record "DEL Fee Connection";
            begin
                IF feeConnection_Re_Loc.GET(Fee_Connection_ID) THEN
                    VALIDATE(Fee_ID, feeConnection_Re_Loc."Fee ID")
            end;
        }
        field(35; Fee_ID; Code[20])
        {
            Caption = 'Fee';
            TableRelation = "DEL Fee".ID;

            trigger OnValidate()
            var
                fee_Re_Loc: Record "DEL Fee";
            begin
                IF fee_Re_Loc.GET(Fee_ID) THEN BEGIN
                    VALIDATE("Fee Description", fee_Re_Loc.Description);
                    VALIDATE("Fee Account No.", fee_Re_Loc."No compte");
                END;
            end;
        }
        field(36; "Fee Description"; Text[250])
        {
            Caption = 'Fee Description';
        }
        field(37; "Fee Account No."; Code[10])
        {
            Caption = 'Account No.';
        }
        field(40; "Planned Amount"; Decimal)
        {
            Caption = 'Planned Amount';

            trigger OnValidate()
            begin
                VALIDATE(Delta, "Planned Amount" - "Real Amount");
            end;
        }
        field(50; "Real Amount"; Decimal)
        {
            Caption = 'Real Amount';

            trigger OnValidate()
            begin
                VALIDATE(Delta, "Planned Amount" - "Real Amount");
            end;
        }
        field(60; Delta; Decimal)
        {
            Caption = 'Delta';

            trigger OnValidate()
            begin
                IF Delta > 0 THEN "Provision Amount" := Delta ELSE "Provision Amount" := 0
            end;
        }
        field(70; "Provision Amount"; Decimal)
        {
            Caption = 'Provision Amount';

            trigger OnValidate()
            begin
                IF "Provision Amount" < 0 THEN "Provision Amount" := 0
            end;
        }
        field(80; Currency; Code[10])
        {
            TableRelation = Currency.Code;
            Caption = 'Currency';
        }
        field(90; Period; Date)
        {
            Caption = 'Period';
        }
        field(95; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(96; "Posting Date Ext."; Date)
        {
            Caption = 'Posting Date Ext.';
        }
        field(100; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(110; "Document No. Ext."; Code[20])
        {
            Caption = 'Document No. Ext.';
        }
        field(120; "BR No."; Code[20])
        {
            Caption = 'BR No.';
        }
        field(130; "Purchase Invoice No."; Code[20])
        {
            Caption = 'Purchase Invoice No.';
        }
        field(190; USER_ID; Code[50])
        {
            Caption = 'USER_ID';
        }
        field(200; IsColored; Boolean)
        {
            Caption = 'IsColored';
        }
        field(201; "Total Planned Amount"; Decimal)
        {
            CalcFormula = Sum("DEL Shipment Provision Select."."Planned Amount");
            FieldClass = FlowField;
            Caption = 'Total Planned Amount';
        }
        field(202; "Total Real Amount"; Decimal)
        {
            CalcFormula = Sum("DEL Shipment Provision Select."."Real Amount");
            Caption = 'Total Real Amount';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                VALIDATE(Delta, "Planned Amount" - "Real Amount");
            end;
        }
        field(203; "Total Delta"; Decimal)
        {
            CalcFormula = Sum("DEL Shipment Provision Select.".Delta);
            Caption = 'Total Delta';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                IF Delta > 0 THEN "Provision Amount" := Delta ELSE "Provision Amount" := 0
            end;
        }
        field(204; "Total Provision Amount"; Decimal)
        {
            CalcFormula = Sum("DEL Shipment Provision Select."."Provision Amount");
            Caption = 'Total Provision Amount';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                IF "Provision Amount" < 0 THEN "Provision Amount" := 0
            end;
        }
    }

    keys
    {
        key(Key1; Deal_ID, Deal_Shipment_ID, Fee_ID, USER_ID)
        {
            Clustered = true;
            SumIndexFields = "Planned Amount", "Real Amount", "Provision Amount";
        }
        key(Key2; Period, Deal_ID, Deal_Shipment_ID)
        {
        }
        key(Key3; "Posting Date", Deal_ID)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        spsp_Re_Loc: Record "DEL Ship. Prov. Sele. Params";
    begin
        RESET();
        SETRANGE(USER_ID, USERID);
        IF COUNT() = 1 THEN
            spsp_Re_Loc.FNC_DeleteUserid();
    end;
}

