pageextension 50003 "DEL GeneralLedgerSetup" extends "General Ledger Setup" //118
{
    layout
    {
        addafter("Use Legacy G/L Entry Locking") //control 4 
        {
            field("DEL Provision Source Code"; Rec."DEL Provision Source Code")
            {
            }
            field("DEL Provision Journal Batch"; Rec."DEL Provision Journal Batch")
            {
            }
        }
        addafter("Payroll Trans. Import Format") //control 7 
        {
            group("DEL QR Code")
            {
                Caption = 'QR Code';
                field("DEL SEPA Non-Euro Export"; Rec."SEPA Non-Euro Export")
                {
                }
            }
        }
    }
}

