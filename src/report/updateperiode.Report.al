report 50029 "DEL update periode"
{
    DefaultLayout = RDLC;
    RDLCLayout = './updateperiode.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {

            trigger OnAfterGetRecord()
            begin
                IF "DEL Date de fin SSA" <> 0D THEN
                    "DEL Period of denunciation" := CALCDATE('<-25M>', "DEL Date de fin SSA")
                ELSE
                    "DEL Period of denunciation" := 0D;

                MODIFY;
            end;
        }
    }


}

