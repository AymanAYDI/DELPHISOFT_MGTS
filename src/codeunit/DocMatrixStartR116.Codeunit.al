codeunit 50017 "DocMatrix Start R116"
{
    // DEL/PD/20190227/LOP003 : object created
    //                          This codeunit must be added in the Job Queue Entries in order to automatically run the Report R116 "Statement"
    //                          The report for lUsage::"C.Statement" (T77 "Report Selection") at the time of deployment was set to R116 (not R1316)


    trigger OnRun()
    var
        lUsage: Option ,"S.Order","S.Invoice","S.Cr.Memo",,,"P.Order","P.Invoice",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"C.Statement";
    begin
        cuDocumentMatrixMgt.ProcessDocumentMatrixAutomatic(lUsage::"C.Statement");
    end;

    var
        cuDocumentMatrixMgt: Codeunit "50015";
}

