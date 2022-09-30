codeunit 50047 "Job Queue Entry To Ready"
{
    // //>>MGTS10.00.01.01
    // 14/01/10 : Restart Job Queue Entries on error

    TableNo = 472;

    trigger OnRun()
    var
        JobQueueEntry: Record "472";
    begin
        IF NOT JobQueueEntry.ISEMPTY THEN BEGIN
            JobQueueEntry.FINDSET;
            REPEAT
                IF IsJobToRestart(JobQueueEntry) THEN BEGIN
                    JobQueueEntry.SetStatus(JobQueueEntry.Status::"On Hold");
                    COMMIT;
                    JobQueueEntry.SetStatus(JobQueueEntry.Status::Ready);
                END;
            UNTIL JobQueueEntry.NEXT = 0;
        END;
    end;

    local procedure IsJobToRestart(RecLJobQueueEntry: Record "472"): Boolean
    begin
        IF (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::Error) THEN
            EXIT(TRUE);

        RecLJobQueueEntry.CALCFIELDS(Scheduled);
        IF (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::Ready) AND NOT RecLJobQueueEntry.Scheduled THEN
            EXIT(TRUE);

        IF (RecLJobQueueEntry.Status = RecLJobQueueEntry.Status::"In Process") AND ((CURRENTDATETIME - RecLJobQueueEntry."Earliest Start Date/Time") > 720000) THEN
            EXIT(TRUE);

        EXIT(FALSE);
    end;
}

