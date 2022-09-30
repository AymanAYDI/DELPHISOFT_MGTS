page 50142 "DEL Type Order EDI"
{
    Caption = 'Type Order EDI';
    PageType = List;
    SourceTable = "DEL Type Order EDI";

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
                field("Automatic ACO"; Rec."Automatic ACO")
                {
                    Caption = 'Automatic ACO';
                }
            }
        }
    }


}

