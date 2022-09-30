tableextension 50023 "DEL Vendor" extends Vendor
{

    fields
    {


        //Unsupported feature: Code Modification on ""IC Partner Code"(Field 119).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF xRec."IC Partner Code" <> "IC Partner Code" THEN BEGIN
          IF NOT VendLedgEntry.SETCURRENTKEY("Vendor No.",Open) THEN
            VendLedgEntry.SETCURRENTKEY("Vendor No.");
        #4..29
          ICPartner."Vendor No." := '';
          ICPartner.MODIFY;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //MIG2017 START
        // LOCO/ChC/EDI -
        {
        #1..32
        }
        // LOCO/ChC/EDI -
        //MIG2017 EN
        */
        //end;
        field(50000; "DEL Forwarding Agent Code"; Code[20])
        {
            Caption = 'Forwarding Agent Code';
            Description = 'EDI';
            TableRelation = "DEL Forwarding agent 2";
        }
        field(50010; "DEL Statut CG"; enum "DEL Statut CG")
        {
            Caption = 'General purchasing term';

        }
        field(50011; "DEL Date de maj statut CG"; Date)
        {
            Caption = 'Update date of the statut';
        }
        field(50012; "DEL URL document CG"; Text[250])
        {
            CalcFormula = Lookup("DEL Document Line"."File Name" WHERE("Table Name" = FILTER(Vendor),
                                                                    "No." = FIELD("No."),
                                                                    "Notation Type" = FILTER(' '),
                                                                    "Type liasse" = FILTER("CG d'achats NGTS")));
            Caption = 'Purchasing Term URL';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013; "DEL Statut CE"; Enum "DEL Statut CE")
        {
            Caption = 'Ethical charter';

        }
        field(50014; "DEL Date de maj statut CE"; Date)
        {
            Caption = 'Updated date CE';
        }
        field(50015; "DEL URL document CE"; Text[250])
        {
            CalcFormula = Lookup("DEL Document Line"."File Name" WHERE("Table Name" = FILTER(Vendor),
                                                                    "No." = FIELD("No."),
                                                                    "Notation Type" = FILTER(' '),
                                                                    "Type liasse" = FILTER("Charte ethique")));
            Caption = 'Ethical charter URL';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50016; "DEL Supplier Base ID"; Text[50])
        {
            Caption = 'Supplier Base ID';
        }
        field(50017; "DEL EDI"; Boolean)
        {
            Caption = 'EDI';

        }
        field(50018; "DEL Ship Per"; enum "DEL Ship Per")
        {
            Caption = 'Ship Per';


        }
        field(50151; "DEL Email Payment Advice"; Code[20])
        {
            Caption = 'Sender Email Payment Advice';

            TableRelation = "DEL DocMatrix Email Codes".Code;
        }
        field(60001; "DEL Note Quality"; Code[10])
        {
            Caption = 'Quality rating';
            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(Quality));

            trigger OnValidate()
            begin
                IF "DEL Realisation Date Quality" <> 0D THEN BEGIN
                    TESTFIELD("DEL Note Quality");
                    Note_Rec.RESET();
                    IF Note_Rec.GET("DEL Note Quality", Note_Rec."Type audit"::Quality) THEN
                        IF FORMAT(Note_Rec."Revision Calculation") = '+99A' THEN
                            VALIDATE("DEL Revision Date quality", 19991231D)
                        ELSE

                            IF FORMAT(Note_Rec."Revision Calculation") = '' THEN
                                VALIDATE("DEL Revision Date quality", 0D)
                            ELSE BEGIN
                                "DEL Revision Date quality" := CALCDATE(Note_Rec."Revision Calculation", "DEL Realisation Date Quality");
                                VALIDATE("DEL Revision Date quality");


                            END;
                    Note_Rec.RESET();
                    IF Note_Rec.GET("DEL Note Quality", Note_Rec."Type audit"::Quality) THEN
                        "DEL Quality status" := Note_Rec."Impact statut"

                    ELSE
                        "DEL Quality status" := "DEL Quality status"::Inactif;
                    MODIFY(TRUE);
                end;
            end;
        }
        field(60002; "DEL Realisation Date Quality"; Date)
        {
            Caption = 'Creation date QA';

            trigger OnValidate()
            begin
                IF "DEL Realisation Date Quality" > TODAY THEN BEGIN
                    TextVar := FIELDCAPTION("DEL Realisation Date Quality") + ' ' + Text50002 + ' ' + FORMAT(TODAY);
                    ERROR(TextVar);
                END;

                IF "DEL Realisation Date Quality" <> 0D THEN BEGIN
                    TESTFIELD("DEL Note Quality");
                    Note_Rec.RESET();
                    IF Note_Rec.GET("DEL Note Quality", Note_Rec."Type audit"::Quality) THEN
                        IF FORMAT(Note_Rec."Revision Calculation") = '+99A' THEN
                            VALIDATE("DEL Revision Date quality", 19991231D)
                        ELSE
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
            Caption = 'Expired date QA';

            trigger OnValidate()
            begin
                IF ("DEL Revision Date quality" = 0D) OR ("DEL Revision Date quality" < TODAY) THEN BEGIN
                    "DEL Qualified vendor" := FALSE;
                    "DEL Quality status" := "DEL Quality status"::Inactif;
                    "DEL Date updated" := TODAY;
                    MODIFY();
                END
                ELSE BEGIN
                    "DEL Quality status" := "DEL Quality status"::Actif;
                    MODIFY(TRUE);

                END;
            end;
        }
        field(60004; "DEL Note Soc"; Code[10])
        {
            Caption = 'Social rating';
            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(social));

            trigger OnValidate()
            begin
                IF "DEL Realisation Date Soc" <> 0D THEN BEGIN
                    TESTFIELD("DEL Note Soc");
                    Note_Rec.RESET();
                    IF Note_Rec.GET("DEL Note Soc", Note_Rec."Type audit"::social) THEN
                        IF FORMAT(Note_Rec."Revision Calculation") = '+99A' THEN
                            VALIDATE("DEL Revision Date Soc", 19991231D)
                        ELSE
                            IF FORMAT(Note_Rec."Revision Calculation") = '' THEN
                                VALIDATE("DEL Revision Date Soc", 0D)
                            ELSE BEGIN
                                "DEL Revision Date Soc" := CALCDATE(Note_Rec."Revision Calculation", "DEL Realisation Date Soc");
                                VALIDATE("DEL Revision Date Soc");
                            END;


                    Note_Rec.RESET();
                    IF Note_Rec.GET("DEL Note Soc", Note_Rec."Type audit"::social) THEN
                        "DEL Social status" := Note_Rec."Impact statut"

                    ELSE
                        "DEL Social status" := "DEL Social status"::Inactif;
                    MODIFY(TRUE);
                end;
            end;

        }
        field(60005; "DEL Realisation Date Soc"; Date)
        {
            Caption = 'Creation date SA';

            trigger OnValidate()
            begin
                IF "DEL Realisation Date Soc" > TODAY THEN BEGIN
                    TextVar := FIELDCAPTION("DEL Realisation Date Soc") + ' ' + Text50002 + ' ' + FORMAT(TODAY);
                    ERROR(TextVar);
                END;


                IF "DEL Realisation Date Soc" <> 0D THEN BEGIN
                    TESTFIELD("DEL Note Soc");
                    Note_Rec.RESET();
                    IF Note_Rec.GET("DEL Note Soc", Note_Rec."Type audit"::social) THEN BEGIN
                        IF FORMAT(Note_Rec."Revision Calculation") = '+99A' THEN
                            VALIDATE("DEL Revision Date Soc", 19991231D)
                        ELSE BEGIN
                            IF FORMAT(Note_Rec."Revision Calculation") = '' THEN
                                VALIDATE("DEL Revision Date Soc", 0D)
                            ELSE BEGIN
                                "DEL Revision Date Soc" := CALCDATE(Note_Rec."Revision Calculation", "DEL Realisation Date Soc");
                                VALIDATE("DEL Revision Date Soc");
                            END;
                        END;
                    END;
                END;
            end;
        }
        field(60006; "DEL Revision Date Soc"; Date)
        {
            Caption = 'Expired date SA';

            trigger OnValidate()
            begin
                IF ("DEL Revision Date Soc" = 0D) OR ("DEL Revision Date Soc" < TODAY) THEN BEGIN
                    "DEL Qualified vendor" := FALSE;
                    "DEL Social status" := "DEL Social status"::Inactif;
                    "DEL Date updated" := TODAY;
                    MODIFY();
                END
                ELSE BEGIN
                    "DEL Social status" := "DEL Social status"::Actif;
                    MODIFY(TRUE);

                END;
            end;
        }
        field(60007; "DEL Note Env"; Code[10])
        {
            Caption = 'Environmental rating';
            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(Environmental));

            trigger OnValidate()
            begin
                IF "DEL Realisation Date Env" <> 0D THEN BEGIN
                    TESTFIELD("DEL Note Env");
                    Note_Rec.RESET();
                    IF Note_Rec.GET("DEL Note Env", Note_Rec."Type audit"::Environmental) THEN BEGIN
                        IF FORMAT(Note_Rec."Revision Calculation") = '+99A' THEN
                            VALIDATE("DEL Revision Date env", 19991231D)
                        ELSE BEGIN
                            IF FORMAT(Note_Rec."Revision Calculation") = '' THEN
                                VALIDATE("DEL Revision Date env", 0D)
                            ELSE BEGIN
                                "DEL Revision Date env" := CALCDATE(Note_Rec."Revision Calculation", "DEL Realisation Date Env");
                                VALIDATE("DEL Revision Date env");
                            END;
                        END;
                    END;
                END;

                Note_Rec.RESET();
                IF Note_Rec.GET("DEL Note Env", Note_Rec."Type audit"::Environmental) THEN BEGIN
                    "DEL Environmental status" := Note_Rec."Impact statut";
                END
                ELSE
                    "DEL Environmental status" := "DEL Environmental status"::Inactif;
                MODIFY(TRUE);
            end;
        }
        field(60008; "DEL Realisation Date Env"; Date)
        {
            Caption = 'Creation date EA';

            trigger OnValidate()
            begin
                IF "DEL Realisation Date Env" > TODAY THEN BEGIN
                    TextVar := FIELDCAPTION("DEL Realisation Date Env") + ' ' + Text50002 + ' ' + FORMAT(TODAY);
                    ERROR(TextVar);
                END;


                IF "DEL Realisation Date Env" <> 0D THEN BEGIN
                    TESTFIELD("DEL Note Env");
                    Note_Rec.RESET();
                    IF Note_Rec.GET("DEL Note Env", Note_Rec."Type audit"::Environmental) THEN
                        IF FORMAT(Note_Rec."Revision Calculation") = '+99A' THEN
                            VALIDATE("DEL Revision Date env", 19991231D)
                        ELSE BEGIN
                            IF FORMAT(Note_Rec."Revision Calculation") = '' THEN
                                VALIDATE("DEL Revision Date env", 0D)
                            ELSE BEGIN
                                "DEL Revision Date env" := CALCDATE(Note_Rec."Revision Calculation", "DEL Realisation Date Env");
                                VALIDATE("DEL Revision Date env");
                            END;
                        END;

                END;
            end;
        }
        field(60009; "DEL Revision Date env"; Date)
        {
            Caption = 'Expired date EA';

            trigger OnValidate()
            begin
                IF ("DEL Revision Date env" = 0D) OR ("DEL Revision Date env" < TODAY) THEN BEGIN
                    "DEL Qualified vendor" := FALSE;
                    "DEL Environmental status" := "DEL Environmental status"::Inactif;
                    "DEL Date updated" := TODAY;
                    MODIFY();
                END
                ELSE BEGIN
                    "DEL Environmental status" := "DEL Environmental status"::Actif;
                    MODIFY(TRUE);

                END;
            end;
        }
        field(60010; "DEL Qualified vendor"; Boolean)
        {
            Caption = 'Qualified vendor';

            trigger OnValidate()
            begin
                IF "DEL Revision Date quality" < "DEL Realisation Date Quality" THEN BEGIN
                    TextVar := FIELDCAPTION("DEL Revision Date quality") + ' ' + Text50001 + ' ' + FIELDCAPTION("DEL Realisation Date Quality");
                    ERROR(TextVar);
                END;

                IF "DEL Revision Date Soc" < "DEL Realisation Date Soc" THEN BEGIN
                    TextVar := FIELDCAPTION("DEL Revision Date Soc") + ' ' + Text50001 + ' ' + FIELDCAPTION("DEL Realisation Date Soc");
                    ERROR(TextVar);
                END;

                IF "DEL Revision Date env" < "DEL Realisation Date Env" THEN BEGIN
                    TextVar := FIELDCAPTION("DEL Revision Date env") + ' ' + Text50001 + ' ' + FIELDCAPTION("DEL Realisation Date Env");
                    ERROR(TextVar);
                END;

                //MGTS10.020; 002; ehh; begin
                //deleted line: TESTFIELD("DEL Revision Date quality");
                /*
                TESTFIELD("DEL Revision Date Soc");
                TESTFIELD("DEL Revision Date env");
                */
                //MGTS10.020; 002; ehh; begin

                "DEL Date updated" := TODAY;

            end;
        }
        field(60011; "DEL Date updated"; Date)
        {
            Caption = 'Date updated';
        }
        field(60012; "DEL URL Quality"; Text[250])
        {
            CalcFormula = Lookup("DEL Document Line"."File Name" WHERE("Table Name" = FILTER(Vendor),
                                                                    "No." = FIELD("No."),
                                                                    "Notation Type" = FILTER(Quality)));
            Caption = 'URL Quality';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60013; "DEL URL social"; Text[250])
        {
            CalcFormula = Lookup("DEL Document Line"."File Name" WHERE("Table Name" = FILTER(Vendor),
                                                                    "No." = FIELD("No."),
                                                                    "Notation Type" = FILTER(Social)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60014; "DEL URL Environmental"; Text[250])
        {
            CalcFormula = Lookup("DEL Document Line"."File Name" WHERE("Table Name" = FILTER(Vendor),
                                                                    "No." = FIELD("No."),
                                                                    "Notation Type" = FILTER(Environmental)));
            Caption = 'URL Environmental';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60015; "DEL Quality status"; Option)
        {
            Caption = 'Quality status';
            OptionCaption = ' ,Inactive,Active';
            OptionMembers = " ",Inactif,Actif;
        }
        field(60016; "DEL Social status"; Option)
        {
            Caption = 'Social status';
            OptionCaption = ' ,Inactive,Active';
            OptionMembers = " ",Inactif,Actif;
        }
        field(60017; "DEL Environmental status"; Option)
        {
            Caption = 'Environmental status';
            OptionCaption = ' ,Inactive,Active';
            OptionMembers = " ",Inactif,Actif;
        }
        field(60018; "DEL Derogation"; Boolean)
        {
            Caption = 'Dispensation';
        }
        field(60019; "DEL Lead Time Not Allowed"; Boolean)
        {
            AccessByPermission = TableData 120 = R;
            Caption = 'Lead Time Not Allowed';
        }
    }
    keys
    {
        key(Key1; "DEL Supplier Base ID")
        {
        }
    }
    var
        GeneralSetup: Record 50000;


        Note_Rec: Record 50019;
        TextVar: Text;
        Text50001: Label 'must be greater than';
        Text50002: Label 'must be less than';

    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Last Date Modified" := TODAY;

    IF (Name <> xRec.Name) OR
    #4..27
        IF FIND THEN;
      END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..30

    //MIG2017 START
    // START T-00652
    //IF "Vendor Posting Group"='MARCH' THEN
    //BEGIN
    //IF ("Quality status"="Quality status"::Actif) AND ("Social status"="Social status"::Actif) AND ("Environmental status"="Environmental status"::Actif) THEN
     //BEGIN
      //"Qualified vendor":=TRUE;
      //"Date updated":=TODAY;
      //MODIFY;
     //END
     //ELSE
     //BEGIN
      //"Qualified vendor":=FALSE;
      //"Date updated":=TODAY;
      //MODIFY;
     //END;
     //END;

    //START T-00652
    //MIG2017 END
    */
    //end;


}

