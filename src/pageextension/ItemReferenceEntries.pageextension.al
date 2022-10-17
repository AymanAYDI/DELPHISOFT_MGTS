pageextension 50052 "DEL ItemReferenceEntries" extends "Item Reference Entries"
{
    // T-00778     THM     16.03.16          add "Sale blocked"
    //             THM     14,09,17          add "Item No."
    layout
    {
        addfirst(Control1)
        {
            field("DEL Item No."; Rec."Item No.")
            {
                Editable = false;
            }
        }
        addafter(Control1)
        {
            field("DEL Sale blocked"; Rec."DEL Sale blocked")
            {
            }
        }
    }
}

