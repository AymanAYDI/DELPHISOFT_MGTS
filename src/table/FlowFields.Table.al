
table 50044 "DEL FlowFields"

{
    Caption = 'FlowFields';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {

            Caption = 'Primary Key';
        }
        field(10; "Provision Planned Amount"; Decimal)
        {
            CalcFormula = Sum("DEL Shipment Provision Select."."Planned Amount" WHERE(USER_ID = FIELD(USER_ID)));
            FieldClass = FlowField;
            Caption = 'Provision Planned Amount';
        }
        field(20; "Provision Real Amount"; Decimal)
        {
            CalcFormula = Sum("DEL Shipment Provision Select."."Real Amount" WHERE(USER_ID = FIELD(USER_ID)));
            FieldClass = FlowField;
            Caption = 'Provision Real Amount';
        }
        field(30; "Provision Amount"; Decimal)
        {
            CalcFormula = Sum("DEL Shipment Provision Select."."Provision Amount" WHERE(USER_ID = FIELD(USER_ID)));
            FieldClass = FlowField;
            Caption = 'Provision Amount';
        }
        field(100; USER_ID; Code[20])
        {
            Caption = 'USER_ID';

        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

