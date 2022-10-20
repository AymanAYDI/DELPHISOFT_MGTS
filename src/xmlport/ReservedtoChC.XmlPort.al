xmlport 50010 "DEL Reserved to ChC"
{
    DefaultFieldsValidation = false;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("G/L Account"; "G/L Account")
            {
                AutoUpdate = true;
                XmlName = 'ContactHeader';
                fieldelement(No; "G/L Account"."No.")
                {
                }
                fieldelement(Length; "G/L Account"."DEL Reporting Dimension 1 Code")
                {
                }
                fieldelement(Width; "G/L Account"."DEL Reporting Dimension 2 Code")
                {
                }
                fieldelement(Depth; "G/L Account"."DEL Shipment Binding Control")
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


    procedure CreateArray()
    var
        IOPos: Integer;
        i: Integer;
    begin
        CLEAR(LineFields);
        IOPos := 1;
        FOR i := 1 TO STRLEN(IOFileLine) DO
            IF IOFileLine[i] = ';' THEN
                IOPos += 1
            ELSE
                LineFields[IOPos] += FORMAT(IOFileLine[i]);

        CurrentNbOfRecords += 1;

    end;


    procedure ImportItems()
    var
        Item: Record Item;
        ItemTranslation: Record "Item Translation";
        DefaultDimension: Record "Default Dimension";
    begin
        MESSAGE(CurrentFileName);
        // TODO //FILE 
        // IF NOT IOFile.OPEN(CurrentFileName) THEN
        //     EXIT;
        // IOFile.TEXTMODE(TRUE);

        // MESSAGE('Debug 2');

        // WHILE IOFile.READ(IOFileLine) > 0 DO BEGIN

        //     CreateArray();

        //     WITH Item DO
        //         IF GET(FORMAT(LineFields[1])) THEN BEGIN
        //             MESSAGE('Debug 3, %1', "No.");
        //             EVALUATE("Length.old", LineFields[2]);
        //             EVALUATE("Width.old", LineFields[3]);
        //             EVALUATE("DEL Depth.old", LineFields[4]);
        //             MODIFY();
        //         END;
        // END;

        // IOFile.CLOSE;
    end;
}

