
table 50033 "DEL Position Detail"
{
    Caption = 'DEL Position Detail';
    LookupPageID = "DEL Position Detail";

    fields
    {
        field(1; ID; Code[20])
        {

            Caption = 'ID';

            trigger OnValidate()
            begin
                IF ID <> '' THEN
                    "Line Amount" := Position_Cu.FNC_Get_Amount(ID);
            end;
        }
        field(2; Deal_ID; Code[20])
        {
            Caption = 'Deal_ID';
        }
        field(10; Type; Enum "DEL TypePoisDetail")
        {

            Caption = 'Type';
        }
        field(20; "Type No."; Code[20])
        {
            TableRelation = IF (Type = CONST(ACO)) "Purchase Header"."No."
            ELSE
            IF (Type = CONST(VCO)) "Sales Header"."No."
            ELSE
            IF (Type = CONST(Fee)) "DEL Fee".ID
            ELSE
            IF (Type = CONST(BR)) "Purch. Rcpt. Header"."No."
            ELSE
            IF (Type = CONST("Purchase Invoice")) "Purch. Inv. Header"."No."
            ELSE
            IF (Type = CONST("Sales Invoice")) "Sales Invoice Header"."No.";
            Caption = 'Type No.';
        }
        field(21; Fee_ID; Code[20])
        {
            Caption = 'Fee_ID';
        }
        field(30; "Deal Item"; Code[20])
        {
            Caption = 'Deal Item';
        }
        field(40; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(50; Amount; Decimal)
        {
            DecimalPlaces = 2 : 3;
            Caption = 'Amount';
        }
        field(60; Currency; Code[10])
        {
            TableRelation = Currency.Code;
            Caption = 'Currency';
        }
        field(70; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';

        }
    }

    keys
    {

        key(Key1; ID)

        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    var
        Position_Cu: Codeunit "DEL Position";

}

