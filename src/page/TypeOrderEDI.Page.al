page 50142 "DEL Type Order EDI"
{
    ApplicationArea = all;
    Caption = 'Type Order EDI';
    PageType = List;
    SourceTable = "DEL Type Order EDI";
    UsageCategory = lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field("Automatic ACO"; Rec."Automatic ACO")
                {
                    ApplicationArea = All;
                    Caption = 'Automatic ACO';
                }
            }
        }
    }


}

