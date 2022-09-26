page 50145 "EDI Delivery GLN Customer"
{
    // MGTSEDI10.00.00.21 | 18.01.2021 | EDI Management : Create Page

    Caption = 'EDI Delivery GLN Customer';
    PageType = List;
    SourceTable = Table50081;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(GLN; GLN)
                {
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

