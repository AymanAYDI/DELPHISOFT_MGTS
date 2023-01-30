pageextension 50037 "DEL ChartofAccounts" extends "Chart of Accounts" //16 
{
    layout
    {
        addafter("Balance (FCY)")
        {
            field("DEL Movement (FCY)"; Rec."Movement (FCY)")
            { }
        }
        addafter("Additional-Currency Balance")
        {
            field("DEL Exchange Rate Adjustment"; Rec."Exchange Rate Adjustment")
            { }
        }
        addafter("Default IC Partner G/L Acc. No")
        {
            field("DEL Reporting Dimension 1 Code"; Rec."DEL Reporting Dimension 1 Code")
            { }
            field("DEL Reporting Dimension 2 Code"; Rec."DEL Reporting Dimension 2 Code")
            { }
            field("DEL No compte groupe"; Rec."No. 2")
            { }
            field("DEL Company Code"; Rec."DEL Company Code")
            { }
        }
    }
    actions
    {
    }
}

