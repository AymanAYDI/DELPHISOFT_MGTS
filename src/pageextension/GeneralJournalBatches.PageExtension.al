pageextension 50000 "DEL GeneralJournalBatches" extends "General Journal Batches"
{

    trigger OnOpenPage()
    begin

        //MGTS10.00.001; 001; mhh; single
        IF NOT ProvBatchChoice THEN
            GenJnlManagement.OpenJnlBatch(Rec);

        ShowAllowPaymentExportForPaymentTemplate();
    end;

    var
        GenJnlManagement: Codeunit GenJnlManagement;
        IsPaymentTemplate: Boolean;
        ProvBatchChoice: Boolean;

    local procedure ShowAllowPaymentExportForPaymentTemplate()
    var
        GenJournalTemplate: Record "Gen. Journal Template";
    begin
        IF GenJournalTemplate.GET(Rec."Journal Template Name") THEN
            IsPaymentTemplate := GenJournalTemplate.Type = GenJournalTemplate.Type::Payments;
    end;


    procedure SetProvBatchChoice(NewProvBatchChoice: Boolean)
    begin

        //MGTS10.00.001; 001; mhh; entire function
        ProvBatchChoice := NewProvBatchChoice;
    end;
}

