table 50022 "DEL Position"
{

    LookupPageID = "DEL Position";

    Caption = 'Position';

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
        field(3; Element_ID; Code[20])
        {

            TableRelation = "DEL Element".ID;
            Caption = 'Element_ID';
        }
        field(4; Instance; Enum "DEL Instance")
        {


            Caption = 'Instance';
        }
        field(5; "Deal Item No."; Code[20])
        {

            TableRelation = "DEL Deal Item"."Item No." WHERE(Deal_ID = FIELD(Deal_ID));

            Caption = 'Deal Item No.';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                "Line Amount (EUR)" := Amount * Quantity;
                "Line Amount" := Amount * Quantity * Rate;
            end;
        }
        field(7; Currency; Code[10])
        {
            TableRelation = Currency.Code;
            Caption = 'Currency';
        }
        field(8; Amount; Decimal)
        {
            DecimalPlaces = 2 : 4;
            Caption = 'Amount';

            trigger OnValidate()
            begin
                "Line Amount" := Amount * Quantity;
                "Line Amount (EUR)" := Amount * Quantity * Rate;
            end;
        }
        field(9; "Sub Element_ID"; Code[20])
        {

            TableRelation = "DEL Element".ID;

            Caption = 'Sub Element_ID';
        }
        field(10; Rate; Decimal)
        {
            DecimalPlaces = 2 : 4;
            Caption = 'Rate';

            trigger OnValidate()
            begin
                "Line Amount" := Amount * Quantity;
                "Line Amount (EUR)" := Amount * Quantity * Rate;
            end;
        }
        field(30; "Campaign Code"; Code[20])
        {
            Caption = 'Campaign Code';
        }
        field(100; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
        }
        field(110; "Line Amount (EUR)"; Decimal)
        {
            Caption = 'Line Amount (EUR)';
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
        key(Key2; Deal_ID)
        {
        }
        key(Key3; Element_ID)
        {
            SumIndexFields = "Line Amount", "Line Amount (EUR)";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Setup.GET();

        IF ID = '' THEN
            ID := NoSeriesMgt.GetNextNo(Setup."Position Nos.", TODAY, TRUE);
    end;

    var

        Setup: Record "DEL General Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";

}

