codeunit 50055 "Record Modification Tracking"
{
    // MGTS10.034      07.12.2021 : Record Modification Tracking : Create object

    Permissions = TableData 21 = rimd,
                  TableData 300 = rimd;

    trigger OnRun()
    begin
    end;

    var
        SynchroniseState: Option Insert,Modify,Delete,Rename;

    [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterGetDatabaseTableTriggerSetup', '', false, false)]
    [Scope('Internal')]
    procedure GetDatabaseTableTriggerSetup(TableId: Integer; var OnDatabaseInsert: Boolean; var OnDatabaseModify: Boolean; var OnDatabaseDelete: Boolean; var OnDatabaseRename: Boolean)
    begin
        IF COMPANYNAME = '' THEN
            EXIT;

        IF NOT GetSynchronizationActivated THEN
            EXIT;

        IF IsSynchronizedRecord(TableId) THEN BEGIN
            OnDatabaseInsert := TRUE;
            OnDatabaseModify := TRUE;
            OnDatabaseDelete := TRUE;
            OnDatabaseRename := TRUE;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabaseInsert', '', false, false)]
    [Scope('Internal')]
    procedure OnDatabaseInsert(RecRef: RecordRef)
    var
        TimeStamp: DateTime;
    begin
        IF NOT GetSynchronizationActivated THEN
            EXIT;

        TimeStamp := CURRENTDATETIME;
        InsertUpdateSynchronizedRecord(RecRef, TimeStamp, SynchroniseState::Insert);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabaseModify', '', false, false)]
    [Scope('Internal')]
    procedure OnDatabaseModify(RecRef: RecordRef)
    var
        TimeStamp: DateTime;
    begin
        IF NOT GetSynchronizationActivated THEN
            EXIT;

        TimeStamp := CURRENTDATETIME;
        InsertUpdateSynchronizedRecord(RecRef, TimeStamp, SynchroniseState::Modify);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabaseDelete', '', false, false)]
    [Scope('Internal')]
    procedure OnDatabaseDelete(RecRef: RecordRef)
    var
        TimeStamp: DateTime;
    begin
        IF NOT GetSynchronizationActivated THEN
            EXIT;

        TimeStamp := CURRENTDATETIME;
        InsertUpdateSynchronizedRecord(RecRef, TimeStamp, SynchroniseState::Delete);
    end;

    [EventSubscriber(ObjectType::Codeunit, 1, 'OnAfterOnDatabaseRename', '', false, false)]
    [Scope('Internal')]
    procedure OnDatabaseRename(RecRef: RecordRef; xRecRef: RecordRef)
    var
        TimeStamp: DateTime;
    begin
        IF NOT GetSynchronizationActivated THEN
            EXIT;

        TimeStamp := CURRENTDATETIME;
        InsertUpdateSynchronizedRecord(RecRef, TimeStamp, SynchroniseState::Rename);
    end;

    local procedure InsertUpdateSynchronizedRecord(RecRef: RecordRef; LastModified: DateTime; CurrentSynchroniseState: Option Insert,Modify,Delete,Rename)
    var
        RecordModificationTracking: Record "50083";
        ContBusRel: Record "5054";
        SalesPrice: Record "7002";
        PurchasePrice: Record "7012";
    begin
        IF IsSynchronizedRecord(RecRef.NUMBER) THEN BEGIN

            IF (RecRef.NUMBER = DATABASE::"Sales Price") THEN BEGIN
                RecRef.SETTABLE(SalesPrice);
                IF (SalesPrice."Ending Date" < 123121D) AND (SalesPrice."Ending Date" <> 0D) THEN
                    EXIT
            END;

            IF (RecRef.NUMBER = DATABASE::"Purchase Price") THEN BEGIN
                RecRef.SETTABLE(PurchasePrice);
                IF (PurchasePrice."Ending Date" < 123121D) AND (PurchasePrice."Ending Date" <> 0D) THEN
                    EXIT
            END;

            IF NOT RecordModificationTracking.GET(RecRef.RECORDID) THEN BEGIN
                RecordModificationTracking.INIT;
                RecordModificationTracking."Table ID" := RecRef.NUMBER;
                RecordModificationTracking."Record ID" := RecRef.RECORDID;
                RecordModificationTracking."Record ID Text" := FORMAT(RecRef.RECORDID);
                IF RecordModificationTracking.INSERT THEN;
            END;
            RecordModificationTracking."Last Date Modified" := LastModified;
            RecordModificationTracking."Last Synchronized state" := CurrentSynchroniseState;
            RecordModificationTracking.Deleted := (CurrentSynchroniseState = CurrentSynchroniseState::Delete);
            IF RecordModificationTracking.MODIFY THEN;
        END;
    end;

    local procedure GetSynchronizationActivated(): Boolean
    var
        CompanyInformation: Record "79";
    begin
        IF NOT CompanyInformation.GET THEN
            CompanyInformation.INIT;
        EXIT(CompanyInformation."Enable WS Interface");
    end;

    [Scope('Internal')]
    procedure IsSynchronizedRecord(TableID: Integer): Boolean
    begin
        EXIT(TableID IN
          [
           DATABASE::"Sales Price",
           DATABASE::"Purchase Price",
           DATABASE::"Item Cross Reference"
          ]);
    end;
}

