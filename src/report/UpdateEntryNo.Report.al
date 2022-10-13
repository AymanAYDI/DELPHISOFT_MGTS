report 50066 "Update Entry No"
{
    // Mgts10.00.04.00      07.12.2021 : Create object

    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem100000000; Table7002)
        {
            DataItemTableView = SORTING (Starting Date, Ending Date)
                                ORDER(Ascending)
                                WHERE (Ending Date=FILTER(>01/11/22|''));

            trigger OnAfterGetRecord()
            begin
                "Entry No." := EntryNo;
                MODIFY;
                EntryNo += 1;
            end;

            trigger OnPreDataItem()
            begin
                EntryNo := 1;
                IF NOT CONFIRM('Sales Price : %1',FALSE,"Sales Price".COUNT) THEN ERROR ('');
            end;
        }
        dataitem(DataItem100000001;Table7012)
        {
            DataItemTableView = SORTING(Starting Date,Ending Date)
                                ORDER(Ascending)
                                WHERE(Ending Date=FILTER(>01/11/22|''));

            trigger OnAfterGetRecord()
            begin
                "Entry No." := EntryNo;
                MODIFY;
                EntryNo += 1;
            end;

            trigger OnPreDataItem()
            begin
                EntryNo := 1;
                IF NOT CONFIRM('Purchase Price : %1',FALSE,"Sales Price".COUNT) THEN ERROR ('');
            end;
        }
        dataitem(DataItem100000002;Table5717)
        {
            DataItemTableView = SORTING(Item No.,Variant Code,Unit of Measure,Cross-Reference Type,Cross-Reference Type No.,Cross-Reference No.)
                                ORDER(Ascending);

            trigger OnAfterGetRecord()
            begin
                "Entry No." :=EntryNo;
                MODIFY;
                EntryNo += 1;
            end;

            trigger OnPreDataItem()
            begin
                EntryNo := 1;
                IF NOT CONFIRM('Item Cross : %1',FALSE,"Sales Price".COUNT) THEN ERROR ('');
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

    trigger OnPostReport()
    begin
        MESSAGE('OK')
    end;

    var
        EntryNo: BigInteger;
}

