page 50125 "DEL Historique Kiriba"
{
    PageType = List;
    SourceTable = "DEL Historique import Kiriba";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No traitement"; Rec."No traitement")
                {
                    Caption = 'No traitement';
                }
                field("Date"; Rec.Date)
                {
                    Caption = 'Date';
                }
                field(Heure; Rec.Heure)
                {
                    Caption = 'Heure';
                }
            }
        }
    }

    actions
    {
    }
}

