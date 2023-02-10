page 50087 "DEL Matrials"
{
    Caption = 'Matrials';
    PageType = List;
    SourceTable = "DEL Regulation Matrix Text";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Caption = 'Item Category Code';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Product Group Code';
                }
            }
        }
    }
}
