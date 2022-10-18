codeunit 50054 "DEL Job Queue Entry Not."
{



    trigger OnRun()
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        IF NOT JobQueueEntry.ISEMPTY THEN BEGIN
            JobQueueEntry.FINDSET();
            REPEAT
                CheckNotificationToSend(JobQueueEntry);
            UNTIL JobQueueEntry.NEXT() = 0;
        END;
    end;


    local procedure CheckNotificationToSend(RecLJobQueueEntry: Record "Job Queue Entry"): Boolean
    begin
        IF (RecLJobQueueEntry."DEL Notify By Email Inactive" = FALSE) AND
           (RecLJobQueueEntry."DEL Notify By Email On Hold" = FALSE) AND
           (RecLJobQueueEntry."DEL Notify By Email On Error" = FALSE)
        THEN
            EXIT(FALSE);

        RecLJobQueueEntry.TESTFIELD(RecLJobQueueEntry."DEL Notif. Recipient Email");

        IF RecLJobQueueEntry."DEL Notify By Email On Hold" THEN
            IF (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::"On Hold") THEN
                SendNotification(RecLJobQueueEntry."DEL Mail Template On Hold", RecLJobQueueEntry.ID, RecLJobQueueEntry."DEL Notif. Recipient Email");

        IF RecLJobQueueEntry."DEL Notify By Email On Error" THEN
            IF (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::Error) THEN
                SendNotification(RecLJobQueueEntry."DEL Mail Template On Error", RecLJobQueueEntry.ID, RecLJobQueueEntry."DEL Notif. Recipient Email");

        IF RecLJobQueueEntry."DEL Notify By Email Inactive" THEN
            IF (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::"In Process") OR
              (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::Ready) OR
              //TODO:à vérifier (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::"5")
              (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::"On Hold with Inactivity Timeout")
              THEN
                IF ((CURRENTDATETIME - RecLJobQueueEntry."Earliest Start Date/Time") > 7200000) THEN
                    SendNotification(RecLJobQueueEntry."DEL Mail Template Inactive", RecLJobQueueEntry.ID, RecLJobQueueEntry."DEL Notif. Recipient Email");
    end;

    local procedure SendNotification(MailTemplate: Text[250]; JobQueueID: Guid; RecipientEmail: Text[250])
    var
        RecLJobQueueEntry: Record "Job Queue Entry";
        EmailSend: Codeunit "DEL D365FM PDF Email Send";

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

