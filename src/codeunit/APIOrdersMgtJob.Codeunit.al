codeunit 50046 "DEL API Orders  Mgt.Job"
{


    TableNo = "Job Queue Entry";

    trigger OnRun()
    begin
        APIOrdersMgt.RUN();
    end;

    var
        APIOrdersMgt: Codeunit "DEL API Orders  Mgt.";
}

