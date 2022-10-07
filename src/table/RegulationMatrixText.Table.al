table 50053 "DEL Regulation Matrix Text"
{

    DrillDownPageID = "DEL Matrix Text";
    LookupPageID = "DEL Matrix Text";
    Caption = 'Regulation Matrix Text';

    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category".Code;
        }
        field(2; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));

        }
        field(3; "Product Description"; Text[100])
        {
            Caption = 'Description produit';
        }
        field(4; Mark; enum "DEL Mark")
        {
            Caption = 'Mark';

        }
        field(5; Type; Enum "DEL Marking Type")
        {
            Caption = 'Type';
        }
        field(6; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(7; "Text"; Text[120])
        {
            Caption = 'Text';
        }
        field(8; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
        }
    }

    keys
    {
        key(Key1; "Item Category Code", "Product Group Code", Mark, "Product Description", Type, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure GetNextLineNo(MatriceLineSource: Record "DEL Regulation Matrix Text"; BelowxRec: Boolean): Integer
    var
        MatriceLine: Record "DEL Regulation Matrix Text";
        LowLineNo: Integer;
        HighLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        LowLineNo := 0;
        HighLineNo := 0;
        NextLineNo := 0;
        LineStep := 10000;
        MatriceLine.SETRANGE(MatriceLine."Item Category Code", "Item Category Code");
        MatriceLine.SETRANGE(MatriceLine."Product Group Code", "Product Group Code");
        MatriceLine.SETRANGE(MatriceLine.Mark, Mark);
        MatriceLine.SETRANGE(MatriceLine."Product Description", "Product Description");
        MatriceLine.SETRANGE(MatriceLine.Type, Type);
        IF MatriceLine.FIND('+') THEN
            IF NOT MatriceLine.GET(MatriceLine."Item Category Code", MatriceLine."Product Group Code", MatriceLine.Mark, MatriceLine."Product Description", MatriceLine.Type, MatriceLine."Line No.") THEN
                NextLineNo := MatriceLine."Line No." + LineStep
            ELSE
                IF BelowxRec THEN BEGIN
                    MatriceLine.FINDLAST();
                    NextLineNo := MatriceLine."Line No." + LineStep;
                END ELSE
                    IF MatriceLine.NEXT(-1) = 0 THEN BEGIN
                        LowLineNo := 0;
                        HighLineNo := MatriceLineSource."Line No.";
                    END ELSE BEGIN
                        MatriceLine := MatriceLineSource;
                        MatriceLine.NEXT(-1);
                        LowLineNo := MatriceLine."Line No.";
                        HighLineNo := MatriceLineSource."Line No.";
                    END
        ELSE
            NextLineNo := LineStep;

        IF NextLineNo = 0 THEN
            NextLineNo := ROUND((LowLineNo + HighLineNo) / 2, 1, '<');

        IF MatriceLine.GET(MatriceLine."Item Category Code", MatriceLine."Product Group Code", MatriceLine.Mark, MatriceLine."Product Description", MatriceLine.Type, NextLineNo) THEN
            EXIT(0);
        EXIT(NextLineNo);
    end;
}

