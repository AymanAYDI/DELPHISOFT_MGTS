table 50021 "DEL Element"
{
    Caption = 'DEL Element';
    LookupPageID = "DEL Element";

    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
        }
        field(2; Deal_ID; Code[20])
        {
            TableRelation = "DEL Deal".ID;
            Caption = 'Deal_ID';
        }
        field(3; Instance; Enum "DEL Instance")
        {
            Caption = 'Instance';
        }
        field(4; Type; Enum "DEL Type")
        {

            Caption = 'Type';

        }
        field(5; "Type No."; Code[20])
        {
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
            Caption = 'Type No.';
        }
        field(6; "Subject No."; Code[20])
        {
            TableRelation = IF (Type = CONST(ACO)) Vendor."No."
            ELSE
            IF (Type = CONST(VCO)) Customer."No.";
            Caption = 'Subject No.';
        }
        field(7; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(8; Fee_ID; Code[20])
        {
            Caption = 'Fee_ID';
            TableRelation = "DEL Fee".ID;
        }
        field(9; Fee_Connection_ID; Code[20])
        {
            Caption = 'Fee_Connection_ID';
            TableRelation = "DEL Fee Connection".ID;
        }
        field(10; "Subject Type"; Enum "DEL Subject Type")
        {
            Caption = 'Subject Type';
        }
        field(11; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(12; "Splitt Index"; Integer)
        {
            Caption = 'Splitt Index';
        }
        field(20; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(30; "Add DateTime"; DateTime)
        {
            Caption = 'Add DateTime';
        }
        field(40; Period; Date)
        {
            Caption = 'Period';
        }
        field(100; Amount; Decimal)
        {
            CalcFormula = Sum("DEL Position"."Line Amount" WHERE(Element_ID = FIELD(FILTER(ID))));
            FieldClass = FlowField;
            Caption = 'Amount';
        }
        field(110; "Amount(EUR)"; Decimal)
        {
            CalcFormula = Sum("DEL Position"."Line Amount (EUR)" WHERE(Element_ID = FIELD(FILTER(ID))));
            FieldClass = FlowField;
            Caption = 'Amount(EUR)';
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
        key(Key3; Type, "Type No.")
        {
        }
        key(Key4; Deal_ID, Type, Instance)
        {
        }
        key(Key5; "Entry No.", ID)
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


    procedure FNC_Date2DateTime()
    var
    begin
    end;

    procedure FNC_DateTime2Date()
    var
    begin
    end;
}


