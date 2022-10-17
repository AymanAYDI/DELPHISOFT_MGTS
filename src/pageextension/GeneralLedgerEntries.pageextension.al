pageextension 50018 "DEL GeneralLedgerEntries" extends "General Ledger Entries" //20
{

    layout
    {
        addafter("Document Type") //4
        {
            field("DEL ExternalDocument No."; Rec."External Document No.")
            {
            }
        }
        addafter("Entry No.") //20
        {
            field("DEL Initial Currency (FCY)"; Rec."DEL Initial Currency (FCY)")
            {
            }
            field("DEL Initial Amount (FCY)"; Rec."DEL Initial Amount (FCY)")
            {
            }
            field("DEL Customer Provision"; Rec."DEL Customer Provision")
            {
            }
        }
    }

    procedure SetGLEntry(var GLEntry: Record "G/L Entry")
    begin
        CurrPage.SETSELECTIONFILTER(GLEntry);
    end;
}

