codeunit 50017 "DEL DocMatrix Start R116"
{
    trigger OnRun()
    var
        lUsage: Option ,"S.Order","S.Invoice","S.Cr.Memo",,,"P.Order","P.Invoice",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"C.Statement";
    begin
        cuDocumentMatrixMgt.ProcessDocumentMatrixAutomatic(lUsage::"C.Statement");
    end;

    var
        cuDocumentMatrixMgt: Codeunit "DEL DocMatrix Management";
}

