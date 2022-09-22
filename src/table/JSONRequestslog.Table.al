table 50073 "JSON Requests log"
{
    // Mgts10.00.01.00 | 11.01.2020  | Create  Web Service request logs
    // Mgts10.00.04.00 | 10.09.2021  | Add new field Filtered
    //                                 Add new Key Filtered

    Caption = 'JSON Requests log';
    DrillDownPageID = 50095;
    LookupPageID = 50095;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; Date; DateTime)
        {
            Caption = 'Date';
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ',Request,Response';
            OptionMembers = ,Request,Response;
        }
        field(4; "Function"; Text[50])
        {
            Caption = 'Function';
        }
        field(5; Message; BLOB)
        {
            Caption = 'Message';
            SubType = Json;
        }
        field(6; Error; Boolean)
        {
            Caption = 'Error';
        }
        field(7; Filtered; Boolean)
        {
            Caption = 'Filtré';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; Date)
        {
        }
        key(Key3; Filtered, Date)
        {
        }
    }

    fieldgroups
    {
    }


    procedure InsertLogRecord(pType: Option ,Request,Response; pCalledFunction: Text[50]; pJsonMessage: Text; pError: Boolean): BigInteger
    var
        lOutStream: OutStream;
        JSONRequestslog: Record "50073";
    begin
        IF NOT JSONRequestslog.FINDLAST THEN
            JSONRequestslog.INIT;

        INIT;
        "Entry No." := JSONRequestslog."Entry No." + 1;
        Date := CURRENTDATETIME;
        Type := pType;
        "Function" := pCalledFunction;
        Rec.Message.CREATEOUTSTREAM(lOutStream);
        lOutStream.WRITETEXT(pJsonMessage);
        Error := pError;
        INSERT;
    end;
}

