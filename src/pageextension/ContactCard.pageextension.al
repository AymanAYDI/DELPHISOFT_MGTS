pageextension 50048 "DEL ContactCard" extends "Contact Card"
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
                RunObject = Page 50067;
                RunPageLink = "No." = FIELD("No.");
            }
        }
    }
}

