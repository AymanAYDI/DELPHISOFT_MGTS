report 50046 "DEL Init Order API Rec. Track."
{
    Caption = 'Init Order API Record Tracking';
    ProcessingOnly = true;

    dataset
    {
        dataitem("DEL Deal"; "DEL Deal")
        {
            DataItemTableView = SORTING(ID)
                                WHERE(Status = FILTER("In order" | "In progress"));
            RequestFilterFields = ID;

            trigger OnAfterGetRecord()
            var
                APIOrdersTrackRecordsMgt: Codeunit "DEL API Orders Track Rec. Mgt.";
            begin
                APIOrdersTrackRecordsMgt.UpdateOrderAPIRecordTracking(ID);
            end;

            trigger OnPostDataItem()
            begin
                Win.CLOSE();
                MESSAGE(FinshMsg);
            end;

            trigger OnPreDataItem()
            begin
                Win.OPEN(ProgressMsg);
            end;
        }
    }



    var
        ProgressMsg: Label 'Initialization in progress ...';
        Win: Dialog;
        FinshMsg: Label 'Initialization Finished';
}

