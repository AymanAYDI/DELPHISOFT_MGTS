page 50087 "DEL Matrials"
{


    Caption = 'Matrials';
    PageType = List;
    SourceTable = "DEL Regulation Matrix Text";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Caption = 'Product Group Code';
                }
            }
        }
    }


}

