tableextension 50043 "DEL Language" extends Language //8
{
    fields
    {
        field(4006496; "DEL Katalogsprache"; Boolean)
        {
        }
        field(4006497; "DEL ISO Code"; Text[3])
        {
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
    //TODO: la procédure GetLanguageID existe seulement dans l'ancien standard, mais elle 
    //a été utilisé dans le report spécifique 50004 ! à vérifier ça #Abir
    PROCEDURE GetLanguageID(LanguageCode: Code[10]): Integer;
    BEGIN
        CLEAR(Rec);
        IF LanguageCode <> '' THEN
            IF GET(LanguageCode) THEN
                EXIT("Windows Language ID");
        "Windows Language ID" := GLOBALLANGUAGE;
        EXIT("Windows Language ID");
    END;




}

