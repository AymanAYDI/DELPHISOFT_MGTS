report 50024 "DEL Update vendor status"
{
    Caption = 'Update vendor status';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; Vendor)
        {

            trigger OnAfterGetRecord()
            begin

                Vendor."DEL Derogation" := TRUE;
                MODIFY(TRUE);

            end;
        }
    }


    trigger OnPostReport()
    begin
        MESSAGE(Text0001);
    end;

    var
        Text0001: Label 'Upgrade Complete';
}

