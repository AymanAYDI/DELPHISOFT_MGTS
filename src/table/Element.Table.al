table 50021 "DEL Element"
{
    Caption = 'DEL Element';
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 20.04.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            20.04.09   added "Add DateTime" field, FNC_Date2DateTime and FNC_DateTime2Date
    //TODO
    // LookupPageID = 50021;

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

            trigger OnValidate()
            var
                Purchaseline: Record "Purchase Line";
                SalesHeader: Record "Sales Header";
                //TODO DealShpmentConnection: Record 50032;
                Deal: Record "DEL Deal";
            begin
            end;
        }
        field(5; "Type No."; Code[20])
        {
            TableRelation = IF (Type = CONST(ACO)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order))
            ELSE
            IF (Type = CONST(VCO)) "Sales Header"."No." WHERE("Document Type" = CONST(Order))
            //TODO  ELSE IF (Type=CONST(Fee)) Fee.ID
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
        field(7; Date; Date)
        {
            Caption = 'Date';
        }
        field(8; Fee_ID; Code[20])
        {
            Caption = 'Fee_ID';
            //TODO   TableRelation = Fee.ID;
        }
        field(9; Fee_Connection_ID; Code[20])
        {
            Caption = 'Fee_Connection_ID';
            //TODO  TableRelation = "Fee Connection".ID;
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
            //TODO      CalcFormula = Sum(Position."Line Amount" WHERE (Element_ID=FIELD(FILTER(ID))));
            FieldClass = FlowField;
            Caption = 'Amount';
        }
        field(110; "Amount(EUR)"; Decimal)
        {
            //TODO  CalcFormula = Sum(Position."Line Amount (EUR)" WHERE (Element_ID=FIELD(FILTER(ID))));
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
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Setup: Record "DEL General Setup";
        element1: Record "DEL Element";
        element2: Record "DEL Element";
        BillNumer: Code[20];


    procedure FNC_Date2DateTime()
    var
        myDT: DateTime;
    begin
        /*
        RESET();
        FIND('-');
        REPEAT
          myDT := 0DT;
          IF EVALUATE(myDT, FORMAT(Date)) THEN BEGIN
            DateTime := myDT;
            //Date := 0D;
            MODIFY();
          END ELSE
            ERROR('Evaluate exception with rec >%1<', ID);
        UNTIL NEXT() = 0;
        */

    end;


    procedure FNC_DateTime2Date()
    var
        myD: Date;
    begin
        /*
        //transforme les DateTime en Date
        RESET();
        FIND('-');
        REPEAT
        
          myD := 0D;
          IF EVALUATE(myD, COPYSTR(FORMAT("Add DateTime"),1,8)) THEN BEGIN
            Date := myD;
            //DateTime := 0DT;
            MODIFY();
          END ELSE
            ERROR('Evaluate exception with rec >%1<', ID);
        
        UNTIL NEXT() = 0;
        */

    end;
}

