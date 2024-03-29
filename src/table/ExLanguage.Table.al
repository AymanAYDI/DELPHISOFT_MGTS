table 99201 "DEL Ex_Language"
{
    Caption = 'Language';
    DataClassification = CustomerContent;
    LookupPageID = Languages;
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(6; "Windows Language ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Windows Language ID';
            DataClassification = CustomerContent;
            TableRelation = "Windows Language";
        }
        field(7; "Windows Language Name"; Text[80])
        {

            CalcFormula = Lookup("Windows Language".Name WHERE("Language ID" = FIELD("Windows Language ID")));
            Caption = 'Windows Language Name';
            Editable = false;
            FieldClass = FlowField;

        }
        //---------Spécifique pays 
        field(4006496; Katalogsprache; Boolean)
        {


            Caption = 'Katalogsprache';
            DataClassification = CustomerContent;
        }
        field(4006497; "ISO Code"; Text[3])
        {

            Caption = 'ISO Code';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

