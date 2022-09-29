tableextension 50036 "DEL ProductGroup" extends "Product Group"
{
    fields
    {
        field(50000; "DEL Item Category Label"; Text[50])
        {
            CalcFormula = Lookup("Item Category".Description WHERE(Code = FIELD("Item Category Code")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category".Description WHERE(Code = FIELD("Item Category Code"));
        }
        field(50002; "DEL Code Segment"; Code[20])
        {
            Caption = 'Segment Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SEGMENT'),
                                                          "Dimension Value Type" = CONST(Standard));
        }
        field(50003; "DEL Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                ApprovalEntry: Record "Approval Entry";
            begin
                //START THM
                IF VendeurRec.GET("DEL Salesperson Code") THEN
                    "DEL Responsible Code" := VendeurRec."DEL Responsible Code"
                ELSE
                    "DEL Responsible Code" := '';
                CALCFIELDS("DEL Salesperson Code", "DEL Responsible Code");
                //END THM
            end;
        }
        field(50004; "DEL Responsible Code"; Code[10])
        {
            Caption = 'Responsible Code';
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                //THM
                CALCFIELDS("DEL Responsible Code");
                //END THM
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


    var
        VendeurRec: Record "Salesperson/Purchaser";
}

