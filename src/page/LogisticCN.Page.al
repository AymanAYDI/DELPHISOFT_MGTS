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
                    ApplicationArea = All;
                    Visible = false;
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
                    ApplicationArea = All;
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
                ApplicationArea = All;
                Caption = 'Affair List';
                Image = Quote;
                RunObject = Page "DEL Deal";
            }
            action("Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
            }
            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
            action(Items)
            {
                ApplicationArea = All;
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

