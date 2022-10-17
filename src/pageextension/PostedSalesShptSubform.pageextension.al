pageextension 50005 "DEL PostedSalesShptSubform" extends "Posted Sales Shpt. Subform" //131
{
    layout
    {
        addafter("Shipping Time") //32 
        {
            field("DEL Ship-to Code"; Rec."DEL Ship-to Code")
            {
            }
            field("DEL Ship-to Name"; Rec."DEL Ship-to Name")
            {
            }
        }
    }
}

