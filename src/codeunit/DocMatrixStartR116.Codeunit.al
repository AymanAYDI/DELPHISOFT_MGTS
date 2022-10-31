codeunit 50017 "DEL DocMatrix Start R116"
{
    trigger OnRun()
    var
        lUsage: Enum "DEL Usage DocMatrix Selection";
    begin
        cuDocumentMatrixMgt.ProcessDocumentMatrixAutomatic(lUsage::"C.Statement");
    end;

    var
        cuDocumentMatrixMgt: Codeunit "DEL DocMatrix Management";
}

