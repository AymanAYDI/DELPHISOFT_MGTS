table 50070 "DEL DocMatrix Email Codes"
{

    Caption = 'Email Item';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            DataClassification = CustomerContent;
            TableRelation = Language;

            trigger OnValidate()
            begin
                IF "Language Code" <> '' THEN
                    "All Language Codes" := FALSE;
            end;
        }
        field(3; "All Language Codes"; Boolean)
        {
            Caption = 'All Language Codes';
            DataClassification = CustomerContent;
            InitValue = true;

            trigger OnValidate()
            begin
                IF "All Language Codes" THEN
                    "Language Code" := ''
            end;
        }
        field(10; Subject; Text[250])
        {
            Caption = 'Subject';
            DataClassification = CustomerContent;
        }
        field(11; Body; BLOB)
        {
            Caption = 'Body';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code", "Language Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure SetBodyText(Value: Text)
    var
        BodyText: BigText;
        DataStream: OutStream;
    begin
        // write text to the BLOB field
        CLEAR(Body);
        BodyText.ADDTEXT(Value);
        Body.CREATEOUTSTREAM(DataStream, TEXTENCODING::UTF8);
        BodyText.WRITE(DataStream);
        MODIFY(TRUE);
    end;


    procedure GetBodyText(pCode: Code[20]; pLanguage: Code[10]) Value: Text
    var
        MyBigText: BigText;
        BLOBInStream: InStream;
    begin
        // get the text from the BLOB field
        IF GET(pCode, pLanguage) THEN BEGIN
            CALCFIELDS(Body);
            IF Body.HASVALUE THEN BEGIN
                CLEAR(MyBigText);
                Body.CREATEINSTREAM(BLOBInStream, TEXTENCODING::UTF8);
                MyBigText.READ(BLOBInStream);
                MyBigText.GETSUBTEXT(Value, 1);
            END;
            EXIT(Value);
        END;
    end;
}

