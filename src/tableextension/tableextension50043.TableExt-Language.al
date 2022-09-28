tableextension 50043 tableextension50043 extends Language
{
    // AL.KVK5.0
    // 19.05.16/AL/MK  - Felder gemäss Kennzeichnung
    fields
    {
        field(4006496; Katalogsprache; Boolean)
        {
            Description = 'AL.KVK5.0';
        }
        field(4006497; "ISO Code"; Text[3])
        {
            Description = 'AL.KVK5.0';
        }
    }
    keys
    {
        key(Key1; Katalogsprache)
        {
        }
    }

    local procedure "-DEL_QR-"()
    begin
    end;

    procedure GetLanguageCode(LanguageId: Integer): Code[10]
    begin
        CLEAR(Rec);
        SETRANGE("Windows Language ID", LanguageId);
        IF FINDFIRST THEN;
        SETRANGE("Windows Language ID");
        EXIT(Code);
    end;
}

