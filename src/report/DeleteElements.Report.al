report 50017 "Delete Elements"
{
    // 
    // loco/ngts/grc 02.11.09 create objet - delete element

    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem9818; Table50021)
        {
            RequestFilterFields = ID;

            trigger OnAfterGetRecord()
            begin



                CuElement.FNC_Delete_Element(Element.ID);
            end;

            trigger OnPreDataItem()
            begin

                filtre := Element.GETFILTER(Element.ID);

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
        CuElement: Codeunit "50021";
        filtre: Code[20];
}

