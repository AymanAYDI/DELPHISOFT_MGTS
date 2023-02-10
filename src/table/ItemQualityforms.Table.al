table 50056 "DEL Item Quality forms"
{


    Caption = 'Quality forms';
    DataClassification = CustomerContent;
    fields
    {
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(3; "Type / Nature Enregistrement"; Code[20])
        {
            Caption = 'Type of forms';
            DataClassification = CustomerContent;

            TableRelation = "DEL Type/Nature Enregistrement";
            trigger OnValidate()
            begin
                CALCFIELDS(Description);
            end;
        }
        field(4; Description; Text[50])
        {

            CalcFormula = Lookup("DEL Type/Nature Enregistrement".Description WHERE(Code = FIELD("Type / Nature Enregistrement")));

            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Description Supplementaire"; Text[50])
        {
            Caption = 'Additionnal description';
            DataClassification = CustomerContent;
        }
        field(6; "Date of creation"; Date)
        {
            Caption = 'Date of creation';
            DataClassification = CustomerContent;
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

        "Date of creation" := WORKDATE();

    end;
}

