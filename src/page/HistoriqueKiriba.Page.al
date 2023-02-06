page 50125 "DEL Historique Kiriba"
{
    PageType = List;
    SourceTable = "DEL Historique import Kiriba";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No traitement"; Rec."No traitement")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Heure; Rec.Heure)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

