table 50059 "DEL Matrise Group Art./Grp Std"
{
    Caption = 'Standard Item Group / Product Group Matrix';
    DrillDownPageID = "DEL Matrice Grp art./Group std";
    LookupPageID = "DEL Matrice Grp art./Group std";

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
            //WE ARE NOT ALLOWED TO MERGE THESE TABLES
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
            //THIS RECORD HAS BEEN REMOVED
            begin
            end;
        }
        field(4; "Std Item Group Description"; Text[50])
        {
            //TODO  CalcFormula = Lookup("Artikelgruppe Katalog".Bezeichnung WHERE(Code = FIELD(Standard Item Group Code)));
            //STANDARD SUISSE, WE ARE NOT ALLOWED TO BRING
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

