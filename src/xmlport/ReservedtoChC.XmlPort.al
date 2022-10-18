xmlport 50010 "Reserved to ChC"
{
    DefaultFieldsValidation = false;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Table15; Table15)
            {
                AutoUpdate = true;
                XmlName = 'ContactHeader';
                fieldelement(No; "G/L Account"."No.")
                {
                }
                fieldelement(Length; "G/L Account"."Reporting Dimension 1 Code")
                {
                }
                fieldelement(Width; "G/L Account"."Reporting Dimension 2 Code")
                {
                }
                fieldelement(Depth; "G/L Account"."Shipment Binding Control")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        //ImportItems();
        MESSAGE(CurrentFileName);
    end;

    trigger OnPreXmlPort()
    begin
        CurrentFileName := currXMLport.FILENAME;
    end;

    var
        CurrentFileName: Text[240];
        CurrentNbOfRecords: Integer;
        CurrentError: Text[30];
        IOFile: File;
        IOFileLine: Text[1024];
        LineFields: array[100] of Text[50];
        TempDate: Date;
        TempDec: Decimal;

    [Scope('Internal')]
    procedure CreateArray()
    var
        IOPos: Integer;
        i: Integer;
    begin
        //IOFileLine := CONVERTSTR(IOFileLine, ';', ',');
        CLEAR(LineFields);
        IOPos := 1;
        FOR i := 1 TO STRLEN(IOFileLine) DO
            IF IOFileLine[i] = ';' THEN
                IOPos += 1
            ELSE
                LineFields[IOPos] += FORMAT(IOFileLine[i]);

        CurrentNbOfRecords += 1;

        //MESSAGE('%1', IOPos);
    end;

    [Scope('Internal')]
    procedure ImportItems()
    var
        Item: Record "27";
        ItemTranslation: Record "30";
        DefaultDimension: Record "352";
    begin
        MESSAGE(CurrentFileName);

        IF NOT IOFile.OPEN(CurrentFileName) THEN
            EXIT;
        IOFile.TEXTMODE(TRUE);

        MESSAGE('Debug 2');

        WHILE IOFile.READ(IOFileLine) > 0 DO BEGIN
            CreateArray();

            WITH Item DO
                IF GET(FORMAT(LineFields[1])) THEN BEGIN
                    MESSAGE('Debug 3, %1', "No.");
                    EVALUATE("Length.old", LineFields[2]);
                    EVALUATE("Width.old", LineFields[3]);
                    EVALUATE("Depth.old", LineFields[4]);
                    MODIFY;
                END;
        END;

        IOFile.CLOSE;
    end;
}

