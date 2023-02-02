pageextension 50048 "DEL ContactCard" extends "Contact Card" //5050
{
    layout
    {
        addafter(ParentCompanyInfo)
        {
            field("DEL GLN"; Rec."DEL GLN")
            {
            }
        }
    }
    actions
    {

        addafter(ContactCoverSheet)
        {
            action("DEL Notation contact")
            {
                Caption = 'Contact Rating';
                Image = AdjustItemCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Contact Notation Card";
                RunPageLink = "No." = FIELD("No.");
            }
        }
    }
}

