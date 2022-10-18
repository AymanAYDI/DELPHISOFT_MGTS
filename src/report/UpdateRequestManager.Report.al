report 50003 "DEL Update Request Manager"
{

    ProcessingOnly = true;

    dataset
    {
        dataitem("DEL ACO Connection"; "DEL ACO Connection")
        {
            RequestFilterFields = Deal_ID, "Vendor No.";

            trigger OnAfterGetRecord()
            begin
                IF UpdatePlanned_Bo_Par THEN BEGIN
                    UpdateRequest.SetValeur(UpdatePlanned_Bo_Par);
                    IF NOT UpdateRequest.RUN("DEL ACO Connection") THEN BEGIN
                        nbreErreur := nbreErreur + 1;
                        IF DealErreur <> '' THEN
                            DealErreur := DealErreur + ', ' + "DEL ACO Connection".Deal_ID
                        ELSE
                            DealErreur := "DEL ACO Connection".Deal_ID
                    END;
                END
                ELSE BEGIN
                    UpdateRequest.SetValeur(UpdatePlanned_Bo_Par);
                    IF NOT UpdateRequest.RUN("DEL ACO Connection") THEN BEGIN
                        nbreErreur := nbreErreur + 1;
                        IF DealErreur <> '' THEN
                            DealErreur := DealErreur + ', ' + "DEL ACO Connection".Deal_ID
                        ELSE
                            DealErreur := "DEL ACO Connection".Deal_ID
                    END;
                END;
                i := i + 1;
                //TODO UpdateRequestManager_CU.FNC_ProgressBar_Update(1);
            end;

            trigger OnPostDataItem()
            begin
                UpdateRequestManager_CU.FNC_ProgressBar_Close(1);
                IF i <> 0 THEN
                    MESSAGE('Liste traitée !');
                IF nbreErreur <> 0 THEN
                    MESSAGE(TextErreur, nbreErreur, DealErreur);
            end;

            trigger OnPreDataItem()
            begin
                i := 0;
                UpdateRequestManager_CU.FNC_ProgressBar_Init(1, 1000, 100, 'Mise à jour en cours...', COUNT());
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("Option")
                {
                    field(UpdatePlanned_Bo_Par; UpdatePlanned_Bo_Par)
                    {
                        Caption = 'Including planned';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        UpdateRequest_Re: Record "DEL Update Request Manager";

        UpdateRequestManager_CU: Codeunit "DEL Update Request Manager";
        UpdatePlanned_Bo_Par: Boolean;
        i: Integer;
        UpdateRequest: Codeunit "DEL Update Request";
        nbreErreur: Integer;
        DealErreur: Text[1024];
        TextErreur: Label 'Nombre d''erreur: %1. Liste des affaires: %2.';
}

