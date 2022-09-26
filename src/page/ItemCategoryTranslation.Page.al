page 50006 "Item Category Translation"
{
    Caption = 'Item category translation';
    DataCaptionFields = CategoryCode;
    PageType = List;
    SourceTable = Table50006;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(CategoryCode; CategoryCode)
                {
                    Visible = false;
                }
                field(Language_Code; Language_Code)
                {
                }
                field(Translation; Translation)
                {
                }
            }
        }
    }

    actions
    {
    }
}

