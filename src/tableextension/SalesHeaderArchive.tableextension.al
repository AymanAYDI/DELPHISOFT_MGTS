tableextension 50034 "DEL SalesHeaderArchive" extends "Sales Header Archive"
{
    fields
    {
        field(50000; "DEL Fiscal Repr."; Code[10])
        {
            Caption = 'Fiscal Repr.';
            Description = 'T-00551-SPEC35';
            TableRelation = Contact;
        }
        field(50004; "DEL Event Code"; Option)
        {
            Caption = 'Event Code';
            Description = 'EDI,MGTS10.025';
            OptionCaption = 'NORM,TYRE,SPARE,SMOOVE,ISP,CANCELLED';
            OptionMembers = NORM,TYRE,SPARE,SMOOVE,ISP,CANCELLED;
        }
        field(50011; "DEL Shipment No."; Text[50])
        {
            Caption = 'Shipment No.';
        }
    }
}

