report 50017 "DEL Delete Elements"
{

    ProcessingOnly = true;

    dataset
    {
        dataitem("DEL Element"; "DEL Element")
        {
            RequestFilterFields = ID;

            trigger OnAfterGetRecord()
            begin



                CuElement.FNC_Delete_Element("DEL Element".ID);
            end;

            trigger OnPreDataItem()
            begin

                filtre := "DEL Element".GETFILTER("DEL Element".ID);

                IF filtre = '' THEN
                    ERROR('Un élément doit être selectionné');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CuElement: Codeunit "DEL Element";
        filtre: Code[20];
}

