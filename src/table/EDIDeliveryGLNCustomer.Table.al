
table 50081 "DEL EDI Delivery GLN Customer"

{
    Caption = 'EDI Delivery GLN Customer';
    //TODO //LookupPageID = 50145;

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

}

