tableextension 50034 "DEL SalesHeaderArchive" extends "Sales Header Archive"
{
    fields
    {
        field(50000; "DEL Fiscal Repr."; Code[10])
        {
            Caption = 'Fiscal Repr.';
            TableRelation = Contact;
        }
        field(50004; "DEL Event Code"; Enum "DEL Code Event")
        {
            Caption = 'Event Code';
        }
        field(50011; "DEL Shipment No."; Text[50])
        {
            Caption = 'Shipment No.';
        }
    }
}

