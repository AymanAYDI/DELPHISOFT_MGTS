table 50031 "DEL Deal Shipment Selection"
{

    Caption = 'Deal Shipment Selection';
    //TODO LookupPageID = 50038;

    fields
    {
        field(1; "Document Type"; Enum "DEL Document Type")
        {

        }
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(11; "Account Type"; Enum "DEL Account Type")
        {
            Caption = 'Account Type';

        }
        field(12; "Account No."; Text[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner";
        }
        field(13; "Account Entry No."; Integer)
        {
        }
        field(20; Deal_ID; Code[20])
        {
        }
        field(50; "Shipment No."; Code[20])
        {
            TableRelation = "DEL Deal Shipment".ID;
        }
        field(60; "BR No."; Code[20])
        {
            TableRelation = "Purch. Rcpt. Header"."No.";

            trigger OnValidate()
            var
                dealShipment_Re_Loc: Record "DEL Deal Shipment";
                purchInvHeader: Record "Purch. Inv. Header";
                purchRcptHeader: Record "Purch. Rcpt. Header";
            begin
            end;
        }
        field(70; "Purchase Invoice No."; Code[20])
        {
            TableRelation = "Purch. Inv. Header"."No.";
        }
        field(80; "Sales Invoice No."; Code[20])
        {
            TableRelation = "Sales Invoice Header"."No.";
        }
        field(90; "Fee Connection"; Code[20])
        {
            TableRelation = "DEL Fee Connection".ID;
        }
        field(95; "Connected Fee Description"; Text[50])
        {
            Caption = 'Connected Fee Description';
        }
        field(100; Checked; Boolean)
        {
        }
        field(110; "Journal Template Name"; Code[10])
        {
        }
        field(120; "Journal Batch Name"; Code[10])
        {
        }
        field(130; "Line No."; Integer)
        {
        }
        field(140; USER_ID; Code[50])
        {

        }
    }

    keys
    {
        key(Key1; Deal_ID, "Shipment No.", "Document No.", "Line No.", USER_ID)
        {
            Clustered = true;
        }
        key(Key2; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
        }
        key(Key3; "Account Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

