tableextension 50012 tableextension50012 extends "G/L Entry"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.001
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version         Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.001   18.12.19    mhh     List of changes:
    //                                             Added new field: 50002 "Customer Provision"
    //                                             Added new field: 50003 "Reverse With Doc. No."
    //                                             Changed function: CopyFromGenJnlLine()
    //                                             Added new key: "Reverse With Doc. No."
    // ------------------------------------------------------------------------------------------
    fields
    {
        field(50000; "Initial Amount (FCY)"; Decimal)
        {
            Caption = 'Initial Amount (FCY)';
        }
        field(50001; "Initial Currency (FCY)"; Code[10])
        {
            Caption = 'Initial Currency (FCY)';
        }
        field(50002; "Customer Provision"; Code[20])
        {
            Caption = 'Customer Provision';
            Description = 'MGTS10.00.001';
            TableRelation = Customer.No.;
        }
        field(50003;"Reverse With Doc. No.";Code[20])
        {
            Caption = 'Reverse With Doc. No.';
            Description = 'MGTS10.00.001';
            Editable = false;
        }
    }
    keys
    {
        key(Key1;"Reverse With Doc. No.")
        {
        }
    }


    //Unsupported feature: Code Modification on "CopyFromGenJnlLine(PROCEDURE 4)".

    //procedure CopyFromGenJnlLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Posting Date" := GenJnlLine."Posting Date";
        "Document Date" := GenJnlLine."Document Date";
        "Document Type" := GenJnlLine."Document Type";
        #4..27
        "No. Series" := GenJnlLine."Posting No. Series";
        "IC Partner Code" := GenJnlLine."IC Partner Code";

        OnAfterCopyGLEntryFromGenJnlLine(Rec,GenJnlLine);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..30
        //MGTS10.00.001; 001; mhh; single
        "Customer Provision" := GenJnlLine."Customer Provision";

        OnAfterCopyGLEntryFromGenJnlLine(Rec,GenJnlLine);
        */
    //end;
}

