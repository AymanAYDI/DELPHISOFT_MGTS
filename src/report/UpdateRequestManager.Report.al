report 50003 "Update Request Manager"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 06.04.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID                  Date           Description
    // ---------------------------------------------------------------------------------
    // T-00759            13.01.16        Create Object

    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1100113001; Table50026)
        {
            RequestFilterFields = Deal_ID, "Vendor No.";

            trigger OnAfterGetRecord()
            begin
                IF UpdatePlanned_Bo_Par THEN BEGIN
                    UpdateRequest.SetValeur(UpdatePlanned_Bo_Par);
                    IF NOT UpdateRequest.RUN("ACO Connection") THEN BEGIN
                        nbreErreur := nbreErreur + 1;
                        IF DealErreur <> '' THEN
                            DealErreur := DealErreur + ', ' + "ACO Connection".Deal_ID
                        ELSE
                            DealErreur := "ACO Connection".Deal_ID
                    END;
                END
                ELSE BEGIN
                    UpdateRequest.SetValeur(UpdatePlanned_Bo_Par);
                    IF NOT UpdateRequest.RUN("ACO Connection") THEN BEGIN
                        nbreErreur := nbreErreur + 1;
                        IF DealErreur <> '' THEN
                            DealErreur := DealErreur + ', ' + "ACO Connection".Deal_ID
                        ELSE
                            DealErreur := "ACO Connection".Deal_ID
                    END;
                END;
                i := i + 1;
                //mise à jour de la barre de progression
                UpdateRequestManager_CU.FNC_ProgressBar_Update(1);
            end;

            trigger OnPostDataItem()
            begin
                //ferme la barre de progression
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
                group(Option)
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
        UpdateRequestManager_CU: Codeunit "50032";
        UpdateRequest_Re: Record "50039";
        UpdatePlanned_Bo_Par: Boolean;
        i: Integer;
        UpdateRequest: Codeunit "50008";
        nbreErreur: Integer;
        DealErreur: Text[1024];
        TextErreur: Label 'Nombre d''erreur: %1. Liste des affaires: %2.';
}

