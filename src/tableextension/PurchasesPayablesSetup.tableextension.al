tableextension 50025 "DEL PurchasesPayablesSetup" extends "Purchases & Payables Setup" //312
{

    fields
    {
        field(50000; "DEL PDF Registr. Vendor Path"; Text[50])
        {
            Caption = 'PDF Registration Vendor Path';
            DataClassification = CustomerContent;
        }
        field(50001; "DEL Do Not Print Invoice"; Boolean)
        {
            Caption = 'Do Not Print Invoice When Posting';
            DataClassification = CustomerContent;
        }
        field(50002; "DEL SalesShipTimeByAirFlight"; DateFormula)
        {
            Caption = 'Sales shipping time by air flight';
            DataClassification = CustomerContent;
        }
        field(50003; "DEL SalesShipTimeBySeaVessel"; DateFormula)
        {
            Caption = 'Sales shipping time by sea vessel';
            DataClassification = CustomerContent;
        }
        field(50004; "DEL Sales Ship Time By Sea/Air"; DateFormula)
        {
            Caption = 'Sales shipping time by see/air';
            DataClassification = CustomerContent;
        }
        field(50005; "DEL Sales Ship Time By Truck"; DateFormula)
        {
            Caption = 'Sales shipping time by truck';
            DataClassification = CustomerContent;
        }
        field(50006; "DEL Sales Ship Time By Train"; DateFormula)
        {
            Caption = 'Sales shipping time by train';
            DataClassification = CustomerContent;
        }
    }
}

