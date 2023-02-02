pageextension 50029 "DEL RecurringGeneralJournal" extends "Recurring General Journal" //283
{
    layout
    {
        addafter("Comment")
        {
            field("DEL Customer Provision"; Rec."DEL Customer Provision")
            {
            }
        }
    }

}

