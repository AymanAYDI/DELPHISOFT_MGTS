pageextension 50015 "DEL GLAccountCard" extends "G/L Account Card" //17
{
    layout
    {
        addafter("Direct Posting") //14
        {
            field("DEL No. 2"; Rec."No. 2")
            {
                Caption = 'No. acount group';
            }
        }
        addafter("Cost Accounting") //3
        {
            group("DEL NGTS")
            {
                Caption = 'NGTS';
                field("DEL Reporting Dimension 1 Code"; Rec."DEL Reporting Dimension 1 Code")
                {
                    Caption = 'Reporting Dimension groupe';
                }
                field("DEL Company Code"; Rec."DEL Company Code")
                {
                    Editable = false;
                }
                field("DEL Reporting Dimension 2 Code"; Rec."DEL Reporting Dimension 2 Code")
                {
                    Caption = 'Reporting Dimension local';
                }
                field("DEL Shipment Binding Control"; Rec."DEL Shipment Binding Control")
                {
                }
                field("DEL Mobivia Detail"; Rec."DEL Mobivia Detail")
                {
                }
                field("DEL Hyperion Export Sign"; Rec."DEL Hyperion Export Sign")
                {
                }
            }
        }
    }
    actions
    {
    }
}

