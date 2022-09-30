tableextension 50010 "DEL SalespersonPurchaser" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; "DEL Responsible Code"; Code[10])
        {
            Caption = 'Responsible Code';
            DataClassification = ToBeClassified;
        }
        field(50001; "DEL Responsible"; Text[50])
        {
            Caption = 'Responsible';
            DataClassification = ToBeClassified;
        }
    }
}
