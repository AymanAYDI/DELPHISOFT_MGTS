tableextension 50004 tableextension50004 extends "Sales Invoice Line"
{
    // LOGICO/THM    28.05.2013  Added Key    Shortcut Dimension 1 Code,Type,Order No.
    // LOGICO/THM    28.05.2013  Added Key    Shortcut Dimension 1 Code,Type,Document No.
    // MGTS0124      23.07.19    Changed field: "Customer Price Group" (Property: Lenght)
    fields
    {
        modify("Customer Price Group")
        {

            //Unsupported feature: Property Modification (Data type) on ""Customer Price Group"(Field 42)".

            Description = 'MGTS0124';
        }
        field(50000; "Customer line reference2"; Text[30])
        {
            Caption = 'Kundenreferenz';
            Description = 'Temp400';
        }
        field(50001; "Qty. Init. Client"; Decimal)
        {
            Description = 'T-00551-WEBSHOP';
        }
        field(50008; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            Description = 'MGTS10.014';
            TableRelation = "Ship-to Address".Code WHERE (Customer No.=FIELD(Sell-to Customer No.));

            trigger OnValidate()
            var
                ShipToAddr: Record "222";
            begin
            end;
        }
        field(50009;"Ship-to Name";Text[50])
        {
            Caption = 'Ship-to Name';
            Description = 'MGTS10.014';
        }
    }
    keys
    {
        key(Key1;"Shortcut Dimension 1 Code",Type,"Order No.")
        {
        }
        key(Key2;"Shortcut Dimension 1 Code",Type,"Document No.")
        {
        }
    }
}

