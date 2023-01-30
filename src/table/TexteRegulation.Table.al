table 50001 "DEL Texte Regulation"
{
    Caption = 'DEL Texte Regulation';

    DrillDownPageID = "DEL Regulation Text";
    LookupPageID = "DEL Regulation Text";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Type; enum "DEL Product Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Text"; Text[120])
        {
            Caption = 'Text';
            DataClassification = CustomerContent;
        }
        field(5; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            DataClassification = CustomerContent;
        }
        field(6; Champs; enum "DEL champs")
        {

            Caption = 'Champs';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.", Type, Champs, "Line No.")
        {
            Clustered = true;
        }
    }

    procedure GetNextLineNo(RegulationLineSource: Record "DEL Texte Regulation"; BelowxRec: Boolean): Integer
    var
        RegulationLine: Record "DEL Texte Regulation";
        HighLineNo: Integer;
        LineStep: Integer;
        LowLineNo: Integer;
        NextLineNo: Integer;
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
                    RegulationLine.FINDLAST();
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

