codeunit 50055 "DEL Record Modification Track"
{


    Permissions = TableData "Cust. Ledger Entry" = rimd,
                  TableData "Reminder/Fin. Charge Entry" = rimd;



    var
        SynchroniseState: Option Insert,Modify,Delete,Rename;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"GlobalTriggerManagement", 'OnAfterGetDatabaseTableTriggerSetup', '', false, false)]

    local procedure GetDatabaseTableTriggerSetup(TableId: Integer; var OnDatabaseInsert: Boolean; var OnDatabaseModify: Boolean; var OnDatabaseDelete: Boolean; var OnDatabaseRename: Boolean)
    begin
        IF COMPANYNAME = '' THEN
            EXIT;

        IF NOT GetSynchronizationActivated() THEN
            EXIT;

        IF IsSynchronizedRecord(TableId) THEN BEGIN
            OnDatabaseInsert := TRUE;
            OnDatabaseModify := TRUE;
            OnDatabaseDelete := TRUE;
            OnDatabaseRename := TRUE;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"GlobalTriggerManagement", 'OnAfterOnDatabaseInsert', '', false, false)]

    local procedure OnDatabaseInsert(RecRef: RecordRef)
    var
        TimeStamp: DateTime;
    begin
        IF NOT GetSynchronizationActivated() THEN
            EXIT;

        TimeStamp := CURRENTDATETIME;
        InsertUpdateSynchronizedRecord(RecRef, TimeStamp, SynchroniseState::Insert);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"GlobalTriggerManagement", 'OnAfterOnDatabaseModify', '', false, false)]

    local procedure OnDatabaseModify(RecRef: RecordRef)
    var
        TimeStamp: DateTime;
    begin
        IF NOT GetSynchronizationActivated() THEN
            EXIT;

        TimeStamp := CURRENTDATETIME;
        InsertUpdateSynchronizedRecord(RecRef, TimeStamp, SynchroniseState::Modify);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"GlobalTriggerManagement", 'OnAfterOnDatabaseDelete', '', false, false)]

    local procedure OnDatabaseDelete(RecRef: RecordRef)
    var
        TimeStamp: DateTime;
    begin
        IF NOT GetSynchronizationActivated() THEN
            EXIT;

        TimeStamp := CURRENTDATETIME;
        InsertUpdateSynchronizedRecord(RecRef, TimeStamp, SynchroniseState::Delete);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"GlobalTriggerManagement", 'OnAfterOnDatabaseRename', '', false, false)]

    local procedure OnDatabaseRename(RecRef: RecordRef; xRecRef: RecordRef)
    var
        TimeStamp: DateTime;
    begin
        IF NOT GetSynchronizationActivated() THEN
            EXIT;

        TimeStamp := CURRENTDATETIME;
        InsertUpdateSynchronizedRecord(RecRef, TimeStamp, SynchroniseState::Rename);
    end;

    local procedure InsertUpdateSynchronizedRecord(RecRef: RecordRef; LastModified: DateTime; CurrentSynchroniseState: Option Insert,Modify,Delete,Rename)
    var
        RecordModificationTracking: Record "DEL Record Modifs. Tracking";
        PurchasePrice: Record "Purchase Price";

        SalesPrice: Record "Sales Price";
    begin
        IF IsSynchronizedRecord(RecRef.NUMBER) THEN BEGIN

            IF (RecRef.NUMBER = DATABASE::"Sales Price") THEN BEGIN
                RecRef.SETTABLE(SalesPrice);
                IF (SalesPrice."Ending Date" < 20211231D) AND (SalesPrice."Ending Date" <> 0D) THEN
                    EXIT
            END;
            //123121D

            IF (RecRef.NUMBER = DATABASE::"Purchase Price") THEN BEGIN
                RecRef.SETTABLE(PurchasePrice);
                IF (PurchasePrice."Ending Date" < 20211231D) AND (PurchasePrice."Ending Date" <> 0D) THEN
                    EXIT
            END;

            IF NOT RecordModificationTracking.GET(RecRef.RECORDID) THEN BEGIN
                RecordModificationTracking.INIT();
                RecordModificationTracking."Table ID" := RecRef.NUMBER;
                RecordModificationTracking."Record ID" := RecRef.RECORDID;
                RecordModificationTracking."Record ID Text" := FORMAT(RecRef.RECORDID);
                IF RecordModificationTracking.INSERT() THEN;
            END;
            RecordModificationTracking."Last Date Modified" := LastModified;
            RecordModificationTracking."Last Synchronized state" := CurrentSynchroniseState;
            RecordModificationTracking.Deleted := (CurrentSynchroniseState = CurrentSynchroniseState::Delete);
            IF RecordModificationTracking.MODIFY() THEN;
        END;
    end;

    local procedure GetSynchronizationActivated(): Boolean
    var
        CompanyInformation: Record "Company Information";
    begin
        IF NOT CompanyInformation.GET() THEN
            CompanyInformation.INIT();
        EXIT(CompanyInformation."DEL Enable WS Interface");
    end;


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

