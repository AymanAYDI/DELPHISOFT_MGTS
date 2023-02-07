tableextension 50034 "DEL SalesHeaderArchive" extends "Sales Header Archive"
{
    fields
    {
        field(50000; "DEL Fiscal Repr."; Code[10])
        {
            Caption = 'Fiscal Repr.';
            TableRelation = Contact;
            DataClassification = CustomerContent;
        }
        field(50004; "DEL Event Code"; Enum "DEL Code Event")
        {
            Caption = 'Event Code';
            DataClassification = CustomerContent;
        }
        field(50011; "DEL Shipment No."; Text[50])
        {
            Caption = 'Shipment No.';
            DataClassification = CustomerContent;
        }
        field(50052; "DEL Container No."; Code[30])
        {
            Caption = 'Container Number';
            DataClassification = CustomerContent;
        }
        field(50053; "DEL Dispute Reason"; Code[20])
        {
            Caption = 'Dispute Reason';
            DataClassification = CustomerContent;
        }
        field(50054; "DEL Dispute Date"; Date)
        {
            Caption = 'Dispute Date';
            DataClassification = CustomerContent;
        }
    }
}

