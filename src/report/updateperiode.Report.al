report 50029 "update periode"
{
    DefaultLayout = RDLC;
    RDLCLayout = './updateperiode.rdlc';

    dataset
    {
        dataitem(DataItem1100113000; Table18)
        {

            trigger OnAfterGetRecord()
            begin
                IF "Date de fin SSA" <> 0D THEN
                    "Period of denunciation" := CALCDATE('<-25M>', "Date de fin SSA")
                ELSE
                    "Period of denunciation" := 0D;

                MODIFY;
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

