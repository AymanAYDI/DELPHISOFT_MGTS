
table 50044 "DEL FlowFields"

{
    Caption = 'FlowFields';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Primary Key"; Code[10])
        {

            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(10; "Provision Planned Amount"; Decimal)
        {
            CalcFormula = Sum("DEL Shipment Provision Select."."Planned Amount" WHERE(USER_ID = FIELD(USER_ID)));
            Caption = 'Provision Planned Amount';
            FieldClass = FlowField;
        }
        field(20; "Provision Real Amount"; Decimal)
        {
            CalcFormula = Sum("DEL Shipment Provision Select."."Real Amount" WHERE(USER_ID = FIELD(USER_ID)));
            Caption = 'Provision Real Amount';
            FieldClass = FlowField;
        }
        field(30; "Provision Amount"; Decimal)
        {
            CalcFormula = Sum("DEL Shipment Provision Select."."Provision Amount" WHERE(USER_ID = FIELD(USER_ID)));
            Caption = 'Provision Amount';
            FieldClass = FlowField;
        }
        field(100; USER_ID; Code[20])
        {
            Caption = 'USER_ID';
            DataClassification = CustomerContent;
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

