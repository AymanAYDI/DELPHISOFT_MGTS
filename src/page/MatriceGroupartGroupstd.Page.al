page 50118 "Matrice Group art./Group std"
{
    Caption = 'Product Group / Standard Item Group Matrix';
    PageType = List;
    SourceTable = Table50059;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Group Code"; "Product Group Code")
                {
                }
                field("Product Group Description"; "Product Group Description")
                {
                }
                field("Standard Item Group Code"; "Standard Item Group Code")
                {
                }
                field("Std Item Group Description"; "Std Item Group Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

