tableextension 50049 "DEL SalesReceivablesSetup" extends "Sales & Receivables Setup"
{
    fields
    {


        field(50000; "DEL PDF Registration Customer Path"; Text[250])
        {
            Caption = 'PDF Registration Customer Path';
            Description = 'MGTS:EDD001.01';
        }
        field(50001; "DEL PDF Registration Sales C.Memo"; Text[250])
        {
            Caption = 'Sales C. Memo PDF Registration Customer Path';
            Description = 'MGTS:EDD001.02';
        }
        field(50002; "DEL PDF Registration PostedSalesIn"; Text[250])
        {
            Caption = 'Posted Sales Inv. PDF Registration Customer Path';
            Description = 'MGTS:EDD001.02';
        }
        field(50003; "DEL Kiriba SFTP Server Address"; Text[100])
        {
            Caption = 'Kiriba FTP Server Address';
            DataClassification = ToBeClassified;
            Description = 'Kiriba';
        }
        field(50004; "DEL Kiriba SFTP Server Login"; Text[30])
        {
            Caption = 'Kiriba FTP Server Login';
            DataClassification = ToBeClassified;
            Description = 'Kiriba';
        }
        field(50005; "DEL Kiriba SFTP Server Password"; Text[100])
        {
            Caption = 'Kiriba FTP Server Password';
            DataClassification = ToBeClassified;
            Description = 'Kiriba';
        }
        field(50006; "DEL Kiriba Local File Path"; Text[100])
        {
            Caption = 'Kiriba Local File Path';
            DataClassification = ToBeClassified;
            Description = 'Kiriba';
        }
        field(50007; "DEL Kiriba Archive File Path"; Text[100])
        {
            Caption = 'Kiriba Archive File Path';
            DataClassification = ToBeClassified;
            Description = 'Kiriba';
        }
        field(50008; "DEL Host Serveur SFTP Kiriba"; Text[30])
        {
            Description = 'Kiriba';
        }
        field(50009; "DEL Port Serveur SFTP Kiriba"; Integer)
        {
            Description = 'Kiriba';
        }
        field(50010; "DEL Def. Req. Worksheet Template"; Code[20])
        {
            Caption = 'Default Req. Worksheet Template';
            Description = 'MGTS10.027';
            TableRelation = "Req. Wksh. Template";
        }
        field(50011; "DEL Def. Req. Worksheet Batch"; Code[20])
        {
            Caption = 'Def. Req. Worksheet Batch';
            Description = 'MGTS10.027';
            TableRelation = "Requisition Wksh. Name".Name WHERE("Worksheet Template Name" = FIELD("DEL Def. Req. Worksheet Template"));
        }
    }
}

