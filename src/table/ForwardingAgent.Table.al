table 50011 "DEL Forwarding Agent"
{


    Caption = 'Forwarding Agent';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Vendor;
        }
        field(2; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(3; "Forwarding Agent"; Code[20])
        {
            Caption = 'Forwarding Agent';
            DataClassification = CustomerContent;
            TableRelation = "DEL Forwarding agent 2";
        }
        field(4; "Departure port"; Code[20])
        {
            Caption = 'Departure port';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
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

