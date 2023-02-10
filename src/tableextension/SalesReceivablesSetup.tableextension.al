tableextension 50049 "DEL SalesReceivablesSetup" extends "Sales & Receivables Setup"
{
    fields
    {


        field(50000; "DEL PDF Reg. Cust. Path"; Text[250])
        {
            Caption = 'PDF Registration Customer Path';
            DataClassification = CustomerContent;
        }
        field(50001; "DEL PDF Reg. Sales C.Memo"; Text[250])
        {
            Caption = 'Sales C. Memo PDF Registration Customer Path';
            DataClassification = CustomerContent;
        }
        field(50002; "DEL PDF Reg. PostedSalesIn"; Text[250])
        {
            Caption = 'Posted Sales Inv. PDF Registration Customer Path';
            DataClassification = CustomerContent;
        }
        field(50003; "DEL Kiriba SFTP Server Address"; Text[100])
        {
            Caption = 'Kiriba FTP Server Address';
            DataClassification = CustomerContent;
        }
        field(50004; "DEL Kiriba SFTP Server Login"; Text[30])
        {
            Caption = 'Kiriba FTP Server Login';
            DataClassification = CustomerContent;
        }
        field(50005; "DEL KiribaSFTPServerPassword"; Text[100])
        {
            Caption = 'Kiriba FTP Server Password';
            DataClassification = CustomerContent;
        }
        field(50006; "DEL Kiriba Local File Path"; Text[100])
        {
            Caption = 'Kiriba Local File Path';
            DataClassification = CustomerContent;
        }
        field(50007; "DEL Kiriba Archive File Path"; Text[100])
        {
            Caption = 'Kiriba Archive File Path';
            DataClassification = CustomerContent;
        }
        field(50008; "DEL Host Serveur SFTP Kiriba"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50009; "DEL Port Serveur SFTP Kiriba"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50010; "DEL Def.Req.Worksheet Temp"; Code[20])
        {
            Caption = 'Default Req. Worksheet Template';
            DataClassification = CustomerContent;
            TableRelation = "Req. Wksh. Template";
        }
        field(50011; "DEL Def. Req. Worksheet Batch"; Code[20])
        {
            Caption = 'Def. Req. Worksheet Batch';
            DataClassification = CustomerContent;
            TableRelation = "Requisition Wksh. Name".Name WHERE("Worksheet Template Name" = FIELD("DEL Def.Req.Worksheet Temp"));
        }
    }
}

