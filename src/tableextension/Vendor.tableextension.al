tableextension 50023 "DEL Vendor" extends Vendor
{

    fields
    {

        field(50000; "DEL Forwarding Agent Code"; Code[20])
        {
            Caption = 'Forwarding Agent Code';
            Description = 'EDI';
            TableRelation = "DEL Forwarding agent 2";
            DataClassification = CustomerContent;
        }
        field(50010; "DEL Statut CG"; enum "DEL Statut CG")
        {
            Caption = 'General purchasing term';
            DataClassification = CustomerContent;
        }
        field(50011; "DEL Date de maj statut CG"; Date)
        {
            Caption = 'Update date of the statut';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(50014; "DEL Date de maj statut CE"; Date)
        {
            Caption = 'Updated date CE';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(50017; "DEL EDI"; Boolean)
        {
            Caption = 'EDI';
            DataClassification = CustomerContent;
        }
        field(50018; "DEL Ship Per"; enum "DEL Ship Per")
        {
            Caption = 'Ship Per';
            DataClassification = CustomerContent;
        }
        field(50151; "DEL Email Payment Advice"; Code[20])
        {
            Caption = 'Sender Email Payment Advice';

            TableRelation = "DEL DocMatrix Email Codes".Code;
            DataClassification = CustomerContent;
        }
        field(60001; "DEL Note Quality"; Code[10])
        {
            Caption = 'Quality rating';
            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(Quality));
            DataClassification = CustomerContent;
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
                        "DEL Quality status" := "DEL Quality status"::Inactive;
                    MODIFY(TRUE);
                end;
            end;
        }
        field(60002; "DEL Realisation Date Quality"; Date)
        {
            Caption = 'Creation date QA';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF ("DEL Revision Date quality" = 0D) OR ("DEL Revision Date quality" < TODAY) THEN BEGIN
                    "DEL Qualified vendor" := FALSE;
                    "DEL Quality status" := "DEL Quality status"::Inactive;
                    "DEL Date updated" := TODAY;
                    MODIFY();
                END
                ELSE BEGIN
                    "DEL Quality status" := "DEL Quality status"::Active;
                    MODIFY(TRUE);

                END;
            end;
        }
        field(60004; "DEL Note Soc"; Code[10])
        {
            Caption = 'Social rating';
            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(social));
            DataClassification = CustomerContent;
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
                        "DEL Social status" := "DEL Social status"::Inactive;
                    MODIFY(TRUE);
                end;
            end;

        }
        field(60005; "DEL Realisation Date Soc"; Date)
        {
            Caption = 'Creation date SA';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF ("DEL Revision Date Soc" = 0D) OR ("DEL Revision Date Soc" < TODAY) THEN BEGIN
                    "DEL Qualified vendor" := FALSE;
                    "DEL Social status" := "DEL Social status"::Inactive;
                    "DEL Date updated" := TODAY;
                    MODIFY();
                END
                ELSE BEGIN
                    "DEL Social status" := "DEL Social status"::Active;
                    MODIFY(TRUE);

                END;
            end;
        }
        field(60007; "DEL Note Env"; Code[10])
        {
            Caption = 'Environmental rating';
            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(Environmental));
            DataClassification = CustomerContent;
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
                    "DEL Environmental status" := "DEL Environmental status"::Inactive;
                MODIFY(TRUE);
            end;
        }
        field(60008; "DEL Realisation Date Env"; Date)
        {
            Caption = 'Creation date EA';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF ("DEL Revision Date env" = 0D) OR ("DEL Revision Date env" < TODAY) THEN BEGIN
                    "DEL Qualified vendor" := FALSE;
                    "DEL Environmental status" := "DEL Environmental status"::Inactive;
                    "DEL Date updated" := TODAY;
                    MODIFY();
                END
                ELSE BEGIN
                    "DEL Environmental status" := "DEL Environmental status"::Active;
                    MODIFY(TRUE);

                END;
            end;
        }
        field(60010; "DEL Qualified vendor"; Boolean)
        {
            Caption = 'Qualified vendor';
            DataClassification = CustomerContent;
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


                "DEL Date updated" := TODAY;

            end;
        }
        field(60011; "DEL Date updated"; Date)
        {
            Caption = 'Date updated';
            DataClassification = CustomerContent;
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
        field(60015; "DEL Quality status"; Enum "DEL Impact Status")
        {
            Caption = 'Quality status';
            DataClassification = CustomerContent;
        }
        field(60016; "DEL Social status"; Enum "DEL Impact Status")
        {
            Caption = 'Social status';
            DataClassification = CustomerContent;
        }
        field(60017; "DEL Environmental status"; Enum "DEL Impact Status")
        {
            Caption = 'Environmental status';
            DataClassification = CustomerContent;
        }
        field(60018; "DEL Derogation"; Boolean)
        {
            Caption = 'Dispensation';
            DataClassification = CustomerContent;
        }
        field(60019; "DEL Lead Time Not Allowed"; Boolean)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            Caption = 'Lead Time Not Allowed';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "DEL Supplier Base ID")
        {
        }
    }
    var


        Note_Rec: Record "DEL Note";
        Text50001: Label 'must be greater than';
        Text50002: Label 'must be less than';
        TextVar: Text;


}

