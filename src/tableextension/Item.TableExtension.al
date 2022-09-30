tableextension 50020 "DEL Item" extends Item
{

    fields
    {

        field(50000; "DEL Weight net"; Decimal)
        {
        }
        field(50001; "DEL Weight brut"; Decimal)
        {
        }
        field(50002; "DEL Code EAN 13"; Code[13])
        {
        }
        field(50003; "DEL Vol cbm"; Decimal)
        {
        }
        field(50004; "DEL Vol cbm carton transport"; Decimal)
        {

            trigger OnValidate()
            begin

                IF ("DEL PCB" = 0) THEN
                    "DEL Vol cbm" := 0
                ELSE
                    "DEL Vol cbm" := ROUND(("DEL Vol cbm carton transport" / "DEL PCB"), 0.00001, '>');

            end;
        }
        field(50005; "DEL PCB"; Integer)
        {

            trigger OnValidate()
            begin

                IF ("DEL PCB" = 0) THEN
                    "DEL Vol cbm" := 0
                ELSE
                    "DEL Vol cbm" := ROUND(("DEL Vol cbm carton transport" / "DEL PCB"), 0.00001, '>');

            end;
        }
        field(50006; "DEL SPCB"; Integer)
        {
        }
        field(50007; "DEL Certified by QS"; Boolean)
        {
            Caption = 'Qualität geprüft';
        }
        field(50008; "DEL Risk Item"; Boolean)
        {
            Caption = 'Risk Item';
        }
        field(50009; "DEL Code motif de suivi"; Integer)
        {
            TableRelation = "DEL Liste des motifs".No;
        }
        field(50019; "DEL Date de creation"; Date)
        {
        }
        field(50020; "DEL Packaging Language FR"; Boolean)
        {
        }
        field(50021; "DEL Packaging Language IT"; Boolean)
        {
        }
        field(50022; "DEL Packaging Language ES"; Boolean)
        {
        }
        field(50023; "DEL Packaging Language NL"; Boolean)
        {
        }
        field(50024; "DEL Packaging Language PT"; Boolean)
        {
        }
        field(50025; "DEL Packaging Language PL"; Boolean)
        {
        }
        field(50026; "DEL Packaging Language HG"; Boolean)
        {
        }
        field(50027; "DEL Packaging Language RO"; Boolean)
        {
        }
        field(50028; "DEL Packaging Language RU"; Boolean)
        {
        }
        field(50029; "DEL OLD marque"; Text[30])
        {
        }
        field(50030; "DEL Marque"; Text[30])
        {
            TableRelation = Manufacturer.Code;
        }
        field(50031; "DEL Carac. complementaire"; Text[30])
        {
        }
        field(50032; "DEL Date prochaine commande"; Date)
        {


        }
        field(50033; "DEL Panier type"; Boolean)
        {

        }
        field(50034; "DEL Est. next delivery date"; Date)
        {
            Caption = 'Estimated next delivery date';

        }
        field(50035; "DEL Remaining days"; Integer)
        {
            Caption = 'Remaining days';

        }
        field(50040; "DEL Ampoules: Type"; Text[30])
        {
        }
        field(50041; "DEL Ampoules: Volt"; Text[30])
        {
        }
        field(50042; "DEL Ampoules: Puissance"; Text[30])
        {
        }
        field(50043; "DEL Ampoules: E-mark"; Boolean)
        {
        }
        field(50050; "DEL Couleur1"; Text[30])
        {
        }
        field(50060; "DEL BEG: Taille en cm"; Decimal)
        {
        }
        field(50061; "DEL BEG: Taille en pouce"; Decimal)
        {
        }
        field(50062; "DEL BEG: Materiau balai"; Text[30])
        {
        }
        field(50063; "DEL BEG: Ep. mat balai en mm"; Text[30])
        {
        }
        field(50064; "DEL BEG: Materiau lame"; Text[30])
        {
        }
        field(50070; "DEL Carac. technique 1"; Text[30])
        {
        }
        field(50071; "DEL Carac. technique 2"; Text[30])
        {
        }
        field(50072; "DEL Carac. technique 3"; Text[30])
        {
        }
        field(50080; "DEL Couleur2"; Text[30])
        {
        }
        field(50081; "DEL Affectation vehicule"; Text[30])
        {
        }
        field(50082; "DEL Normes et qualite"; Text[30])
        {
        }
        field(50083; "DEL Date de peremption"; Date)
        {
        }
        field(50084; "DEL Code nomenc. douaniere"; Text[30])
        {
        }
        field(50085; "DEL Droit de douane reduit"; Decimal)
        {
        }
        field(50090; "DEL Images"; Integer)
        {
            //TODO CalcFormula = Count("DEL Texte Regulation" WHERE("Attached to Line No."=FIELD("No.")));

            Editable = false;
            FieldClass = FlowField;
        }
        field(50091; "DEL Qtés en com panier WEB"; Decimal)
        {
            CalcFormula = Sum("DEL Web_Order_Line".Qty WHERE(Item = FIELD("No."),
                                                        OrderCreated = CONST(false)));
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50092; "DEL Qty. optimale"; Decimal)
        {
            // TODO CalcFormula = Sum("Purchase Price"."Qty. optimale" WHERE ("Item No."=FIELD("No."),
            //                                 "Starting Date"=FIELD("Date Filter Start date"),
            //                                 "Ending Date"=FIELD("Date Filter End date")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Purchase Price"."Vendor No." WHERE("Item No." = FIELD("No."));
        }
        field(50094; "DEL Date Filter Startdate"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50095; "DEL Date Filter Enddate"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50096; "DEL Segment Code"; Code[20])
        {
            //TODO CalcFormula = Lookup("Product Group"."Code Segment" 
            // WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //         Code=FIELD("Product Group Code")));
            Caption = 'Segment Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50100; "DEL Show item as new until"; Date)
        {
            Caption = 'Date affichage article nouveautés';
        }
        field(50101; "DEL WEB Sale blocked"; Text[30])
        {
            Caption = 'WEB Sale blocked';
        }
        field(60001; "DEL Item Category Label"; Text[50])
        {
            CalcFormula = Lookup("Item Category".Description WHERE(Code = FIELD("Item Category Code")));
            Caption = 'Item Category Description';

            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category".Description WHERE(Code = FIELD("Item Category Code"));
        }
        field(60002; "DEL Product Group Label"; Text[50])
        {
            //TODO:Product group is no longer here
            // CalcFormula = Lookup("Product Group".Description 
            // WHERE(Code = FIELD("Product Group Code"),
            // "Item Category Code" = FIELD("Item Category Code")));
            Caption = 'Product Group Description';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60003; "DEL Risque Securitaire"; Enum "DEL Risque Securitaire")
        {
            //TODO CalcFormula = Lookup("DEL Regulation Matrix"."Risque Quality"
            //  WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                         // "Product Group Code"=FIELD("Product Group Code"),
            //                         // Mark=FIELD("Marque Produit"),
            //                         "Product Description"=FIELD("Product Description")));
            Caption = 'Security Level Of Risk';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60005; "DEL NGTS Quality Expert"; Enum "DEL NGTS Quality Expert")

        {
            FieldClass = FlowField;
            //TODO:Product group is no longer here
            // CalcFormula = Lookup("DEL Regulation Matrix"."NGTS Quality Expert"
            //  WHERE("Item Category Code" = FIELD("Item Category Code"),
            //                  "Product Group Code" = FIELD("Product Group Code"),
            //                  Mark = FIELD("Marque Produi"t),
            //              "Product Description"=FIELD("Product Description")));
            Caption = 'NGTS Quality Expert';

            Editable = false;
        }
        field(60006; "DEL Regl. Generale"; Boolean)
        {
            FieldClass = FlowField;
            //TODO: CalcFormula = Lookup("DEL Regulation Matrix"."Regl. Generale" 
            // WHERE ("Item Category Code"=FIELD("Item Category Code"),

            //        "DEL Mark"=FIELD("Marque Produit"),
            //        "Product Description"=FIELD("Product Description")));
            Caption = 'General Product Regulation';

            Editable = false;

        }
        field(60007; "DEL Regl. Matiere"; Boolean)
        {
            //TODO CalcFormula = Lookup("Regulation Matrix"."Regl. Matiere" WHERE (Item Category Code=FIELD(Item Category Code),
            //  Product Group Code=FIELD(Product Group Code),
            //   Mark=FIELD(Marque Produit),
            //          Product Description=FIELD(Product Description)));
            Caption = 'Subtance Regulation';
            Description = 'T-00716';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60008; "DEL Checklist by item"; Integer)
        {
            //TODO CalcFormula = Count("Regulation Matrix Line" WHERE (Item Category Code=FIELD(Item Category Code),
            //                                                     Product Group Code=FIELD(Product Group Code),
            //                                                     Product Description=FIELD(Product Description),
            //                                                     Mark=FIELD(Marque Produit),
            //                                                     Type=FIELD(Regl. Type Filter),
            //                                                     No.=FIELD(Regl. No. Filter)));
            Caption = 'Checklist by item';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60010; "DEL Marque Produit"; Enum "DEL Marque Produit")
        {
            Caption = 'Brand Type';

            trigger OnValidate()
            begin


                CALCFIELDS("DEL Risque Securitaire", "DEL NGTS Quality Expert", "DEL Regl. Generale",
                "DEL Regl. Matiere", "DEL Nombre Regl. Generale",
                "DEL Nombre Regl. Matiere", "DEL Regl. Plan Control", "DEL Nbre Regl. Plan control");
                IF "DEL Marque Produit" <> xRec."DEL Marque Produit" THEN
                    VALIDATE("DEL Product Description", '');
            end;
        }
        field(60014; "DEL Nombre Regl. Generale"; Integer)
        { //TODO
            // CalcFormula = Count("DEL Regulation Matrix Line" WHERE("Item Category Code" = FIELD("Item Category Code"),
            //                                                    "Product Group Code" = FIELD("Product Group Code"),
            //                                                     Type = FILTER("General product"),
            //                                                     Mark = FIELD("Marque Produit"),
            //                                                     "Product Description" = FIELD("Product Description")));
            Caption = 'General Product Regulation';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60015; "DEL Nombre Regl. Matiere"; Integer)
        { //TODO
            // CalcFormula = Count("DEL Regulation Matrix Line" WHERE("Item Category Code="FIELD("Item Category Code"),
            //                                                     "Product Group Code" = FIELD("Product Group Code"),
            //                                                     Type = FILTER(Materials),
            //                                                     Mark = FIELD("Marque Produit"),
            //                                                     "Product Description" = FIELD("Product Description")));
            Caption = 'Substance regulation';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60016; "DEL Regl. Type Filter"; Enum "DEL Product Type")
        {
            Caption = 'Regl. Type Filter';
            FieldClass = FlowFilter;

        }
        field(60017; "DEL Regl. No. Filter"; Code[20])
        {
            Caption = 'Filtre N° réglementation';
            FieldClass = FlowFilter;
            TableRelation = "DEL Regulation Matrix Line"."No.";
        }
        field(60025; "DEL Blocking Quality"; Boolean)
        {
            Caption = 'Blocking Quality';


            trigger OnValidate()
            begin

                IF "DEL Blocking Quality" THEN BEGIN

                    TESTFIELD("DEL Dispensation", FALSE);

                    Blocked := TRUE;

                END
                ELSE
                    Blocked := FALSE;

                "DEL Nom utilisateur" := USERID;
                "DEL Date Of Update" := WORKDATE();

            end;
        }
        field(60026; "DEL Nom utilisateur"; Code[50])
        {
            Caption = 'Validator User';

        }
        field(60027; "DEL Date Of Update"; Date)
        {
            Caption = 'Date Of Update';

        }
        field(60028; "DEL Dispensation"; Boolean)
        {
            Caption = 'Dispensation';


            trigger OnValidate()
            begin



                IF "DEL Dispensation" THEN
                    TESTFIELD("DEL Blocking Quality", FALSE);

                "DEL Nom utlisateur 2" := USERID;
                "DEL Date Of Update 2" := WORKDATE();

            end;
        }
        field(60029; "DEL Nom utlisateur 2"; Code[50])
        {
            Caption = 'User Name Making The Last Update';

        }
        field(60030; "DEL Date Of Update 2"; Date)
        {
            Caption = 'Date Of Update';

        }
        field(60031; "DEL Regl. Plan Control"; Boolean)
        {
            //TODO CalcFormula = Lookup("Regulation Matrix"."Plan of control" WHERE(Item Category Code=FIELD(Item Category Code),
            //                                                                   Product Group Code=FIELD(Product Group Code),
            //                                                                   Mark=FIELD(Marque Produit),
            //                                                                   Product Description=FIELD(Product Description)));
            Caption = 'Plan of control Regulation';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60032; "DEL Product Description"; Text[100])
        {
            Caption = 'Description produit';
            //TODO/ 'Product Group Code' is removed.
            // TableRelation = "DEL Regulation Matrix"."Product Description" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                                  "Product Group Code"=FIELD("Product Group Code"),
            //                                                                  Mark=FIELD("Marque Produit"));

            trigger OnValidate()
            begin
                CALCFIELDS("DEL Risque Securitaire", "DEL NGTS Quality Expert", "DEL Regl. Generale", "DEL Regl. Matiere",
                "DEL Nombre Regl. Generale", "DEL Nombre Regl. Matiere", "DEL Regl. Plan Control", "DEL Nbre Regl. Plan control");
            end;
        }
        field(60033; "DEL Nbre Regl. Plan control"; Integer)
        {
            FieldClass = FlowField;
            // TODO: 'Product Group Code' is removed.
            //CalcFormula = Count("DEL Regulation Matrix Line" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                     "Product Group Code"=FIELD("Product Group Code"),
            //                                                     Type=FILTER("Plan of control"),
            //                                                     Mark=FIELD("Marque Produit"),
            //                                                     "Product Description"=FIELD("Product Description")));
            Caption = 'Plan of control regulation';

            Editable = false;

        }
        field(60034; "DEL Marking in the product FR"; Boolean)
        {// TODO:'Product Group Code' is removed.
            // CalcFormula = Exist("DEL Regulation Matrix Text" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                     "Product Group Code"=FIELD("Product Group Code"),
            //                                                     "Product Description"=FIELD("Product Description"),
            //                                                     Mark=FIELD("Marque Produit"),
            //                                                     Type=FILTER("Marking in the product FR")));
            Caption = 'Marking in the product (warning) + Pictogram type in French';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60035; "DEL Marking in the pack FR"; Boolean)
        {//TODO:'Product Group Code' is removed.
            // CalcFormula = Exist("DEL Regulation Matrix Text" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                     "Product Group Code"=FIELD("Product Group Code"),
            //                                                     "Product Description"=FIELD("Product Description"),
            //                                                     Mark=FIELD("Marque Produit"),
            //                                                     Type=FILTER("Marking in the pack FR")));
            Caption = 'Marking in the pack (warning + Pictogram) in French';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60036; "DEL Marking in the product ENU"; Boolean)
        {  //TODO:'Product Group Code' is removed.
            // CalcFormula = Exist("DEL Regulation Matrix Text" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                     "Product Group Code"=FIELD("Product Group Code"),
            //                                                     "Product Description"=FIELD("Product Description"),
            //                                                     Mark=FIELD("Marque Produit"),
            //                                                     Type=FILTER("Marking in the product ENU")));
            Caption = 'Marking in the product (warning) + Pictogram type in English';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60037; "DEL Marking in the pack ENU"; Boolean)
        { //TODO:'Product Group Code' is removed.
            // CalcFormula = Exist("Regulation Matrix Text" WHERE (Item Category Code=FIELD(Item Category Code),
            //                                                     Product Group Code=FIELD(Product Group Code),
            //                                                     Product Description=FIELD(Product Description),
            //                                                     Mark=FIELD(Marque Produit),
            //                                                     Type=FILTER(Marking in the pack ENU)));
            Caption = 'Marking in the pack (warning + Pictogram) in English';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60038; "DEL Manuel instruction"; Enum "DEL Manuel instruction")
        { //TODO
            // CalcFormula = Lookup("DEL Regulation Matrix"."Manuel instruction" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                                      "Product Group Code"=FIELD("Product Group Code"),
            //                                                                      Mark=FIELD("Marque Produit"),
            //                                                                      "Product Description"=FIELD("Product Description")));
            Editable = false;
            FieldClass = FlowField;

        }
        field(60039; "DEL Warning"; Boolean)
        {
            FieldClass = FlowField;
            //TODO:'Product Group Code' is removed.
            // CalcFormula = Exist("DEL Regulation Matrix Text" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                     "Product Group Code"=FIELD("Product Group Code"),
            //                                                     "Product Description"=FIELD("Product Description"),
            //                                                     Mark=FIELD("Marque Produit"),
            //                                                     Type=FILTER("Warning in French")));
            Editable = false;

        }
        field(91032; "DEL Length.old"; Decimal)
        {
            BlankZero = true;
            Caption = 'Length';

            MinValue = 0;
        }
        field(91034; "DEL Width.old"; Decimal)
        {
            BlankZero = true;
            Caption = 'Width';

            MinValue = 0;
        }
        field(91036; "DEL Depth.old"; Decimal)
        {
            BlankZero = true;
            Caption = 'Depth';

            MinValue = 0;
        }
        field(4006496; "DEL EAN Code Katalog"; Text[13])
        {
            Caption = 'EAN Catalogue Code';

        }
        field(4006497; "DEL EAN Nummernserie Katalog"; Code[10])
        {
            Caption = 'Catalogue EAN Number Series';

            TableRelation = "No. Series";
        }
        field(4006498; "DEL Katalogbezeichnung"; Text[80])
        {
            Caption = 'Catalogue Description';

        }
        field(4006499; "DEL Katalogbezeichnung 2"; Text[80])
        {
            Caption = 'Catalogue Description 2';

        }
        field(4006500; "DEL Hersteller"; Text[50])
        {
            CalcFormula = Lookup(Manufacturer.Name WHERE(Code = FIELD("Manufacturer Code")));
            Caption = 'Manufacturer';

            Editable = false;
            FieldClass = FlowField;
        }
        field(4006501; "DEL Kurztext Katalog"; Text[100])
        {     //TODO: Katalogkopf is missing
            //CalcFormula = Lookup(Katalogkopf.Kurztext WHERE (Code=FIELD(Hauptkatalogcode)));
            Caption = 'Catalogue Short Text';

            FieldClass = FlowField;
        }
        field(4006502; "DEL Vorlagencode"; Code[20])
        {
            Caption = 'Template Code';
            // TODO: Vorlage ismissing. 
            //TableRelation = "Vorlage".Code WHERE (Dokumententyp=CONST(InDesign));
        }
        field(4006503; "DEL Standardartikelgruppe"; Code[20])
        {
            Caption = 'Standard Item Group';
            ////TODO: Artikelgruppe Katalog is missing
            // TableRelation = "Artikelgruppe Katalog";
        }
        field(4006504; "DEL Katalogpreis"; Decimal)
        {
            Caption = 'Catalogue Price';

        }
        field(4006505; "DEL Katalogartikelnr."; Text[30])
        {
            Caption = 'Sub. Item No.';

        }
        field(4006506; "DEL MDM Angelegt am"; Date)
        {
            Caption = 'Created On';

            Editable = false;
        }
        field(4006507; "DEL MDM Angelegt von"; Code[30])
        {
            Caption = 'Created By';

            Editable = false;
            TableRelation = User;
        }
        field(4006508; "DEL MDM Aktualisiert am"; Date)
        {
            Caption = 'Last Date Modified';

            Editable = false;
        }
        field(4006509; "DEL MDM Aktualisiert vom"; Code[30])
        {
            Caption = 'Modified By';

            Editable = false;
            TableRelation = User;
        }
        field(4006510; "DEL Bilddokument ID"; Code[20])
        {
            Caption = 'Picture Document ID';

            //TODO TableRelation = "Dokument Katalog" WHERE (Art=CONST(Bild));

            // trigger OnLookup()
            // begin

            //     CLEAR(gfrmDoklisteB);


            //     gfrmDoklisteB.FilterSetzen(goptQuellenart::Artikel,"No.",0);

            //     gfrmDoklisteB.LOOKUPMODE(TRUE);
            //     IF gfrmDoklisteB.RUNMODAL = ACTION::LookupOK THEN BEGIN
            //       gfrmDoklisteB.GETRECORD(grecKatDok);
            //       IF grecKatDok.Nummer <> "Bilddokument ID" THEN
            //         VALIDATE("Bilddokument ID",grecKatDok.Nummer);
            //     END;

            // end;

            //TODO trigger OnValidate()
            // begin
            //     // --- AL.KVK6.0 --- //
            //     IF Rec."Bilddokument ID" <> '' THEN BEGIN
            //       // --- Katalogdokument --- //
            //       grecKatDok.RESET;
            //       grecKatDok.SETRANGE(Quelle,grecKatDok.Quelle::Artikel);
            //       grecKatDok.SETRANGE(Art,grecKatDok.Art::Bild);
            //       grecKatDok.SETRANGE(Code,"No.");
            //       grecKatDok.SETRANGE(Nummer,"Bilddokument ID");
            //       IF NOT grecKatDok.FIND('-') THEN
            //         ERROR(AL0001,"Bilddokument ID");
            //     END;
            //     // --- AL.KVK6.0 END --- //
            // end;
        }
        // TODO field(4006512; "DEL Publikationsgruppe"; Code[20])
        // {
        //     Caption = 'Publication Group';
        //     Description = 'AL.KVK4.5';
        //     TableRelation = Publikationsgruppe;
        // }
        // field(4006513; "DEL Dokument ID"; Code[20])
        // {
        //     Caption = 'Dokument ID Image';
        //     Description = 'AL.KVK4.5';
        //     TableRelation = "Dokument Katalog";

        //     trigger OnLookup()
        //     begin
        //         // --- AL.KVK6.0 --- //
        //         CLEAR(gfrmZeichnung);

        //         // --- Zeichnungsfilter --- //
        //         grecDokument.RESET;
        //         grecDokument.SETCURRENTKEY(Art);
        //         grecDokument.SETRANGE(Art,grecDokument.Art::Zeichnung);
        //         gfrmZeichnung.SETTABLEVIEW(grecDokument);
        //         // --- Datensatz holen --- //
        //         grecDokument.SETRANGE("Dokument ID","Dokument ID");
        //         IF grecDokument.FIND('-') THEN
        //           gfrmZeichnung.SETRECORD(grecDokument);
        //         gfrmZeichnung.LOOKUPMODE(TRUE);
        //         IF gfrmZeichnung.RUNMODAL = ACTION::LookupOK THEN BEGIN
        //           gfrmZeichnung.GETRECORD(grecDokument);
        //           "Dokument ID" := grecDokument."Dokument ID";
        //         END;
        //         // --- AL.KVK6.0 END --- //
        //     end;
        // }
        // field(4006514; "DEL Katalogseite Hauptkatalog"; Text[100])
        // {
        //     CalcFormula = Lookup("Inhaltsverzeichnis Artikel".Seite WHERE (Aktuell=CONST(Yes),
        //                                                                    Artikelnr.=FIELD(No.)));
        //     Caption = 'Main Catalogue Page';
        //     Description = 'AL.KVK4.5';
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(4006515; "DEL Nettoartikel"; Boolean)
        {
            Caption = 'Netto Product';
            Description = 'AL.KVK4.5';
        }
        field(4006516; "DEL Liquidationsartikel"; Boolean)
        {
            Caption = 'Liquidation Item';
            Description = 'AL.KVK4.5';
        }
        field(4006517; "DEL Katalogartikel"; Boolean)
        {
            Caption = 'Nonstock Items';
            Description = 'AL.KVK4.5';
        }
        // field(4006520; "DEL Checklistennr."; Code[20])
        // {
        //     Caption = 'Checklist Number';
        //     Description = 'AL.KVK4.5';
        //     TableRelation = Checklistkopf WHERE (Klasse=CONST(Artikel));

        //     trigger OnValidate()
        //     begin
        //         // --- AL.KVK6.0 --- //
        //         IF xRec."Checklistennr." <> Rec."Checklistennr." THEN
        //           Systemstatus := Systemstatus::"In Entwicklung";
        //         // --- AL.KVK6.0, END --- //
        //     end;
        // }
        field(4006521; "DEL Systemstatus"; Option)
        {
            Caption = 'System Status';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;

            //TODO trigger OnValidate()
            // begin
            //     // --- AL.KVK6.0 --- //
            //     IF "Checklistennr." <> '' THEN BEGIN
            //       CALCFIELDS("Systemstatus pruefen");
            //       IF NOT gcouSystemVerw.SystemstatusPruefen(goptQuelle::Artikel,
            //                                                 "No.",
            //                                                 "Systemstatus pruefen",
            //                                                 Systemstatus,
            //                                                 TRUE) THEN
            //         ERROR(AL0002);
            //       // --- Zertifizierung --- //
            //       IF (Rec.Systemstatus <> xRec.Systemstatus) AND (Systemstatus = Systemstatus::Zertifiziert) THEN BEGIN
            //         grefRecordRef.OPEN(27);
            //         grefRecordRef.GETTABLE(Rec);
            //         ZertifizierungID := gcouStammVerw.ZertifizierungEinzVerarbeiten(grefRecordRef,
            //                                                                         "Checklistennr.",
            //                                                                         Systemstatus,
            //                                                                         '');
            //         IF ZertifizierungID > 0 THEN BEGIN
            //           grecZertProt.RESET;
            //           grecZertProt.SETCURRENTKEY(Nummer);
            //           grecZertProt.SETRANGE(Nummer,"No.");
            //           grecZertProt.SETRANGE(Meldungsart,grecZertProt.Meldungsart::Fehler);
            //           IF grecZertProt.FIND('-') THEN BEGIN
            //             // --- Bereich --- //
            //             gcouStammVerw.ZertifizierungBereich(Rec,0);
            //             MESSAGE(AL0003);
            //             Systemstatus := Systemstatus::"In Entwicklung";
            //           END
            //           ELSE BEGIN
            //             // --- Bereich --- //
            //             gcouStammVerw.ZertifizierungBereich(Rec,1);
            //             MESSAGE(AL0004);
            //           END;
            //         END
            //         ELSE
            //           gcouStammVerw.ZertifizierungBereich(Rec,1);
            //       END;
            //     END;
            //     // --- AL.KVK6.0, END --- //
            // end;
        }
        field(4006522; "DEL Systemstatus pruefen"; Boolean)
        {
            // //TODO CalcFormula = Lookup(Checklistkopf."Systemstatus pruefen" WHERE (Code=FIELD(Checklistennr.)));
            Caption = 'Check System Status';
            Description = 'AL.KVK4.5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006523; "DEL Katalogverwendung"; Boolean)
        {
            Caption = 'Catalogue Usage';
            Description = 'AL.KVK4.5';
            Editable = false;
        }
        field(4006524; "DEL Hauptkatalogcode"; Code[20])
        {
            Caption = 'Main Catalogue Code';
            Description = 'AL.KVK4.5';
            //TODO TableRelation = Katalogkopf.Code;
        }
        field(4006525; "DEL Bilddokument ID vererbt"; Boolean)
        {
            Caption = 'Inherit Picture Document ID';
            Description = 'AL.KVK4.5';
        }
        field(4006528; "DEL Zusatzinfo 1"; Text[20])
        {
            Caption = 'Additional Information 1';
            Description = 'AL.KVK4.5';
            //TODO TableRelation = Zusatzinfo.Code WHERE (Art=CONST(Zusatzinfo1),
            //                                        Code=FIELD("Zusatzinfo 1"));
        }
        field(4006529; "DEL Zusatzinfo 2"; Text[20])
        {
            Caption = 'Additional Information 2';
            Description = 'AL.KVK4.5';
            //TODO TableRelation = Zusatzinfo.Code WHERE (Art=CONST(Zusatzinfo2),
            //                                        Code=FIELD(Zusatzinfo 2));
        }
        field(4006530; "DEL Zusatzinfo 3"; Text[20])
        {
            Caption = 'Additional Information 3';
            Description = 'AL.KVK4.5';
            //TODO TableRelation = Zusatzinfo.Code WHERE (Art=CONST(Zusatzinfo3),
            //                                        Code=FIELD(Zusatzinfo 3));
        }
        field(4006531; "DEL Zusatzinfo 4"; Text[20])
        {
            Caption = 'Additional Information 4';
            Description = 'AL.KVK4.5';
            // TODO TableRelation = Zusatzinfo.Code WHERE (Art=CONST(Zusatzinfo4),
            //                                        Code=FIELD(Zusatzinfo 4));
        }
        field(4006532; "DEL Zusatzinfo 5"; Text[20])
        {
            Caption = 'Additional Information 5';
            Description = 'AL.KVK4.5';
            //TODO TableRelation = Zusatzinfo.Code WHERE (Art=CONST(Zusatzinfo5),
            //                                        Code=FIELD(Zusatzinfo 5));
        }
        field(4006533; "DEL Katalogseite"; Text[100])
        {
            Caption = 'Catalogue Page';
            Description = 'AL.KVK4.5';
            Editable = false;
        }
        field(4006534; "DEL Sprache 01"; Code[10])
        {
            //TODO CalcFormula = Lookup("Katalog Einrichtung"."Sprache 01" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 1';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006535; "DEL Sprache 02"; Code[10])
        {
            //TODO CalcFormula = Lookup("Katalog Einrichtung"."Sprache 02" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 1';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006536; "DEL Sprache 03"; Code[10])
        {
            //TODO CalcFormula = Lookup("Katalog Einrichtung"."Sprache 03" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 3';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006537; "DEL Sprache 04"; Code[10])
        {
            // TODO CalcFormula = Lookup("Katalog Einrichtung"."Sprache 04" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 4';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006538; "DEL Sprache 05"; Code[10])
        {
            // TODO CalcFormula = Lookup("Katalog Einrichtung"."Sprache 05" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006539; "DEL Sprache 06"; Code[10])
        {
            //TODO CalcFormula = Lookup("Katalog Einrichtung"."Sprache 06" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 6';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006540; "DEL Sprache 07"; Code[10])
        {
            //TODO CalcFormula = Lookup("Katalog Einrichtung"."Sprache 07" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 7';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006541; "DEL Sprache 08"; Code[10])
        {
            //TODO  CalcFormula = Lookup("Katalog Einrichtung"."Sprache 08" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 8';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006542; "DEL Sprache 09"; Code[10])
        {
            //TODO CalcFormula = Lookup("Katalog Einrichtung"."Sprache 09" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 9';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006543; "DEL Sprache 10"; Code[10])
        {
            //TODO CalcFormula = Lookup("Katalog Einrichtung"."Sprache 10" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 10';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006544; "DEL ML Bezeichnung 01"; Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006545; "DEL ML Bezeichnung 02"; Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006546; "DEL ML Bezeichnung 03"; Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006547; "DEL ML Bezeichnung 04"; Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006548; "DEL ML Bezeichnung 05"; Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006549; "DEL ML Bezeichnung 06"; Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006550; "DEL ML Bezeichnung 07"; Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006551; "DEL ML Bezeichnung 08"; Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006552; "DEL ML Bezeichnung 09"; Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006553; "DEL ML Bezeichnung 10"; Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006554; "DEL ML Beschrieb 01"; Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006555; "DEL ML Beschrieb 02"; Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006556; "DEL ML Beschrieb 03"; Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006557; "DEL ML Beschrieb 04"; Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006558; "DEL ML Beschrieb 05"; Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006559; "DEL ML Beschrieb 06"; Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006560; "DEL ML Beschrieb 07"; Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006561; "DEL ML Beschrieb 08"; Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006562; "DEL ML Beschrieb 09"; Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006563; "DEL ML Beschrieb 10"; Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006564; "DEL Klassifikationscode"; Text[8])
        {
            Caption = 'Classification Code';
            Description = 'AL.KVK4.5';
        }
        field(4006565; "DEL Datanaustausch ID"; Code[20])
        {
            Caption = 'Data Exchange ID';
            Description = 'AL.KVK4.5';
            Editable = false;
        }
        field(4006566; "DEL Datenaustauschart"; Option)
        {
            Caption = 'Data Exchange Type';
            Description = 'AL.KVK4.5';
            Editable = false;
            OptionCaption = 'Import,Export,Archive Import,Archive Export';
            OptionMembers = Import,Export,ArchivImport,ArchivExport;
        }
        field(4006567; "DEL Transaktionsart"; Option)
        {
            Caption = 'Transaction Type';
            Description = 'AL.KVK4.5';
            Editable = false;
            OptionCaption = 'Create,Change,Delete';
            OptionMembers = Neuanlage,"Änderung","Löschnung";
        }
        field(4006571; "DEL Manipulation ID"; Integer)
        {
            Caption = 'Manipulation ID';
            Description = 'AL.KVK4.5';
        }
        field(4006575; "DEL Langtextnummer"; Text[15])
        {
            Caption = 'Long Text No.';
            Description = 'AL.KVK4.5';
        }
        field(4006576; "DEL Vererbung Beschreibungen"; Boolean)
        {
            Caption = 'Inherit Descriptions';
            Description = 'AL.KVK4.5';
        }
        field(4006577; "DEL Vererbung Merkmale"; Boolean)
        {
            Caption = 'Inherit Features';
            Description = 'AL.KVK4.5';
        }
        field(4006578; "DEL Vererbung Schlagworte"; Boolean)
        {
            Caption = 'Inherit Keywords';
            Description = 'AL.KVK4.5';
        }
        field(4006579; "DEL Vererbung Bilder"; Boolean)
        {
            Caption = 'Inherit Pictures';
            Description = 'AL.KVK4.5';
        }
        field(4006580; "DEL Vererbung Dokumente"; Boolean)
        {
            Caption = 'Inherit Documents';
            Description = 'AL.KVK4.5';
        }
        field(4006581; "DEL Vererbung Grafik"; Boolean)
        {
            Caption = 'Inherit Graphic';
            Description = 'AL.KVK4.5';
        }
        field(4006582; "DEL Vererbung Bezeichnung"; Boolean)
        {
            Caption = 'Inherit Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006583; "DEL Uebersetzung"; Boolean)
        {
            Caption = 'Translation';
            Description = 'AL.KVK4.5';
        }
        field(4006584; "DEL Akt. Kampagnenummer"; Code[20])
        {
            //TODO CalcFormula = Lookup("Katalog Einrichtung".Kampagnenummer WHERE (Primaerschluessel=CONST()));
            Caption = 'Act. Campaign No.';
            Description = 'AL.KVK4.5';
            FieldClass = FlowField;
            TableRelation = Campaign;
        }
        field(4006585; "DEL Verwendung Print"; Boolean)
        {
            Caption = 'Print Usage';
            Description = 'AL.KVK4.5';
        }
        field(4006586; "DEL Verwendung Web"; Boolean)
        {
            Caption = 'Web Usage';
            Description = 'AL.KVK4.5';
        }
        field(4006587; "DEL Vererbung Merkmalwerte"; Boolean)
        {
            Caption = 'Inherit Feature Values';
            Description = 'AL.KVK4.5';
        }
        field(4006588; "DEL ZertifizierungID"; BigInteger)
        {
            Caption = 'Certification ID';
            Description = 'AL.KVK4.5';
        }
        field(4006592; "DEL Kurztext"; Text[100])
        {
            Caption = 'Short Text';
            Description = 'AL.KVK4.5';
        }
        field(4006594; "DEL Neuer Artikel"; Boolean)
        {
            Caption = 'New Item';
            Description = 'AL.KVK4.5';
        }
        field(4006595; "DEL Vererbung Referenzen"; Boolean)
        {
            Caption = 'Inherit References';
            Description = 'AL.KVK4.5';
        }
        field(4006596; "DEL Bereich 01"; Code[10])
        {
            Caption = 'Area 1';
            Description = 'AL.KVK4.5';
            Editable = false;
            //TODO TableRelation = Datenbereich;
        }
        field(4006597; "DEL Bereich 02"; Code[10])
        {
            Caption = 'Area 2';
            Description = 'AL.KVK4.5';
            Editable = false;
            ////TODO TableRelation = Datenbereich;
        }
        field(4006598; "DEL Bereich 03"; Code[10])
        {
            Caption = 'Area 3';
            Description = 'AL.KVK4.5';
            Editable = false;
            //TODO TableRelation = Datenbereich;
        }
        field(4006599; "DEL Bereich 04"; Code[10])
        {
            Caption = 'Area 4';
            Description = 'AL.KVK4.5';
            Editable = false;
            //TODO TableRelation = Datenbereich;
        }
        field(4006600; "DEL Bereich 05"; Code[10])
        {
            Caption = 'Area 5';
            Description = 'AL.KVK4.5';
            Editable = false;
            //TODO TableRelation = Datenbereich;
        }
        field(4006601; "DEL Bereich 06"; Code[10])
        {
            Caption = 'Area 6';
            Description = 'AL.KVK4.5';
            Editable = false;
            //TODO TableRelation = Datenbereich;
        }
        field(4006602; "DEL Bereich 07"; Code[10])
        {
            Caption = 'Area 7';
            Description = 'AL.KVK4.5';
            Editable = false;
            //TODO TableRelation = Datenbereich;
        }
        field(4006603; "DEL Bereich 08"; Code[10])
        {
            Caption = 'Area 8';
            Description = 'AL.KVK4.5';
            Editable = false;
            //TODO TableRelation = Datenbereich;
        }
        field(4006604; "DEL Bereich 09"; Code[10])
        {
            Caption = 'Area 9';
            Description = 'AL.KVK4.5';
            Editable = false;
            //TODO TableRelation = Datenbereich;
        }
        field(4006605; "DEL Bereich 10"; Code[10])
        {
            Caption = 'Area 10';
            Description = 'AL.KVK4.5';
            Editable = false;
            //TODO TableRelation = Datenbereich;
        }
        field(4006606; "DEL Systemstatus Ber. 01"; Option)
        {
            Caption = 'System Status Area 01';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006607; "DEL Systemstatus Ber. 02"; Option)
        {
            Caption = 'System Status Area 02';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006608; "DEL Systemstatus Ber. 03"; Option)
        {
            Caption = 'System Status Area 03';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006609; "DEL Systemstatus Ber. 04"; Option)
        {
            Caption = 'System Status Area 04';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006610; "DEL Systemstatus Ber. 05"; Option)
        {
            Caption = 'System Status Area 05';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006611; "DEL Systemstatus Ber. 06"; Option)
        {
            Caption = 'System Status Area 06';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006612; "DEL Systemstatus Ber. 07"; Option)
        {
            Caption = 'System Status Area 07';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006613; "DEL Systemstatus Ber. 08"; Option)
        {
            Caption = 'System Status Area 08';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006614; "DEL Systemstatus Ber. 09"; Option)
        {
            Caption = 'System Status Area 09';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
    }
    keys
    {//TODO
        // key(Key1;Standardartikelgruppe)
        // {
        // }
        // key(Key2;"Checklistennr.")
        // {
        // }
    }

    //TODO

    // procedure ModifSegment(var ProductCode: Code[20]; var CategCode: Code[20])
    // var
    //     // //TODO ProductGroup_Rec: Record "Product Group";
    //     DefaultDimension_Rec: Record "Default Dimension";
    //     ItemCategory_Rec: Record "Item Category";
    // begin
    //     //MIG2017
    //     IF ProductGroup_Rec.GET(CategCode, ProductCode) THEN BEGIN
    //         IF DefaultDimension_Rec.GET(27, "No.", 'Segment') THEN BEGIN
    //             IF DefaultDimension_Rec."Dimension Value Code" <> ProductGroup_Rec."Code Segment" THEN BEGIN
    //                 DefaultDimension_Rec.VALIDATE("Dimension Value Code", ProductGroup_Rec."Code Segment");
    //                 DefaultDimension_Rec.MODIFY;
    //             END;
    //         END
    //         ELSE BEGIN
    //             DefaultDimension_Rec.INIT;
    //             DefaultDimension_Rec.VALIDATE("Table ID", 27);
    //             DefaultDimension_Rec.VALIDATE("No.", "No.");
    //             DefaultDimension_Rec.VALIDATE("Dimension Code", 'Segment');
    //             DefaultDimension_Rec.VALIDATE("Dimension Value Code", ProductGroup_Rec."Code Segment");
    //             DefaultDimension_Rec.INSERT;
    //         END;
    //     END;
    //     //END MIG2017
    // end;

    procedure ModifCategory(var CategCode: Code[20])
    var
        DefaultDimension_Rec: Record "Default Dimension";
        ItemCategory_Rec: Record "Item Category";
    begin
        //MIG2017
        // T-00746 START
        IF DefaultDimension_Rec.GET(27, "No.", 'Categorie') THEN BEGIN
            IF DefaultDimension_Rec."Dimension Value Code" <> CategCode THEN BEGIN
                DefaultDimension_Rec.VALIDATE("Dimension Value Code", CategCode);
                DefaultDimension_Rec.MODIFY;
            END;
        END
        // T-00746 END
        ELSE BEGIN
            // T-00746 START
            DefaultDimension_Rec.INIT;
            DefaultDimension_Rec.VALIDATE("Table ID", 27);
            DefaultDimension_Rec.VALIDATE("No.", "No.");
            DefaultDimension_Rec.VALIDATE("Dimension Code", 'Categorie');
            DefaultDimension_Rec.VALIDATE("Dimension Value Code", CategCode);
            DefaultDimension_Rec.INSERT;
            // T-00746 END
        END;
        //END MIG2017
    end;

    // //TODO procedure GetVolCBM(Update: Boolean): Decimal
    // begin
    //     //>>Mgts10.00.05.00
    //     IF ("Vol cbm" = 0) AND (PCB <> 0) THEN BEGIN
    //         "Vol cbm" := ROUND(("Vol cbm carton transport" / PCB), 0.00001, '>');
    //         IF Update THEN
    //             MODIFY;
    //     END;
    //     EXIT("Vol cbm")
    //     //<<Mgts10.00.05.00
    // end;

    var
        ItemCategory: Record "Item Category";
        "--- AL.KVK ---": Integer;
        // TODO    grecDokEinr: Record "4024041";
        //     grecDokument: Record "4024045";
        //     grecArtikelGrp: Record "4006519";
        //     grecKatDok: Record "4006515";
        //     grecZertProt: Record "4024050";
        //     grecCheckZeile: Record "4006524";
        //     grecCheckZeileRef: Record "4006524";
        //     gfrmDoklisteB: Page "4024073";
        //     gfrmZeichnung: Page "4006563";
        //                        gcouKatVerw: Codeunit "4006500";
        //                        gcouSystemVerw: Codeunit "4006498";
        //                        gcouDokVerw: Codeunit "4006497";
        //                        gcouStammVerw: Codeunit "4006496";
        //                        grefRecordRef: RecordRef;
        // goptQuelle: Option Artikel,Artikelgruppe,Kapitel,Kataloggruppe,Gruppensystem,Katalog,Checkliste,Textbaustein,Vorlage;
        // goptQuellenart: Option Artikel,Artikelgruppe,Warengruppe,Kapitel,Kataloggruppe,Textbaustein;
        // //TODO RecMatriseGroupArtGroup: Record "DEL Matrise Group Art./Group Std";
        PageMatriseGroupArtGroup: Page "DEL Matrice Grp art./Group std";
        Text0027: Label 'Segment code missing product code %1';
        AL0001: Label 'Picture Document %1 cannot be found in the related table.';
        AL0002: Label 'You are not authorized to certify items.';
        AL0003: Label 'Certification failure, please check the log.';
        AL0004: Label 'Certification Log contains warnings.';
}

