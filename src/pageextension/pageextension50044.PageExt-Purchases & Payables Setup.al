pageextension 50044 pageextension50044 extends "Purchases & Payables Setup"
{
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // NGTS:EDD001.01 :TU 24/05/2018 : Minimisation des clics :
    //   # Add new Field "PDF Registration Customer Path" in Archiving Tab
    // 
    // +----------------------------------------------------------------------------------------------------------------+
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.004,MGTS10.00.006
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.004    03.02.20    mhh     List of changes:
    //                                              Added new field: "Do Not Print Invoice"
    // 
    // 002     MGTS10.00.006    04.02.20    mhh     List of changes:
    //                                              Added new field: "Sales Ship Time By Air Flight"
    //                                              Added new field: "Sales Ship Time By Sea Vessel"
    //                                              Added new field: "Sales Ship Time By Sea/Air"
    //                                              Added new field: "Sales Ship Time By Truck"
    //                                              Added new field: "Sales Ship Time By Train"
    // ------------------------------------------------------------------------------------------
    layout
    {
        addafter("Control 35")
        {
            field("Do Not Print Invoice"; "Do Not Print Invoice")
            {
            }
        }
        addafter("Control 1140006")
        {
            field("PDF Registration Vendor Path"; "PDF Registration Vendor Path")
            {

                trigger OnLookup(var Text: Text): Boolean
                var
                    FileManagement: Codeunit "419";
                    Cst001: Label 'PDF Registration Customer Path';
                    Cst002: Label 'MGTS PDF';
                begin
                    "PDF Registration Vendor Path" := FileManagement.BrowseForFolderDialog(Cst001, Cst002, TRUE);
                end;
            }
        }
        addafter("Control 21")
        {
            group("Sales Shipping Time")
            {
                Caption = 'Sales Shipping Time';
                field("Sales Ship Time By Air Flight"; "Sales Ship Time By Air Flight")
                {
                    Caption = 'Sales shipping time by air flight';
                }
                field("Sales Ship Time By Sea Vessel"; "Sales Ship Time By Sea Vessel")
                {
                    Caption = 'Sales shipping time by sea vessel';
                }
                field("Sales Ship Time By Sea/Air"; "Sales Ship Time By Sea/Air")
                {
                    Caption = 'Sales shipping time by see/air';
                }
                field("Sales Ship Time By Truck"; "Sales Ship Time By Truck")
                {
                }
                field("Sales Ship Time By Train"; "Sales Ship Time By Train")
                {
                }
            }
        }
    }
}

