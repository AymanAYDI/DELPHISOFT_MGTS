table 50041 "DEL Element Update"
{
    Caption = 'DEL Element Update';
    DataClassification = CustomerContent;
    LookupPageID = "DEL Element";
    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; Deal_ID; Code[20])
        {
            Caption = 'Deal_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal".ID;
        }
        field(3; Instance; enum "DEL Instance")
        {

            Caption = 'Instance';
            DataClassification = CustomerContent;
        }
        field(4; Type; enum "DEL Type")
        {

            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(5; "Type No."; Code[20])
        {
            Caption = 'Type No.';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST(ACO)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order))
            ELSE
            IF (Type = CONST(VCO)) "Sales Header"."No." WHERE("Document Type" = CONST(Order))
            ELSE
            IF (Type = CONST(Fee)) "DEL Fee".ID
            ELSE
            IF (Type = CONST(BR)) "Purch. Rcpt. Header"."No."
            ELSE
            IF (Type = CONST("Purchase Invoice")) "Purch. Inv. Header"."No."
            ELSE
            IF (Type = CONST("Sales Invoice")) "Sales Invoice Header"."No."
            ELSE
            IF (Type = CONST("Sales Cr. Memo")) "Sales Cr.Memo Header"."No."
            ELSE
            IF (Type = CONST("Purch. Cr. Memo")) "Purch. Cr. Memo Hdr."."No.";
            ValidateTableRelation = false;
        }
        field(6; "Subject No."; Code[20])
        {
            Caption = 'Subject No.';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST(ACO)) Vendor."No."
            ELSE
            IF (Type = CONST(VCO)) Customer."No.";
        }
        field(7; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(8; Fee_ID; Code[20])
        {
            Caption = 'Fee_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Fee".ID;
        }
        field(9; Fee_Connection_ID; Code[20])
        {
            Caption = 'Fee_Connection_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Fee Connection".ID;
        }
        field(10; "Subject Type"; Enum "DEL Subject Type")
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
        }
        field(11; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(20; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Customer;
        }
        field(30; "Add DateTime"; DateTime)
        {
            Caption = 'Add DateTime';
            DataClassification = CustomerContent;
        }
        field(31; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(32; Shipment_ID; Code[20])
        {
            Caption = 'Shipment_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal Shipment".ID;
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
        key(Key2; Deal_ID, Type)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Setup.GET();

        IF ID = '' THEN
            ID := NoSeriesMgt.GetNextNo(Setup."Element Nos.", TODAY, TRUE);
    end;

    var
        Setup: Record "DEL General Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

