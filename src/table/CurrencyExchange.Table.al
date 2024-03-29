table 50028 "DEL Currency Exchange"
{
    Caption = 'DEL Currency Exchange';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Currency 1"; Code[10])
        {
            Caption = 'Currency 1';
            DataClassification = CustomerContent;
            TableRelation = Currency.Code;
        }
        field(2; "Currency 2"; Code[10])
        {
            Caption = 'Currency 2';
            DataClassification = CustomerContent;
            TableRelation = Currency.Code;
        }
        field(3; "Rate C2/C1"; Decimal)
        {
            Caption = 'Rate C2/C1';
            DataClassification = CustomerContent;
            DecimalPlaces = 5 : 5;
        }
        field(4; "Valid From"; Date)
        {
            Caption = 'Valid From';
            DataClassification = CustomerContent;
        }
        field(5; "Valid To"; Date)
        {
            Caption = 'Valid To';
            DataClassification = CustomerContent;
        }
        field(6; Deal_ID; Code[20])
        {
            Caption = 'Deal_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal".ID;
        }
    }

    keys
    {
        key(Key1; Deal_ID, "Currency 1", "Currency 2", "Valid From", "Valid To")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure FNC_Convert(Deal_ID_Co_Par: Code[20]; Amount_Dec_Par: Decimal; From_Currency_Co_Par: Code[10]; To_Currency_Co_Par: Code[10]) Amount_Dec_Ret: Decimal
    begin
        Amount_Dec_Ret := 0;
        IF From_Currency_Co_Par = To_Currency_Co_Par THEN BEGIN

            Amount_Dec_Ret := Amount_Dec_Par;
            EXIT;

        END ELSE BEGIN

            RESET();
            SETFILTER("Currency 1", From_Currency_Co_Par);
            SETFILTER("Currency 2", To_Currency_Co_Par);
            SETFILTER("Valid From", '<=%1', TODAY);
            SETFILTER("Valid To", '>=%1', TODAY);

            IF Deal_ID_Co_Par = '' THEN SETRANGE(Deal_ID, '');

            IF FIND('+') THEN
                Amount_Dec_Ret := Amount_Dec_Par * "Rate C2/C1"
            ELSE
                ERROR('You can''t convert %1 to %2', From_Currency_Co_Par, To_Currency_Co_Par);

        END;
    end;


    procedure FNC_Get_Rate(Deal_ID_Co_Par: Code[20]; From_Currency_Co_Par: Code[10]; To_Currency_Co_Par: Code[10]) Rate_Dec_Ret: Decimal
    begin
        Rate_Dec_Ret := 0;
        IF From_Currency_Co_Par = To_Currency_Co_Par THEN BEGIN

            Rate_Dec_Ret := 1;
            EXIT;

        END ELSE BEGIN

            RESET();
            SETFILTER("Currency 1", From_Currency_Co_Par);
            SETFILTER("Currency 2", To_Currency_Co_Par);
            SETFILTER("Valid From", '<=%1', TODAY);
            SETFILTER("Valid To", '>=%1', TODAY);

            SETFILTER(Deal_ID, '%1|%2', Deal_ID_Co_Par, '');
            IF FIND('+') THEN
                Rate_Dec_Ret := "Rate C2/C1"
            ELSE
                ERROR('Exchange Rate %1 to %2 not found in Exchange Currency table', From_Currency_Co_Par, To_Currency_Co_Par);

        END
    end;
}

