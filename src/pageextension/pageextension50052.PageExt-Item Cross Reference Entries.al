pageextension 50052 pageextension50052 extends "Item Cross Reference Entries"
{
    // T-00778     THM     16.03.16          add "Sale blocked"
    //             THM     14,09,17          add "Item No."
    layout
    {
        addfirst("Control 1")
        {
            field("Item No."; "Item No.")
            {
                Editable = false;
            }
        }
        addafter("Control 6")
        {
            field("Sale blocked"; "Sale blocked")
            {
            }
        }
    }
}

