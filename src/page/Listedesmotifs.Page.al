page 50123 "DEL Liste des motifs"
{
    PageType = List;
    SourceTable = "DEL Liste des motifs";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    Caption = 'No';
                }
                field(Motif; Rec.Motif)
                {
                    Caption = 'Motif';
                }
            }
        }
    }


}

