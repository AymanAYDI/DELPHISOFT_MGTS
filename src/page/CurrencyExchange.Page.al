page 50039 "Currency Exchange"
{
    Caption = 'Currency exchange';
    PageType = List;
    SourceTable = Table50028;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Deal_ID; Deal_ID)
                {
                    Caption = 'Deal ID';
                }
                field("Currency 1"; "Currency 1")
                {
                    Caption = 'Currency';
                }
                field("Currency 2"; "Currency 2")
                {
                    Caption = 'Budget currency';
                }
                field("Rate C2/C1"; "Rate C2/C1")
                {
                    Caption = 'Rate C2/C1';
                }
                field("Valid From"; "Valid From")
                {
                    Caption = 'Valid from';
                }
                field("Valid To"; "Valid To")
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

