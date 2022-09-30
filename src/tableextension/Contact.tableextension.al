tableextension 50033 "DEL Contact" extends Contact
{
    fields
    {
        field(50000; "DEL Password_webAccess"; Text[30])
        {
            Description = 'Temp400';
        }
        field(50001; "DEL Categories"; Integer)
        {
            CalcFormula = Count("DEL Contact_ItemCategory" WHERE(contactNo = FIELD("No.")));
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
        field(50002; "DEL Commande_web"; Boolean)
        {
            Description = 'Temp400';
        }
        field(50003; "DEL adv"; Boolean)
        {
            Caption = 'Administration des vents';
            Description = 'Temp400';
        }
        field(50004; "N° de TVA"; Text[20])
        {
            Description = 'Temp400';
        }
        field(50005; "DEL GLN"; Code[13])
        {
            Caption = 'GLN';
            Numeric = true;

            trigger OnValidate()
            var
                GLNCalculator: Codeunit "GLN Calculator";
            begin
                IF "DEL GLN" <> '' THEN
                    GLNCalculator.AssertValidCheckDigit13("DEL GLN");
            end;
        }
        field(60001; "DEL Note Quality"; Code[10])
        {
            Caption = 'Quality rating';
            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(Quality));

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
        field(60002; "DEL Realisation Date Quality"; Date)
        {
            Caption = 'Creation Date';

            trigger OnValidate()
            begin
                IF "DEL Realisation Date Quality" <> 0D THEN BEGIN
                    TESTFIELD("DEL Note Quality");
                    Note_Rec.RESET();
                    IF Note_Rec.GET("DEL Note Quality", Note_Rec."Type audit"::Quality) THEN
                        IF FORMAT(Note_Rec."Revision Calculation") = '' THEN
                            VALIDATE("DEL Revision Date quality", 0D)
                        ELSE BEGIN
                            "DEL Revision Date quality" := CALCDATE(Note_Rec."Revision Calculation", "DEL Realisation Date Quality");
                            VALIDATE("DEL Revision Date quality");
                        END;
                END;
            end;
        }
        field(60003; "DEL Revision Date quality"; Date)
        {
            Caption = 'Expired Date';
        }
        field(60004; "DEL Note Soc"; Code[10])
        {
            Caption = 'Social rating';
            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(social));

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
        field(60005; "DEL Realisation Date Soc"; Date)
        {
            Caption = 'Creation Date Soc';

            trigger OnValidate()
            begin
                IF "DEL Realisation Date Soc" <> 0D THEN BEGIN

                    TESTFIELD("DEL Note Soc");
                    Note_Rec.RESET;

                    IF Note_Rec.GET("DEL Note Soc", Note_Rec."Type audit"::social) THEN
                        IF FORMAT(Note_Rec."Revision Calculation") = '' THEN
                            VALIDATE("DEL Revision Date Soc", 0D)
                        ELSE BEGIN
                            "DEL Revision Date Soc" := CALCDATE(Note_Rec."Revision Calculation", "DEL Realisation Date Soc");
                            VALIDATE("DEL Revision Date Soc");
                        END;
                END;
            end;
        }
        field(60006; "DEL Revision Date Soc"; Date)
        {
            Caption = 'Expired Date Soc';
        }
        field(60007; "DEL Note Env"; Code[10])
        {
            Caption = 'Environmental rating';
            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(Environmental));

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
        field(60008; "DEL Realisation Date Env"; Date)
        {
            Caption = 'Creation Date Env';

            trigger OnValidate()
            begin
                IF "DEL Realisation Date Env" <> 0D THEN BEGIN
                    TESTFIELD("DEL Note Env");
                    Note_Rec.RESET();
                    IF Note_Rec.GET("DEL Note Env", Note_Rec."Type audit"::Environmental) THEN
                        IF FORMAT(Note_Rec."Revision Calculation") = '' THEN
                            VALIDATE("DEL Revision Date env", 0D)
                        ELSE BEGIN
                            "DEL Revision Date env" := CALCDATE(Note_Rec."Revision Calculation", "DEL Realisation Date Env");
                            VALIDATE("DEL Revision Date env");
                        END;
                END;
            end;
        }
        field(60009; "DEL Revision Date env"; Date)
        {
            Caption = 'Expired Date Env';
        }
        field(60012; "DEL URL Quality"; Text[250])
        {
            CalcFormula = Lookup("DEL Document Line"."File Name" WHERE("Table Name" = FILTER(Contact),
                                                                    "No." = FIELD("No."),
                                                                    "Notation Type" = FILTER(Quality)));
            Caption = 'URL Quality';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60013; "DEL URL social"; Text[250])
        {
            CalcFormula = Lookup("DEL Document Line"."File Name" WHERE("Table Name" = FILTER(Contact),
                                                                    "No." = FIELD("No."),
                                                                    "Notation Type" = FILTER(Social)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60014; "DEL URL Environmental"; Text[250])
        {
            CalcFormula = Lookup("DEL Document Line"."File Name" WHERE("Table Name" = FILTER(Contact),
                                                                    "No." = FIELD("No."),
                                                                    "Notation Type" = FILTER(Environmental)));
            Caption = 'URL Environmental';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60015; "DEL Quality status"; Option)
        {
            Caption = 'Quality status';
            OptionCaption = ' ,Inactif,Actif';
            OptionMembers = " ",Inactif,Actif;
        }
        field(60016; "DEL Social status"; Option)
        {
            Caption = 'Social status';
            OptionCaption = ' ,Inactif,Actif';
            OptionMembers = " ",Inactif,Actif;
        }
        field(60017; "DEL Environmental status"; Option)
        {
            Caption = 'Environmental status';
            OptionCaption = ' ,Inactif,Actif';
            OptionMembers = " ",Inactif,Actif;
        }
        field(70000; "DEL Type Contact"; Option)
        {
            Caption = 'Contact Type';
            OptionCaption = 'Commercial,Juridical,Accountant,Quality';
            OptionMembers = Commercial,Juridical,Accountant,Quality;
        }
        field(70001; "DEL Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(70002; "DEL Name Contact"; Text[20])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                //START THM080517
                Name := "DEL Name Contact" + ' ' + "DEL First Name Contact";
                //END THM080517
            end;
        }
        field(70003; "DEL First Name Contact"; Text[30])
        {
            Caption = 'First Name';

            trigger OnValidate()
            begin
                //START THM080517
                Name := "DEL Name Contact" + ' ' + "DEL First Name Contact";
                //END THM080517
            end;
        }
    }

    var

        Note_Rec: Record "DEL Note";
}

