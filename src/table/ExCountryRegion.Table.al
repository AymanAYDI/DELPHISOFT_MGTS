table 99202 "DEL Ex_Country/Region"
{
    Caption = 'Country/Region';
    DataPerCompany = false;
    LookupPageID = "Countries/Regions";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(6; "EU Country/Region Code"; Code[10])
        {
            Caption = 'EU Country/Region Code';
        }
        field(7; "Intrastat Code"; Code[10])
        {
            Caption = 'Intrastat Code';
        }
        field(8; "Address Format"; Enum "DEL Address format")
        {
            Caption = 'Address Format';
            InitValue = "City+Post Code";
        }
        field(9; "Contact Address Format"; Enum "DEL Contact Add. Format")
        {
            Caption = 'Contact Address Format';
            InitValue = "After Company Name";
        }
        field(4006496; Mandant; Text[30])
        {
            Caption = 'Company';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "EU Country/Region Code")
        {
        }
        key(Key3; "Intrastat Code")
        {
        }
        key(Key4; Name)
        {
        }
    }

    fieldgroups
    {
    }
}

