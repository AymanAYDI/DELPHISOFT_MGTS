tableextension 50043 "DEL Language" extends Language
{
    fields
    {
        field(4006496; "DEL Katalogsprache"; Boolean)
        {
            Description = 'AL.KVK5.0';
        }
        field(4006497; "DEL ISO Code"; Text[3])
        {
            Description = 'AL.KVK5.0';
        }
    }
    keys
    {
        key(Key2; "DEL Katalogsprache")
        {
        }
    }

    procedure GetLanguageCode(LanguageId: Integer): Code[10]
    begin
        CLEAR(Rec);
        SETRANGE("Windows Language ID", LanguageId);
        IF FINDFIRST() THEN;
        SETRANGE("Windows Language ID");
        EXIT(Code);
    end;
}

