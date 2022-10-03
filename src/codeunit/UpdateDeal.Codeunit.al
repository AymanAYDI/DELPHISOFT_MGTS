codeunit 50004 "DEL Update Deal"
{
    trigger OnRun()
    begin
        IF Deal.FINDFIRST() THEN
            REPEAT
                Deal_Cu.FNC_Reinit_Deal(Deal.ID, FALSE, TRUE)
            UNTIL Deal.NEXT() = 0;
        MESSAGE('Mise à jour des affaires effectuées');
    end;

    var
        Deal: Record "DEL Deal";
        Deal_Cu: Codeunit "DEL Deal";
}

