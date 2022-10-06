table 50009 "DEL Forwarding agent 2"
{


    Caption = 'Forwarding agent';
    LookupPageID = "DEL Forwarding agent";

    fields
    {
        field(1; "Forwarding Agent Code"; Code[20])
        {
            Caption = 'Forwarding Agent Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Folder for file"; Text[200])
        {
            Caption = 'Folder for file';
        }
        field(4; "URL Address"; Text[50])
        {
            Caption = 'URL Address';
        }
        field(50000; "HSCODE Enable"; Boolean)
        {
            Caption = 'HSCODE Enable';
        }
    }

    keys
    {
        key(Key1; "Forwarding Agent Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

