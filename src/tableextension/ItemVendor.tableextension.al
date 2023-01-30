tableextension 50047 "DEL ItemVendor" extends "Item Vendor" //99
{
    fields
    {
        field(50001; "DEL Country/Region Code"; Code[20])
        {
            Caption = 'Coubtry/Region Code';
            TableRelation = "Country/Region".Code;
            DataClassification = CustomerContent;
        }
    }
}

