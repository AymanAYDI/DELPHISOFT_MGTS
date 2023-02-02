pageextension 50042 "DEL SalesReceivablesSetup" extends "Sales & Receivables Setup" //456
{
    layout
    {
        addafter(General)
        {
            field("DEL Def. Req. Worksheet Template"; Rec."DEL Def.Req.Worksheet Temp")
            {
            }
            field("DEL Def. Req. Worksheet Batch"; Rec."DEL Def. Req. Worksheet Batch")
            {
            }
        }
        addafter("Archive Return Orders")
        {
            field("DEL PDF Registration Customer Path"; Rec."DEL PDF Reg. Cust. Path")
            {

                trigger OnLookup(var Text: Text): Boolean
                begin
                    // Rec."DEL PDF Registration Customer Path" := FileManagement.BrowseForFolderDialog(Cst001, Cst002, TRUE); //TODO: 'Codeunit "File Management"' does not contain a definition for 'BrowseForFolderDialog'
                end;
            }
            field("DEL PDF Registration Sales C.Memo"; Rec."DEL PDF Reg. Sales C.Memo")
            {

                trigger OnLookup(var Text: Text): Boolean
                begin
                    // Rec."DEL PDF Registration Sales C.Memo" := RecLFileManagement.BrowseForFolderDialog(Cst001, Cst002, TRUE); //TODO: 'Codeunit "File Management"' does not contain a definition for 'BrowseForFolderDialog'
                end;
            }
            field("DEL PDF Registration PostedSalesIn"; Rec."DEL PDF Reg. PostedSalesIn")
            {

                trigger OnLookup(var Text: Text): Boolean
                begin
                    // Rec."DEL PDF Registration Sales C.Memo" := RecLFileManagement.BrowseForFolderDialog(Cst001, Cst002, TRUE); //TODO: 'Codeunit "File Management"' does not contain a definition for 'BrowseForFolderDialog'
                end;
            }
            group("DEL Kiriba")
            {
                Caption = 'Kiriba';
                field("DEL Host Serveur SFTP Kiriba"; Rec."DEL Host Serveur SFTP Kiriba")
                {
                }
                field("DEL Port Serveur SFTP Kiriba"; Rec."DEL Port Serveur SFTP Kiriba")
                {
                }
                field("DEL Kiriba SFTP Server Address"; Rec."DEL Kiriba SFTP Server Address")
                {
                }
                field("DEL Kiriba SFTP Server Login"; Rec."DEL Kiriba SFTP Server Login")
                {
                }
                field("DEL Kiriba SFTP Server Password"; Rec."DEL KiribaSFTPServerPassword")
                {
                }
                field("DEL Kiriba Local File Path"; Rec."DEL Kiriba Local File Path")
                {
                }
                field("DEL Kiriba Archive File Path"; Rec."DEL Kiriba Archive File Path")
                {
                }
            }
        }
    }
}


