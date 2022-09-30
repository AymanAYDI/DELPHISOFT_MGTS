codeunit 50054 "Job Queue Entry Notification"
{
    // +--------------------------------------------------------------------+
    // | D365FM14.00.00.11      | 30.11.21 | Job Queue Notification
    // |                                      Create codeunit
    // +--------------------------------------------------------------------+


    trigger OnRun()
    var
        JobQueueEntry: Record "472";
    begin
        IF NOT JobQueueEntry.ISEMPTY THEN BEGIN
            JobQueueEntry.FINDSET;
            REPEAT
                CheckNotificationToSend(JobQueueEntry);
            UNTIL JobQueueEntry.NEXT = 0;
        END;
    end;

    var
        Company: Record "2000000006";

    local procedure CheckNotificationToSend(RecLJobQueueEntry: Record "472"): Boolean
    begin
        IF (RecLJobQueueEntry."Notify By Email Inactive" = FALSE) AND
           (RecLJobQueueEntry."Notify By Email On Hold" = FALSE) AND
           (RecLJobQueueEntry."Notify By Email On Error" = FALSE)
        THEN
            EXIT(FALSE);

        RecLJobQueueEntry.TESTFIELD(RecLJobQueueEntry."Notification Recipient Email");

        IF RecLJobQueueEntry."Notify By Email On Hold" THEN BEGIN
            IF (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::"On Hold") THEN
                SendNotification(RecLJobQueueEntry."Mail Template On Hold", RecLJobQueueEntry.ID, RecLJobQueueEntry."Notification Recipient Email");
        END;

        IF RecLJobQueueEntry."Notify By Email On Error" THEN BEGIN
            IF (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::Error) THEN
                SendNotification(RecLJobQueueEntry."Mail Template On Error", RecLJobQueueEntry.ID, RecLJobQueueEntry."Notification Recipient Email");
        END;

        IF RecLJobQueueEntry."Notify By Email Inactive" THEN BEGIN
            IF (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::"In Process") OR
              (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::Ready) OR
              (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::"5")
              THEN
                IF ((CURRENTDATETIME - RecLJobQueueEntry."Earliest Start Date/Time") > 7200000) THEN // 7200000 Milliseconds = 2 Hours
                    SendNotification(RecLJobQueueEntry."Mail Template Inactive", RecLJobQueueEntry.ID, RecLJobQueueEntry."Notification Recipient Email");
        END;
    end;

    local procedure SendNotification(MailTemplate: Text[250]; JobQueueID: Guid; RecipientEmail: Text[250])
    var
        EmailSend: Codeunit "50053";
        RecLJobQueueEntry: Record "472";
        recRef: RecordRef;
        EmailObject: Text;
        Sender: Text;
    begin

        CLEAR(EmailSend);

        RecLJobQueueEntry.GET(JobQueueID);
        recRef.GETTABLE(RecLJobQueueEntry);

        EmailSend.SetRecRef(recRef);
        EmailSend.InitValue(EmailObject, Sender, RecipientEmail, 0, '', '', 0, 0, 'FctLaunchExport');
        EmailSend.SetParam(MailTemplate, FALSE, FALSE);
        EmailSend.SetTemplateMailString(MailTemplate);
        EmailSend.RUN();
    end;
}

