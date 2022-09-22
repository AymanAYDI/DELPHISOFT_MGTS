table 50044 FlowFields
{
    Caption = 'FlowFields';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(10; "Provision Planned Amount"; Decimal)
        {
            CalcFormula = Sum("Shipment Provision Selection"."Planned Amount" WHERE(USER_ID = FIELD(USER_ID)));
            FieldClass = FlowField;
        }
        field(20; "Provision Real Amount"; Decimal)
        {
            CalcFormula = Sum("Shipment Provision Selection"."Real Amount" WHERE(USER_ID = FIELD(USER_ID)));
            FieldClass = FlowField;
        }
        field(30; "Provision Amount"; Decimal)
        {
            CalcFormula = Sum("Shipment Provision Selection"."Provision Amount" WHERE(USER_ID = FIELD(USER_ID)));
            FieldClass = FlowField;
        }
        field(100; USER_ID; Code[20])
        {
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

