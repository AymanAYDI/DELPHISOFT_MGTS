pageextension 50000 "DEL GeneralJournalBatches" extends "General Journal Batches" //251
{

    trigger OnOpenPage()
    begin

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

        ProvBatchChoice := NewProvBatchChoice;
    end;
}

