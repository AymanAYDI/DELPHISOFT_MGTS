page 50145 "DEL EDI Delivery GLN Customer"
{
    ApplicationArea = all;
    Caption = 'EDI Delivery GLN Customer';
    PageType = List;
    SourceTable = "DEL EDI Delivery GLN Customer";
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(GLN; Rec.GLN)
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
