table 50068 "DEL DocMatrix Log"
{
    Caption = 'DocMatrix Log';

    fields
    {


        field(1; Type; Enum "Credit Transfer Account Type")

        {

        }
        field(2; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            TableRelation = IF (Type = CONST(Customer)) Customer."No."
            ELSE
            IF (Type = CONST(Vendor)) Vendor."No.";

        }
        field(3; "Process Type"; Enum "DEL Process Type")
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(4; "Report ID"; Integer)
        {
            Editable = false;

            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report));

        }
        field(5; "Report Caption"; Text[250])
        {

            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report),

            "Object ID" = FIELD("Report ID")));

            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Usage; Enum "DEL Usage DocMatrix Selection")
        {
            Editable = false;
        }
        field(7; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "UserId"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Send to FTP 1"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Send to FTP 2"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "E-Mail To 1"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "E-Mail To 2"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "E-Mail To 3"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "E-Mail From"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Save PDF"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40; "Print PDF"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "Mail Text Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DEL DocMatrix Email Codes";
        }
        field(51; "Mail Text Langauge Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Language;
        }
        field(70; Post; Enum "DEL Post DocMatrix")
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(75; "E-Mail from Sales Order"; Boolean)
        {

            trigger OnValidate()
            begin

                TESTFIELD(Type, Type::Customer);

            end;
        }
        field(100; "Action"; Enum "DEL Action100")
        {
            Caption = 'Action';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(101; "Date Time Stamp"; DateTime)
        {
            Caption = 'Date Time Stamp';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(102; "Error"; Boolean)
        {
            Caption = 'Error';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(103; "Document No."; Code[10])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(104; "Process Result Description"; Text[250])
        {
            Caption = 'Process Result Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(105; "Error Solved"; Boolean)
        {
            Caption = 'Error Solved';
            DataClassification = ToBeClassified;
        }
        field(106; "Solving Description"; Text[250])
        {
            Caption = 'Solving Description';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Type, "No.", "Process Type", Usage, "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Date Time Stamp")
        {
        }
        key(Key3; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

