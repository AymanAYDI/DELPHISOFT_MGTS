page 50099 "Logistic CN"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 9175)
                {
                }
                systempart(; Outlook)
                {
                    Visible = false;
                }
            }
            group()
            {
                systempart(; MyNotes)
                {
                }
                part(; 9152)
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
                RunObject = Page 50020;
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page 9307;
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page 27;
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page 31;
            }
        }
        area(sections)
        {
        }
    }
}

