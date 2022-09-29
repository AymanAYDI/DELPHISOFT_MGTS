tableextension 50046 "DEL GeneralLedgerSetup" extends "General Ledger Setup"
{
    fields
    {

        //Unsupported feature: Property Modification (InitValue) on ""Amount Rounding Precision"(Field 73)".


        //Unsupported feature: Property Modification (InitValue) on ""Unit-Amount Rounding Precision"(Field 74)".


        field(50000; "DEL Provision Source Code"; Code[20])
        {
            Caption = 'Provision Source Code';
            TableRelation = "Source Code".Code;
        }
        field(50001; "DEL Provision Journal Batch"; Text[250])
        {
            Caption = 'Provision Journal Batch';

            trigger OnLookup()
            var
                GenJournalBatch: Record "Gen. Journal Batch";
                GenJournalBatchPage: Page "General Journal Batches";
            begin

                //MGTS10.00.001; 001; mhh; begin
                CLEAR(GenJournalBatchPage);
                GenJournalBatchPage.LOOKUPMODE(TRUE);
                GenJournalBatchPage.SetProvBatchChoice(TRUE);
                IF GenJournalBatchPage.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                    GenJournalBatchPage.GETRECORD(GenJournalBatch);
                    IF "DEL Provision Journal Batch" = '' THEN
                        "DEL Provision Journal Batch" := GenJournalBatch.Name
                    ELSE
                        "DEL Provision Journal Batch" := STRSUBSTNO(Text50000, "DEL Provision Journal Batch", GenJournalBatch.Name);
                END;
                //MGTS10.00.001; 001; mhh; end
            end;
        }
    }

    var
        Text50000: Label '%1|%2';
}

