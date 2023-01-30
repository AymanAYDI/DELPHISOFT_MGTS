table 50011 "DEL Forwarding Agent"
{


    Caption = 'Forwarding Agent';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(2; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            DataClassification = CustomerContent;
        }
        field(3; "Forwarding Agent"; Code[20])
        {
            Caption = 'Forwarding Agent';
            TableRelation = "DEL Forwarding agent 2";
            DataClassification = CustomerContent;
        }
        field(4; "Departure port"; Code[20])
        {
            Caption = 'Departure port';
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Vendor No.", "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}

