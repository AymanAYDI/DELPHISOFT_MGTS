table 50017 "DEL Note Audit Social"
{
    Caption = 'DEL Note Audit Social';
    DataClassification = CustomerContent;


    DrillDownPageID = "DEL Detail Social Audit";
    LookupPageID = "DEL Detail Social Audit";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            TableRelation = "DEL Audit social";
            trigger OnValidate()
            begin
                CALCFIELDS(Axe);
            end;
        }
        field(2; Axe; Text[60])
        {
            CalcFormula = Lookup("DEL Audit social".Axe WHERE("No." = FIELD("No.")));
            Caption = 'Dimension';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Vendor/Contact No."; Code[20])
        {
            Caption = 'Vendor/Contact No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; Note; Enum "DEL Rating")
        {
            Caption = 'Rating';
            DataClassification = CustomerContent;
        }
        field(5; Type; enum "DEL Type Vend/Cont")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.", "Vendor/Contact No.", Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

