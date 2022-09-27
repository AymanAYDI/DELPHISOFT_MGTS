tableextension 50033 tableextension50033 extends Contact
{
    // EDI       22.05.13/LOCO/ChC- New field 50002, Disable Code IC Partner Code - OnValidate()
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00652     THM      24.03.14           add fields 60001..60017
    // T-00705     THM      17.06.15           add Caption ML Field 60001..60017
    // THM080517   THM      08.05.17           add field "First Name Contact","Name Contact"  and add Code
    //             THM      15.05.17           Modify optionString field "Type Contact"
    //             THM      01.06.17           Change Field 60018 to 70000
    // 
    // MGTSEDI10.00.00.00 | 08.10.2020 | EDI Management : Add field : GLN
    fields
    {
        field(50000; Password_webAccess; Text[30])
        {
            Description = 'Temp400';
        }
        field(50001; Categories; Integer)
        {
            CalcFormula = Count (Contact_ItemCategory WHERE (contactNo = FIELD (No.)));
            Description = 'Temp400';
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup()
            begin
                // NTO appel matrice configuration
                /*
                NTO_CatMatrix.SetContactFilter("No.");
                NTO_CatMatrix.RUN;
                */

            end;
        }
        field(50002; Commande_web; Boolean)
        {
            Description = 'Temp400';
        }
        field(50003; adv; Boolean)
        {
            Caption = 'Administration des vents';
            Description = 'Temp400';
        }
        field(50004; "N° de TVA"; Text[20])
        {
            Description = 'Temp400';
        }
        field(50005; GLN; Code[13])
        {
            Caption = 'GLN';
            Numeric = true;

            trigger OnValidate()
            var
                GLNCalculator: Codeunit "1607";
            begin
                IF GLN <> '' THEN
                    GLNCalculator.AssertValidCheckDigit13(GLN);
            end;
        }
        field(60001; "Note Quality"; Code[10])
        {
            Caption = 'Quality rating';
            TableRelation = Note.Code WHERE (Type audit=FILTER(Quality));

            trigger OnValidate()
            begin
                /*IF "Realisation Date Quality"<>0D THEN
                BEGIN
                  TESTFIELD("Note Quality");
                  Note_Rec.RESET;
                  IF Note_Rec.GET("Note Quality",Note_Rec."Type audit"::Quality) THEN
                  BEGIN
                  IF  FORMAT(Note_Rec."Revision Calculation")='' THEN
                     VALIDATE("Revision Date quality",0D)
                    ELSE
                    BEGIN
                    "Revision Date quality":=CALCDATE(Note_Rec."Revision Calculation","Realisation Date Quality");
                    VALIDATE("Revision Date quality");
                    END;
                  END;
                END;
                Note_Rec.RESET;
                IF Note_Rec.GET("Note Quality",Note_Rec."Type audit"::Quality) THEN
                BEGIN
                  "Quality status":=Note_Rec."Impact statut";
                END
                ELSE
                "Quality status":="Quality status"::Inactif;
                */

            end;
        }
        field(60002;"Realisation Date Quality";Date)
        {
            Caption = 'Creation Date';

            trigger OnValidate()
            begin
                IF "Realisation Date Quality"<>0D THEN
                BEGIN
                  TESTFIELD("Note Quality");
                  Note_Rec.RESET;
                  IF Note_Rec.GET("Note Quality",Note_Rec."Type audit"::Quality) THEN
                  BEGIN
                  IF  FORMAT(Note_Rec."Revision Calculation")='' THEN
                     VALIDATE("Revision Date quality",0D)
                    ELSE
                    BEGIN
                    "Revision Date quality":=CALCDATE(Note_Rec."Revision Calculation","Realisation Date Quality");
                    VALIDATE("Revision Date quality");
                    END;
                  END;
                END;
            end;
        }
        field(60003;"Revision Date quality";Date)
        {
            Caption = 'Expired Date';
        }
        field(60004;"Note Soc";Code[10])
        {
            Caption = 'Social rating';
            TableRelation = Note.Code WHERE (Type audit=FILTER(social));

            trigger OnValidate()
            begin
                /*
                IF "Realisation Date Soc"<>0D THEN
                BEGIN
                  TESTFIELD("Note Soc");
                  Note_Rec.RESET;
                  IF Note_Rec.GET("Note Soc",Note_Rec."Type audit"::social) THEN
                  BEGIN
                  IF  FORMAT(Note_Rec."Revision Calculation")='' THEN
                     VALIDATE("Revision Date Soc",0D)
                    ELSE
                    BEGIN
                    "Revision Date Soc":=CALCDATE(Note_Rec."Revision Calculation","Realisation Date Soc");
                    VALIDATE("Revision Date Soc");
                    END;
                  END;
                END;
                Note_Rec.RESET;
                IF Note_Rec.GET("Note Soc",Note_Rec."Type audit"::social) THEN
                BEGIN
                  "Social status":=Note_Rec."Impact statut";
                END
                ELSE
                  "Social status":= "Social status"::Inactif;
                */

            end;
        }
        field(60005;"Realisation Date Soc";Date)
        {
            Caption = 'Creation Date Soc';

            trigger OnValidate()
            begin
                IF "Realisation Date Soc"<>0D THEN
                BEGIN
                  TESTFIELD("Note Soc");
                  Note_Rec.RESET;
                  IF Note_Rec.GET("Note Soc",Note_Rec."Type audit"::social) THEN
                  BEGIN
                  IF  FORMAT(Note_Rec."Revision Calculation")='' THEN
                     VALIDATE("Revision Date Soc",0D)
                    ELSE
                    BEGIN
                    "Revision Date Soc":=CALCDATE(Note_Rec."Revision Calculation","Realisation Date Soc");
                    VALIDATE("Revision Date Soc");
                    END;
                  END;
                END;
            end;
        }
        field(60006;"Revision Date Soc";Date)
        {
            Caption = 'Expired Date Soc';
        }
        field(60007;"Note Env";Code[10])
        {
            Caption = 'Environmental rating';
            TableRelation = Note.Code WHERE (Type audit=FILTER(Environmental));

            trigger OnValidate()
            begin
                /*IF "Realisation Date Env"<>0D THEN
                BEGIN
                  TESTFIELD("Note Env");
                  Note_Rec.RESET;
                  IF Note_Rec.GET("Note Env",Note_Rec."Type audit"::Environmental) THEN
                  BEGIN
                  IF  FORMAT(Note_Rec."Revision Calculation")='' THEN
                     VALIDATE("Revision Date env",0D)
                    ELSE
                    BEGIN
                    "Revision Date env":=CALCDATE(Note_Rec."Revision Calculation","Realisation Date Env");
                    VALIDATE("Revision Date env");
                    END;
                  END;
                END;
                
                Note_Rec.RESET;
                IF Note_Rec.GET("Note Env",Note_Rec."Type audit"::Environmental) THEN
                BEGIN
                  "Environmental status":=Note_Rec."Impact statut";
                END
                ELSE
                "Environmental status":="Environmental status"::Inactif;
                 */

            end;
        }
        field(60008;"Realisation Date Env";Date)
        {
            Caption = 'Creation Date Env';

            trigger OnValidate()
            begin
                IF "Realisation Date Env"<>0D THEN
                BEGIN
                  TESTFIELD("Note Env");
                  Note_Rec.RESET;
                  IF Note_Rec.GET("Note Env",Note_Rec."Type audit"::Environmental) THEN
                  BEGIN
                  IF  FORMAT(Note_Rec."Revision Calculation")='' THEN
                     VALIDATE("Revision Date env",0D)
                    ELSE
                    BEGIN
                    "Revision Date env":=CALCDATE(Note_Rec."Revision Calculation","Realisation Date Env");
                    VALIDATE("Revision Date env");
                    END;
                  END;
                END;
            end;
        }
        field(60009;"Revision Date env";Date)
        {
            Caption = 'Expired Date Env';
        }
        field(60012;"URL Quality";Text[60])
        {
            CalcFormula = Lookup("Document Line"."File Name" WHERE (Table Name=FILTER(Contact),
                                                                    No.=FIELD(No.),
                                                                    Notation Type=FILTER(Quality)));
            Caption = 'URL Quality';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60013;"URL social";Text[60])
        {
            CalcFormula = Lookup("Document Line"."File Name" WHERE (Table Name=FILTER(Contact),
                                                                    No.=FIELD(No.),
                                                                    Notation Type=FILTER(Social)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60014;"URL Environmental";Text[60])
        {
            CalcFormula = Lookup("Document Line"."File Name" WHERE (Table Name=FILTER(Contact),
                                                                    No.=FIELD(No.),
                                                                    Notation Type=FILTER(Environmental)));
            Caption = 'URL Environmental';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60015;"Quality status";Option)
        {
            Caption = 'Quality status';
            OptionCaption = ' ,Inactif,Actif';
            OptionMembers = " ",Inactif,Actif;
        }
        field(60016;"Social status";Option)
        {
            Caption = 'Social status';
            OptionCaption = ' ,Inactif,Actif';
            OptionMembers = " ",Inactif,Actif;
        }
        field(60017;"Environmental status";Option)
        {
            Caption = 'Environmental status';
            OptionCaption = ' ,Inactif,Actif';
            OptionMembers = " ",Inactif,Actif;
        }
        field(70000;"Type Contact";Option)
        {
            Caption = 'Contact Type';
            OptionCaption = 'Commercial,Juridical,Accountant,Quality';
            OptionMembers = Commercial,Juridical,Accountant,Quality;
        }
        field(70001;"Customer No.";Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(70002;"Name Contact";Text[20])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                //START THM080517
                Name:="Name Contact"+' '+"First Name Contact";
                //END THM080517
            end;
        }
        field(70003;"First Name Contact";Text[30])
        {
            Caption = 'First Name';

            trigger OnValidate()
            begin
                //START THM080517
                Name:="Name Contact"+' '+"First Name Contact";
                //END THM080517
            end;
        }
    }

    var
        Note_Rec: Record "50019";
}

