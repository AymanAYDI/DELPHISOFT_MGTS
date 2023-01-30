page 50039 "DEL Currency Exchange"
{
    Caption = 'Currency exchange';
    PageType = List;
    SourceTable = "DEL Currency Exchange";
    UsageCategory = Administration;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Deal_ID; Rec.Deal_ID)
                {
                    Caption = 'Deal ID';
                }
                field("Currency 1"; Rec."Currency 1")
                {
                    Caption = 'Currency';
                }
                field("Currency 2"; Rec."Currency 2")
                {
                    Caption = 'Budget currency';
                }
                field("Rate C2/C1"; Rec."Rate C2/C1")
                {
                    Caption = 'Rate C2/C1';
                }
                field("Valid From"; Rec."Valid From")
                {
                    Caption = 'Valid from';
                }
                field("Valid To"; Rec."Valid To")
                {
                    Caption = 'To';
                }
            }
        }
    }

    actions
    {
    }
}

