tableextension 50013 "DEL Customer" extends Customer //18
{
    fields
    {

        field(50000; "DEL No TVA intracomm. NGTS"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(50001; "DEL Fiscal Repr."; Code[10])
        {
            Caption = 'Fiscal Repr.';

            TableRelation = Contact;
            DataClassification = CustomerContent;
        }
        field(50002; "DEL FTP Save"; Boolean)
        {
            Caption = 'FTP Save';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TESTFIELD("DEL FTP Save 2", FALSE)

            end;
        }
        field(50003; "DEL FTP Save 2"; Boolean)
        {
            Caption = 'FTP Save 2';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TESTFIELD("DEL FTP Save", FALSE)

            end;
        }
        field(50050; "DEL Mention Under Total"; Text[250])
        {
            Caption = 'Mention Under Total';
            DataClassification = CustomerContent;
        }
        field(50051; "DEL Amount Mention Under Total"; Text[30])
        {
            Caption = 'Amount Mention Under Total';
            DataClassification = CustomerContent;
        }
        field(50100; "DEL Partnership agreement"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(50101; "DEL Libellé PA"; Text[60])

        {
            Caption = 'Partnership agreement description';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TESTFIELD("DEL Partnership agreement", TRUE);
            end;
        }
        field(50102; "DEL Statut PA"; Enum "DEL Statut PA")
        {
            Caption = 'Partnership agreement status';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TESTFIELD("DEL Partnership agreement", TRUE);
            end;
        }
        field(50103; "DEL Date de début PA"; Date)

        {
            Caption = 'Starting date PA';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                TESTFIELD("DEL Partnership agreement", TRUE);

            end;
        }
        field(50104; "DEL Date de fin PA"; Date)
        {
            Caption = 'End date PA';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                TESTFIELD("DEL Partnership agreement", TRUE);

            end;
        }
        field(50105; "DEL Service agreement"; Boolean)
        {
            Caption = 'Service agreement';
            DataClassification = CustomerContent;
        }

        field(50106; "DEL Libellé SSA"; Text[60])

        {
            Caption = 'Service agreement description';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                TESTFIELD("DEL Service agreement", TRUE);
            end;
        }
        field(50107; "DEL Statut SSA"; Enum "DEL Statut PA")
        {
            Caption = 'Status SSA';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TESTFIELD("DEL Service agreement", TRUE);
            end;
        }
        field(50108; "DEL Date de début SSA"; Date)

        {
            Caption = 'Starting date SSA';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                TESTFIELD("DEL Service agreement", TRUE);

            end;
        }
        field(50109; "DEL Date de fin SSA"; Date)
        {
            Caption = 'End date SSA';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TESTFIELD("DEL Service agreement", TRUE);
            end;
        }
        field(50111; "DEL Date de proch. fact."; Date)
        {
            Caption = 'Next invoice date';
            DataClassification = CustomerContent;
        }
        field(50112; "DEL Nbr jr avant proch. fact."; Integer)
        {
            Caption = 'Nb of days before invoicing';
            DataClassification = CustomerContent;
        }
        field(50113; "DEL Level"; Enum "DEL Level")
        {
            Caption = 'Level';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TESTFIELD("DEL Service agreement", TRUE);

            end;
        }
        field(50114; "DEL Reporting vente"; Boolean)
        {
            Caption = 'Sales reports';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                TESTFIELD("DEL Service agreement", TRUE);

            end;
        }
        field(50115; "DEL Last Accounting Date"; Date)
        {
            Caption = 'Last accounting date';
            DataClassification = CustomerContent;
        }
        field(50116; "DEL Facture"; Code[20])
        {
            Caption = 'Invoce No.';
            DataClassification = CustomerContent;
        }
        field(50117; "DEL Montant"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(50119; "DEL Montant ouvert"; Decimal)
        {
            Caption = 'Pending amount';
            DataClassification = CustomerContent;
        }

        field(50120; "DEL Statut CE"; Enum "DEL Statut CE")
        {
            Caption = 'Ethical Charter status';
            DataClassification = CustomerContent;
        }
        field(50121; "DEL Date Signature CE"; Date)
        {
            Caption = 'Date of signature EC';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(50128; "DEL Denunciation to analyze"; Boolean)
        {
            Caption = 'Denunciation to analyze';
            DataClassification = CustomerContent;
        }
        field(50129; "DEL Denunciation Replanned"; Boolean)
        {
            Caption = 'Denunciation Replanned';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(50132; "DEL Not denunciation"; Boolean)
        {
            Caption = 'Pas de dénonciation';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(50134; "DEL Annexe B PA"; Boolean)
        {
            Caption = 'B';
            DataClassification = CustomerContent;
        }
        field(50135; "DEL Annexe C PA"; Boolean)
        {
            Caption = 'C';
            DataClassification = CustomerContent;
        }
        field(50136; "DEL Annexe D PA"; Boolean)
        {
            Caption = 'D';
            DataClassification = CustomerContent;
        }
        field(50137; "DEL En facturation"; Boolean)
        {
            Caption = 'Invoicing';
            DataClassification = CustomerContent;
        }
        field(50138; "DEL Renouvellement tacite"; Boolean)
        {
            Caption = 'Tacit renewal';
            DataClassification = CustomerContent;
        }
        field(50139; "DEL Annexe A SSA"; Boolean)
        {
            Caption = 'A';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(50142; "DEL Quote part 1 Mobivia/CA %"; Decimal)
        {
            Caption = 'Quote part 1 Mobivia/CA %';
            DataClassification = CustomerContent;
        }
        field(50143; "DEL Quote part 2 Mobivia/CA %"; Decimal)
        {
            Caption = 'Quote part 2 Mobivia/CA %';
            DataClassification = CustomerContent;
        }

        field(50144; "DEL Qte part 1 Mobivia/CA Year"; Integer)
        {
            Caption = 'Quote part 1 Mobivia/CA Year';
            DataClassification = CustomerContent;
        }
        field(50145; "DEL Qte part 2 Mobivia/CA Year"; Integer)

        {
            Caption = 'Quote part 2 Mobivia/CA Year';
            DataClassification = CustomerContent;
        }
        field(50146; "DEL Renewal by mail"; Boolean)
        {
            Caption = 'Renewal by mail';
            DataClassification = CustomerContent;
        }
        field(50147; "DEL Renewal by endorsement"; Boolean)
        {
            Caption = 'Renewal by endorsement';
            DataClassification = CustomerContent;
        }

        field(50148; "DEL Change VAT Reg. Place"; Boolean)
        {
            Caption = 'Change VAT Registration Place';
            DataClassification = CustomerContent;
        }
        field(50149; "DEL EDI"; Boolean)
        {
            Caption = 'EDI';
            DataClassification = CustomerContent;
        }
        field(50150; "DEL Show VAT In Invoice"; Boolean)
        {
            Caption = 'Show VAT In Invoice';
            DataClassification = CustomerContent;
        }
        field(60001; "DEL Note Quality"; Code[10])
        {
            Caption = 'Quality rating';

            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(Quality));
            DataClassification = CustomerContent;
        }
        field(60002; "DEL Realisation Date Quality"; Date)
        {
            Caption = 'Creation date QA';
            DataClassification = CustomerContent;
        }
        field(60100; "DEL Note Soc"; Code[10])
        {
            Caption = 'Social rating';

            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(social));
            DataClassification = CustomerContent;
        }
        field(60101; "DEL Realisation Date Soc"; Date)
        {
            Caption = 'Creation date';
            DataClassification = CustomerContent;
        }
        field(60102; "DEL Note Env"; Code[10])
        {
            Caption = 'Environmental rating';

            TableRelation = "DEL Note".Code WHERE("Type audit" = FILTER(Environmental));
            DataClassification = CustomerContent;
        }
        field(60103; "DEL Realisation Date Env"; Date)
        {
            Caption = 'Creation date';
            DataClassification = CustomerContent;
        }
        field(60104; "DEL National Mark"; Boolean)
        {
            Caption = 'National Mark';
            DataClassification = CustomerContent;
        }
        field(60105; "DEL MDD"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60106; "DEL NORAUTO"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60107; "DEL MIDAS"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60108; "DEL ATU"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60109; "DEL ATYSE"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60110; "DEL CARTER CASH"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60111; "DEL Parent Company"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60112; "DEL Segmentation Prod Niveau"; Text[160])
        {
            Caption = 'Segmentation Produit Niveau';
            DataClassification = CustomerContent;
        }
        field(60113; "DEL Amount YTD"; Decimal)
        {
            Caption = 'Amount YTD';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60114; "DEL Amount YTD-1"; Decimal)
        {
            Caption = 'Amount YTD-1';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60115; "DEL Amount YTD-2"; Decimal)
        {
            Caption = 'Amount YTD-2';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60116; "DEL SYNCHRO"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60117; "DEL Segmentation Description"; Text[250])
        {
            Caption = 'Segmentation Description';

            TableRelation = "Dimension Value".Name WHERE("Dimension Code" = FILTER('SEGMENT'));

            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(60118; "DEL Shruvat"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60119; "DEL Bythjul"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60120; "DEL Central trading"; Boolean)
        {
            Caption = 'Central trading';
            DataClassification = CustomerContent;
        }
        field(60121; "DEL Sales data report"; Boolean)
        {
            Caption = 'Sales data report';
            DataClassification = CustomerContent;
        }

        field(60122; "DEL Ass. in relat. with the BU"; Boolean)

        {
            Caption = 'Assist in relations with the BU (Blue Helmets)';
            DataClassification = CustomerContent;
        }
        field(60123; "DEL Organization of visits"; Boolean)
        {
            Caption = 'Organization of visits';
            DataClassification = CustomerContent;
        }
        field(60124; "DEL Vision and Market Analysis"; Boolean)
        {
            Caption = 'Vision and Market Analysis';
            DataClassification = CustomerContent;
        }

        field(60125; "DEL Pres. provider strategy"; Boolean)
        {
            Caption = 'Presentation provider strategy';
            DataClassification = CustomerContent;
        }
        field(60126; "DEL Pres. MOBIVIA strategy"; Boolean)
        {
            Caption = 'Presentation MOBIVIA strategy';
            DataClassification = CustomerContent;
        }
        field(60127; "DEL AdvOntheAdapt.OfTheOffer"; Boolean)

        {
            Caption = 'Advising on the adaptation of the offer';
            DataClassification = CustomerContent;
        }
        field(60128; "DEL Favorite referencing by BU"; Boolean)
        {
            Caption = 'Favorite referencing by BU';
            DataClassification = CustomerContent;
        }
        field(60129; "DEL Forecast"; Boolean)
        {
            Caption = 'Forecast';
            DataClassification = CustomerContent;
        }

        field(60130; "DEL Frequency of delivery 1"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';
            DataClassification = CustomerContent;
        }
        field(60131; "DEL Invoicing Frequency 1"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';
            DataClassification = CustomerContent;
        }
        field(60132; "DEL Frequency of delivery 2"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';
            DataClassification = CustomerContent;
        }
        field(60133; "DEL Invoicing Frequency 2"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';
            DataClassification = CustomerContent;
        }
        field(60134; "DEL Frequency of delivery 3"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';
            DataClassification = CustomerContent;
        }
        field(60135; "DEL Invoicing Frequency 3"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';
            DataClassification = CustomerContent;
        }
        field(60136; "DEL Frequency of delivery 4"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';
            DataClassification = CustomerContent;
        }
        field(60137; "DEL Invoicing Frequency 4"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';
            DataClassification = CustomerContent;
        }
        field(60138; "DEL Frequency of delivery 5"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';
            DataClassification = CustomerContent;
        }
        field(60139; "DEL Invoicing Frequency 5"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';
            DataClassification = CustomerContent;
        }
        field(60140; "DEL Frequency of delivery 6"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';
            DataClassification = CustomerContent;
        }
        field(60141; "DEL Invoicing Frequency 6"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';
            DataClassification = CustomerContent;
        }
        field(60142; "DEL Frequency of delivery 7"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';
            DataClassification = CustomerContent;
        }
        field(60143; "DEL Invoicing Frequency 7"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';
            DataClassification = CustomerContent;
        }
        field(60144; "DEL Frequency of delivery 8"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';
            DataClassification = CustomerContent;
        }
        field(60145; "DEL Invoicing Frequency 8"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';
            DataClassification = CustomerContent;
        }
        field(60146; "DEL Frequency of delivery 9"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';
            DataClassification = CustomerContent;
        }
        field(60147; "DEL Invoicing Frequency 9"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';
            DataClassification = CustomerContent;
        }
        field(60148; "DEL Frequency of delivery 10"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Frequency of delivery';
            DataClassification = CustomerContent;
        }
        field(60149; "DEL Invoicing Frequency 10"; Enum "DEL Frequency of delivery 1")
        {
            Caption = 'Invoicing Frequency';
            DataClassification = CustomerContent;
        }
    }
    var
        Window: Dialog;
        PreparationMsg: Label 'EPreparation in progress ...';
        FinishedMsg: Label 'Processing completed.';

    PROCEDURE ShowSelectedEntriesForReverse();
    VAR
        GLEntry: Record "G/L Entry";
        GLReverseForCustomer: Page "DEL G/L Reverse For Customer";
        GLSetup: Record "General Ledger Setup";
        ReverseGLEntry: Record "G/L Entry";
        ReverseConfirmMsg: Label 'Do you want to reverse the selected entries;FRS=Voulez-vous extourner les ‚critures s‚lectionn‚es';
        PostingDate: Date;
        PostingDatePage: Page "DEL Posting Date";
        Text001: Label 'You must fill in the Posting Date field.;FRS=Vous devez renseigner le champ Date comptabilisation.';
    BEGIN
        GLSetup.GET();
        GLSetup.TESTFIELD("DEL Provision Source Code");
        GLSetup.TESTFIELD("DEL Provision Journal Batch");

        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("DEL Customer Provision");
        GLEntry.FILTERGROUP(2);
        GLEntry.SETRANGE("Source Code", GLSetup."DEL Provision Source Code");
        GLEntry.SETFILTER("Journal Batch Name", GLSetup."DEL Provision Journal Batch");
        GLEntry.SETRANGE("DEL Customer Provision", "No.");
        GLEntry.SETRANGE(Reversed, FALSE);
        GLEntry.FILTERGROUP(4);

        CLEAR(GLReverseForCustomer);
        COMMIT();
        GLReverseForCustomer.SETTABLEVIEW(GLEntry);
        GLReverseForCustomer.LOOKUPMODE(TRUE);
        IF GLReverseForCustomer.RUNMODAL = ACTION::LookupOK THEN BEGIN
            GLReverseForCustomer.GetGLEntry(ReverseGLEntry);
            IF CONFIRM(ReverseConfirmMsg) THEN BEGIN
                COMMIT();
                IF PostingDatePage.RUNMODAL = ACTION::OK THEN
                    PostingDate := PostingDatePage.GetPostingDate()
                ELSE
                    EXIT;
                IF PostingDate = 0D THEN
                    ERROR(Text001);
                IF ReverseGLEntry.FINDSET THEN BEGIN
                    Window.OPEN(PreparationMsg);
                    REPEAT
                        ReverseProvisionEntries(ReverseGLEntry, PostingDate);
                    UNTIL ReverseGLEntry.NEXT = 0;
                    Window.CLOSE();
                    MESSAGE(FinishedMsg);
                END;
            END;
        END;
    END;

    PROCEDURE ReverseProvisionEntries(VAR ReverseGLEntry: Record "G/L Entry"; PostingDate: Date);
    VAR
        GLEntryProvision: Record "G/L Entry";
        BalGLEntry: Record "G/L Entry";
        GLEntry: Record "G/L Entry";
        GLEntryVATEntryLink: Record "G/L Entry - VAT Entry Link";
        GlobalVATEntry: Record "VAT Entry";
        GlobalGLEntry: Record "G/L Entry";
        VATEntryProvision: Record "VAT Entry";
        GLSetup: Record "General Ledger Setup";
        NextGLEntryNo: Integer;
        NextTransactionNo: Integer;
        NextVATEntryNo: Integer;
    BEGIN
        GlobalGLEntry.LOCKTABLE;
        GlobalVATEntry.LOCKTABLE;

        GlobalGLEntry.RESET;
        IF GlobalGLEntry.FINDLAST THEN BEGIN
            NextGLEntryNo := GlobalGLEntry."Entry No." + 1;
            NextTransactionNo := GlobalGLEntry."Transaction No." + 1;
        END ELSE BEGIN
            NextGLEntryNo := 1;
            NextTransactionNo := 1;
        END;

        GlobalVATEntry.RESET;
        IF GlobalVATEntry.FINDLAST THEN
            NextVATEntryNo := GlobalVATEntry."Entry No." + 1
        ELSE
            NextVATEntryNo := 1;

        GLEntryProvision.INIT;
        GLEntryProvision := ReverseGLEntry;
        GLEntryProvision."Entry No." := NextGLEntryNo;
        GLEntryProvision."Transaction No." := NextTransactionNo;
        GLEntryProvision."Posting Date" := PostingDate;
        GLEntryProvision."Document Date" := PostingDate;
        GLEntryProvision.Reversed := TRUE;
        GLEntryProvision."Reversed Entry No." := ReverseGLEntry."Entry No.";
        GLEntryProvision.Amount := -ReverseGLEntry.Amount;
        GLEntryProvision.Quantity := -ReverseGLEntry.Quantity;
        GLEntryProvision."VAT Amount" := -ReverseGLEntry."VAT Amount";
        GLEntryProvision."Debit Amount" := -ReverseGLEntry."Debit Amount";
        GLEntryProvision."Credit Amount" := -ReverseGLEntry."Credit Amount";
        GLEntryProvision."Additional-Currency Amount" := -ReverseGLEntry."Additional-Currency Amount";
        GLEntryProvision."Add.-Currency Debit Amount" := -ReverseGLEntry."Add.-Currency Debit Amount";
        GLEntryProvision."Add.-Currency Credit Amount" := -ReverseGLEntry."Add.-Currency Credit Amount";
        GLEntryProvision."DEL Initial Amount (FCY)" := -ReverseGLEntry."DEL Initial Amount (FCY)";
        GLEntryProvision."Amount (FCY)" := -ReverseGLEntry."Amount (FCY)";
        GLEntryProvision.INSERT(FALSE);

        ReverseGLEntry.Reversed := TRUE;
        ReverseGLEntry."Reversed by Entry No." := GLEntryProvision."Entry No.";
        ReverseGLEntry.MODIFY;

        GLEntryVATEntryLink.RESET;
        GLEntryVATEntryLink.SETRANGE("G/L Entry No.", ReverseGLEntry."Entry No.");
        IF GLEntryVATEntryLink.FINDFIRST THEN BEGIN
            IF GlobalVATEntry.GET(GLEntryVATEntryLink."VAT Entry No.") THEN BEGIN
                VATEntryProvision.INIT;
                VATEntryProvision := GlobalVATEntry;
                VATEntryProvision."Entry No." := NextVATEntryNo;
                ;
                VATEntryProvision."Transaction No." := NextTransactionNo;
                VATEntryProvision."Posting Date" := PostingDate;
                VATEntryProvision."Document Date" := PostingDate;
                VATEntryProvision.Reversed := TRUE;
                VATEntryProvision."Reversed Entry No." := GlobalVATEntry."Entry No.";
                VATEntryProvision.Amount := -GlobalVATEntry.Amount;
                VATEntryProvision."Amount (FCY)" := -GlobalVATEntry."Amount (FCY)";
                VATEntryProvision.Base := -GlobalVATEntry.Base;
                VATEntryProvision."Base (FCY)" := -GlobalVATEntry."Base (FCY)";
                VATEntryProvision."Unrealized Amount" := -GlobalVATEntry."Unrealized Amount";
                VATEntryProvision."Unrealized Base" := -GlobalVATEntry."Unrealized Base";
                VATEntryProvision."Remaining Unrealized Amount" := -GlobalVATEntry."Remaining Unrealized Amount";
                VATEntryProvision."Remaining Unrealized Base" := -GlobalVATEntry."Remaining Unrealized Base";
                VATEntryProvision."Add.-Curr. Rem. Unreal. Amount" := -GlobalVATEntry."Add.-Curr. Rem. Unreal. Amount";
                VATEntryProvision."Add.-Curr. Rem. Unreal. Base" := -GlobalVATEntry."Add.-Curr. Rem. Unreal. Base";
                VATEntryProvision."Add.-Curr. VAT Difference" := -GlobalVATEntry."Add.-Curr. VAT Difference";
                VATEntryProvision."Add.-Currency Unrealized Amt." := -GlobalVATEntry."Add.-Currency Unrealized Amt.";
                VATEntryProvision."Add.-Currency Unrealized Base" := -GlobalVATEntry."Add.-Currency Unrealized Base";
                VATEntryProvision."Additional-Currency Amount" := -GlobalVATEntry."Additional-Currency Amount";
                VATEntryProvision."Additional-Currency Base" := -GlobalVATEntry."Additional-Currency Base";
                VATEntryProvision.INSERT(FALSE);

                GlobalVATEntry.Reversed := TRUE;
                GlobalVATEntry."Reversed by Entry No." := NextVATEntryNo;
                GlobalVATEntry.MODIFY;

                NextVATEntryNo += 1;
            END;
        END;
    END;


}

