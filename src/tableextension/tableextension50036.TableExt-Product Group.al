tableextension 50036 tableextension50036 extends "Product Group"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 03.07.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // MIK01                            03.07.09   Designation of Item Category in Product Group table
    //                                             used by the Matrix "Contact/Product Group"
    // T-00712             SAZ           21.07.15   Field Segment
    //                                   23.07.15   Modify FieldGroup
    //                    THM            15.02.17   add 50003 and 50004 , 50005,50006
    //                    THM            23.02.18   add sourceur
    fields
    {
        field(50000; "Item Category Label"; Text[50])
        {
            CalcFormula = Lookup ("Item Category".Description WHERE (Code = FIELD (Item Category Code)));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category".Description WHERE (Code = FIELD (Item Category Code));
        }
        field(50002; "Code Segment"; Code[20])
        {
            Caption = 'Segment Code';
            TableRelation = "Dimension Value".Code WHERE (Dimension Code=CONST(SEGMENT),
                                                          Dimension Value Type=CONST(Standard));
        }
        field(50003; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = Salesperson/Purchaser;

            trigger OnValidate()
            var
                ApprovalEntry: Record "454";
            begin
                //START THM
                IF VendeurRec.GET("Salesperson Code") THEN
                "Responsible Code":=VendeurRec."Responsible Code"
                ELSE
                "Responsible Code":='';
                CALCFIELDS(Salesperson,Responsible);
                //END THM
            end;
        }
        field(50004;"Responsible Code";Code[10])
        {
            Caption = 'Responsible Code';
            TableRelation = Salesperson/Purchaser;

            trigger OnValidate()
            begin
                //THM
                CALCFIELDS(Responsible);
                //END THM
            end;
        }
        field(50005;Salesperson;Text[50])
        {
            CalcFormula = Lookup(Salesperson/Purchaser.Name WHERE (Code=FIELD(Salesperson Code)));
            Caption = 'Salesperson';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006;Responsible;Text[50])
        {
            CalcFormula = Lookup(Salesperson/Purchaser.Name WHERE (Code=FIELD(Responsible Code)));
            Caption = 'Responsible';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007;"Sourceur Code";Code[20])
        {
            Caption = 'Sourceur Code';
            TableRelation = Sourceur;
        }
        field(50008;Sourceur;Text[50])
        {
            CalcFormula = Lookup(Sourceur.Name WHERE (Code=FIELD(Sourceur Code)));
            Caption = 'Sourceur';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    //Unsupported feature: Insertion (FieldGroupCollection) on "(FieldGroup: DropDown)".


    var
        VendeurRec: Record "13";
}

