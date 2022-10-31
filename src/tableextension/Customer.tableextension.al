tableextension 50013 "DEL Customer" extends Customer //18
{



    fields
    {
        // TODO    
        // modify("Customer Price Group")
        //     {

        // //Unsupported feature: Property Modification (Data type) on ""Customer Price Group"(Field 23)".

        //         Description = 'MGTS0124';
        // Customer Price Group;Code20        ;OnLookup=BEGIN

        //                                                         //MGTS0124; MHH; begin
        //                                                         CustPriceGroup.RESET;
        //                                                         IF PAGE.RUNMODAL(0, CustPriceGroup) = ACTION::LookupOK THEN BEGIN
        //                                                           IF "Customer Price Group" = '' THEN
        //                                                             "Customer Price Group" := CustPriceGroup.Code
        //                                                           ELSE
        //                                                             "Customer Price Group" := STRSUBSTNO(Text50000, "Customer Price Group", CustPriceGroup.Code);
        //                                                         END;
        //                                                         //MGTS0124; MHH; end
        //                                                     END;
        //     }

        field(50000; "DEL No TVA intracomm. NGTS"; Code[30])
        {
        }
        field(50001; "DEL Fiscal Repr."; Code[10])
        {
            Caption = 'Fiscal Repr.';

            TableRelation = Contact;
        }
        field(50002; "DEL FTP Save"; Boolean)
        {
            Caption = 'FTP Save';



            trigger OnValidate()
            begin
                TESTFIELD("DEL FTP Save 2", FALSE)

            end;
        }
        field(50003; "DEL FTP Save 2"; Boolean)
        {
            Caption = 'FTP Save 2';



            trigger OnValidate()
            begin
                TESTFIELD("DEL FTP Save", FALSE)

            end;
        }
        field(50050; "DEL Mention Under Total"; Text[250])
        {
            Caption = 'Mention Under Total';

        }
        field(50051; "DEL Amount Mention Under Total"; Text[30])
        {
            Caption = 'Amount Mention Under Total';

        }
        field(50100; "DEL Partnership agreement"; Boolean)
        {
        }

        field(50101; "DEL Libellé PA"; Text[60])

        {
            Caption = 'Partnership agreement description';

            trigger OnValidate()
            begin

                TESTFIELD("DEL Partnership agreement", TRUE);
            end;
        }
        field(50102; "DEL Statut PA"; Enum "DEL Statut PA")
        {
            Caption = 'Partnership agreement status';

            trigger OnValidate()
            begin
                TESTFIELD("DEL Partnership agreement", TRUE);
            end;
        }
        field(50103; "DEL Date de début PA"; Date)

        {
            Caption = 'Starting date PA';

            trigger OnValidate()
            begin

                TESTFIELD("DEL Partnership agreement", TRUE);

            end;
        }
        field(50104; "DEL Date de fin PA"; Date)
        {
            Caption = 'End date PA';

            trigger OnValidate()
            begin

                TESTFIELD("DEL Partnership agreement", TRUE);

            end;
        }
        field(50105; "DEL Service agreement"; Boolean)
        {
            Caption = 'Service agreement';
        }

        field(50106; "DEL Libellé SSA"; Text[60])

        {
            Caption = 'Service agreement description';

            trigger OnValidate()
            begin

                TESTFIELD("DEL Service agreement", TRUE);
            end;
        }
        field(50107; "DEL Statut SSA"; Enum "DEL Statut PA")
        {
            Caption = 'Status SSA';


            trigger OnValidate()
            begin
                TESTFIELD("DEL Service agreement", TRUE);
            end;
        }
        field(50108; "DEL Date de début SSA"; Date)

        {
            Caption = 'Starting date SSA';

            trigger OnValidate()
            begin

                TESTFIELD("DEL Service agreement", TRUE);

            end;
        }
        field(50109; "DEL Date de fin SSA"; Date)
        {
            Caption = 'End date SSA';

            trigger OnValidate()
            begin

                TESTFIELD("DEL Service agreement", TRUE);

                IF "DEL Date de fin SSA" <> 0D THEN
                    "DEL Period of denunciation" := CALCDATE('<-25M>', "DEL Date de fin SSA")
                ELSE
                    "DEL Period of denunciation" := 0D;

            end;
        }
        field(50110; "DEL Fréquence de facturation"; Enum "DEL Fréquence de facturation")
        {
            Caption = 'Frequency of invoicing';

            trigger OnValidate()
            begin
                TESTFIELD("DEL Service agreement", TRUE);
            end;
        }
        field(50111; "DEL Date de proch. fact."; Date)
        {
            Caption = 'Next invoice date';
        }
        field(50112; "DEL Nbr jr avant proch. fact."; Integer)
        {
            Caption = 'Nb of days before invoicing';
        }
        field(50113; "DEL Level"; Enum "DEL Level")
        {
            Caption = 'Level';

            trigger OnValidate()
            begin
                TESTFIELD("DEL Service agreement", TRUE);

            end;
        }
        field(50114; "DEL Reporting vente"; Boolean)
        {
            Caption = 'Sales reports';

            trigger OnValidate()
            begin

                TESTFIELD("DEL Service agreement", TRUE);

            end;
        }
        field(50115; "DEL Last Accounting Date"; Date)
        {
            Caption = 'Last accounting date';
        }
        field(50116; "DEL Facture"; Code[20])
        {
            Caption = 'Invoce No.';
        }
        field(50117; "DEL Montant"; Decimal)
        {
            Caption = 'Amount';
        }
        field(50119; "DEL Montant ouvert"; Decimal)
        {
            Caption = 'Pending amount';
        }

        field(50120; "DEL Statut CE"; Enum "DEL Statut CE")
        {
            Caption = 'Ethical Charter status';

        }
        field(50121; "DEL Date Signature CE"; Date)
        {
            Caption = 'Date of signature EC';
        }

        field(50122; "DEL URL document CE"; Text[250])
        {
            CalcFormula = Lookup("DEL Document Line"."File Name" WHERE("Table Name" = FILTER(Customer),
                                                                    "No." = FIELD("No."),
                                                                    "Notation Type" = FILTER(' '),
                                                                    "Type liasse" = FILTER(' '),
                                                                    "Type contrat" = FILTER('Charte ethique')));

            Caption = 'URL document CE';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50123; "DEL URL document PA"; Text[250])
        {
            CalcFormula = Lookup("DEL Document Line"."File Name" WHERE("Table Name" = FILTER(Customer),
                                                                    "No." = FIELD("No."),
                                                                    "Notation Type" = FILTER(' '),
                                                                    "Type liasse" = FILTER(' '),
                                                                    "Type contrat" = FILTER(Partnership)));

            Caption = 'URL document PA';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50124; "DEL URL document SSA"; Text[250])
        {
            CalcFormula = Lookup("DEL Document Line"."File Name" WHERE("Table Name" = FILTER(Customer),
                                                                    "No." = FIELD("No."),
                                                                    "Notation Type" = FILTER(' '),
                                                                    "Type liasse" = FILTER(' '),
                                                                    "Type contrat" = FILTER(Service)));

            Caption = 'URL document SSA';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50125; "DEL Comment PA"; Text[80])
        {

            CalcFormula = Lookup("Comment Line".Comment WHERE("Table Name" = CONST(Customer),
                                                               "No." = FIELD("No."),
                                                   "DEL Type contrat" = FILTER(Partnership)));

            Caption = 'Comment PA';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50126; "DEL Comment SSA"; Text[80])
        {

            CalcFormula = Lookup("Comment Line".Comment WHERE("Table Name" = CONST(Customer),
                                                               "No." = FIELD("No."),
                                                               "DEL Type contrat" = FILTER(Service)));

            Caption = 'Comment SSA';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50127; "DEL Period of denunciation"; Date)
        {
            Caption = 'Period of denunciation';
        }
        field(50128; "DEL Denunciation to analyze"; Boolean)
        {
            Caption = 'Denunciation to analyze';
        }
        field(50129; "DEL Denunciation Replanned"; Boolean)
        {
            Caption = 'Denunciation Replanned';

            trigger OnValidate()
            begin


                IF "DEL Denunciation Replanned" THEN BEGIN
                    "DEL Denunciation to analyze" := FALSE;
                    "DEL Denunciation realised" := FALSE;
                    "DEL Not denunciation" := FALSE;
                END;

            end;
        }
        field(50130; "DEL Denunciation realised"; Boolean)
        {
            Caption = 'Denunciation realised';

            trigger OnValidate()
            begin


                IF "DEL Denunciation realised" THEN BEGIN
                    "DEL Period of denunciation" := 0D;
                    "DEL Denunciation to analyze" := FALSE;
                    "DEL Denunciation Replanned" := FALSE;
                    "DEL Not denunciation" := FALSE;
                END;


            end;
        }
        field(50131; "DEL Denunciation date"; Date)
        {
            Caption = 'Denunciation Date';
        }
        field(50132; "DEL Not denunciation"; Boolean)
        {
            Caption = 'Pas de dénonciation';

            trigger OnValidate()
            begin


                IF "DEL Not denunciation" THEN BEGIN
                    "DEL Period of denunciation" := 0D;
                    "DEL Denunciation to analyze" := FALSE;
                    "DEL Denunciation Replanned" := FALSE;
                    "DEL Denunciation date" := 0D;
                    "DEL Denunciation realised" := FALSE;
                END;

            end;
        }
        field(50133; "DEL Annexe A PA"; Boolean)
        {
            Caption = 'A';
        }
        field(50134; "DEL Annexe B PA"; Boolean)
        {
            Caption = 'B';
        }
        field(50135; "DEL Annexe C PA"; Boolean)
        {
            Caption = 'C';
        }
        field(50136; "DEL Annexe D PA"; Boolean)
        {
            Caption = 'D';
        }
        field(50137; "DEL En facturation"; Boolean)
        {
            Caption = 'Invoicing';
        }
        field(50138; "DEL Renouvellement tacite"; Boolean)
        {
            Caption = 'Tacit renewal';
        }
        field(50139; "DEL Annexe A SSA"; Boolean)
        {
            Caption = 'A';
        }
        field(50140; "DEL Comment denunciation"; Text[80])
        {

            CalcFormula = Lookup("Comment Line".Comment WHERE("Table Name" = CONST(Customer),
                                                              "No." = FIELD("No."),
                                                               "DEL Type contrat" = FILTER(Denunciation)));

            Caption = 'Comment denunciation';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50141; "DEL Start date of Relationship"; Date)

        {
            Caption = 'Starting date of Relationship';
        }
        field(50142; "DEL Quote part 1 Mobivia/CA %"; Decimal)
        {
            Caption = 'Quote part 1 Mobivia/CA %';
        }
        field(50143; "DEL Quote part 2 Mobivia/CA %"; Decimal)
        {
            Caption = 'Quote part 2 Mobivia/CA %';
        }

        field(50144; "DEL Qte part 1 Mobivia/CA Year"; Integer)
        {
            Caption = 'Quote part 1 Mobivia/CA Year';
        }
        field(50145; "DEL Qte part 2 Mobivia/CA Year"; Integer)

        {
            Caption = 'Quote part 2 Mobivia/CA Year';
        }
        field(50146; "DEL Renewal by mail"; Boolean)
        {
            Caption = 'Renewal by mail';
        }
        field(50147; "DEL Renewal by endorsement"; Boolean)
        {
            Caption = 'Renewal by endorsement';
        }

        field(50148; "DEL Change VAT Reg. Place"; Boolean)
        {
            Caption = 'Change VAT Registration Place';

        }
        field(50149; "DEL EDI"; Boolean)
        {
            Caption = 'EDI';


        }
        field(50150; "DEL Show VAT In Invoice"; Boolean)
        {
            Caption = 'Show VAT In Invoice';

        }
        field(60001; "DEL Note Quality"; Code[10])
        {
            Caption = 'Quality rating';

            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(Quality));

        }
        field(60002; "DEL Realisation Date Quality"; Date)
        {
            Caption = 'Creation date QA';
        }
        field(60100; "DEL Note Soc"; Code[10])
        {
            Caption = 'Social rating';

            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(social));

        }
        field(60101; "DEL Realisation Date Soc"; Date)
        {
            Caption = 'Creation date';
        }
        field(60102; "DEL Note Env"; Code[10])
        {
            Caption = 'Environmental rating';

            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(Environmental));

        }
        field(60103; "DEL Realisation Date Env"; Date)
        {
            Caption = 'Creation date';
        }
        field(60104; "DEL National Mark"; Boolean)
        {
            Caption = 'National Mark';
        }
        field(60105; "DEL MDD"; Boolean)
        {
        }
        field(60106; "DEL NORAUTO"; Boolean)
        {
        }
        field(60107; "DEL MIDAS"; Boolean)
        {
        }
        field(60108; "DEL ATU"; Boolean)
        {
        }
        field(60109; "DEL ATYSE"; Boolean)
        {
        }
        field(60110; "DEL CARTER CASH"; Boolean)
        {
        }
        field(60111; "DEL Parent Company"; Text[30])
        {
        }
        field(60112; "DEL Segmentation Prod Niveau"; Text[160])
        {
            Caption = 'Segmentation Produit Niveau';
        }
        field(60113; "DEL Amount YTD"; Decimal)
        {
            Caption = 'Amount YTD';
            Editable = false;
        }
        field(60114; "DEL Amount YTD-1"; Decimal)
        {
            Caption = 'Amount YTD-1';
            Editable = false;
        }
        field(60115; "DEL Amount YTD-2"; Decimal)
        {
            Caption = 'Amount YTD-2';
            Editable = false;
        }
        field(60116; "DEL SYNCHRO"; Boolean)
        {
        }
        field(60117; "DEL Segmentation Description"; Text[250])
        {
            Caption = 'Segmentation Description';

            TableRelation = "Dimension Value".Name WHERE("Dimension Code" = FILTER('SEGMENT'));

            ValidateTableRelation = false;
        }
        field(60118; "DEL Shruvat"; Boolean)
        {
        }
        field(60119; "DEL Bythjul"; Boolean)
        {
        }
        field(60120; "DEL Central trading"; Boolean)
        {
            Caption = 'Central trading';
        }
        field(60121; "DEL Sales data report"; Boolean)
        {
            Caption = 'Sales data report';
        }

        field(60122; "DEL Ass. in relat. with the BU"; Boolean)

        {
            Caption = 'Assist in relations with the BU (Blue Helmets)';
        }
        field(60123; "DEL Organization of visits"; Boolean)
        {
            Caption = 'Organization of visits';
        }
        field(60124; "DEL Vision and Market Analysis"; Boolean)
        {
            Caption = 'Vision and Market Analysis';
        }

        field(60125; "DEL Pres. provider strategy"; Boolean)
        {
            Caption = 'Presentation provider strategy';
        }
        field(60126; "DEL Pres. MOBIVIA strategy"; Boolean)
        {
            Caption = 'Presentation MOBIVIA strategy';
        }
        field(60127; "DEL Adv on the adapt.of the offer"; Boolean)

        {
            Caption = 'Advising on the adaptation of the offer';
        }
        field(60128; "DEL Favorite referencing by BU"; Boolean)
        {
            Caption = 'Favorite referencing by BU';
        }
        field(60129; "DEL Forecast"; Boolean)
        {
            Caption = 'Forecast';
        }

        field(60130; "DEL Frequency of delivery 1"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';

        }
        field(60131; "DEL Invoicing Frequency 1"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';


        }
        field(60132; "DEL Frequency of delivery 2"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';


        }
        field(60133; "DEL Invoicing Frequency 2"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';


        }
        field(60134; "DEL Frequency of delivery 3"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';

        }
        field(60135; "DEL Invoicing Frequency 3"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';

        }
        field(60136; "DEL Frequency of delivery 4"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';

        }
        field(60137; "DEL Invoicing Frequency 4"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';

        }
        field(60138; "DEL Frequency of delivery 5"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';

        }
        field(60139; "DEL Invoicing Frequency 5"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';

        }
        field(60140; "DEL Frequency of delivery 6"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';

        }
        field(60141; "DEL Invoicing Frequency 6"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';

        }
        field(60142; "DEL Frequency of delivery 7"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';

        }
        field(60143; "DEL Invoicing Frequency 7"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';

        }
        field(60144; "DEL Frequency of delivery 8"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';

        }
        field(60145; "DEL Invoicing Frequency 8"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';

        }
        field(60146; "DEL Frequency of delivery 9"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';

        }
        field(60147; "DEL Invoicing Frequency 9"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';

        }
        field(60148; "DEL Frequency of delivery 10"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';

        }
        field(60149; "DEL Invoicing Frequency 10"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';


        }
    }

}

