table 50079 "DEL Type Order EDI"
{

    //TODO 
    // LookupPageID = 50142;
    Caption = 'Type Order EDI';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Automatic ACO"; Boolean)
        {
            Caption = 'Automatic ACO';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

