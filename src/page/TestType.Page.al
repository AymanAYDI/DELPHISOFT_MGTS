page 50100 "DEL Test Type"
{


    Caption = 'Test Type';
    PageType = List;
    SourceTable = "DEL Test Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
            }
        }
    }


}

