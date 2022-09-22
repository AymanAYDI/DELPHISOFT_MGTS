table 99202 "Ex_Country/Region"
{
    Caption = 'Country/Region';
    DataPerCompany = false;
    LookupPageID = 10;

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
        field(8; "Address Format"; Option)
        {
            Caption = 'Address Format';
            InitValue = "City+Post Code";
            OptionCaption = 'Post Code+City,City+Post Code,City+County+Post Code,Blank Line+Post Code+City';
            OptionMembers = "Post Code+City","City+Post Code","City+County+Post Code","Blank Line+Post Code+City";
        }
        field(9; "Contact Address Format"; Option)
        {
            Caption = 'Contact Address Format';
            InitValue = "After Company Name";
            OptionCaption = 'First,After Company Name,Last';
            OptionMembers = First,"After Company Name",Last;
        }
        field(4006496; Mandant; Text[30])
        {
            Caption = 'Company';
            Description = 'AL.KVK5.0';
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

    trigger OnDelete()
    var
        VATRegNoFormat: Record "381";
    begin
    end;
}

