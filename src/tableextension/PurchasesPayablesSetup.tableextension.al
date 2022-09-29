tableextension 50025 "DEL PurchasesPayablesSetup" extends "Purchases & Payables Setup"
{
   
    fields
    {
        field(50000; "DEL PDF Registration Vendor Path"; Text[50])
        {
            Caption = 'PDF Registration Vendor Path';
        }
        field(50001; "DEL Do Not Print Invoice"; Boolean)
        {
            Caption = 'Do Not Print Invoice When Posting';
            Description = 'MGTS10.00.004';
        }
        field(50002; "DEL Sales Ship Time By Air Flight"; DateFormula)
        {
            Caption = 'Sales shipping time by air flight';
            Description = 'MGTS10.00.006';
        }
        field(50003; "DEL Sales Ship Time By Sea Vessel"; DateFormula)
        {
            Caption = 'Sales shipping time by sea vessel';
            Description = 'MGTS10.00.006';
        }
        field(50004; "DEL Sales Ship Time By Sea/Air"; DateFormula)
        {
            Caption = 'Sales shipping time by see/air';
            Description = 'MGTS10.00.006';
        }
        field(50005; "DEL Sales Ship Time By Truck"; DateFormula)
        {
            Caption = 'Sales shipping time by truck';
            Description = 'MGTS10.00.006';
        }
        field(50006; "DEL Sales Ship Time By Train"; DateFormula)
        {
            Caption = 'Sales shipping time by train';
            Description = 'MGTS10.00.006';
        }
    }
}

