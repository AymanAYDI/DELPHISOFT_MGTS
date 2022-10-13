report 50024 "Update vendor status"
{
    Caption = 'Update vendor status';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1100113000; Table23)
        {

            trigger OnAfterGetRecord()
            begin
                /*
                IF  "Revision Date quality"<TODAY THEN
                BEGIN
                 "Quality status":="Quality status"::Inactif ;
                  Vendor."Qualified vendor":=FALSE;
                END;

                IF "Revision Date Soc"<TODAY THEN
                BEGIN
                "Social status":="Social status"::Inactif;
                Vendor."Qualified vendor":=FALSE;
                END;

                 IF "Revision Date env"<TODAY THEN
                 BEGIN
                 "Environmental status":="Environmental status"::Inactif;
                 Vendor."Qualified vendor":=FALSE;
                 END;
                */
                Vendor.Derogation := TRUE;
                MODIFY(TRUE);

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
        MESSAGE(Text0001);
    end;

    var
        Text0001: Label 'Upgrade Complete';
}

