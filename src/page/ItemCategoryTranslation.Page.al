page 50006 "DEL Item Category Translation"
{
    Caption = 'Item category translation';
    DataCaptionFields = CategoryCode;
    PageType = List;
    SourceTable = "DEL ItemCategory_Translation";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(CategoryCode; Rec.CategoryCode)
                {
                    Visible = false;
                    Caption = 'CategoryCode';
                }
                field(Language_Code; Rec.Language_Code)
                {
                    Caption = 'Language Code';
                }
                field(Translation; Rec.Translation)
                {
                    Caption = 'Translation';
                }
            }
        }
    }

}

