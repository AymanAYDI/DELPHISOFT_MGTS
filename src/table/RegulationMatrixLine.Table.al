table 50051 "Regulation Matrix Line"
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
    // T-00758      THM     12.01.16           add new field
    // T-00783      THM     04.04.16           delete Fields
    // T-00783      THM     26.04.16           modify length field 61 de 20 --> 50
    // T-00783      THM     27.04.16           modify field text-->boolean
    //              THM     03.05.16           add Field 20
    //              THM     09.06.16           élargir field 18
    //              THM     22.06.16           Modifiy optionString Nature
    //              THM     27.06.16           add OptionString field Mark
    //              THM     27.06.16           "Product Description" 50 -->100
    //              THM     26.08.16           add ,All Marks

    Caption = 'Regulation Matrix Line';

    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            Editable = false;
            TableRelation = "Item Category".Code;

            trigger OnValidate()
            begin
                CALCFIELDS("Item Category Label");
            end;
        }
        field(2; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            Editable = false;
            TableRelation = "Product Group".Code WHERE(Item Category Code=FIELD(Item Category Code));

            trigger OnValidate()
            begin
                CALCFIELDS("Product Group Label");
            end;
        }
        field(3; "Item Category Label"; Text[50])
        {
            CalcFormula = Lookup("Item Category".Description WHERE(Code = FIELD(Item Category Code)));
            Caption = 'Item category description';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category".Description WHERE(Code = FIELD(Item Category Code));
        }
        field(4; "Product Group Label"; Text[50])
        {
            CalcFormula = Lookup("Product Group".Description WHERE(Code = FIELD(Product Group Code),
                                                                    Item Category Code=FIELD(Item Category Code)));
                                                                                           Caption = 'Product group description';
                                                                                           Editable = false;
                                                                                           FieldClass = FlowField;
        }
        field(5; "No."; Code[60])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            Editable = false;
            OptionCaption = ' ,General product,Materials,Plan of control';
            OptionMembers = " ","General product",Materials,"Plan of control";
        }
        field(7; Nature; Option)
        {
            CalcFormula = Lookup(Regulation.Nature WHERE(No.=FIELD(No.),
                                                          Type=FIELD(Type)));
            Caption = 'Type of regulation';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Stopped,Decree,Directive,Card interpretation,Documentation Booklet,Norm,Internal norm,ONU Regulation,EU Regulation,Rules of certification';
            OptionMembers = " ",Stopped,Decree,Directive,"Card interpretation","Documentation Booklet",Norm,"Internal norm","ONU Regulation","EU Regulation","Rules of certification";
        }
        field(8;"Title in French";Text[250])
        {
            Caption = 'Title in French';
        }
        field(9;Description;Boolean)
        {
            CalcFormula = Exist("Texte Regulation" WHERE (No.=FIELD(No.),
                                                          Type=FIELD(Type),
                                                          Champs=FILTER(Description)));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10;"Starting date";Date)
        {
            CalcFormula = Lookup(Regulation."Starting date" WHERE (No.=FIELD(No.),
                                                                   Type=FIELD(Type)));
            Caption = 'Starting date';
            Description = 'General/Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(11;"Date Fin";Date)
        {
            CalcFormula = Lookup(Regulation."Date Fin" WHERE (No.=FIELD(No.),
                                                              Type=FIELD(Type)));
            Caption = 'End date';
            Description = 'General/Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12;"Texte rattachement";Text[50])
        {
            CalcFormula = Lookup(Regulation."Texte rattachement" WHERE (No.=FIELD(No.),
                                                                        Type=FIELD(Type)));
            Caption = 'Text of connection';
            Description = 'General';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13;Statut;Option)
        {
            CalcFormula = Lookup(Regulation.Statut WHERE (No.=FIELD(No.),
                                                          Type=FIELD(Type)));
            Caption = 'Status';
            Description = 'General/Materials';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Active,Inactive';
            OptionMembers = " ",Actif,Inactif;
        }
        field(14;"Texte de remplacement";Text[50])
        {
            CalcFormula = Lookup(Regulation."Texte de remplacement" WHERE (No.=FIELD(No.),
                                                                           Type=FIELD(Type)));
            Caption = 'Text of substitution';
            Description = 'General/Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15;"Type of material";Text[100])
        {
            CalcFormula = Lookup(Regulation."Type of material" WHERE (No.=FIELD(No.),
                                                                      Type=FIELD(Type)));
            Caption = 'Type of material';
            Description = 'Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16;Usage;Text[100])
        {
            CalcFormula = Lookup(Regulation.Usage WHERE (No.=FIELD(No.),
                                                         Type=FIELD(Type)));
            Caption = 'Usage';
            Description = 'Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17;"Substance - CAS / EINECS";Text[50])
        {
            CalcFormula = Lookup(Regulation."Substance - CAS / EINECS" WHERE (No.=FIELD(No.),
                                                                              Type=FIELD(Type)));
            Caption = 'Substance ID';
            Description = 'Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18;"Substance - nom";Text[250])
        {
            CalcFormula = Lookup(Regulation."Substance - nom" WHERE (No.=FIELD(No.),
                                                                     Type=FIELD(Type)));
            Caption = 'Substance name';
            Description = 'Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19;Source;Text[50])
        {
            CalcFormula = Lookup(Regulation.Source WHERE (No.=FIELD(No.),
                                                          Type=FIELD(Type)));
            Caption = 'Origine';
            Description = 'Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20;"Description Usage in French";Boolean)
        {
            CalcFormula = Exist("Texte Regulation" WHERE (No.=FIELD(No.),
                                                          Type=FIELD(Type),
                                                          Champs=FILTER(Description Usage in French)));
            Caption = 'Description Usage in French';
            Description = 'Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24;"List Items Associated";Integer)
        {
            CalcFormula = Count(Item WHERE (Item Category Code=FIELD(Item Category Code),
                                            Product Group Code=FIELD(Product Group Code),
                                            Product Description=FIELD(Product Description),
                                            Marque Produit=FIELD(Mark)));
            Caption = 'List Items Associated';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37;"Norm of testing";Boolean)
        {
            CalcFormula = Exist("Texte Regulation" WHERE (No.=FIELD(No.),
                                                          Type=FIELD(Type),
                                                          Champs=FILTER(Norm of testing)));
            Caption = 'Norm of testing';
            Description = 'Materials';
            Editable = false;
            FieldClass = FlowField;
        }
        field(38;Pays;Text[50])
        {
            CalcFormula = Lookup(Regulation.Pays WHERE (No.=FIELD(No.),
                                                        Type=FIELD(Type)));
            Caption = 'Country Code';
            Description = 'General/Materials';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Pays;
        }
        field(41;Checked;Boolean)
        {
            Caption = 'Checked';
        }
        field(43;"Livrables 1";Boolean)
        {
            CalcFormula = Exist("Texte Regulation" WHERE (No.=FIELD(No.),
                                                          Type=FIELD(Type),
                                                          Champs=FILTER(Livrables 1)));
            Caption = 'Deliverables 1';
            Description = 'Plan Of control/General';
            Editable = false;
            FieldClass = FlowField;
        }
        field(53;Scope;Text[50])
        {
            CalcFormula = Lookup(Regulation.Scope WHERE (No.=FIELD(No.),
                                                         Type=FIELD(Type)));
            Caption = 'Scope';
            Description = 'General';
            Editable = false;
            FieldClass = FlowField;
        }
        field(54;"Test Type";Text[100])
        {
            CalcFormula = Lookup(Regulation."Test Type" WHERE (No.=FIELD(No.),
                                                               Type=FIELD(Type)));
            Caption = 'Test Type';
            Description = 'Plan Of control';
            FieldClass = FlowField;
        }
        field(55;Descriptive;Boolean)
        {
            CalcFormula = Exist("Texte Regulation" WHERE (No.=FIELD(No.),
                                                          Type=FIELD(Type),
                                                          Champs=FILTER(Descriptive)));
            Caption = 'Descriptive';
            Description = 'Plan Of control';
            Editable = false;
            FieldClass = FlowField;
        }
        field(56;"Support Text";Text[100])
        {
            CalcFormula = Lookup(Regulation."Support Text" WHERE (No.=FIELD(No.),
                                                                  Type=FIELD(Type)));
            Caption = 'Support Text';
            Description = 'Plan Of control';
            Editable = false;
            FieldClass = FlowField;
        }
        field(57;"Control Type";Option)
        {
            CalcFormula = Lookup(Regulation."Control Type" WHERE (No.=FIELD(No.),
                                                                  Type=FIELD(Type)));
            Caption = 'Type de contrôle';
            Description = 'Plan Of control';
            FieldClass = FlowField;
            OptionCaption = ' ,Mandatory,Voluntary';
            OptionMembers = " ",Mandatory,Voluntary;
        }
        field(58;Frequency;Text[15])
        {
            CalcFormula = Lookup(Regulation.Frequency WHERE (No.=FIELD(No.),
                                                             Type=FIELD(Type)));
            Caption = 'Frequency';
            Description = 'Plan Of control';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59;"Referent Laboratory";Text[50])
        {
            CalcFormula = Lookup(Regulation."Referent Laboratory" WHERE (No.=FIELD(No.),
                                                                         Type=FIELD(Type)));
            Caption = 'Referent Laboratory';
            Description = 'Plan Of control';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61;"Product Description";Text[100])
        {
            Caption = 'Description produit';
            Editable = false;
        }
        field(62;Mark;Option)
        {
            Caption = 'Mark';
            Editable = false;
            OptionCaption = ' ,Own brand,Supplier brand,Licence,No Name,Premium Brand,NC,NA,?,All Marks';
            OptionMembers = " ","Own brand","Supplier brand",Licence,"No Name","Premium Brand",NC,NA,"?","All Marks";
        }
        field(63;"Description pays";Text[100])
        {
            CalcFormula = Lookup(Regulation."Description pays" WHERE (No.=FIELD(No.),
                                                                      Type=FIELD(Type)));
            Caption = 'Country';
            Editable = false;
            FieldClass = FlowField;
        }
        field(64;"Publication date";Date)
        {
            CalcFormula = Lookup(Regulation."Publication date" WHERE (No.=FIELD(No.),
                                                                      Type=FIELD(Type)));
            Caption = 'Publication date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65;"Date limit of the application";Date)
        {
            CalcFormula = Lookup(Regulation."Date limit of the application" WHERE (No.=FIELD(No.),
                                                                                   Type=FIELD(Type)));
            Caption = 'Date limit of the application';
            Editable = false;
            FieldClass = FlowField;
        }
        field(67;"Description Plan of control";Text[100])
        {
            CalcFormula = Lookup(Regulation."Description Plan of control" WHERE (No.=FIELD(No.),
                                                                                 Type=FIELD(Type)));
            Caption = 'Description';
            Description = 'Plan Of control';
            FieldClass = FlowField;
            TableRelation = "Description Plan of control".Description;
        }
        field(68;"Title in English";Text[250])
        {
            Caption = 'Title in English';
        }
        field(69;"Description Usage in English";Boolean)
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
        key(Key1;"Item Category Code","Product Group Code",Mark,"Product Description","No.",Type)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

