tableextension 50013 tableextension50013 extends Customer
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00678      THM     30.09.14   field   add fields 50100..50126
    // T-00678      THM     03,10,14           modify table relation N° facture
    // T-00678      THM     12.11.14           change caption field 50116
    // T-00705      THM     15.06.15  field    add captionML fields 50000..
    // T-00738      YAL     14.10.15           add 12months condition + change conditions values to match with option field
    // T-00767      THM     16.02.16           Add new Fields
    // T-00767      THM     16.02.16           Date de fin SSA - OnValidate()
    // T-00767      THM     18.02.16
    // T-00784      THM     06.04.16           add Field
    // THM          THM     08.05.17           Add fields
    //              THM     15.05.17           add field 50146,50147
    //              THM     16.06.17           add 60118..60149
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // MGTS:EDD001.01 :TU 24/05/2018 : Minimisation des clics :
    //   #Added new Fields 50002"FTP Save"[Boolean]
    // 
    // MGTS:EDD001.02 :TU 06/06/2018: Minimisation des clics :
    //                               - Add new field (ID 50003) "FTP Save 2" [Boolean]
    // +----------------------------------------------------------------------------------------------------------------+
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS0124,MGTS10.00.005,MGTS10.009
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001     MGTS0124         23.07.19    mhh     List of changes:
    //                                              Changed field: "Customer Price Group" (Properties: TableRelation, Lenght)
    //                                              Changed trigger: Customer Price Group - OnLookup()
    // 
    // 002    MGTS10.00.005    04.02.20    mhh     List of changes:
    //                                              Added new field: 50148 "Change VAT Registration Place"
    // 
    // 003    MGTS10.009       09.09.20    ehh     List of changes:
    //                                              Added new field: 50149 ODI
    // 004    MGTS10.032       30.07.21    ehh     List of changes:
    //                                              Added new field: 50150 Show TVA In Invoice
    // 
    // ------------------------------------------------------------------------------------------
    // 
    // MGTS10.033 :  11.02.2022  Add Fields  :  "Mention Under Total","Amount Mention Under Total"
    // 
    fields
    {
        modify("Customer Price Group")
        {

            //Unsupported feature: Property Modification (Data type) on ""Customer Price Group"(Field 23)".

            Description = 'MGTS0124';
        }


        //Unsupported feature: Code Insertion on ""Customer Price Group"(Field 23)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*

          //MGTS0124; MHH; begin
          CustPriceGroup.RESET;
          IF PAGE.RUNMODAL(0, CustPriceGroup) = ACTION::LookupOK THEN BEGIN
            IF "Customer Price Group" = '' THEN
              "Customer Price Group" := CustPriceGroup.Code
            ELSE
              "Customer Price Group" := STRSUBSTNO(Text50000, "Customer Price Group", CustPriceGroup.Code);
          END;
          //MGTS0124; MHH; end
        */
        //end;

        //Unsupported feature: Property Deletion (TableRelation) on ""Customer Price Group"(Field 23)".

        field(50000; "No TVA intracomm. NGTS"; Code[30])
        {
        }
        field(50001; "Fiscal Repr."; Code[10])
        {
            Caption = 'Fiscal Repr.';
            Description = 'T-00551-SPEC35';
            TableRelation = Contact;
        }
        field(50002; "FTP Save"; Boolean)
        {
            Caption = 'FTP Save';
            Description = 'MGTS:EDD001.01';

            trigger OnValidate()
            begin
                TESTFIELD("FTP Save 2", FALSE)
            end;
        }
        field(50003; "FTP Save 2"; Boolean)
        {
            Caption = 'FTP Save 2';
            Description = 'MGTS:EDD001.02';

            trigger OnValidate()
            begin
                TESTFIELD("FTP Save", FALSE)
            end;
        }
        field(50050; "Mention Under Total"; Text[250])
        {
            Caption = 'Mention Under Total';
            Description = 'MGTS10.033';
        }
        field(50051; "Amount Mention Under Total"; Text[30])
        {
            Caption = 'Amount Mention Under Total';
            Description = 'MGTS10.033';
        }
        field(50100; "Partnership agreement"; Boolean)
        {
        }
        field(50101; "Libellé PA"; Text[60])
        {
            Caption = 'Partnership agreement description';

            trigger OnValidate()
            begin
                TESTFIELD("Partnership agreement", TRUE);
            end;
        }
        field(50102; "Statut PA"; Option)
        {
            Caption = 'Partnership agreement status';
            OptionCaption = ' ,Draft, Signed,Expired,Extented';
            OptionMembers = " ",Draft,"Signé","Échu","Prolongé";

            trigger OnValidate()
            begin
                TESTFIELD("Partnership agreement", TRUE);
            end;
        }
        field(50103; "Date de début PA"; Date)
        {
            Caption = 'Starting date PA';

            trigger OnValidate()
            begin
                TESTFIELD("Partnership agreement", TRUE);
            end;
        }
        field(50104; "Date de fin PA"; Date)
        {
            Caption = 'End date PA';

            trigger OnValidate()
            begin
                TESTFIELD("Partnership agreement", TRUE);
            end;
        }
        field(50105; "Service agreement"; Boolean)
        {
            Caption = 'Service agreement';
        }
        field(50106; "Libellé SSA"; Text[60])
        {
            Caption = 'Service agreement description';

            trigger OnValidate()
            begin
                TESTFIELD("Service agreement", TRUE);
            end;
        }
        field(50107; "Statut SSA"; Option)
        {
            Caption = 'Status SSA';
            OptionCaption = ' ,Draft,Signed,Expired,Extented';
            OptionMembers = " ",Draft,"Signé","Échu","Prolongé";

            trigger OnValidate()
            begin
                TESTFIELD("Service agreement", TRUE);
            end;
        }
        field(50108; "Date de début SSA"; Date)
        {
            Caption = 'Starting date SSA';

            trigger OnValidate()
            begin
                TESTFIELD("Service agreement", TRUE);
            end;
        }
        field(50109; "Date de fin SSA"; Date)
        {
            Caption = 'End date SSA';

            trigger OnValidate()
            begin
                TESTFIELD("Service agreement", TRUE);
                //START  T-00767
                IF "Date de fin SSA" <> 0D THEN
                    "Period of denunciation" := CALCDATE('<-25M>', "Date de fin SSA")
                ELSE
                    "Period of denunciation" := 0D;
                // STOP T-00767
            end;
        }
        field(50110; "Fréquence de facturation"; Option)
        {
            Caption = 'Frequency of invoicing';
            OptionCaption = ' ,3 months,4 months,6 months,12 months';
            OptionMembers = " ","3 mois","4 mois","6 mois","12 mois";

            trigger OnValidate()
            begin
                TESTFIELD("Service agreement", TRUE);
            end;
        }
        field(50111; "Date de prochaine facturation"; Date)
        {
            Caption = 'Next invoice date';
        }
        field(50112; "Nbre jour avant proch. fact."; Integer)
        {
            Caption = 'Nb of days before invoicing';
        }
        field(50113; Level; Option)
        {
            Caption = 'Level';
            OptionCaption = 'Standard,Intermediate Premium';
            OptionMembers = Standard,"Intermédiaire",Premium;

            trigger OnValidate()
            begin
                TESTFIELD("Service agreement", TRUE);
            end;
        }
        field(50114; "Reporting vente"; Boolean)
        {
            Caption = 'Sales reports';

            trigger OnValidate()
            begin
                TESTFIELD("Service agreement", TRUE);
            end;
        }
        field(50115; "Last Accounting Date"; Date)
        {
            Caption = 'Last accounting date';
        }
        field(50116; Facture; Code[20])
        {
            Caption = 'Invoce No.';
        }
        field(50117; Montant; Decimal)
        {
            Caption = 'Amount';
        }
        field(50119; "Montant ouvert"; Decimal)
        {
            Caption = 'Pending amount';
        }
        field(50120; "Statut CE"; Option)
        {
            Caption = 'Ethical Charter status';
            OptionCaption = ',Sent,Signed';
            OptionMembers = " ","Charte envoyée","Charte signée";
        }
        field(50121; "Date Signature CE"; Date)
        {
            Caption = 'Date of signature EC';
        }
        field(50122; "URL document CE"; Text[60])
        {
            CalcFormula = Lookup ("Document Line"."File Name" WHERE (Table Name=FILTER(Customer),
                                                                    No.=FIELD(No.),
                                                                    Notation Type=FILTER(' '),
                                                                    Type liasse=FILTER(' '),
                                                                    Type contrat=FILTER(Charte ethique)));
            Caption = 'URL document CE';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50123;"URL document PA";Text[60])
        {
            CalcFormula = Lookup("Document Line"."File Name" WHERE (Table Name=FILTER(Customer),
                                                                    No.=FIELD(No.),
                                                                    Notation Type=FILTER(' '),
                                                                    Type liasse=FILTER(' '),
                                                                    Type contrat=FILTER(Partnership)));
            Caption = 'URL document PA';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50124;"URL document SSA";Text[60])
        {
            CalcFormula = Lookup("Document Line"."File Name" WHERE (Table Name=FILTER(Customer),
                                                                    No.=FIELD(No.),
                                                                    Notation Type=FILTER(' '),
                                                                    Type liasse=FILTER(' '),
                                                                    Type contrat=FILTER(Service)));
            Caption = 'URL document SSA';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50125;"Comment PA";Text[80])
        {
            CalcFormula = Lookup("Comment Line".Comment WHERE (Table Name=CONST(Customer),
                                                               No.=FIELD(No.),
                                                               Type contrat=FILTER(Partnership)));
            Caption = 'Comment PA';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50126;"Comment SSA";Text[80])
        {
            CalcFormula = Lookup("Comment Line".Comment WHERE (Table Name=CONST(Customer),
                                                               No.=FIELD(No.),
                                                               Type contrat=FILTER(Service)));
            Caption = 'Comment SSA';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50127;"Period of denunciation";Date)
        {
            Caption = 'Period of denunciation';
        }
        field(50128;"Denunciation to analyze";Boolean)
        {
            Caption = 'Denunciation to analyze';
        }
        field(50129;"Denunciation Replanned";Boolean)
        {
            Caption = 'Denunciation Replanned';

            trigger OnValidate()
            begin
                //START  T-00767
                IF "Denunciation Replanned" THEN
                BEGIN
                "Denunciation to analyze":=FALSE;
                 "Denunciation realised":=FALSE;
                 "Not denunciation":=FALSE;
                END;
                //STOP  T-00767
            end;
        }
        field(50130;"Denunciation realised";Boolean)
        {
            Caption = 'Denunciation realised';

            trigger OnValidate()
            begin
                //START  T-00767
                IF "Denunciation realised" THEN
                BEGIN
                  "Period of denunciation":=0D;
                  "Denunciation to analyze":=FALSE;
                  "Denunciation Replanned":=FALSE;
                  "Not denunciation":=FALSE;
                END;
                //STOP  T-00767
            end;
        }
        field(50131;"Denunciation date";Date)
        {
            Caption = 'Denunciation Date';
        }
        field(50132;"Not denunciation";Boolean)
        {
            Caption = 'Pas de dénonciation';

            trigger OnValidate()
            begin
                //START  T-00767
                IF "Not denunciation" THEN
                BEGIN
                  "Period of denunciation":=0D;
                  "Denunciation to analyze":=FALSE;
                  "Denunciation Replanned":=FALSE;
                  "Denunciation date":=0D;
                  "Denunciation realised":=FALSE;
                END;
                //STOP  T-00767
            end;
        }
        field(50133;"Annexe A PA";Boolean)
        {
            Caption = 'A';
        }
        field(50134;"Annexe B PA";Boolean)
        {
            Caption = 'B';
        }
        field(50135;"Annexe C PA";Boolean)
        {
            Caption = 'C';
        }
        field(50136;"Annexe D PA";Boolean)
        {
            Caption = 'D';
        }
        field(50137;"En facturation";Boolean)
        {
            Caption = 'Invoicing';
        }
        field(50138;"Renouvellement tacite";Boolean)
        {
            Caption = 'Tacit renewal';
        }
        field(50139;"Annexe A SSA";Boolean)
        {
            Caption = 'A';
        }
        field(50140;"Comment denunciation";Text[80])
        {
            CalcFormula = Lookup("Comment Line".Comment WHERE (Table Name=CONST(Customer),
                                                               No.=FIELD(No.),
                                                               Type contrat=FILTER(Denunciation)));
            Caption = 'Comment denunciation';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50141;"Starting date of Relationship";Date)
        {
            Caption = 'Starting date of Relationship';
        }
        field(50142;"Quote part 1 Mobivia/CA %";Decimal)
        {
            Caption = 'Quote part 1 Mobivia/CA %';
        }
        field(50143;"Quote part 2 Mobivia/CA %";Decimal)
        {
            Caption = 'Quote part 2 Mobivia/CA %';
        }
        field(50144;"Quote part 1 Mobivia/CA Year";Integer)
        {
            Caption = 'Quote part 1 Mobivia/CA Year';
        }
        field(50145;"Quote part 2 Mobivia/CA Year";Integer)
        {
            Caption = 'Quote part 2 Mobivia/CA Year';
        }
        field(50146;"Renewal by mail";Boolean)
        {
            Caption = 'Renewal by mail';
        }
        field(50147;"Renewal by endorsement";Boolean)
        {
            Caption = 'Renewal by endorsement';
        }
        field(50148;"Change VAT Registration Place";Boolean)
        {
            Caption = 'Change VAT Registration Place';
            Description = 'MGTS10.00.005';
        }
        field(50149;EDI;Boolean)
        {
            Caption = 'EDI';
            Description = 'MGTS10.009';
        }
        field(50150;"Show VAT In Invoice";Boolean)
        {
            Caption = 'Show VAT In Invoice';
            Description = 'MGTS10.032';
        }
        field(60001;"Note Quality";Code[10])
        {
            Caption = 'Quality rating';
            TableRelation = Note.Code WHERE (Type audit=FILTER(Quality));
        }
        field(60002;"Realisation Date Quality";Date)
        {
            Caption = 'Creation date QA';
        }
        field(60100;"Note Soc";Code[10])
        {
            Caption = 'Social rating';
            TableRelation = Note.Code WHERE (Type audit=FILTER(social));
        }
        field(60101;"Realisation Date Soc";Date)
        {
            Caption = 'Creation date';
        }
        field(60102;"Note Env";Code[10])
        {
            Caption = 'Environmental rating';
            TableRelation = Note.Code WHERE (Type audit=FILTER(Environmental));
        }
        field(60103;"Realisation Date Env";Date)
        {
            Caption = 'Creation date';
        }
        field(60104;"National Mark";Boolean)
        {
            Caption = 'National Mark';
        }
        field(60105;MDD;Boolean)
        {
        }
        field(60106;NORAUTO;Boolean)
        {
        }
        field(60107;MIDAS;Boolean)
        {
        }
        field(60108;ATU;Boolean)
        {
        }
        field(60109;ATYSE;Boolean)
        {
        }
        field(60110;"CARTER CASH";Boolean)
        {
        }
        field(60111;"Parent Company";Text[30])
        {
        }
        field(60112;"Segmentation Prod Niveau";Text[160])
        {
            Caption = 'Segmentation Produit Niveau';
        }
        field(60113;"Amount YTD";Decimal)
        {
            Caption = 'Amount YTD';
            Editable = false;
        }
        field(60114;"Amount YTD-1";Decimal)
        {
            Caption = 'Amount YTD-1';
            Editable = false;
        }
        field(60115;"Amount YTD-2";Decimal)
        {
            Caption = 'Amount YTD-2';
            Editable = false;
        }
        field(60116;SYNCHRO;Boolean)
        {
        }
        field(60117;"Segmentation Description";Text[250])
        {
            Caption = 'Segmentation Description';
            TableRelation = "Dimension Value".Name WHERE (Dimension Code=FILTER(SEGMENT));
            ValidateTableRelation = false;
        }
        field(60118;Shruvat;Boolean)
        {
        }
        field(60119;Bythjul;Boolean)
        {
        }
        field(60120;"Central trading";Boolean)
        {
            Caption = 'Central trading';
        }
        field(60121;"Sales data report";Boolean)
        {
            Caption = 'Sales data report';
        }
        field(60122;"Assist in relat. with the BU";Boolean)
        {
            Caption = 'Assist in relations with the BU (Blue Helmets)';
        }
        field(60123;"Organization of visits";Boolean)
        {
            Caption = 'Organization of visits';
        }
        field(60124;"Vision and Market Analysis";Boolean)
        {
            Caption = 'Vision and Market Analysis';
        }
        field(60125;"Presentation provider strategy";Boolean)
        {
            Caption = 'Presentation provider strategy';
        }
        field(60126;"Presentation MOBIVIA strategy";Boolean)
        {
            Caption = 'Presentation MOBIVIA strategy';
        }
        field(60127;"Adv on the adapt. of the offer";Boolean)
        {
            Caption = 'Advising on the adaptation of the offer';
        }
        field(60128;"Favorite referencing by BU";Boolean)
        {
            Caption = 'Favorite referencing by BU';
        }
        field(60129;Forecast;Boolean)
        {
            Caption = 'Forecast';
        }
        field(60130;"Frequency of delivery 1";Option)
        {
            Caption = 'Frequency of delivery';
            Description = 'for field 60120';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60131;"Invoicing Frequency 1";Option)
        {
            Caption = 'Invoicing Frequency';
            Description = 'for field 60120';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60132;"Frequency of delivery 2";Option)
        {
            Caption = 'Frequency of delivery';
            Description = 'for field 60121';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60133;"Invoicing Frequency 2";Option)
        {
            Caption = 'Invoicing Frequency';
            Description = 'for field 60121';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60134;"Frequency of delivery 3";Option)
        {
            Caption = 'Frequency of delivery';
            Description = 'for field 60122';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60135;"Invoicing Frequency 3";Option)
        {
            Caption = 'Invoicing Frequency';
            Description = 'for field 60122';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60136;"Frequency of delivery 4";Option)
        {
            Caption = 'Frequency of delivery';
            Description = 'for field 60123';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60137;"Invoicing Frequency 4";Option)
        {
            Caption = 'Invoicing Frequency';
            Description = 'for field 60123';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60138;"Frequency of delivery 5";Option)
        {
            Caption = 'Frequency of delivery';
            Description = 'for field 60124';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60139;"Invoicing Frequency 5";Option)
        {
            Caption = 'Invoicing Frequency';
            Description = 'for field 60124';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60140;"Frequency of delivery 6";Option)
        {
            Caption = 'Frequency of delivery';
            Description = 'for field 60125';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60141;"Invoicing Frequency 6";Option)
        {
            Caption = 'Invoicing Frequency';
            Description = 'for field 60125';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60142;"Frequency of delivery 7";Option)
        {
            Caption = 'Frequency of delivery';
            Description = 'for field 60126';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60143;"Invoicing Frequency 7";Option)
        {
            Caption = 'Invoicing Frequency';
            Description = 'for field 60126';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60144;"Frequency of delivery 8";Option)
        {
            Caption = 'Frequency of delivery';
            Description = 'for field 60127';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60145;"Invoicing Frequency 8";Option)
        {
            Caption = 'Invoicing Frequency';
            Description = 'for field 60127';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60146;"Frequency of delivery 9";Option)
        {
            Caption = 'Frequency of delivery';
            Description = 'for field 60128';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60147;"Invoicing Frequency 9";Option)
        {
            Caption = 'Invoicing Frequency';
            Description = 'for field 60128';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60148;"Frequency of delivery 10";Option)
        {
            Caption = 'Frequency of delivery';
            Description = 'for field 60129';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
        field(60149;"Invoicing Frequency 10";Option)
        {
            Caption = 'Invoicing Frequency';
            Description = 'for field 60129';
            OptionCaption = ' ,Monthly,Quarterly,Semi-annual,Annual,No frequency';
            OptionMembers = " ",Monthly,Quarterly,"Semi-annual",Annual,"No frequency";
        }
    }


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Last Date Modified" := TODAY;

        IF (Name <> xRec.Name) OR
        #4..28
            IF FIND THEN;
          END;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..31


        //START T-00678
        IF "Last Accounting Date"<>0D THEN
        BEGIN
        //START T-00738
          IF "Fréquence de facturation"="Fréquence de facturation"::"12 mois" THEN
            "Date de prochaine facturation":=CALCDATE('<+12M>',"Last Accounting Date");
          IF "Fréquence de facturation"="Fréquence de facturation"::"6 mois" THEN
           "Date de prochaine facturation":=   CALCDATE('<+6M>',"Last Accounting Date");
          IF "Fréquence de facturation"="Fréquence de facturation"::"4 mois" THEN
           "Date de prochaine facturation":=   CALCDATE('<+4M>',"Last Accounting Date");
          IF "Fréquence de facturation"="Fréquence de facturation"::"3 mois" THEN
          "Date de prochaine facturation":=   CALCDATE('<+3M>',"Last Accounting Date");
          IF "Fréquence de facturation"="Fréquence de facturation"::" " THEN
          "Date de prochaine facturation":=   CALCDATE('<+0M>',"Last Accounting Date");
        //STOP T-00738
          "Nbre jour avant proch. fact.":="Date de prochaine facturation"-TODAY;
        END;
        // STOP T-00678
        */
    //end;

    var
        CustPriceGroup: Record "6";
        Text50000: Label '%1|%2';
}

