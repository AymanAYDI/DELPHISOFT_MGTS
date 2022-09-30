codeunit 50004 "Update Deal"
{
    // CHG04                            26.09.11   adapted deal update function with "updatePlanned" parameter


    trigger OnRun()
    begin
        IF Deal.FINDFIRST THEN
            REPEAT
                Deal_Cu.FNC_Reinit_Deal(Deal.ID, FALSE, TRUE)
            UNTIL Deal.NEXT = 0;
        MESSAGE('Mise à jour des affaires effectuées');
    end;

    var
        Deal: Record "50020";
        Deal_Cu: Codeunit "50020";
}

