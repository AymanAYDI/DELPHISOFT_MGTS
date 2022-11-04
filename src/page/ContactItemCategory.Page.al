page 50005 "DEL Contact_ItemCategory"
{
    Caption = 'Product Groups';
    Editable = false;
    PageType = List;
    SourceTable = "DEL Contact_ItemCategory";

    layout
    {
        area(content)
        {
            repeater(Contact1)
            {
                field(contactNo; Rec.contactNo)
                {
                    Visible = false;
                }
                field("Groupe de produits"; Rec.ItemCategory)
                {
                }
            }
        }
    }

}

