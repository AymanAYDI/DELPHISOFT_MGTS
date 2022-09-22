table 50056 "DEL Item Quality forms"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00716      THM     27.08.15           Create Object
    // T-00747      THM     17.11.15           change name in fields
    // T-00755      THM     04.01.16           delete field
    // T-00757      THM     07.01.16           add and modify Field

    Caption = 'Quality forms';

    fields
    {
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; "Type / Nature Enregistrement"; Code[20])
        {
            Caption = 'Type of forms';
            TableRelation = "Type/Nature Enregistrement";

            trigger OnValidate()
            begin
                CALCFIELDS(Description);
            end;
        }
        field(4; Description; Text[50])
        {
            CalcFormula = Lookup("Type/Nature Enregistrement".Description WHERE(Code = FIELD(Type / Nature Enregistrement)));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Description Supplementaire"; Text[50])
        {
            Caption = 'Additionnal description';
        }
        field(6; "Date of creation"; Date)
        {
            Caption = 'Date of creation';
        }
    }

    keys
    {
        key(Key1; "Item No.", "Type / Nature Enregistrement")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Date of creation" := WORKDATE;
    end;
}

