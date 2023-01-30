pageextension 50043 "DEL SalesOrderSubform" extends "Sales Order Subform"
{
    layout
    {
        addafter("Control1")
        {
            field("DEL Requested qtity"; Rec."DEL Requested qtity")
            {
                BlankZero = true;
            }
        }
        addafter("Control1")
        {
            field("DEL Special Order Purchase No."; Rec."Special Order Purchase No.")
            {
            }
            field("DEL Special Order Purch. Line No."; Rec."Special Order Purch. Line No.")
            {
            }
            field("DEL Post With Purch. Order No."; Rec."DEL Post With Purch. Order No.")
            {
                Caption = 'Post with purchase order No.';
            }
        }
        addafter("Control1")
        {
            field("DEL VAT %"; Rec."VAT %")
            {
            }
        }
        addafter("Control1")
        {
            field("DEL Shipped With Difference"; Rec."DEL Shipped With Difference")
            {
            }
        }
        addafter("Control1")
        {
            field("DEL Estimated Delivery Date"; Rec."DEL Estimated Delivery Date")
            {
            }
        }
        addafter("Control1")
        {
            field("DEL Ship-to Code"; Rec."DEL Ship-to Code")
            {
            }
            field("DEL Ship-to Name"; Rec."DEL Ship-to Name")
            {
            }
        }
        addafter("Control1")
        {
            field("DEL VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                Visible = true;
            }
        }
    }
}


