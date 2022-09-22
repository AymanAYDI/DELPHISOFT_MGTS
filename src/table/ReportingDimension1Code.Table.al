table 50015 "DEL Reporting Dimension 1 Code"
{
    Caption = 'Reporting Dimension 1 Code';
    //TODO //Page
    // LookupPageID = 50016;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;

            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
                BusUnit: Record "Business Unit";
                Item: Record Item;
                Location: Record Location;
            begin
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
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

