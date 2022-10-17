report 50046 "Init Order API Record Tracking"
{
    // Mgts10.00.01.00 | 11.01.2020 | Order API Management

    Caption = 'Init Order API Record Tracking';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem100000000; "DEL Deal")
        {
            DataItemTableView = SORTING(ID)
                                WHERE(Status = FILTER('In order' | 'In progress'));
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

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ProgressMsg: Label 'Initialization in progress ...';
        Win: Dialog;
        FinshMsg: Label 'Initialization Finished';
}

