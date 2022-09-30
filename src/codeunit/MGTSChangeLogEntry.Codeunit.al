codeunit 50048 "MGTS Change Log Entry"
{
    // Mgts10.00.01.01 | 23.01.2020 | User Tracking Management


    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabaseInsert', '', false, false)]
    local procedure Loginsertion(RecRef: RecordRef)
    var
        MGTSChangeLogEntry: Record "50076";
        ChangeType: Option Insertion,Modification,Deletion;
    begin
        //IF NOT (USERID IN ['NGTSDOMN\ABAUDY','NGTSDOMN\ACANNEBOTIN']) THEN
        EXIT;
        MGTSChangeLogEntry.InsertLogEntry(USERID, RecRef.NUMBER, ChangeType::Insertion, FORMAT(RecRef.RECORDID));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabaseModify', '', false, false)]
    local procedure LogModification(RecRef: RecordRef)
    var
        MGTSChangeLogEntry: Record "50076";
        ChangeType: Option Insertion,Modification,Deletion;
    begin
        //IF NOT (USERID IN ['NGTSDOMN\ABAUDY','NGTSDOMN\ACANNEBOTIN']) THEN
        EXIT;
        MGTSChangeLogEntry.InsertLogEntry(USERID, RecRef.NUMBER, ChangeType::Modification, FORMAT(RecRef.RECORDID));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabaseDelete', '', false, false)]
    local procedure LogDeletion(RecRef: RecordRef)
    var
        MGTSChangeLogEntry: Record "50076";
        ChangeType: Option Insertion,Modification,Deletion;
    begin
        //IF NOT (USERID IN ['NGTSDOMN\ABAUDY','NGTSDOMN\ACANNEBOTIN']) THEN
        EXIT;
        MGTSChangeLogEntry.InsertLogEntry(USERID, RecRef.NUMBER, ChangeType::Deletion, FORMAT(RecRef.RECORDID));
    end;

    [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnGlobalRename', '', false, false)]
    local procedure LogRename(RecRef: RecordRef; xRecRef: RecordRef)
    var
        MGTSChangeLogEntry: Record "50076";
        ChangeType: Option Insertion,Modification,Deletion;
    begin
        //IF NOT (USERID IN ['NGTSDOMN\ABAUDY','NGTSDOMN\ACANNEBOTIN']) THEN
        EXIT;
        MGTSChangeLogEntry.InsertLogEntry(USERID, RecRef.NUMBER, ChangeType::Modification, FORMAT(RecRef.RECORDID));
    end;
}

