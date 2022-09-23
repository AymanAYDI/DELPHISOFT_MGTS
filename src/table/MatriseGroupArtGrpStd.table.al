table 50059 "DEL Matrise Group Art./Grp Std"
{
    Caption = 'Standard Item Group / Product Group Matrix';
    //TODO DrillDownPageID = 50118;
    // LookupPageID = 50118;

    fields
    {
        field(1; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code;

            trigger OnValidate()
            var
            //TODO ProductGroup_Rec: Record "Product Group";
            begin
            end;
        }
        field(2; "Standard Item Group Code"; Code[20])
        {
            Caption = 'Standard Item Group Code';
            //TODO TableRelation = "Artikelgruppe Katalog";
        }
        field(3; "Product Group Description"; Text[50])
        {
            CalcFormula = Lookup("Product Group".Description WHERE(Code = FIELD("Product Group Code")));
            Caption = 'Product Group Description';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
            //TODO  ProductGroup_Rec: Record "5723";
            begin
            end;
        }
        field(4; "Std Item Group Description"; Text[50])
        {
            //TODO  CalcFormula = Lookup("Artikelgruppe Katalog".Bezeichnung WHERE(Code = FIELD(Standard Item Group Code)));
            Caption = 'Standard Item Group Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Product Group Code", "Standard Item Group Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

