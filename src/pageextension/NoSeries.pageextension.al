pageextension 50041 "DEL NoSeries" extends "No. Series"
{
    layout
    {
        addafter(Control1)
        {
            field("DEL Check Entry For Reverse"; Rec."DEL Check Entry For Reverse")
            {
                Caption = 'Check For Relation Entry For Reverse';
            }
        }
    }
}

