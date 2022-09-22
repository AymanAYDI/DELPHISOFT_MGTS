table 50081 "EDI Delivery GLN Customer"
{
    // MGTSEDI10.00.00.21 | 18.01.2021 | EDI Management : Create Table

    Caption = 'EDI Delivery GLN Customer';
    LookupPageID = 50145;

    fields
    {
        field(1; GLN; Text[30])
        {
            Caption = 'Delivery GLN';
        }
        field(2; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
    }

    keys
    {
        key(Key1; GLN)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

