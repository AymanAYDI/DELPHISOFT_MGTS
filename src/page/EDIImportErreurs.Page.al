//TODO
// page 50144 "DEL EDI Import Erreurs"
// {


//     Caption = 'EDI Import Errors';
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     PageType = List;
//     ShowFilter = false;
//     SourceTable = Table5327322;
//     SourceTableView = SORTING("Entry No.")
//                       ORDER(Ascending)
//                       WHERE(Status = CONST(Failed),
//                             "Processing Type"=FILTER("<>Test Convert"));

//     layout
//     {
//         area(content)
//         {
//             repeater(Group)
//             {
//                 field("Ctrl Status Image"; "Status Image")
//                 {
//                     Editable = false;
//                 }
//                 field("Ctrl Status"; Status)
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Ctrl Entry No"; "Entry No.")
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Ctrl Processing Type"; "Processing Type")
//                 {
//                     Editable = false;
//                 }
//                 field("Ctrl Description"; GetDescription())
//                 {
//                     Caption = 'Description';
//                 }
//                 field("Ctrl Creation Date Time"; "Creation Date/Time")
//                 {
//                     Editable = false;
//                 }
//                 field("Ctrl Processing Date Time"; "Processing Date/Time")
//                 {
//                     Editable = false;
//                 }
//                 field("Ctrl Processing End Date Time"; "Processing End Date/Time")
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Ctrl Processing Duration"; "Processing Duration")
//                 {
//                     Editable = false;
//                 }
//                 field("Ctrl Debug Count"; "Debug Count")
//                 {
//                     Visible = false;
//                 }
//                 field("Ctrl Hints Count"; "Hints Count")
//                 {
//                     Visible = false;
//                 }
//                 field("Ctrl Information Count"; "Information Count")
//                 {
//                 }
//                 field("Ctrl Warning Count"; "Warning Count")
//                 {
//                 }
//                 field("Ctrl Error Count"; "Error Count")
//                 {
//                 }
//                 field("Ctrl First Error Text"; "First Error Text")
//                 {
//                 }
//                 field("Ctrl Project Code"; "Project Code")
//                 {
//                     Visible = true;
//                 }
//                 field("Ctrl Format Code"; "Format Code")
//                 {
//                     Visible = true;
//                 }
//                 field("Ctrl Mapping Code"; "Mapping Code")
//                 {
//                     Visible = true;
//                 }
//                 field("Ctrl Mapping Version"; "Mapping Version")
//                 {
//                     Visible = false;
//                 }
//                 field("Ctrl Mapping Line No"; "Mapping Line No.")
//                 {
//                     Visible = false;
//                 }
//                 field("Ctrl Created by User ID"; "Created by User ID")
//                 {
//                     Visible = false;
//                 }
//                 field("Ctrl Processing User ID"; "Processing User ID")
//                 {
//                     Visible = false;
//                 }
//                 field("Ctrl User Transaction ID"; "User Transaction ID")
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Ctrl Business Transaction Entry"; "Business Transaction Entry No.")
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Ctrl Process Synchronously"; "Process Synchronously")
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//                 field("Ctrl Run with Priority"; "Run with Priority")
//                 {
//                     Editable = false;
//                     Visible = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action("Action Process")
//             {
//                 Caption = '&Process';
//                 Enabled = IsOpen;
//                 Image = Start;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;

//                 trigger OnAction()
//                 var
//                     EDIIntegration: Codeunit "5327311";
//                     EDIProcessing: Codeunit "5327322";
//                     ProcessingQueue: Record "5327322";
//                 begin
//                     EDIIntegration.BEGIN_USER_TRANSACTION(FORMAT("Processing Type"));
//                     ProcessingQueue.GET("Entry No.");
//                     EDIProcessing.Process(ProcessingQueue);
//                     UpdateIfTemp(ProcessingQueue);
//                     EDIIntegration.END_USER_TRANSACTION(TRUE, FALSE);
//                 end;
//             }
//             action("Action Test")
//             {
//                 Caption = '&Test Convert';
//                 Image = CheckRulesSyntax;

//                 trigger OnAction()
//                 begin
//                     DebugMapping();
//                 end;
//             }
//             group("Action Grp Change Status")
//             {
//                 Caption = '&Change Status';
//                 action("Action Hide")
//                 {
//                     Caption = 'Hide errors as solved';
//                     Enabled = IsProcessingError;
//                     Image = Status;

//                     trigger OnAction()
//                     var
//                         ProcessingQueue: Record "5327322";
//                     begin
//                         CurrPage.SETSELECTIONFILTER(ProcessingQueue);

//                         IF ProcessingQueue.FINDSET() THEN REPEAT
//                           ProcessingQueue.HideFailure();
//                           UpdateIfTemp(ProcessingQueue);
//                         UNTIL ProcessingQueue.NEXT() = 0;
//                     end;
//                 }
//                 action("Action Change Status")
//                 {
//                     Caption = 'Change status to &Wait for user';
//                     Image = Status;

//                     trigger OnAction()
//                     var
//                         ProcessingQueue: Record "5327322";
//                     begin
//                         CurrPage.SETSELECTIONFILTER(ProcessingQueue);

//                         IF ProcessingQueue.FINDSET() THEN REPEAT
//                           ProcessingQueue.WaitForUser();
//                           UpdateIfTemp(ProcessingQueue);
//                         UNTIL ProcessingQueue.NEXT() = 0;
//                     end;
//                 }
//                 action("Action Do Not Execute")
//                 {
//                     Caption = 'Set status to &do not execute';
//                     Image = Status;

//                     trigger OnAction()
//                     var
//                         ProcessingQueue: Record "5327322";
//                     begin
//                         CurrPage.SETSELECTIONFILTER(ProcessingQueue);

//                         IF ProcessingQueue.FINDSET() THEN REPEAT
//                           ProcessingQueue.SetDoNotExecute();
//                           UpdateIfTemp(ProcessingQueue);
//                         UNTIL ProcessingQueue.NEXT() = 0;
//                     end;
//                 }
//                 action("Action Use Newer Version")
//                 {
//                     Caption = 'Use &newer mapping version';
//                     Image = Reuse;

//                     trigger OnAction()
//                     var
//                         ProcessingQueue: Record "5327322";
//                     begin
//                         ProcessingQueue.GET("Entry No.");
//                         ProcessingQueue.UseNewMappingVersion();

//                         IF NOT GET("Entry No.") THEN BEGIN
//                           TRANSFERFIELDS(ProcessingQueue, TRUE);
//                           INSERT;
//                         END;
//                     end;
//                 }
//                 separator()
//                 {
//                 }
//                 action("Action Reset Process")
//                 {
//                     Caption = 'Reset status && &Process';

//                     trigger OnAction()
//                     var
//                         ProcessingQueue: Record "5327322";
//                         EDIIntegration: Codeunit "5327311";
//                         EDIProcessing: Codeunit "5327322";
//                     begin
//                         CurrPage.SETSELECTIONFILTER(ProcessingQueue);

//                         EDIIntegration.BEGIN_USER_TRANSACTION(FORMAT("Processing Type"));

//                         IF ProcessingQueue.FINDSET THEN REPEAT
//                           ProcessingQueue.ResetStatus();
//                           EDIProcessing.Process(ProcessingQueue);
//                           UpdateIfTemp(ProcessingQueue);
//                         UNTIL ProcessingQueue.NEXT = 0;

//                         EDIIntegration.END_USER_TRANSACTION(TRUE, FALSE);
//                         SETRANGE(Status);
//                     end;
//                 }
//                 action("Action Reset Status")
//                 {
//                     Caption = '&Reset status';
//                     Enabled = IsProcessingError;
//                     Image = ReOpen;
//                     Promoted = true;
//                     PromotedCategory = Process;

//                     trigger OnAction()
//                     var
//                         ProcessingQueue: Record "5327322";
//                     begin
//                         CurrPage.SETSELECTIONFILTER(ProcessingQueue);

//                         IF ProcessingQueue.FINDSET() THEN REPEAT
//                           ProcessingQueue.ResetStatus();
//                           UpdateIfTemp(ProcessingQueue);
//                         UNTIL ProcessingQueue.NEXT() = 0;

//                         SETRANGE(Status);
//                     end;
//                 }
//             }
//         }
//         area(navigation)
//         {
//             action("Action Transmission")
//             {
//                 Caption = '&Transmission';
//                 Image = List;
//                 RunObject = Page 5327367;
//                                 RunPageLink = Entry No.=FIELD(Transmission Entry No.);
//             }
//             action("Action Message")
//             {
//                 Caption = '&Message';
//                 Image = List;
//                 RunObject = Page 5327328;
//                                 RunPageLink = Entry No.=FIELD(Message Entry No.);
//             }
//             action("Action Documents")
//             {
//                 Caption = '&Documents';
//                 Image = List;
//                 RunObject = Page 5327378;
//                                 RunPageLink = Type=CONST(Processing Queue),
//                               Linked Entry No.=FIELD(Entry No.);
//             }
//             action("Action BT")
//             {
//                 Caption = '&Business Transaction';
//                 Image = List;

//                 trigger OnAction()
//                 var
//                     BusinessTransaction: Record "5327395";
//                 begin
//                     IF BusinessTransaction.GET("Business Transaction Entry No.") THEN BEGIN
//                       BusinessTransaction.SETRANGE("Process ID", BusinessTransaction."Process ID");
//                       PAGE.RUN(PAGE::"ANVEDI Business Trans. List", BusinessTransaction);
//                     END ELSE
//                       MESSAGE(NoBusinessTransactionMsg);
//                 end;
//             }
//         }
//         area(reporting)
//         {
//             action("Action Batch Process")
//             {
//                 Caption = 'EDI &Batch Processing';
//                 Image = "Report";
//                 RunObject = Report 5327310;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         IsProcessingError := Status IN [Status::Failed, Status::"Failed Hidden", Status::Processing]; //0000225 Added Status::Processing
//         IsOpen := Status IN [Status::Open];

//         SetImage;
//     end;

//     trigger OnOpenPage()
//     begin
//         IF GETFILTER("Processing Type") = '' THEN
//           SETFILTER("Processing Type", '<>%1', "Processing Type"::"Test Convert");

//         IF GETFILTER(Status) = '' THEN
//           SETFILTER(Status, '<>%1', Status::"Failed Hidden"); //0000087
//     end;

//     var
//         [InDataSet]
//         IsProcessingError: Boolean;
//         [InDataSet]
//         IsOpen: Boolean;
//         NoBusinessTransactionMsg: Label 'Cannot find business transaction. Either there is none assigned to this processing queue, or it was deleted.';

//     local procedure UpdateIfTemp(var ProcessingQueue: Record "5327322")
//     var
//         RRef: RecordRef;
//         BusinessTransactionMgmt: Codeunit "5327394";
//     begin
//         RRef.GETTABLE(Rec);
//         IF RRef.ISTEMPORARY THEN BEGIN
//           GET(ProcessingQueue."Entry No.");
//           TRANSFERFIELDS(ProcessingQueue);
//           IF MODIFY THEN ;
//           BusinessTransactionMgmt.UpdateStatus(ProcessingQueue);
//         END;
//     end;
// }

