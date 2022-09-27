tableextension 50010 tableextension50010 extends "Incoming Document"
{
    // DELGR\THS\300620\Add fields from 11530 to 11545
    fields
    {
        field(11530; "Swiss QRBill"; Boolean)
        {
            Caption = 'Swiss QRBill';
        }
        field(11531; "Swiss QRBill Vendor Address 1"; Text[100])
        {
            Caption = 'Address Line 1';
            Description = 'DEL_QR';
        }
        field(11532; "Swiss QRBill Vendor Address 2"; Text[100])
        {
            Caption = 'Address Line 2';
            Description = 'DEL_QR';
        }
        field(11533; "Swiss QRBill Vendor Post Code"; Code[20])
        {
            Caption = 'Postal Code';
            Description = 'DEL_QR';
        }
        field(11534; "Swiss QRBill Vendor City"; Text[100])
        {
            Caption = 'City';
            Description = 'DEL_QR';
        }
        field(11535; "Swiss QRBill Vendor Country"; Code[10])
        {
            Caption = 'Country';
            Description = 'DEL_QR';
        }
        field(11536; "Swiss QRBill Debitor Name"; Text[100])
        {
            Caption = 'Name';
            Description = 'DEL_QR';
        }
        field(11537; "Swiss QRBill Debitor Address1"; Text[100])
        {
            Caption = 'Address Line 1';
            Description = 'DEL_QR';
        }
        field(11538; "Swiss QRBill Debitor Address2"; Text[100])
        {
            Caption = 'Address Line 2';
            Description = 'DEL_QR';
        }
        field(11539; "Swiss QRBill Debitor PostCode"; Code[20])
        {
            Caption = 'Postal Code';
            Description = 'DEL_QR';
        }
        field(11540; "Swiss QRBill Debitor City"; Text[100])
        {
            Caption = 'City';
            Description = 'DEL_QR';
        }
        field(11541; "Swiss QRBill Debitor Country"; Code[10])
        {
            Caption = 'Country';
            Description = 'DEL_QR';
        }
        field(11542; "Swiss QRBill Reference Type"; Option)
        {
            Caption = 'Payment Reference Type';
            Description = 'DEL_QR';
            OptionCaption = 'Without Reference,Creditor Reference (ISO 11649),QR Reference';
            OptionMembers = "Without Reference","Creditor Reference (ISO 11649)","QR Reference";
        }
        field(11543; "Swiss QRBill Reference No."; Code[50])
        {
            Caption = 'Payment Reference';
            Description = 'DEL_QR';
        }
        field(11544; "Swiss QRBill Unstr. Message"; Text[140])
        {
            Caption = 'Unstructured Message';
            Description = 'DEL_QR';
        }
        field(11545; "Swiss QRBill Bill Info"; Text[140])
        {
            Caption = 'Billing Information';
            Description = 'DEL_QR';
        }
    }
}

