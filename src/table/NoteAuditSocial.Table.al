table 50017 "DEL Note Audit Social"
{
    Caption = 'DEL Note Audit Social';

    //TODO //Page
    // DrillDownPageID = 50019;
    // LookupPageID = 50019;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            //TODO
            // TableRelation = "Audit social";

            trigger OnValidate()
            begin
                CALCFIELDS(Axe);
            end;
        }
        field(2; Axe; Text[60])
        {//TODO
            // CalcFormula = Lookup ("Audit social".Axe WHERE ("No."=FIELD("No.")));
            Caption = 'Dimension';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Vendor/Contact No."; Code[20])
        {
            Caption = 'Vendor/Contact No.';
            Editable = false;
        }
        field(4; Note; Enum "DEL Rating")
        {
            Caption = 'Rating';

        }
        field(5; Type; enum "DEL Type Vend/Cont")
        {
            Caption = 'Type';
        }
    }

    keys
    {
        key(Key1; "No.", "Vendor/Contact No.", Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

