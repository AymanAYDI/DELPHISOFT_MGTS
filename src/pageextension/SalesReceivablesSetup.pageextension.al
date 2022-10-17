pageextension 50042 "DEL SalesReceivablesSetup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter(General)
        {
            field("DEL Def. Req. Worksheet Template"; "Def. Req. Worksheet Template")
            {
            }
            field("DEL Def. Req. Worksheet Batch"; "Def. Req. Worksheet Batch")
            {
            }
        }
        addafter("Control 1140000")
        {
            field("DEL PDF Registration Customer Path"; "PDF Registration Customer Path")
            {

                trigger OnLookup(var Text: Text): Boolean
                var
                    FileManagement: Codeunit "419";
                    Cst001: Label 'PDF Registration Customer Path';
                    Cst002: Label 'MGTS PDF';
                begin
                    "PDF Registration Customer Path" := FileManagement.BrowseForFolderDialog(Cst001, Cst002, TRUE);
                end;
            }
            field("DEL PDF Registration Sales C.Memo"; "PDF Registration Sales C.Memo")
            {

                trigger OnLookup(var Text: Text): Boolean
                var
                    RecLFileManagement: Codeunit "419";
                    Cst001: Label 'Sales C. Memo PDF Registration Customer Path';
                    Cst002: Label 'MGTS PDF';
                begin
                    "PDF Registration Sales C.Memo" := RecLFileManagement.BrowseForFolderDialog(Cst001, Cst002, TRUE);
                end;
            }
            field("DEL PDF Registration PostedSalesIn"; "PDF Registration PostedSalesIn")
            {

                trigger OnLookup(var Text: Text): Boolean
                var
                    Cst001: Label 'Posted Sales Inv. PDF Registration Customer Path';
                    Cst002: Label 'MGTS PDF';
                    RecLFileManagement: Codeunit "419";
                begin
                    "PDF Registration Sales C.Memo" := RecLFileManagement.BrowseForFolderDialog(Cst001, Cst002, TRUE);
                end;
            }
            group("DEL Kiriba")
            {
                Caption = 'Kiriba';
                field("DEL Host Serveur SFTP Kiriba"; "Host Serveur SFTP Kiriba")
                {
                }
                field("DEL Port Serveur SFTP Kiriba"; "Port Serveur SFTP Kiriba")
                {
                }
                field("DEL Kiriba SFTP Server Address"; "Kiriba SFTP Server Address")
                {
                }
                field("DEL Kiriba SFTP Server Login"; "Kiriba SFTP Server Login")
                {
                }
                field("DEL Kiriba SFTP Server Password"; "Kiriba SFTP Server Password")
                {
                }
                field("DEL Kiriba Local File Path"; "Kiriba Local File Path")
                {
                }
                field("DEL Kiriba Archive File Path"; "Kiriba Archive File Path")
                {
                }
            }
        }
    }
}

