tableextension 50017 tableextension50017 extends Vendor
{
    // 
    // EDI       22.05.13/LOCO/ChC- New field 50002, Disable Code IC Partner Code - OnValidate()
    // 
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00652     THM      24.03.14           add fields 60001..60017
    //             THM      04.04.14           ajout gestion de blocage fournisseur si statut innactif
    //             THM      16.04.14           Ajout filtre group compta fournisseur
    //             THM      22.04.14           Suppression de blocage
    //             THM      23.04.14           add field 60018
    //             THM      23.04.14           ajout controle date de realisation
    //             THM      24.04.14           Ajout date de revision 31/12/9999
    // T-00678     THM      12.09.14           add field 50010..50015
    //             THM      29,09,14           rename field 50011 and  50014
    // T-00705     THM      19.06.15           Add CaptionMl fields 50000..60018
    //             THM      08.05.17           Correction CaptionML
    //             THM      08.09.17           MIG2017
    // 
    // Mgts10.00.01.00 | 11.01.2020 | JSON WS Mgt
    //                          Add Field : "Supplier Base ID"
    //                          Add Key   : "Supplier Base ID"
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Emil Hr. Hristov = ehh
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.009,MGTS10.020,MGTS10.023
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version       Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.009    09.09.20    ehh     List of changes:
    //                                           Added new field: ODI
    // 
    // 002     MGTS10.020    21.12.20    mhh     List of changes:
    //                                           Changed trigger: Qualified vendor - OnValidate()
    // 
    // 003     MGTS10.023    28.01.21    mhh     List of changes:
    //                                           Added new field: 50018 "Ship Per"
    // 
    // MGTS10.00.06.00    | 07.01.2022 | Send Payment Advice : List of changes:
    //                                              Added new field: 50019 "Email Payment Advice"
    // 
    // ------------------------------------------------------------------------------------------
    // 
    // 
    // MGTSEDI10.00.00.00 | 08.10.2020 | EDI Management : Add field : Lead Time Not Allowed
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
        field(50000; "Forwarding Agent Code"; Code[20])
        {
            Caption = 'Forwarding Agent Code';
            Description = 'EDI';
            TableRelation = "Forwarding agent 2";
        }
        field(50010; "Statut CG"; Option)
        {
            Caption = 'General purchasing term';
            OptionCaption = ' ,PT sent,PT signed';
            OptionMembers = " ","CGA envoyées","CGA signées";
        }
        field(50011; "Date de maj statut CG"; Date)
        {
            Caption = 'Update date of the statut';
        }
        field(50012; "URL document CG"; Text[60])
        {
            CalcFormula = Lookup ("Document Line"."File Name" WHERE (Table Name=FILTER(Vendor),
                                                                    No.=FIELD(No.),
                                                                    Notation Type=FILTER(' '),
                                                                    Type liasse=FILTER(CG d'achats NGTS)));
            Caption = 'Purchasing Term URL';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013;"Statut CE";Option)
        {
            Caption = 'Ethical charter';
            OptionCaption = ' ,Charter sent,Charter signed';
            OptionMembers = " ","Charte envoyée","Charte signée";
        }
        field(50014;"Date de maj statut CE";Date)
        {
            Caption = 'Updated date CE';
        }
        field(50015;"URL document CE";Text[60])
        {
            CalcFormula = Lookup("Document Line"."File Name" WHERE (Table Name=FILTER(Vendor),
                                                                    No.=FIELD(No.),
                                                                    Notation Type=FILTER(' '),
                                                                    Type liasse=FILTER(Charte ethique)));
            Caption = 'Ethical charter URL';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50016;"Supplier Base ID";Text[50])
        {
            Caption = 'Supplier Base ID';
        }
        field(50017;EDI;Boolean)
        {
            Caption = 'EDI';
            Description = 'MGTS10.009';
        }
        field(50018;"Ship Per";Option)
        {
            Caption = 'Ship Per';
            Description = 'MGTS10.023';
            OptionCaption = 'Air Flight,Sea Vessel,Sea/Air,Truck,Train';
            OptionMembers = "Air Flight","Sea Vessel","Sea/Air",Truck,Train;
        }
        field(50151;"Email Payment Advice";Code[20])
        {
            Caption = 'Sender Email Payment Advice';
            Description = 'MGTS10.00.06.00';
            TableRelation = "DocMatrix Email Codes".Code;
        }
        field(60001;"Note Quality";Code[10])
        {
            Caption = 'Quality rating';
            TableRelation = Note.Code WHERE (Type audit=FILTER(Quality));

            trigger OnValidate()
            begin
                IF "Realisation Date Quality"<>0D THEN
                BEGIN
                  TESTFIELD("Note Quality");
                  Note_Rec.RESET;
                  IF Note_Rec.GET("Note Quality",Note_Rec."Type audit"::Quality) THEN
                  BEGIN
                  IF FORMAT(Note_Rec."Revision Calculation")='+99A' THEN
                  VALIDATE("Revision Date quality",12319999D)
                  ELSE
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
                END;
                Note_Rec.RESET;
                IF Note_Rec.GET("Note Quality",Note_Rec."Type audit"::Quality) THEN
                BEGIN
                  "Quality status":=Note_Rec."Impact statut";
                END
                ELSE
                "Quality status":="Quality status"::Inactif;
                MODIFY(TRUE);
            end;
        }
        field(60002;"Realisation Date Quality";Date)
        {
            Caption = 'Creation date QA';

            trigger OnValidate()
            begin
                IF  "Realisation Date Quality">TODAY THEN
                BEGIN
                TextVar:=FIELDCAPTION( "Realisation Date Quality")+' '+Text50002+' '+FORMAT(TODAY);
                ERROR(TextVar);
                END;

                IF "Realisation Date Quality"<>0D THEN
                BEGIN
                  TESTFIELD("Note Quality");
                  Note_Rec.RESET;
                  IF Note_Rec.GET("Note Quality",Note_Rec."Type audit"::Quality) THEN
                  BEGIN
                  IF FORMAT(Note_Rec."Revision Calculation")='+99A' THEN
                  VALIDATE("Revision Date quality",12319999D)
                  ELSE
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
                END;
            end;
        }
        field(60003;"Revision Date quality";Date)
        {
            Caption = 'Expired date QA';

            trigger OnValidate()
            begin
                IF ( "Revision Date quality"=0D ) OR ("Revision Date quality"<TODAY) THEN
                BEGIN
                 "Qualified vendor":=FALSE;
                 "Quality status":="Quality status"::Inactif;
                 "Date updated":=TODAY;
                 MODIFY;
                END
                ELSE
                BEGIN
                 "Quality status":="Quality status"::Actif;
                 MODIFY(TRUE);

                END;
            end;
        }
        field(60004;"Note Soc";Code[10])
        {
            Caption = 'Social rating';
            TableRelation = Note.Code WHERE (Type audit=FILTER(social));

            trigger OnValidate()
            begin
                IF "Realisation Date Soc"<>0D THEN
                BEGIN
                  TESTFIELD("Note Soc");
                  Note_Rec.RESET;
                  IF Note_Rec.GET("Note Soc",Note_Rec."Type audit"::social) THEN
                  BEGIN
                  IF FORMAT(Note_Rec."Revision Calculation")='+99A' THEN
                  VALIDATE("Revision Date Soc",12319999D)
                  ELSE
                  BEGIN
                  IF  FORMAT(Note_Rec."Revision Calculation")='' THEN
                  BEGIN
                     VALIDATE("Revision Date Soc",0D);
                  END
                    ELSE
                    BEGIN
                    "Revision Date Soc":=CALCDATE(Note_Rec."Revision Calculation","Realisation Date Soc");
                    VALIDATE("Revision Date Soc");
                    END;
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
                MODIFY(TRUE);
            end;
        }
        field(60005;"Realisation Date Soc";Date)
        {
            Caption = 'Creation date SA';

            trigger OnValidate()
            begin
                IF  "Realisation Date Soc">TODAY THEN
                BEGIN
                TextVar:=FIELDCAPTION( "Realisation Date Soc")+' '+Text50002+' '+FORMAT(TODAY);
                ERROR(TextVar);
                END;


                IF "Realisation Date Soc"<>0D THEN
                BEGIN
                  TESTFIELD("Note Soc");
                  Note_Rec.RESET;
                  IF Note_Rec.GET("Note Soc",Note_Rec."Type audit"::social) THEN
                  BEGIN
                  IF FORMAT(Note_Rec."Revision Calculation")='+99A' THEN
                  VALIDATE("Revision Date Soc",12319999D)
                  ELSE
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
                END;
            end;
        }
        field(60006;"Revision Date Soc";Date)
        {
            Caption = 'Expired date SA';

            trigger OnValidate()
            begin
                IF ("Revision Date Soc"=0D) OR ("Revision Date Soc"<TODAY) THEN
                BEGIN
                 "Qualified vendor":=FALSE;
                 "Social status":="Social status"::Inactif;
                 "Date updated":=TODAY;
                 MODIFY;
                END
                ELSE
                BEGIN
                 "Social status":="Social status"::Actif;
                 MODIFY(TRUE);

                END;
            end;
        }
        field(60007;"Note Env";Code[10])
        {
            Caption = 'Environmental rating';
            TableRelation = Note.Code WHERE (Type audit=FILTER(Environmental));

            trigger OnValidate()
            begin
                IF "Realisation Date Env"<>0D THEN
                BEGIN
                  TESTFIELD("Note Env");
                  Note_Rec.RESET;
                  IF Note_Rec.GET("Note Env",Note_Rec."Type audit"::Environmental) THEN
                  BEGIN
                  IF FORMAT(Note_Rec."Revision Calculation")='+99A' THEN
                  VALIDATE("Revision Date env",12319999D)
                  ELSE
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
                END;

                Note_Rec.RESET;
                IF Note_Rec.GET("Note Env",Note_Rec."Type audit"::Environmental) THEN
                BEGIN
                  "Environmental status":=Note_Rec."Impact statut";
                END
                ELSE
                "Environmental status":="Environmental status"::Inactif;
                MODIFY(TRUE);
            end;
        }
        field(60008;"Realisation Date Env";Date)
        {
            Caption = 'Creation date EA';

            trigger OnValidate()
            begin
                IF "Realisation Date Env">TODAY THEN
                BEGIN
                TextVar:=FIELDCAPTION("Realisation Date Env")+' '+Text50002+' '+FORMAT(TODAY);
                ERROR(TextVar);
                END;


                IF "Realisation Date Env"<>0D THEN
                BEGIN
                  TESTFIELD("Note Env");
                  Note_Rec.RESET;
                  IF Note_Rec.GET("Note Env",Note_Rec."Type audit"::Environmental) THEN
                  BEGIN
                  IF FORMAT(Note_Rec."Revision Calculation")='+99A' THEN
                  VALIDATE("Revision Date env",12319999D)
                  ELSE
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
                END;
            end;
        }
        field(60009;"Revision Date env";Date)
        {
            Caption = 'Expired date EA';

            trigger OnValidate()
            begin
                IF ("Revision Date env"=0D) OR ("Revision Date env"<TODAY) THEN
                BEGIN
                 "Qualified vendor":=FALSE;
                 "Environmental status":="Environmental status"::Inactif;
                 "Date updated":=TODAY;
                 MODIFY;
                END
                ELSE
                BEGIN
                 "Environmental status":="Environmental status"::Actif;
                 MODIFY(TRUE);

                END;
            end;
        }
        field(60010;"Qualified vendor";Boolean)
        {
            Caption = 'Qualified vendor';

            trigger OnValidate()
            begin
                IF "Revision Date quality"<"Realisation Date Quality" THEN
                BEGIN
                TextVar:=FIELDCAPTION("Revision Date quality")+' '+Text50001+' '+FIELDCAPTION("Realisation Date Quality");
                ERROR(TextVar);
                END;
                
                IF "Revision Date Soc"<"Realisation Date Soc" THEN
                BEGIN
                TextVar:=FIELDCAPTION("Revision Date Soc")+' '+Text50001+' '+FIELDCAPTION("Realisation Date Soc");
                ERROR(TextVar);
                END;
                
                IF "Revision Date env"<"Realisation Date Env" THEN
                BEGIN
                TextVar:=FIELDCAPTION("Revision Date env")+' '+Text50001+' '+FIELDCAPTION("Realisation Date Env");
                ERROR(TextVar);
                END;
                
                //MGTS10.020; 002; ehh; begin
                //deleted line: TESTFIELD("Revision Date quality");
                /*
                TESTFIELD("Revision Date Soc");
                TESTFIELD("Revision Date env");
                */
                //MGTS10.020; 002; ehh; begin
                
                "Date updated":=TODAY;

            end;
        }
        field(60011;"Date updated";Date)
        {
            Caption = 'Date updated';
        }
        field(60012;"URL Quality";Text[60])
        {
            CalcFormula = Lookup("Document Line"."File Name" WHERE (Table Name=FILTER(Vendor),
                                                                    No.=FIELD(No.),
                                                                    Notation Type=FILTER(Quality)));
            Caption = 'URL Quality';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60013;"URL social";Text[60])
        {
            CalcFormula = Lookup("Document Line"."File Name" WHERE (Table Name=FILTER(Vendor),
                                                                    No.=FIELD(No.),
                                                                    Notation Type=FILTER(Social)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60014;"URL Environmental";Text[60])
        {
            CalcFormula = Lookup("Document Line"."File Name" WHERE (Table Name=FILTER(Vendor),
                                                                    No.=FIELD(No.),
                                                                    Notation Type=FILTER(Environmental)));
            Caption = 'URL Environmental';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60015;"Quality status";Option)
        {
            Caption = 'Quality status';
            OptionCaption = ' ,Inactive,Active';
            OptionMembers = " ",Inactif,Actif;
        }
        field(60016;"Social status";Option)
        {
            Caption = 'Social status';
            OptionCaption = ' ,Inactive,Active';
            OptionMembers = " ",Inactif,Actif;
        }
        field(60017;"Environmental status";Option)
        {
            Caption = 'Environmental status';
            OptionCaption = ' ,Inactive,Active';
            OptionMembers = " ",Inactif,Actif;
        }
        field(60018;Derogation;Boolean)
        {
            Caption = 'Dispensation';
        }
        field(60019;"Lead Time Not Allowed";Boolean)
        {
            AccessByPermission = TableData 120=R;
            Caption = 'Lead Time Not Allowed';
        }
    }
    keys
    {
        key(Key1;"Supplier Base ID")
        {
        }
    }


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

    var
        GeneralSetup: Record "50000";

    var
        Note_Rec: Record "50019";
        TextVar: Text;
        Text50001: Label 'must be greater than';
        Text50002: Label 'must be less than';
}

