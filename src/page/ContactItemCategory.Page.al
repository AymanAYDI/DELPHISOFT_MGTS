page 50005 Contact_ItemCategory
{
    Caption = 'Product Groups';
    Editable = false;
    PageType = List;
    SourceTable = Table50005;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(contactNo; contactNo)
                {
                    Visible = false;
                }
                field("Groupe de produits"; ItemCategory)
                {
                }
            }
        }
    }

    actions
    {
    }
}

