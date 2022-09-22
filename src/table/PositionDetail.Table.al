table 50033 "Position Detail"
{
    LookupPageID = 50043;
    Caption = 'Position Detail';

    fields
    {
        field(1; ID; Code[20])
        {

            trigger OnValidate()
            begin
                IF ID <> '' THEN
                    "Line Amount" := Position_Cu.FNC_Get_Amount(ID);
            end;
        }
        field(2; Deal_ID; Code[20])
        {
        }
        field(10; Type; Option)
        {
            OptionCaption = 'ACO,VCO,Fee,Invoice,BR,BL,Purchase Invoice,Sales Invoice,Sales Cr. Memo,Purch. Cr. Memo';
            OptionMembers = ACO,VCO,Fee,Invoice,BR,BL,"Purchase Invoice","Sales Invoice","Sales Cr. Memo","Purch. Cr. Memo";
        }
        field(20; "Type No."; Code[20])
        {
            TableRelation = IF (Type = CONST(ACO)) "Purchase Header".No.
                            ELSE IF (Type=CONST(VCO)) "Sales Header".No.
                            ELSE IF (Type=CONST(Fee)) Fee.ID
                            ELSE IF (Type=CONST(BR)) "Purch. Rcpt. Header".No.
                            ELSE IF (Type=CONST(Purchase Invoice)) "Purch. Inv. Header".No.
                            ELSE IF (Type=CONST(Sales Invoice)) "Sales Invoice Header".No.;
        }
        field(21;Fee_ID;Code[20])
        {
        }
        field(30;"Deal Item";Code[20])
        {
        }
        field(40;Quantity;Decimal)
        {
        }
        field(50;Amount;Decimal)
        {
            DecimalPlaces = 2:3;
        }
        field(60;Currency;Code[10])
        {
            TableRelation = Currency.Code;
        }
        field(70;"Line Amount";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Position_Cu: Codeunit "50022";
}

