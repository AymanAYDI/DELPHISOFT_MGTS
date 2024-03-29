tableextension 50036 "DEL ProductGroup" extends "Product Group"
{
    fields
    {
        field(50000; "DEL Item Category Label"; Text[100])
        {
            CalcFormula = Lookup("Item Category".Description WHERE(Code = FIELD("Item Category Code")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category".Description WHERE(Code = FIELD("Item Category Code"));
        }
        field(50002; "DEL Code Segment"; Code[20])
        {
            Caption = 'Segment Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SEGMENT'),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(50003; "DEL Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
            trigger OnValidate()
            begin
                IF VendeurRec.GET("DEL Salesperson Code") THEN
                    "DEL Responsible Code" := VendeurRec."DEL Responsible Code"
                ELSE
                    "DEL Responsible Code" := '';
                CALCFIELDS("DEL Salesperson Code", "DEL Responsible Code");
            end;
        }
        field(50004; "DEL Responsible Code"; Code[10])
        {
            Caption = 'Responsible Code';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser";
            trigger OnValidate()
            begin
                CALCFIELDS("DEL Responsible Code");
            end;
        }
        field(50005; "DEL Salesperson"; Text[50])
        {
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE(Code = FIELD("DEL Salesperson Code")));
            Caption = 'Salesperson';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "DEL Responsible"; Text[50])
        {
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE(Code = FIELD("DEL Responsible Code")));
            Caption = 'Responsible';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "DEL Sourceur Code"; Code[20])
        {
            Caption = 'Sourceur Code';
            DataClassification = CustomerContent;
            TableRelation = "DEL Sourceur";
        }
        field(50008; "DEL Sourceur"; Text[50])
        {
            CalcFormula = Lookup("DEL Sourceur".Name WHERE(Code = FIELD("DEL Sourceur Code")));
            Caption = 'Sourceur';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: DropDown)".

    // fieldgroups
    // {
    //     addlast(DropDown; "Item Category Code",Code,Description,"DEL Code Segment"){} TODO:
    // }


    var
        VendeurRec: Record "Salesperson/Purchaser";
}

