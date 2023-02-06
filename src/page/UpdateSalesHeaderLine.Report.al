report 50068 "Update Sales Header/Line"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table36)
        {
            DataItemTableView = SORTING (Document Type, No.)
                                WHERE (Document Type=CONST(Order));
            RequestFilterFields = "No.";
            dataitem(DataItem1000000001; Table37)
            {
                DataItemLink = Document Type=FIELD(Document Type),
                               Document No.=FIELD(No.);

                trigger OnAfterGetRecord()
                begin
                    "Sales Line".SetHideValidationDialog(TRUE);
                    "Sales Line".SuspendStatusCheck(TRUE);
                    "Sales Line"."VAT Bus. Posting Group" := 'TVASU0%';
                    "Sales Line".VALIDATE("VAT Bus. Posting Group");
                    "Sales Line".MODIFY;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Sales Header"."VAT Bus. Posting Group" := 'TVASU0%';
                "Sales Header".MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                IF "Sales Header".GETFILTER("No.") = '' THEN
                  EXIT;
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
}

