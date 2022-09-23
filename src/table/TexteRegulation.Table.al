table 50001 "DEL Texte Regulation"
{
    Caption = 'DEL Texte Regulation';

    //TODO DrillDownPageID = 50001;
    // LookupPageID = 50001;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Type; enum "DEL Product Type")
        {
            Caption = 'Type';

        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(4; Text; Text[120])
        {
            Caption = 'Text';
        }
        field(5; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
        }
        field(6; Champs; enum "DEL champs")
        {

            Caption = 'Champs';
        }
    }

    keys
    {
        key(Key1; "No.", Type, Champs, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure GetNextLineNo(RegulationLineSource: Record "DEL Texte Regulation"; BelowxRec: Boolean): Integer
    var
        RegulationLine: Record "DEL Texte Regulation";
        LowLineNo: Integer;
        HighLineNo: Integer;
        NextLineNo: Integer;
        LineStep: Integer;
    begin
        LowLineNo := 0;
        HighLineNo := 0;
        NextLineNo := 0;
        LineStep := 10000;
        RegulationLine.SETRANGE(RegulationLine."No.", "No.");
        RegulationLine.SETRANGE(RegulationLine.Type, Type);
        RegulationLine.SETRANGE(RegulationLine.Champs, Champs);
        IF RegulationLine.FIND('+') THEN
            IF NOT RegulationLine.GET(RegulationLine."No.", RegulationLine.Type, RegulationLine.Champs, RegulationLine."Line No.") THEN
                NextLineNo := RegulationLine."Line No." + LineStep
            ELSE
                IF BelowxRec THEN BEGIN
                    RegulationLine.FINDLAST;
                    NextLineNo := RegulationLine."Line No." + LineStep;
                END ELSE
                    IF RegulationLine.NEXT(-1) = 0 THEN BEGIN
                        LowLineNo := 0;
                        HighLineNo := RegulationLineSource."Line No.";
                    END ELSE BEGIN
                        RegulationLine := RegulationLineSource;
                        RegulationLine.NEXT(-1);
                        LowLineNo := RegulationLine."Line No.";
                        HighLineNo := RegulationLineSource."Line No.";
                    END
        ELSE
            NextLineNo := LineStep;

        IF NextLineNo = 0 THEN
            NextLineNo := ROUND((LowLineNo + HighLineNo) / 2, 1, '<');

        IF RegulationLine.GET(RegulationLine."No.", RegulationLine.Type, RegulationLine.Champs, NextLineNo) THEN
            EXIT(0);
        EXIT(NextLineNo);
    end;
}

