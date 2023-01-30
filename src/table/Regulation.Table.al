table 50057 "DEL Regulation"
{

    Caption = 'Regulation';
    DataClassification = CustomerContent;
    fields
    {
        field(5; "No."; Code[60])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }

        field(6; Type; Enum "DEL Product Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(7; Nature; Enum "DEL Nature de Regulation")
        {
            Caption = 'Type of regulation';
            DataClassification = CustomerContent;
        }
        field(8; "Title in French"; Text[250])
        {
            Caption = 'Title in French';
            DataClassification = CustomerContent;
        }
        field(9; Description; Boolean)
        {

            FieldClass = FlowField;

            CalcFormula = Exist("DEL Texte Regulation" WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type),
                                                          Champs = FILTER(Description)));
            Caption = 'Description';
            Editable = false;

        }
        field(10; "Starting date"; Date)
        {
            Caption = 'Starting date';
            DataClassification = CustomerContent;
        }
        field(11; "Date Fin"; Date)
        {
            Caption = 'End date';
            DataClassification = CustomerContent;
        }
        field(12; "Texte rattachement"; Text[50])
        {
            Caption = 'Text of connection';
            DataClassification = CustomerContent;
        }
        field(13; Statut; Enum "DEL Impact Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(14; "Texte de remplacement"; Text[50])
        {
            Caption = 'Text of substitution';
            DataClassification = CustomerContent;
        }
        field(15; "Type of material"; Text[100])
        {
            Caption = 'Type of material';
            Description = 'Materials';
            DataClassification = CustomerContent;
        }
        field(16; Usage; Text[100])
        {
            Caption = 'Usage';
            DataClassification = CustomerContent;
        }
        field(17; "Substance - CAS / EINECS"; Text[50])
        {
            Caption = 'Substance ID';
            DataClassification = CustomerContent;
        }
        field(18; "Substance - nom"; Text[250])
        {
            Caption = 'Substance name';
            DataClassification = CustomerContent;
        }
        field(19; Source; Text[100])
        {
            Caption = 'Origine';
            DataClassification = CustomerContent;
        }
        field(20; "Description Usage in French"; Boolean)
        {
            CalcFormula = Exist("DEL Texte Regulation" WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type),
                                                          Champs = FILTER("Description Usage in French")));
            Caption = 'Description Usage in French';

            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Norm of testing"; Boolean)
        {
            CalcFormula = Exist("DEL Texte Regulation" WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type),
                                                          Champs = FILTER("Norm of testing")));
            Caption = 'Norm of testing';

            Editable = false;
            FieldClass = FlowField;
        }
        field(38; Pays; Text[50])
        {
            Caption = 'Country code';

            TableRelation = "DEL Pays";
            DataClassification = CustomerContent;
        }
        field(41; Checked; Boolean)
        {
            Caption = 'Checked';
            DataClassification = CustomerContent;
        }
        field(43; "Livrables 1"; Boolean)
        {
            CalcFormula = Exist("DEL Texte Regulation" WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type),
                                                          Champs = FILTER("Livrables 1")));
            Caption = 'Deliverables 1';

            Editable = false;
            FieldClass = FlowField;
        }
        field(53; Scope; Text[50])
        {
            Caption = 'Scope';
            DataClassification = CustomerContent;
        }
        field(54; "Test Type"; Text[100])
        {
            Caption = 'Test Type';

            TableRelation = "DEL Test Type".Description;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(55; Descriptive; Boolean)
        {

            CalcFormula = Exist("DEL Texte Regulation" WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type),
                                                          Champs = FILTER(Descriptive)));
            Caption = 'Descriptive';


            Editable = false;
            FieldClass = FlowField;
        }
        field(56; "Support Text"; Text[100])
        {
            Caption = 'Support Text';
            DataClassification = CustomerContent;
        }
        field(57; "Control Type"; Enum "DEL Control Type de regulation")
        {
            Caption = 'Type de contrôle';
            DataClassification = CustomerContent;
        }
        field(58; Frequency; Text[15])
        {
            Caption = 'Frequency';
            DataClassification = CustomerContent;
        }
        field(59; "Referent Laboratory"; Text[50])
        {
            Caption = 'Referent Laboratory';
            DataClassification = CustomerContent;
        }
        field(61; "Description pays"; Text[100])
        {
            Caption = 'Country';
            TableRelation = "DEL Pays";
            DataClassification = CustomerContent;
        }
        field(65; "Publication date"; Date)
        {
            Caption = 'Publication date';
            DataClassification = CustomerContent;
        }
        field(66; "Date limit of the application"; Date)
        {
            Caption = 'Date limit of the application';
            DataClassification = CustomerContent;
        }
        field(67; "Description Plan of control"; Text[100])
        {
            Caption = 'Description';
            Description = 'Plan Of control';

            TableRelation = "DEL Desc Plan of control".Description;

            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(68; "Title in English"; Text[250])
        {
            Caption = 'Title in English';
            DataClassification = CustomerContent;
        }
        field(69; "Description Usage in English"; Boolean)
        {

            CalcFormula = Exist("DEL Texte Regulation" WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type),
                                                          Champs = FILTER("Description Usage in English")));

            Caption = 'Description Usage in English';
            Description = 'Materials';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {

        key(Key1; "No.", Type)

        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        IF Type = Type::"Plan of control" THEN BEGIN
            Regulation_Var.RESET();
            Regulation_Var.SETRANGE(Regulation_Var.Type, Regulation_Var.Type::"Plan of control");
            IF Regulation_Var.FINDLAST() THEN BEGIN
                EVALUATE(Num, Regulation_Var."No.");
                Num := Num + 1;
            END
            ELSE
                Num := 10000;

            "No." := FORMAT(Num);

        END;
    end;

    var

        Regulation_Var: Record "DEL Regulation";

        Num: Integer;
}

