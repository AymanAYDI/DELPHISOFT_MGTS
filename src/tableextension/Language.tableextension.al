tableextension 50043 "DEL Language" extends Language //8
{
    fields
    {
        field(4006496; "DEL Katalogsprache"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(4006497; "DEL ISO Code"; Text[3])
        {
            DataClassification = CustomerContent;
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

