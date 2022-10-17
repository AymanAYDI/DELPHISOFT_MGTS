pageextension 50042 pageextension50042 extends "Sales & Receivables Setup"
{
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // MGTS:EDD001.01 :TU 24/05/2018 : Minimisation des clics :
    //   # Add new Field "PDF Registration Customer Path" in Archiving Tab
    // 
    // MGTS:EDD001.01 :TU 06/06/2018 : Minimisation des clics :
    //                               - Add new field "PDF Registration Sales C.Memo" in Archiving Tab
    //                               - Add new field "PDF Registration PostedSalesIn" in Archiving Tab
    // +----------------------------------------------------------------------------------------------------------------+
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // 
    // Version : MGTS10.027
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001     MGTS10.027       24.02.21    mhh     List of changes:
    //                                              Added new field: 50010 "Def. Req. Worksheet Template"
    //                                              Added new field: 50011 "Def. Req. Worksheet Batch"
    // ------------------------------------------------------------------------------------------
    layout
    {
        addafter("Control 37")
        {
            field("Def. Req. Worksheet Template"; "Def. Req. Worksheet Template")
            {
            }
            field("Def. Req. Worksheet Batch"; "Def. Req. Worksheet Batch")
            {
            }
        }
        addafter("Control 1140000")
        {
            field("PDF Registration Customer Path"; "PDF Registration Customer Path")
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
            field("PDF Registration Sales C.Memo"; "PDF Registration Sales C.Memo")
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
            field("PDF Registration PostedSalesIn"; "PDF Registration PostedSalesIn")
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
            group(Kiriba)
            {
                Caption = 'Kiriba';
                field("Host Serveur SFTP Kiriba"; "Host Serveur SFTP Kiriba")
                {
                }
                field("Port Serveur SFTP Kiriba"; "Port Serveur SFTP Kiriba")
                {
                }
                field("Kiriba SFTP Server Address"; "Kiriba SFTP Server Address")
                {
                }
                field("Kiriba SFTP Server Login"; "Kiriba SFTP Server Login")
                {
                }
                field("Kiriba SFTP Server Password"; "Kiriba SFTP Server Password")
                {
                }
                field("Kiriba Local File Path"; "Kiriba Local File Path")
                {
                }
                field("Kiriba Archive File Path"; "Kiriba Archive File Path")
                {
                }
            }
        }
    }
}

