
table 50081 "DEL EDI Delivery GLN Customer"

{
    Caption = 'EDI Delivery GLN Customer';
    LookupPageID = "DEL EDI Delivery GLN Customer";
    DataClassification = CustomerContent;
    fields
    {
        field(1; GLN; Text[30])
        {
            Caption = 'Delivery GLN';
            DataClassification = CustomerContent;
        }
        field(2; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
            DataClassification = CustomerContent;
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

