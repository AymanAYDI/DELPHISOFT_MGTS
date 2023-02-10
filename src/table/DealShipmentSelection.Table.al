table 50031 "DEL Deal Shipment Selection"
{

    Caption = 'Deal Shipment Selection';
    DataClassification = CustomerContent;
    LookupPageID = "DEL Deal Shipment Selection";
    fields
    {
        field(1; "Document Type"; Enum "DEL Document Type")
        {

            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(11; "Account Type"; Enum "Gen. Journal Account Type")
        {
            Caption = 'Account Type';
            DataClassification = CustomerContent;
        }
        field(12; "Account No."; Text[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
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

            Caption = 'Account Entry No.';
            DataClassification = CustomerContent;
        }
        field(20; Deal_ID; Code[20])
        {
            Caption = 'Deal_ID';
            DataClassification = CustomerContent;
        }
        field(50; "Shipment No."; Code[20])
        {

            Caption = 'Shipment No.';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal Shipment".ID;
        }
        field(60; "BR No."; Code[20])
        {

            Caption = 'BR No.';
            DataClassification = CustomerContent;
            TableRelation = "Purch. Rcpt. Header"."No.";
            trigger OnValidate()
            var

            begin
            end;
        }
        field(70; "Purchase Invoice No."; Code[20])
        {

            Caption = 'Purchase Invoice No.';
            DataClassification = CustomerContent;
            TableRelation = "Purch. Inv. Header"."No.";
        }
        field(80; "Sales Invoice No."; Code[20])
        {

            Caption = 'Sales Invoice No.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Invoice Header"."No.";
        }
        field(90; "Fee Connection"; Code[20])
        {

            Caption = 'Fee Connection';
            DataClassification = CustomerContent;
            TableRelation = "DEL Fee Connection".ID;
        }
        field(95; "Connected Fee Description"; Text[50])
        {
            Caption = 'Connected Fee Description';
            DataClassification = CustomerContent;
        }
        field(100; Checked; Boolean)
        {

            Caption = 'Checked';
            DataClassification = CustomerContent;
        }
        field(110; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
        }
        field(120; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
        }
        field(130; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(140; USER_ID; code[50])
        {
            Caption = 'USER_ID';
            DataClassification = CustomerContent;
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

