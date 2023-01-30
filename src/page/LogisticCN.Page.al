page 50099 "DEL Logistic CN"
{
    Caption = 'Role Center';
    PageType = RoleCenter;
    UsageCategory = None;

    layout
    {
        area(rolecenter)
        {
            group(group1)
            {
                part(CopyProfile; "Copy Profile")
                {
                    ApplicationArea = All;
                }
                systempart(Outlookv; Outlook)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(group2)
            {
                systempart(MyNotes; MyNotes)
                {
                    ApplicationArea = All;
                }
                part(MyItems; "My Items")
                {
                    Visible = false;
                    ApplicationArea = All;
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
                ApplicationArea = All;
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
                ApplicationArea = All;
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ApplicationArea = All;
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ApplicationArea = All;
            }
        }
        area(sections)
        {
        }
    }
}

