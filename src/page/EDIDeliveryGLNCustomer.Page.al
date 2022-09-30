page 50145 "DEL EDI Delivery GLN Customer"
{


    Caption = 'EDI Delivery GLN Customer';
    PageType = List;
    SourceTable = "DEL EDI Delivery GLN Customer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(GLN; Rec.GLN)
                {
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

