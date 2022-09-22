table 50057 "DEL Regulation"
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
    // T-00757      THM     08.01.16           add and modify Field
    // T-00758      THM     12.01.16           add new fields 61,62,63
    // T-00758      THM     12.01.16           add new field
    // T-00783      THM     05.04.16           add New Field and delete fields
    // T-00783      THM     26.04.16           Modify table relation field 54
    // T-00783      THM     27.04.16           Modify field Text to boolean
    //              THM     03.05.16           add Field 20
    //              THM     09.06.16           élargir field 18
    //              THM     22.06.16           Change OptionString Nature
    //              thm     26.08.16           Modify insert

    Caption = 'Regulation';

    fields
    {
        field(5; "No."; Code[60])
        {
            Caption = 'No.';
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,General product,Materials,Plan of control';
            OptionMembers = " ","General product",Materials,"Plan of control";
        }
        field(7; Nature; Option)
        {
            Caption = 'Type of regulation';
            OptionCaption = ' ,Stopped,Decree,Directive,Card interpretation,Documentation Booklet,Norm,Internal norm,ONU Regulation,EU Regulation,Rules of certification';
            OptionMembers = " ",Stopped,Decree,Directive,"Card interpretation","Documentation Booklet",Norm,"Internal norm","ONU Regulation","EU Regulation","Rules of certification";
        }
        field(8; "Title in French"; Text[250])
        {
            Caption = 'Title in French';
        }
        field(9; Description; Boolean)
        {
            CalcFormula = Exist("DEL Texte Regulation" WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type),
                                                          Champs = FILTER(Description)));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Starting date"; Date)
        {
            Caption = 'Starting date';
            Description = 'General/Materials';
        }
        field(11; "Date Fin"; Date)
        {
            Caption = 'End date';
            Description = 'General/Materials';
        }
        field(12; "Texte rattachement"; Text[50])
        {
            Caption = 'Text of connection';
            Description = 'General';
        }
        field(13; Statut; Option)
        {
            Caption = 'Status';
            Description = 'General/Materials';
            OptionCaption = ' ,Active,Inactive';
            OptionMembers = " ",Actif,Inactif;
        }
        field(14; "Texte de remplacement"; Text[50])
        {
            Caption = 'Text of substitution';
            Description = 'General/Materials';
        }
        field(15; "Type of material"; Text[100])
        {
            Caption = 'Type of material';
            Description = 'Materials';
        }
        field(16; Usage; Text[100])
        {
            Caption = 'Usage';
            Description = 'Materials';
        }
        field(17; "Substance - CAS / EINECS"; Text[50])
        {
            Caption = 'Substance ID';
            Description = 'Materials';
        }
        field(18; "Substance - nom"; Text[250])
        {
            Caption = 'Substance name';
            Description = 'Materials';
        }
        field(19; Source; Text[100])
        {
            Caption = 'Origine';
            Description = 'Materials';
        }
        field(20; "Description Usage in French"; Boolean)
        {
            CalcFormula = Exist("DEL Texte Regulation" WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type),
                                                          Champs = FILTER("Description Usage in French")));
            Caption = 'Description Usage in French';
            Description = 'Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Norm of testing"; Boolean)
        {
            CalcFormula = Exist("DEL Texte Regulation" WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type),
                                                          Champs = FILTER("Norm of testing")));
            Caption = 'Norm of testing';
            Description = 'Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; Pays; Text[50])
        {
            Caption = 'Country code';
            Description = 'General/Materials';
            TableRelation = Pays;
        }
        field(41; Checked; Boolean)
        {
            Caption = 'Checked';
        }
        field(43; "Livrables 1"; Boolean)
        {
            CalcFormula = Exist("DEL Texte Regulation" WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type),
                                                          Champs = FILTER("Livrables 1")));
            Caption = 'Deliverables 1';
            Description = 'Plan Of control/General';
            Editable = false;
            FieldClass = FlowField;
        }
        field(53; Scope; Text[50])
        {
            Caption = 'Scope';
            Description = 'General';
        }
        field(54; "Test Type"; Text[100])
        {
            Caption = 'Test Type';
            Description = 'Plan Of control';
            TableRelation = "Test Type".Description;
            ValidateTableRelation = false;
        }
        field(55; Descriptive; Boolean)
        {
            CalcFormula = Exist("Texte Regulation" WHERE(No.=FIELD(No.),
                                                          Type=FIELD(Type),
                                                          Champs=FILTER(Descriptive)));
            Caption = 'Descriptive';
            Description = 'Plan Of control';
            Editable = false;
            FieldClass = FlowField;
        }
        field(56; "Support Text"; Text[100])
        {
            Caption = 'Support Text';
            Description = 'Plan Of control';
        }
        field(57; "Control Type"; Option)
        {
            Caption = 'Type de contrôle';
            Description = 'Plan Of control';
            OptionCaption = ' ,Mandatory,Voluntary';
            OptionMembers = " ",Mandatory,Voluntary;
        }
        field(58; Frequency; Text[15])
        {
            Caption = 'Frequency';
            Description = 'Plan Of control';
        }
        field(59; "Referent Laboratory"; Text[50])
        {
            Caption = 'Referent Laboratory';
            Description = 'Plan Of control';
        }
        field(61; "Description pays"; Text[100])
        {
            Caption = 'Country';
            TableRelation = Pays;
        }
        field(65; "Publication date"; Date)
        {
            Caption = 'Publication date';
        }
        field(66; "Date limit of the application"; Date)
        {
            Caption = 'Date limit of the application';
        }
        field(67; "Description Plan of control"; Text[100])
        {
            Caption = 'Description';
            Description = 'Plan Of control';
            TableRelation = "Description Plan of control".Description;
            ValidateTableRelation = false;
        }
        field(68; "Title in English"; Text[250])
        {
            Caption = 'Title in English';
        }
        field(69; "Description Usage in English"; Boolean)
        {
            CalcFormula = Exist("Texte Regulation" WHERE (No.=FIELD(No.),
                                                          Type=FIELD(Type),
                                                          Champs=FILTER(Description Usage in English)));
            Caption = 'Description Usage in English';
            Description = 'Materials';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"No.",Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF Type=Type::"Plan of control" THEN
        BEGIN
          Regulation_Var.RESET;
          Regulation_Var.SETRANGE(Regulation_Var.Type,Regulation_Var.Type::"Plan of control");
          IF Regulation_Var.FINDLAST THEN
          BEGIN
            EVALUATE(Num,Regulation_Var."No.");
            Num:=Num+1;
          END
          ELSE
          Num:=10000;

        "No.":=FORMAT(Num);
        END;
    end;

    var
        Regulation_Var: Record "50057";
        Num: Integer;
}

