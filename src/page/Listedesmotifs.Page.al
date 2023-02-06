page 50123 "DEL Liste des motifs"
{
    PageType = List;
    SourceTable = "DEL Liste des motifs";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }
                field(Motif; Rec.Motif)
                {
                    ApplicationArea = All;
                    Caption = 'Motif';
                }
            }
        }
    }
}
