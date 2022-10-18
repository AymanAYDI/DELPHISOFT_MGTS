pageextension 50052 "DEL ItemReferenceEntries" extends "Item Reference Entries"
{
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

