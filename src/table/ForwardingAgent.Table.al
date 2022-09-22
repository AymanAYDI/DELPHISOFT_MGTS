table 50011 "DEL Forwarding Agent"
{
    // T-00799         THM       22.06.16        Add field 4   Departure port

    Caption = 'Forwarding Agent';

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;
            //TODO //unused
            // trigger OnValidate()
            // var
            //     TempDocDim: Record "357" temporary;
            // begin
            // end;
        }
        field(2; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(3; "Forwarding Agent"; Code[20])
        {
            Caption = 'Forwarding Agent';
            //TODO   TableRelation = "Forwarding agent 2";
        }
        field(4; "Departure port"; Code[20])
        {
            Caption = 'Departure port';
            TableRelation = Location.Code;
        }
    }

    keys
    {
        key(Key1; "Vendor No.", "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    //TODO //unused
    // trigger OnDelete()
    // var
    //     TransferRoute: Record "5742";
    // begin
    // end;
}

