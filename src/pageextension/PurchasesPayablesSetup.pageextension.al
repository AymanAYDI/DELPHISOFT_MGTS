pageextension 50044 "DEL PurchasesPayablesSetup" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("General")
        {
            field("DEL Do Not Print Invoice"; Rec."DEL Do Not Print Invoice")
            {
            }
        }
        addafter(Archiving)
        {
            field("DEL PDF Registration Vendor Path"; Rec."DEL PDF Registr. Vendor Path")
            {

                trigger OnLookup(var Text: Text): Boolean
                var
                    FileManagement: Codeunit "File Management";
                    Cst001: Label 'PDF Registration Customer Path';
                    Cst002: Label 'MGTS PDF';
                begin
                    // Rec."DEL PDF Registr. Vendor Path" := FileManagement.BrowseForFolderDialog(Cst001, Cst002, TRUE); TODO: Codeunit "File Management"' ne contient pas de définition pour 'BrowseForFolderDialog
                end;
            }
        }
        addafter("Default Accounts")
        {
            group("DEL Sales Shipping Time")
            {
                Caption = 'Sales Shipping Time';
                field("DEL Sales Ship Time By Air Flight"; Rec."DEL Sales Ship Time By Air Flight")
                {
                    Caption = 'Sales shipping time by air flight';
                }
                field("DEL Sales Ship Time By Sea Vessel"; Rec."DEL Sales Ship Time By Sea Vessel")
                {
                    Caption = 'Sales shipping time by sea vessel';
                }
                field("DEL Sales Ship Time By Sea/Air"; Rec."DEL Sales Ship Time By Sea/Air")
                {
                    Caption = 'Sales shipping time by see/air';
                }
                field("DEL Sales Ship Time By Truck"; Rec."DEL Sales Ship Time By Truck")
                {
                }
                field("DEL Sales Ship Time By Train"; Rec."DEL Sales Ship Time By Train")
                {
                }
            }
        }
    }
}

