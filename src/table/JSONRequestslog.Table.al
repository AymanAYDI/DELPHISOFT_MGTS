table 50073 "DEL JSON Requests log"
{
    Caption = 'JSON Requests log';
    //   TODO 
    // DrillDownPageID = 50095;
    // LookupPageID = 50095;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Date"; DateTime)
        {
            Caption = 'Date';
        }
        field(3; Type; Enum "DEL Type ReqRes")
        {
            Caption = 'Type';
        }
        field(4; Function; Text[50])
        {
            Caption = 'Function';
        }
        field(5; "Message"; BLOB)
        {
            Caption = 'Message';
            SubType = Json;
        }
        field(6; "Error"; Boolean)
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


    procedure InsertLogRecord(pType: Enum "DEL Type ReqRes"; pCalledFunction: Text[50]; pJsonMessage: Text; pError: Boolean): BigInteger
    var
        JSONRequestslog: Record "DEL JSON Requests log";
        lOutStream: OutStream;
    begin
        IF NOT JSONRequestslog.FINDLAST() THEN
            JSONRequestslog.INIT();
        INIT();
        "Entry No." := JSONRequestslog."Entry No." + 1;
        Date := CURRENTDATETIME;
        Type := pType;
        "Function" := pCalledFunction;
        Rec.Message.CREATEOUTSTREAM(lOutStream);
        lOutStream.WRITETEXT(pJsonMessage);
        Error := pError;
        INSERT();
    end;
}

