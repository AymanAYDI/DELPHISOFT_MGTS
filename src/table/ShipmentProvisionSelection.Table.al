table 50042 "Shipment Provision Selection"
{
    Caption = 'Shipment Provision Selection';
    // Mgts10.00.06.01 : 03.02.21 --> field USER_ID  20 >>50


    fields
    {
        field(10; Deal_ID; Code[20])
        {
            Caption = 'Deal';
            TableRelation = Deal.ID;
        }
        field(20; Deal_Shipment_ID; Code[20])
        {
            Caption = 'Deal Shipment';
            TableRelation = "Deal Shipment".ID WHERE(Deal_ID = FIELD(Deal_ID));
        }
        field(30; Fee_Connection_ID; Code[20])
        {
            TableRelation = "Fee Connection".ID;

            trigger OnValidate()
            var
                feeConnection_Re_Loc: Record "50025";
            begin
                IF feeConnection_Re_Loc.GET(Fee_Connection_ID) THEN
                    VALIDATE(Fee_ID, feeConnection_Re_Loc."Fee ID")
            end;
        }
        field(35; Fee_ID; Code[20])
        {
            Caption = 'Fee';
            TableRelation = Fee.ID;

            trigger OnValidate()
            var
                fee_Re_Loc: Record "50024";
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
        }
        field(90; Period; Date)
        {
            Caption = 'Period';
        }
        field(95; "Posting Date"; Date)
        {
        }
        field(96; "Posting Date Ext."; Date)
        {
        }
        field(100; "Document No."; Code[20])
        {
        }
        field(110; "Document No. Ext."; Code[20])
        {
        }
        field(120; "BR No."; Code[20])
        {
        }
        field(130; "Purchase Invoice No."; Code[20])
        {
        }
        field(190; USER_ID; Code[50])
        {
            Description = 'Mgts10.00.06.01';
        }
        field(200; IsColored; Boolean)
        {
        }
        field(201; "Total Planned Amount"; Decimal)
        {
            CalcFormula = Sum("Shipment Provision Selection"."Planned Amount");
            FieldClass = FlowField;
        }
        field(202; "Total Real Amount"; Decimal)
        {
            CalcFormula = Sum("Shipment Provision Selection"."Real Amount");
            Caption = 'Total Real Amount';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                VALIDATE(Delta, "Planned Amount" - "Real Amount");
            end;
        }
        field(203; "Total Delta"; Decimal)
        {
            CalcFormula = Sum("Shipment Provision Selection".Delta);
            Caption = 'Total Delta';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                IF Delta > 0 THEN "Provision Amount" := Delta ELSE "Provision Amount" := 0
            end;
        }
        field(204; "Total Provision Amount"; Decimal)
        {
            CalcFormula = Sum("Shipment Provision Selection"."Provision Amount");
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
        spsp_Re_Loc: Record "50045";
    begin
        // Lorsqu'on supprime le dernier enregistrement d'un user, alors on vide les paramètres enregistrés dans la tables associée
        RESET();
        SETRANGE(USER_ID, USERID);
        IF COUNT() = 1 THEN
            spsp_Re_Loc.FNC_DeleteUserid();
    end;
}

