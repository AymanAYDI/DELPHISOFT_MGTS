table 50041 "Element Update"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 20.04.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            20.04.09   added "Add DateTime" field, FNC_Date2DateTime and FNC_DateTime2Date

    LookupPageID = 50021;
    Caption = 'Element Update';

    fields
    {
        field(1; ID; Code[20])
        {
        }
        field(2; Deal_ID; Code[20])
        {
            TableRelation = Deal.ID;
        }
        field(3; Instance; Option)
        {
            OptionCaption = 'Planned,Real';
            OptionMembers = planned,real;
        }
        field(4; Type; Option)
        {
            OptionCaption = 'ACO,VCO,Fee,Invoice,BR,BL,Purchase Invoice,Sales Invoice,Sales Cr. Memo,Purch. Cr. Memo';
            OptionMembers = ACO,VCO,Fee,Invoice,BR,BL,"Purchase Invoice","Sales Invoice","Sales Cr. Memo","Purch. Cr. Memo";
        }
        field(5; "Type No."; Code[20])
        {
            TableRelation = IF (Type = CONST(ACO)) "Purchase Header".No. WHERE (Document Type=CONST(Order))
                            ELSE IF (Type=CONST(VCO)) "Sales Header".No. WHERE (Document Type=CONST(Order))
                            ELSE IF (Type=CONST(Fee)) Fee.ID
                            ELSE IF (Type=CONST(BR)) "Purch. Rcpt. Header".No.
                            ELSE IF (Type=CONST(Purchase Invoice)) "Purch. Inv. Header".No.
                            ELSE IF (Type=CONST(Sales Invoice)) "Sales Invoice Header".No.
                            ELSE IF (Type=CONST(Sales Cr. Memo)) "Sales Cr.Memo Header".No.
                            ELSE IF (Type=CONST(Purch. Cr. Memo)) "Purch. Cr. Memo Hdr.".No.;
            ValidateTableRelation = false;
        }
        field(6;"Subject No.";Code[20])
        {
            TableRelation = IF (Type=CONST(ACO)) Vendor.No.
                            ELSE IF (Type=CONST(VCO)) Customer.No.;
        }
        field(7;Date;Date)
        {
        }
        field(8;Fee_ID;Code[20])
        {
            TableRelation = Fee.ID;
        }
        field(9;Fee_Connection_ID;Code[20])
        {
            TableRelation = "Fee Connection".ID;
        }
        field(10;"Subject Type";Option)
        {
            OptionCaption = ' ,Vendor,Customer,G/L Account';
            OptionMembers = " ",Vendor,Customer,"G/L Account";
        }
        field(11;"Entry No.";Integer)
        {
            Caption = 'Entry No.';
        }
        field(20;"Bill-to Customer No.";Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(30;"Add DateTime";DateTime)
        {
        }
        field(31;"User ID";Code[20])
        {
            Caption = 'User ID';
            TableRelation = Table2000000002.Field1;
        }
        field(32;Shipment_ID;Code[20])
        {
            TableRelation = "Deal Shipment".ID;
        }
    }

    keys
    {
        key(Key1;ID)
        {
            Clustered = true;
        }
        key(Key2;Deal_ID,Type)
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
        NoSeriesMgt: Codeunit "396";
        Setup: Record "50000";


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

