page 50099 "DEL Logistic CN"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(group1)
            {
                part(CopyProfile; "Copy Profile")
                {
                }
                systempart(Outlookv; Outlook)
                {
                    Visible = false;
                }
            }
            group(group2)
            {
                systempart(MyNotes; MyNotes)
                {
                }
                part(MyItems; "My Items")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(embedding)
        {
            action("Affair List")
            {
                Caption = 'Affair List';
                Image = Quote;
                RunObject = Page "DEL Deal";
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
            }
        }
        area(sections)
        {
        }
    }
}

