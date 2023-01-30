
table 50051 "DEL Regulation Matrix Line"
{

    Caption = 'Regulation Matrix Line';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            Editable = false;
            TableRelation = "Item Category".Code;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CALCFIELDS("Item Category Label");
            end;
        }
        field(2; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            Editable = false;
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CALCFIELDS("Product Group Label");
            end;
        }
        field(3; "Item Category Label"; Text[100])
        {

            CalcFormula = Lookup("Item Category".Description WHERE(Code = FIELD("Item Category Code")));
            Caption = 'Item category description';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category".Description WHERE(Code = FIELD("Item Category Code"));
        }
        field(4; "Product Group Label"; Text[100])
        {
            CalcFormula = Lookup("Product Group".Description WHERE(Code = FIELD("Product Group Code"),
                                                                    "Item Category Code" = FIELD("Item Category Code")));
            Caption = 'Product group description';
            Editable = false;
            FieldClass = FlowField;

        }
        field(5; "No."; Code[60])
        {
            Caption = 'No.';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(6; Type; Enum "DEL Product Type")
        {
            Caption = 'Type';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; Nature; Enum "DEL Nature de Regulation")
        {
            CalcFormula = Lookup("DEL Regulation".Nature WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type)));
            Caption = 'Type of regulation';
            Editable = false;
            FieldClass = FlowField;

        }
        field(8; "Title in French"; Text[250])
        {
            Caption = 'Title in French';
            DataClassification = CustomerContent;
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
            CalcFormula = Lookup("DEL Regulation"."Starting date" WHERE("No." = FIELD("No."),
                                                                   Type = FIELD(Type)));

            Caption = 'Starting date';
            Editable = false;
            FieldClass = FlowField;
        }

        field(11; "Date Fin"; Date)
        {
            CalcFormula = Lookup("DEL Regulation"."Date Fin" WHERE("No." = FIELD("No."),
                                                              Type = FIELD(Type)));

            Caption = 'End date';
            Editable = false;
            FieldClass = FlowField;
        }

        field(12; "Texte rattachement"; Text[50])
        {
            CalcFormula = Lookup("DEL Regulation"."Texte rattachement" WHERE("No." = FIELD("No."),
                                                                        Type = FIELD(Type)));

            Caption = 'Text of connection';
            Editable = false;
            FieldClass = FlowField;
        }

        field(13; Statut; enum "DEL ActivationStatus")
        {
            CalcFormula = Lookup("DEL Regulation".Statut WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type)));
            Caption = 'Status';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Texte de remplacement"; Text[50])
        {
            CalcFormula = Lookup("DEL Regulation"."Texte de remplacement" WHERE("No." = FIELD("No."),
                                                                           Type = FIELD(Type)));
            Caption = 'Text of substitution';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Type of material"; Text[100])
        {
            CalcFormula = Lookup("DEL Regulation"."Type of material" WHERE("No." = FIELD("No."),
                                                                      Type = FIELD(Type)));

            Caption = 'Type of material';
            Editable = false;
            FieldClass = FlowField;
        }

        field(16; Usage; Text[100])
        {
            CalcFormula = Lookup("DEL Regulation".Usage WHERE("No." = FIELD("No."),
                                                         Type = FIELD(Type)));

            Caption = 'Usage';
            Editable = false;
            FieldClass = FlowField;
        }

        field(17; "Substance - CAS / EINECS"; Text[50])
        {
            CalcFormula = Lookup("DEL Regulation"."Substance - CAS / EINECS" WHERE("No." = FIELD("No."),
                                                                              Type = FIELD(Type)));

            Caption = 'Substance ID';
            Editable = false;
            FieldClass = FlowField;
        }

        field(18; "Substance - nom"; Text[250])
        {
            CalcFormula = Lookup("DEL Regulation"."Substance - nom" WHERE("No." = FIELD("No."),
                                                                     Type = FIELD(Type)));

            Caption = 'Substance name';
            Editable = false;
            FieldClass = FlowField;
        }

        field(19; Source; Text[100])
        {
            CalcFormula = Lookup("DEL Regulation".Source WHERE("No." = FIELD("No."),
                                                          Type = FIELD(Type)));

            Caption = 'Origine';
            Editable = false;
            FieldClass = FlowField;
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

        field(24; "List Items Associated"; Integer)
        {
            //TODO CalcFormula = Count("Item" WHERE("Item Category Code" = FIELD("Item Category Code"),
            //   //TODO  // "Product Group Code"=FIELD("Product Group Code"),
            //    "DEL Product Description" = FIELD("DEL Product Description"),
            //   "DEL Marque Produit" = FIELD(Mark)));

            Caption = 'List Items Associated';
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

        field(38; Pays; Text[100])
        {
            CalcFormula = Lookup("DEL Regulation".Pays WHERE("No." = FIELD("No."),
                                                        Type = FIELD(Type)));

            Caption = 'Country Code';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "DEL Pays";
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
            CalcFormula = Lookup("DEL Regulation".Scope WHERE("No." = FIELD("No."),
                                                         Type = FIELD(Type)));

            Caption = 'Scope';
            Editable = false;
            FieldClass = FlowField;
        }

        field(54; "Test Type"; Text[100])
        {
            CalcFormula = Lookup("DEL Regulation"."Test Type" WHERE("No." = FIELD("No."),
                                                               Type = FIELD(Type)));

            Caption = 'Test Type';
            FieldClass = FlowField;
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
            CalcFormula = Lookup("DEL Regulation"."Support Text" WHERE("No." = FIELD("No."),
                                                                  Type = FIELD(Type)));

            Caption = 'Support Text';
            Editable = false;
            FieldClass = FlowField;
        }

        field(57; "Control Type"; enum "DEL Control Type de regulation")
        {
            CalcFormula = Lookup("DEL Regulation"."Control Type" WHERE("No." = FIELD("No."),
                                                                  Type = FIELD(Type)));
            Caption = 'Type de contrôle';
            FieldClass = FlowField;

        }
        field(58; Frequency; Text[15])
        {
            CalcFormula = Lookup("DEL Regulation".Frequency WHERE("No." = FIELD("No."),
                                                             Type = FIELD(Type)));

            Caption = 'Frequency';
            Editable = false;
            FieldClass = FlowField;
        }

        field(59; "Referent Laboratory"; Text[50])
        {
            CalcFormula = Lookup("DEL Regulation"."Referent Laboratory" WHERE("No." = FIELD("No."),
                                                                         Type = FIELD(Type)));

            Caption = 'Referent Laboratory';
            Editable = false;
            FieldClass = FlowField;
        }

        field(61; "Product Description"; Text[100])

        {
            Caption = 'Description produit';
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(62; Mark; Enum "DEL Mark")
        {
            Caption = 'Mark';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(63; "Description pays"; Text[100])
        {
            CalcFormula = Lookup("DEL Regulation"."Description pays" WHERE("No." = FIELD("No."),
                                                                      Type = FIELD(Type)));

            Caption = 'Country';
            Editable = false;
            FieldClass = FlowField;
        }

        field(64; "Publication date"; Date)
        {
            CalcFormula = Lookup("DEL Regulation"."Publication date" WHERE("No." = FIELD("No."),
                                                                      Type = FIELD(Type)));

            Caption = 'Publication date';
            Editable = false;
            FieldClass = FlowField;
        }

        field(65; "Date limit of the application"; Date)
        {
            CalcFormula = Lookup("DEL Regulation"."Date limit of the application" WHERE("No." = FIELD("No."),
                                                                                   Type = FIELD(Type)));

            Caption = 'Date limit of the application';
            Editable = false;
            FieldClass = FlowField;
        }

        field(67; "Description Plan of control"; Text[100])
        {
            CalcFormula = Lookup("DEL Regulation"."Description Plan of control" WHERE("No." = FIELD("No."),
                                                                                 Type = FIELD(Type)));

            Caption = 'Description';
            FieldClass = FlowField;
            TableRelation = "DEL Desc Plan of control".Description;
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
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {

        key(Key1; "Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)

        {
            Clustered = true;
        }
    }

}

