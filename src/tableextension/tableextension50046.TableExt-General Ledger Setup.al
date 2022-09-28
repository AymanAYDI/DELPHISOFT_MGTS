tableextension 50046 tableextension50046 extends "General Ledger Setup"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.001
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.001    18.12.19    mhh     List of changes:
    //                                              Added new field: 50000 "Provision Source Code"
    //                                              Added new field: 50001 "Provision Journal Batch"
    // ------------------------------------------------------------------------------------------
    fields
    {

        //Unsupported feature: Property Modification (InitValue) on ""Amount Rounding Precision"(Field 73)".


        //Unsupported feature: Property Modification (InitValue) on ""Unit-Amount Rounding Precision"(Field 74)".

        field(170; "SEPA Non-Euro Export"; Boolean)
        {
            Caption = 'SEPA Non-Euro Export';
        }
        field(50000; "Provision Source Code"; Code[20])
        {
            Caption = 'Provision Source Code';
            Description = 'MGTS10.00.001';
            TableRelation = "Source Code".Code;
        }
        field(50001; "Provision Journal Batch"; Text[250])
        {
            Caption = 'Provision Journal Batch';
            Description = 'MGTS10.00.001';

            trigger OnLookup()
            var
                GenJournalBatchPage: Page "251";
                GenJournalBatch: Record "232";
            begin

                //MGTS10.00.001; 001; mhh; begin
                CLEAR(GenJournalBatchPage);
                GenJournalBatchPage.LOOKUPMODE(TRUE);
                GenJournalBatchPage.SetProvBatchChoice(TRUE);
                IF GenJournalBatchPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                    GenJournalBatchPage.GETRECORD(GenJournalBatch);
                    IF "Provision Journal Batch" = '' THEN
                        "Provision Journal Batch" := GenJournalBatch.Name
                    ELSE
                        "Provision Journal Batch" := STRSUBSTNO(Text50000, "Provision Journal Batch", GenJournalBatch.Name);
                END;
                //MGTS10.00.001; 001; mhh; end
            end;
        }
    }

    var
        Text50000: Label '%1|%2';
}

