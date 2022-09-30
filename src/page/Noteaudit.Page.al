page 50069 "DEL Note audit"
{
    Caption = 'Rating Audit';
    PageType = List;
    SourceTable = "DEL Note";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Revision Calculation"; Rec."Revision Calculation")
                {
                    Caption = 'Revising Calculation';
                }
                field("Impact statut"; Rec."Impact statut")
                {
                    Caption = 'Impact of status';
                }
            }
        }
    }

    
}

