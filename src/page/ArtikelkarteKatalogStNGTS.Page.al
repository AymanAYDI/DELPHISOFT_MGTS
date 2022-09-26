page 50121 "Artikelkarte Katalog St. NGTS"
{
    // AL.KVK4.0

    Caption = 'Catalog Item Card NGTS';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Catalog';
    RefreshOnActivate = true;
    SourceTable = Table27;

    layout
    {
        area(content)
        {
            group(Allgemein)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = "No.Editable";

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Katalogbezeichnung; Katalogbezeichnung)
                {
                    Visible = KatalogbezeichnungVisible;
                }
                field(Bezeichnung; Description)
                {
                    Visible = BezeichnungVisible;
                }
                field(Bezeichnung2; "Description 2")
                {
                    Visible = Bezeichnung2Visible;
                }
                field(Katalogbezeichnung2; "Katalogbezeichnung 2")
                {
                    Visible = Katalogbezeichnung2Visible;
                }
                field("Search Description"; "Search Description")
                {
                }
                field("Base Unit of Measure"; "Base Unit of Measure")
                {
                }
                field("Assembly BOM"; "Assembly BOM")
                {
                }
                field("Sales Unit of Measure"; "Sales Unit of Measure")
                {
                }
                field(Systemstatus; Systemstatus)
                {
                }
                field(Standardartikelgruppe; Standardartikelgruppe)
                {
                }
                field(Publikationsgruppe; Publikationsgruppe)
                {
                }
                field(Vorlagencode; Vorlagencode)
                {
                }
                field("Katalogartikelnr."; "Katalogartikelnr.")
                {
                }
                field(Hauptkatalogcode; Hauptkatalogcode)
                {
                }
            }
            part(Uebersetzungen; 4006527)
            {
                Caption = 'Translations';
                SubPageLink = Art = CONST (Artikel),
                              Code = FIELD (No.);
            }
            part(Beschreibungen; 4006555)
            {
                Caption = 'Descriptions';
                SubPageLink = Art = CONST (Artikel),
                              Nummer = FIELD (No.);
            }
            part(Merkmale; 4006560)
            {
                Caption = 'Features';
                SubPageLink = Zeilenart = CONST (Merkmal),
                              Code = FIELD (No.);
            }
            part(Bilddokumente; 4006557)
            {
                Caption = 'Picture Documents';
                SubPageLink = Quelle = CONST (Artikel),
                              Art = CONST (Bild),
                              Code = FIELD (No.);
            }
            part(Verwendungen; 4006499)
            {
                Caption = 'Usages';
                Editable = false;
                SubPageLink = Zeilenart = CONST (Artikel),
                              Nummer = FIELD (No.);
                SubPageView = SORTING (Zeilenart, Nummer)
                              WHERE (Zeilenart = CONST (Artikel));
            }
            group(Zuordnungen)
            {
                Caption = 'Allocations';
                field("Unit Price"; "Unit Price")
                {
                }
                field("<Katalogartikelnr.2>"; "Katalogartikelnr.")
                {
                }
                field("<Sales Unit of Measure2>"; "Sales Unit of Measure")
                {
                }
                field("EAN Code Katalog"; "EAN Code Katalog")
                {
                    Editable = false;
                }
                field(Hersteller; Hersteller)
                {
                    Caption = 'Manufacturer';
                }
                field("Vendor Item No."; "Vendor Item No.")
                {
                }
                field("Vendor No."; "Vendor No.")
                {
                }
                field("Checklistennr."; "Checklistennr.")
                {
                    Editable = gboChecklistennrEditable;

                    trigger OnValidate()
                    begin
                        ControlSHowMendatory; // vaseem
                        CurrPage.UPDATE;
                    end;
                }
                field("Bilddokument ID"; "Bilddokument ID")
                {
                }
                field(Blocked; Blocked)
                {
                }
                field(Uebersetzung; Uebersetzung)
                {
                }
                field(Katalogartikel; Katalogartikel)
                {
                }
                field("Zusatzinfo 1"; "Zusatzinfo 1")
                {
                }
                field("Zusatzinfo 2"; "Zusatzinfo 2")
                {
                }
                field("Zusatzinfo 3"; "Zusatzinfo 3")
                {
                }
                field("Zusatzinfo 4"; "Zusatzinfo 4")
                {
                }
                field("Zusatzinfo 5"; "Zusatzinfo 5")
                {
                }
                field("Vererbung Beschreibungen"; "Vererbung Beschreibungen")
                {
                }
                field("Vererbung Merkmale"; "Vererbung Merkmale")
                {
                }
                field("Vererbung Merkmalwerte"; "Vererbung Merkmalwerte")
                {
                }
                field("Vererbung Schlagworte"; "Vererbung Schlagworte")
                {
                }
                field("Vererbung Bilder"; "Vererbung Bilder")
                {
                }
                field("Vererbung Dokumente"; "Vererbung Dokumente")
                {
                }
                field("Vererbung Grafik"; "Vererbung Grafik")
                {
                }
            }
            group(Log)
            {
                Caption = 'Log';
                field("MDM Angelegt am"; "MDM Angelegt am")
                {
                }
                field("MDM Angelegt von"; "MDM Angelegt von")
                {
                }
                field("MDM Aktualisiert am"; "MDM Aktualisiert am")
                {
                }
                field("MDM Aktualisiert vom"; "MDM Aktualisiert vom")
                {
                }
            }
        }
        area(factboxes)
        {
            part(MultiPicture; 4021251)
            {
                SubPageLink = Quelle = CONST (Artikel),
                              Art = CONST (Bild),
                              Code = FIELD (No.);
                Visible = false;
            }
            part(DescriptionFactBox; 4043662)
            {
                Caption = 'Descriptions';
                Provider = Beschreibungen;
                SubPageLink = Art = FIELD (Art),
                              Zeilennr.=FIELD(Zeilennr.),
                              Nummer=FIELD(Nummer),
                              Basiszeilennr.=FIELD(Basiszeilennr.);
                Visible = false;
            }
            systempart(;Links)
            {
                Visible = true;
            }
            systempart(;Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Masterdaten)
            {
                Caption = 'Master Data';
                action("Ein&heiten")
                {
                    Caption = 'Units';
                    Image = UnitOfMeasure;
                    RunObject = Page 5404;
                                    RunPageLink = Item No.=FIELD(No.);
                }
                action("Va&rianten")
                {
                    Caption = 'Va&riants';
                    Image = ItemVariant;
                    RunObject = Page 5401;
                                    RunPageLink = Item No.=FIELD(No.);
                }
                action("Ersat&zartikel")
                {
                    Caption = 'Substituti&ons';
                    Image = ItemSubstitution;
                    RunObject = Page 5716;
                                    RunPageLink = Type=CONST(Item),
                                  No.=FIELD(No.);
                }
                action("&Textbausteine")
                {
                    Caption = 'E&xtended Texts';
                    Image = Text;
                    RunObject = Page 391;
                                    RunPageLink = Table Name=CONST(Item),
                                  No.=FIELD(No.);
                    RunPageView = SORTING(Table Name,No.,Language Code,All Language Codes,Starting Date,Ending Date);
                }
                action("Übersetzungen")
                {
                    Caption = 'Translations';
                    Image = Translations;
                    RunObject = Page 35;
                                    RunPageLink = Item No.=FIELD(No.),
                                  Variant Code=CONST();
                }
                action(Artikelbarcodes)
                {
                    Caption = 'Identifiers';
                    Image = BarCode;
                    RunObject = Page 7706;
                                    RunPageLink = Item No.=FIELD(No.);
                    RunPageView = SORTING(Item No.,Variant Code,Unit of Measure Code);
                }
                action("<Action1100176002>")
                {
                    Caption = 'Catalog Page References';
                    Image = ViewPage;
                    RunObject = Page 4006531;
                                    RunPageLink = Artikelnr.=FIELD(No.);
                    RunPageView = SORTING(Artikelnr.,Code)
                                  ORDER(Descending);
                }
                action("<Action1100168015>")
                {
                    Caption = 'Certification Log';
                    Image = Certificate;

                    trigger OnAction()
                    begin
                        // --- Init --- //
                        CLEAR(gpagZertProt);

                        // --- Schlüssel --- //
                        grefRecordRefQuelle.OPEN(27);
                        grefRecordRefQuelle.GETTABLE(Rec);
                        gridRecordID := grefRecordRefQuelle.RECORDID;

                        // --- Filter --- //
                        gpagZertProt.FilterSetzen(27,gridRecordID);
                        gpagZertProt.RUNMODAL;

                        // --- Init --- //
                        grefRecordRefQuelle.CLOSE;
                    end;
                }
            }
            group(Historie)
            {
                Caption = 'History';
                Image = History;
                group("&Posten")
                {
                    Caption = 'E&ntries';
                    Image = Entries;
                    action("&Posten")
                    {
                        Caption = 'Ledger E&ntries';
                        Image = ItemLedger;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        RunObject = Page 38;
                                        RunPageLink = Item No.=FIELD(No.);
                        RunPageView = SORTING(Item No.);
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("&Reservierungsposten")
                    {
                        Caption = '&Reservation Entries';
                        Image = ReservationLedger;
                        RunObject = Page 497;
                                        RunPageLink = Reservation Status=CONST(Reservation),
                                      Item No.=FIELD(No.);
                        RunPageView = SORTING(Item No.,Variant Code,Location Code,Reservation Status);
                    }
                    action("&Inventurposten")
                    {
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        RunObject = Page 390;
                                        RunPageLink = Item No.=FIELD(No.);
                        RunPageView = SORTING(Item No.);
                    }
                    action("&Wertposten")
                    {
                        Caption = '&Value Entries';
                        Image = ValueLedger;
                        RunObject = Page 5802;
                                        RunPageLink = Item No.=FIELD(No.);
                        RunPageView = SORTING(Item No.);
                    }
                    action("Artikel&verfolgungsposten")
                    {
                        Caption = 'Item &Tracking Entries';
                        Image = ItemTrackingLedger;

                        trigger OnAction()
                        var
                            ItemTrackingMgt: Codeunit "6500";
                        begin
                            //ItemTrackingMgt.CallItemTrackingEntryForm(3,'',"No.",'','','','');
                        end;
                    }
                    action("&Lagerplatzposten")
                    {
                        Caption = '&Warehouse Entries';
                        Image = BinLedger;
                        RunObject = Page 7318;
                                        RunPageLink = Item No.=FIELD(No.);
                        RunPageView = SORTING(Item No.,Bin Code,Location Code,Variant Code,Unit of Measure Code,Lot No.,Serial No.,Entry Type,Dedicated);
                    }
                    action(Ausgleichsvorschlag)
                    {
                        Caption = 'Application Worksheet';
                        Image = ApplicationWorksheet;
                        RunObject = Page 521;
                                        RunPageLink = Item No.=FIELD(No.);
                    }
                }
                group(Statistik)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    action(Statistics)
                    {
                        Caption = 'Statistics';
                        Image = Statistics;
                        Promoted = true;
                        PromotedCategory = Process;
                        ShortCutKey = 'F7';

                        trigger OnAction()
                        var
                            ItemStatistics: Page "5827";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RUNMODAL;
                        end;
                    }
                    action(Buchungsstatistik)
                    {
                        Caption = 'Entry Statistics';
                        Image = EntryStatistics;
                        RunObject = Page 304;
                                        RunPageLink = No.=FIELD(No.),
                                      Date Filter=FIELD(Date Filter),
                                      Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                      Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                                      Location Filter=FIELD(Location Filter),
                                      Drop Shipment Filter=FIELD(Drop Shipment Filter),
                                      Variant Filter=FIELD(Variant Filter);
                    }
                    action("&Umsatz")
                    {
                        Caption = 'T&urnover';
                        Image = Turnover;
                        RunObject = Page 158;
                                        RunPageLink = No.=FIELD(No.),
                                      Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                      Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter),
                                      Location Filter=FIELD(Location Filter),
                                      Drop Shipment Filter=FIELD(Drop Shipment Filter),
                                      Variant Filter=FIELD(Variant Filter);
                    }
                }
                action("Be&merkungen")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 124;
                                    RunPageLink = Table Name=CONST(Item),
                                  No.=FIELD(No.);
                }
            }
            group(Zuordnung)
            {
                Caption = 'Master Data';
                Image = DataEntry;
                action("Übersetzungen")
                {
                    Caption = 'Translations';
                    Image = Translations;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        // --- Init --- //
                        CLEAR(gpagArtikelÜber);

                        gpagArtikelÜber.FilterSetzen(0,"No.");
                        gpagArtikelÜber.RUN;
                    end;
                }
                action("Re&ferenzen")
                {
                    Caption = 'Cross Re&ferences';
                    Image = Change;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        // --- Init --- //
                        CLEAR(gpagZuordRef);

                        gpagZuordRef.FilterSetzen(0,"No.");
                        gpagZuordRef.RUN;
                    end;
                }
                action("&Beschreibungen")
                {
                    Caption = 'Description';
                    Image = Text;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = false;

                    trigger OnAction()
                    begin
                        // --- Init --- //
                        CLEAR(gpagTextKatalog);

                        gpagTextKatalog.FilterSetzen(0,"No.");
                        gpagTextKatalog.RUN;
                    end;
                }
            }
            group(Klassifikation)
            {
                Caption = 'Classification';
                action("&Merkmale")
                {
                    Caption = '&Features';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        // --- Init --- //
                        CLEAR(gpagKatalogmerkmale);

                        gpagKatalogmerkmale.FilterSetzen(0,"No.");
                        gpagKatalogmerkmale.RUN;
                    end;
                }
                action("&Schlagworte")
                {
                    Caption = 'Keywords';
                    Image = Entries;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        // --- Init --- //
                        CLEAR(gpagKatalogschlagworte);

                        gpagKatalogschlagworte.FilterSetzen(0,"No.");
                        gpagKatalogschlagworte.RUN;
                    end;
                }
                action("&Klassen")
                {
                    Caption = '&Class';
                    Image = Category;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page 4006605;
                                    RunPageLink = Art=CONST(Artikel),
                                  Nummer=FIELD(No.);
                    RunPageView = SORTING(Art,Nummer,Code);
                }
            }
            group(Dokumente)
            {
                Caption = 'Documents';
                action("&Bilddokumente")
                {
                    Caption = 'Pictures';
                    Image = Picture;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        // --- Init --- //
                        CLEAR(gpagKatalogbild);

                        gpagKatalogbild.FilterSetzen(0,0,"No.");
                        gpagKatalogbild.RUN;
                    end;
                }
                action("&Dokumente")
                {
                    Caption = 'Documents';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        // --- Init --- //
                        CLEAR(gpagKatalogdok);

                        gpagKatalogdok.FilterSetzen(0,1,"No.");
                        gpagKatalogdok.RUN;
                    end;
                }
                action("&Grafikdokumente")
                {
                    Caption = 'Graphics';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        // --- Init --- //
                        CLEAR(gpagKataloggrafik);

                        gpagKataloggrafik.FilterSetzen(0,3,"No.");
                        gpagKataloggrafik.RUN;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unktion")
            {
                Caption = 'F&unctions';
                action("Artikel kopieren")
                {
                    Caption = 'Copy item';
                    Image = copy;

                    trigger OnAction()
                    var
                        ArtikelKopieren: Report "4006496";
                    begin
                        ArtikelKopieren.ItemDef(Rec);
                        ArtikelKopieren.RUNMODAL;
                    end;
                }
                action("EAN Code generieren")
                {
                    Caption = 'Generate EAN Code';
                    Image = BarCode;

                    trigger OnAction()
                    begin
                        IF "EAN Code Katalog" <> '' THEN
                          MESSAGE(AL0001)
                        ELSE BEGIN
                          // --- EAN-Code generieren --- //
                          IF CONFIRM(AL0002) THEN BEGIN
                            CASE STRMENU('&1 Neutraler EAN Code,&2 Kunden EAN Code') - 1 OF
                              0: BEGIN
                                   // --- EAN-Code extern generieren --- //
                                   "EAN Code Katalog" := gcouSystemVerw.ExtEANgenerieren(Rec);
                                   MODIFY;
                                 END;
                              1: BEGIN
                                   // --- EAN-Code intern generieren --- //
                                   "EAN Code Katalog" := gcouSystemVerw.IntEANgenerieren(Rec);
                                   MODIFY;
                                 END;
                            END;
                          END;
                        END;
                    end;
                }
                action("EAN Code initialisieren")
                {
                    Caption = 'Initialize EAN Code';
                    Image = BarCode;

                    trigger OnAction()
                    begin
                        IF CONFIRM(AL0003) THEN BEGIN
                          // --- EAN Init. --- //
                          gcouSystemVerw.EANinitialisieren("No.","EAN Code Katalog");
                          // --- Artikel aktualisieren --- //
                          "EAN Code Katalog" := '';
                          MODIFY;
                        END;
                    end;
                }
                action("Merkmale reorganisieren")
                {
                    Caption = 'Reorganize Features';
                    Image = RefreshText;

                    trigger OnAction()
                    begin
                        // --- Quelle --- //
                        goptQuelle := goptQuelle::Artikel;

                        IF CONFIRM(AL0007) THEN BEGIN
                          // --- Katalogmerkmal --- //
                          grecKatMerk.RESET;
                          grecKatMerk.SETRANGE(Quelle,grecKatMerk.Quelle::Artikel);
                          grecKatMerk.SETRANGE(Code,"No.");
                          grecKatMerk.SETRANGE(Vererbt,TRUE);
                          IF grecKatMerk.FIND('-') THEN
                            ERROR(AL0006);
                          // --- Merkmale reorg. --- //
                          gcouKatVerw.KatalogMerkmaleReorg(goptQuelle,"No.");
                        END;
                    end;
                }
                action("Schlagworte reorganisieren")
                {
                    Caption = 'Reorganize Keywords';
                    Image = RefreshText;

                    trigger OnAction()
                    begin
                        // --- Quelle --- //
                        goptQuelle := goptQuelle::Artikel;

                        IF CONFIRM(AL0008) THEN
                          gcouKatVerw.KatalogSchlagwortReorg(goptQuelle,"No.");
                    end;
                }
                action("<Action1100168022>")
                {
                    Caption = 'Confirm Translations';
                    Image = Confirm;

                    trigger OnAction()
                    begin
                        IF CONFIRM(AL0011) THEN BEGIN
                          grecKatUeber.RESET;
                          grecKatUeber.SETCURRENTKEY(Uebersetzt);
                          grecKatUeber.SETRANGE(Uebersetzt,TRUE);
                          grecKatUeber.SETRANGE(Art,grecKatUeber.Art::Artikel);
                          grecKatUeber.SETRANGE(Code,"No.");
                          grecKatUeber.SETRANGE(Uebersetzungsmandant,'');
                          IF grecKatUeber.FIND('-') THEN REPEAT
                            grecKatUeber.VALIDATE(Aktivitaet,FALSE);
                            grecKatUeber.MODIFY(TRUE);
                          UNTIL grecKatUeber.NEXT = 0;
                        END;
                    end;
                }
                action("Apply Template")
                {
                    Caption = 'Apply Template';
                    Ellipsis = true;
                    Image = ApplyTemplate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ConfigTemplateMgt: Codeunit "8612";
                        RecRef: RecordRef;
                    begin
                        RecRef.GETTABLE(Rec);
                        ConfigTemplateMgt.UpdateFromTemplateSelection(RecRef);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("RW Bericht / Artikel")
            {
                Caption = 'RW Report / Item';
                Image = "Report";

                trigger OnAction()
                begin
                    // --- Artikel --- /
                    grecArtikel.RESET;
                    grecArtikel.SETRANGE("No.","No.");
                    REPORT.RUNMODAL(REPORT::"RW Bericht / Artikel",TRUE,FALSE,grecArtikel);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF "No." <> '' THEN
          "No.Editable" := FALSE;

        SETRANGE("No.");

        gintBildTimer := 0;
        CLEAR(grecDokument);

        ControlSHowMendatory;

        // Mulitimage Factbox
        CurrPage.MultiPicture.PAGE.SetMainPicture("Bilddokument ID");
    end;

    trigger OnInit()
    begin
        Katalogbezeichnung2Visible := TRUE;
        KatalogbezeichnungVisible := TRUE;
        Bezeichnung2Visible := TRUE;
        BezeichnungVisible := TRUE;
        "No.Editable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "No.Editable" := TRUE;
    end;

    trigger OnOpenPage()
    var
        lcoTmp: Code[30];
    begin
        // --- Init --- //
        gintBildTimer := 0;

        // --- Katalogbenutzer --- //
        grecBenEinr.RESET;

        lcoTmp := UPPERCASE(USERID);

        grecBenEinr.GET(UPPERCASE(USERID));

        // --- Katalog Einr. --- //
        grecKatEinr.GET;

        // --- Checkliste --- //
        gboChecklistennrEditable := grecBenEinr."Zertifizierung Artikel";

        // --- Bezeichnungen --- //
        IF grecKatEinr.Katalogbezeichnungen THEN BEGIN
          BezeichnungVisible := FALSE;
          Bezeichnung2Visible := FALSE;
          KatalogbezeichnungVisible := TRUE;
          Katalogbezeichnung2Visible := TRUE;
        END
        ELSE BEGIN
          KatalogbezeichnungVisible := FALSE;
          Katalogbezeichnung2Visible := FALSE;
          BezeichnungVisible := TRUE;
          Bezeichnung2Visible := TRUE;
        END;

        ControlSHowMendatory;
    end;

    var
        grecBenEinr: Record "4006555";
        grecKatEinr: Record "4006541";
        grecBeschrText: Record "4006511";
        grecBeschrTextUeber: Record "4006505";
        grecDokument: Record "4024045";
        grecZuordZeile: Record "4006572";
        grecZuordZeileRef: Record "4006572";
        grecKatMerk: Record "4006501";
        grecArtikel: Record "27";
        grecArtGrp: Record "4006519";
        grecWarGrp: Record "4006578";
        grecKatGrp: Record "4006509";
        grecTextbaustein: Record "4006514";
        grecKatDok: Record "4006515";
        grecKatUeber: Record "4006510";
        grecChecklistkopf: Record "4006523";
        grecChecklistzeileSteuerung: Record "4024061";
        gpagDokKarte: Page "4024049";
                          gpagArtikelKarte: Page "30";
                          gpagArtGrpKarte: Page "4006524";
                          gpagWarGrpKarte: Page "4006539";
                          gpagKatGrpKarte: Page "4006629";
                          gpagTextbauKarte: Page "4006518";
                          gpagProdGrp: Page "4006519";
                          gpagBeschrArtGrpUeber: Page "4006540";
                          gpagZeilenKarte: Page "4006525";
                          gpagVerwKarte: Page "4006513";
                          gpagArtikelListe: Page "4006545";
                          gpagKatalogbild: Page "4024074";
                          gpagKatalogdok: Page "4024210";
                          gpagKataloggrafik: Page "4024211";
                          gpagKatalogmerkmale: Page "4006640";
                          gpagKatalogschlagworte: Page "4043478";
                          "gpagArtikelÜber": Page "4043480";
                          gpagTextKatalog: Page "4043479";
                          gpagZuordRef: Page "4043481";
                          gpagZertProt: Page "4024208";
                          gcouSystemVerw: Codeunit "4006498";
                          AL0001: Label 'EAN Code already exists.';
        AL0002: Label 'Do you want to generate EAN Code for this item?';
        AL0003: Label 'Do you want to initialize EAN Code?';
        AL0004: Label 'No Description line present.';
        gcouKatVerw: Codeunit "4006500";
        grefRecordRefQuelle: RecordRef;
        gridRecordID: RecordID;
        gintBildTimer: Integer;
        AL0005: Label 'No Usage Line present.';
        i: Integer;
        goptQuelle: Option Artikel,Artikelgruppe,Kataloggruppe;
        AL0006: Label 'The inherited features can only be reorganized by Item Group.';
        AL0007: Label 'Do you want to reorganize features?';
        AL0008: Label 'Do you wish to reorganize the keywords?';
        AL0009: Label 'No Picture present.';
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        BezeichnungVisible: Boolean;
        [InDataSet]
        Bezeichnung2Visible: Boolean;
        [InDataSet]
        KatalogbezeichnungVisible: Boolean;
        [InDataSet]
        Katalogbezeichnung2Visible: Boolean;
        [InDataSet]
        gboChecklistennrEditable: Boolean;
        AL0011: Label 'Do you wish to confirm the Translations?';
        [InDataSet]
        gboNo: Boolean;
        [InDataSet]
        gboKatalogbezeichnung: Boolean;
        [InDataSet]
        gboDescription: Boolean;
        [InDataSet]
        "gboDescription 2": Boolean;
        [InDataSet]
        "gboKatalogbezeichnung 2": Boolean;
        [InDataSet]
        "gboSearch Description": Boolean;
        [InDataSet]
        "gboBase Unit of Measure": Boolean;
        [InDataSet]
        "gboSales Unit of Measure": Boolean;
        [InDataSet]
        gboSystemstatus: Boolean;
        [InDataSet]
        gboStandardartikelgruppe: Boolean;
        [InDataSet]
        gboPublikationsgruppe: Boolean;
        [InDataSet]
        gboVorlagencode: Boolean;
        [InDataSet]
        "gboKatalogartikelnr.": Boolean;
        [InDataSet]
        gboHauptkatalogcode: Boolean;
        [InDataSet]
        "gboUnit Price": Boolean;
        [InDataSet]
        "gboEAN Code Katalog": Boolean;
        [InDataSet]
        gboHersteller: Boolean;
        [InDataSet]
        "gboVendor Item No.": Boolean;
        [InDataSet]
        "gboVendor No.": Boolean;
        [InDataSet]
        "gboChecklistennr.": Boolean;
        [InDataSet]
        "gboBilddokument ID": Boolean;
        [InDataSet]
        gboBlocked: Boolean;
        [InDataSet]
        gboUebersetzung: Boolean;
        [InDataSet]
        gboKatalogartikel: Boolean;
        [InDataSet]
        "gboZusatzinfo 1": Boolean;
        [InDataSet]
        "gboZusatzinfo 2": Boolean;
        [InDataSet]
        "gboZusatzinfo 3": Boolean;
        [InDataSet]
        "gboZusatzinfo 4": Boolean;
        [InDataSet]
        "gboZusatzinfo 5": Boolean;
        [InDataSet]
        "gboVererbung Beschreibungen": Boolean;
        [InDataSet]
        "gboVererbung Merkmale": Boolean;
        [InDataSet]
        "gboVererbung Merkmalwerte": Boolean;
        [InDataSet]
        "gboVererbung Schlagworte": Boolean;
        [InDataSet]
        "gboVererbung Bilder": Boolean;
        [InDataSet]
        "gboVererbung Dokumente": Boolean;
        [InDataSet]
        "gboVererbung Grafik": Boolean;
        [InDataSet]
        "gboMDM Angelegt am": Boolean;
        [InDataSet]
        "gboMDM Angelegt von": Boolean;
        [InDataSet]
        "gboMDM Aktualisiert am": Boolean;
        [InDataSet]
        "gboMDM Aktualisiert vom": Boolean;
        [InDataSet]
        "gboDatanaustausch ID": Boolean;
        [InDataSet]
        "gboSprache 01": Boolean;
        [InDataSet]
        "gboSprache 02": Boolean;
        [InDataSet]
        "gboSprache 03": Boolean;
        [InDataSet]
        "gboSprache 04": Boolean;
        [InDataSet]
        "gboSprache 05": Boolean;
        [InDataSet]
        "gboML Bezeichnung 01": Boolean;
        [InDataSet]
        "gboML Bezeichnung 02": Boolean;
        [InDataSet]
        "gboML Bezeichnung 03": Boolean;
        [InDataSet]
        "gboML Bezeichnung 04": Boolean;
        [InDataSet]
        "gboML Bezeichnung 05": Boolean;
        [InDataSet]
        "gboML Beschrieb 01": Boolean;
        [InDataSet]
        "gboML Beschrieb 02": Boolean;
        [InDataSet]
        "gboML Beschrieb 03": Boolean;
        [InDataSet]
        "gboML Beschrieb 04": Boolean;
        [InDataSet]
        "gboML Beschrieb 05": Boolean;
        DotNetStr: DotNet String;
                       DotNetArrayRecord: DotNet Array;
                       DotNetArrayField: DotNet Array;
                       ArrayofDel: DotNet Array;
                       Char: Char;

    local procedure OnTimer()
    begin
        IF "Bilddokument ID" <> '' THEN BEGIN
            IF gintBildTimer < 2 THEN
                gintBildTimer := gintBildTimer + 1;

            IF gintBildTimer = 1 THEN BEGIN
                grecDokument.RESET;
                IF grecDokument.GET("Bilddokument ID") THEN BEGIN
                    grecDokument.CALCFIELDS(Bild);
                END;
            END;
        END;
    end;

    local procedure ControlSHowMendatory()
    begin
        // vaseem start 02.09.2015
        gboNo := FALSE;
        gboKatalogbezeichnung := FALSE;
        gboDescription := FALSE;
        "gboDescription 2" := FALSE;
        "gboKatalogbezeichnung 2" := FALSE;
        "gboSearch Description" := FALSE;
        "gboBase Unit of Measure" := FALSE;
        "gboSales Unit of Measure" := FALSE;
        gboSystemstatus := FALSE;
        gboStandardartikelgruppe := FALSE;
        gboPublikationsgruppe := FALSE;
        gboVorlagencode := FALSE;
        "gboKatalogartikelnr." := FALSE;
        gboHauptkatalogcode := FALSE;
        "gboUnit Price" := FALSE;
        "gboEAN Code Katalog" := FALSE;
        gboHersteller := FALSE;
        "gboVendor Item No." := FALSE;
        "gboVendor No." := FALSE;
        "gboChecklistennr." := FALSE;
        "gboBilddokument ID" := FALSE;
        gboBlocked := FALSE;
        gboUebersetzung := FALSE;
        gboKatalogartikel := FALSE;
        "gboZusatzinfo 1" := FALSE;
        "gboZusatzinfo 2" := FALSE;
        "gboZusatzinfo 3" := FALSE;
        "gboZusatzinfo 4" := FALSE;
        "gboZusatzinfo 5" := FALSE;
        "gboVererbung Beschreibungen" := FALSE;
        "gboVererbung Merkmale" := FALSE;
        "gboVererbung Merkmalwerte" := FALSE;
        "gboVererbung Schlagworte" := FALSE;
        "gboVererbung Bilder" := FALSE;
        "gboVererbung Dokumente" := FALSE;
        "gboVererbung Grafik" := FALSE;
        "gboMDM Angelegt am" := FALSE;
        "gboMDM Angelegt von" := FALSE;
        "gboMDM Aktualisiert am" := FALSE;

        "gboMDM Aktualisiert vom" := FALSE;
        "gboDatanaustausch ID" := FALSE;
        "gboSprache 01" := FALSE;
        "gboSprache 02" := FALSE;
        "gboSprache 03" := FALSE;
        "gboSprache 04" := FALSE;
        "gboSprache 05" := FALSE;
        "gboML Bezeichnung 01" := FALSE;
        "gboML Bezeichnung 02" := FALSE;
        "gboML Bezeichnung 03" := FALSE;
        "gboML Bezeichnung 04" := FALSE;
        "gboML Bezeichnung 05" := FALSE;
        "gboML Beschrieb 01" := FALSE;
        "gboML Beschrieb 02" := FALSE;
        "gboML Beschrieb 03" := FALSE;
        "gboML Beschrieb 04" := FALSE;
        "gboML Beschrieb 05" := FALSE;
        IF grecChecklistkopf.GET("Checklistennr.") THEN BEGIN
            grecChecklistzeileSteuerung.RESET;
            grecChecklistzeileSteuerung.SETRANGE(Code, grecChecklistkopf.Code);
            grecChecklistzeileSteuerung.SETRANGE("Bereich ID", '');
            IF grecChecklistzeileSteuerung.FINDSET THEN BEGIN
                ArrayofDel := ArrayofDel.CreateInstance(GETDOTNETTYPE(Char), 100);
                FOR i := 0 TO 99 DO BEGIN
                    Char := ';';
                    ArrayofDel.SetValue(Char, i);
                END;
                DotNetStr := grecChecklistzeileSteuerung."ErfArt 001";
                DotNetArrayRecord := DotNetStr.Split(ArrayofDel);
                DotNetStr := grecChecklistzeileSteuerung."Felder 001";
                DotNetArrayField := DotNetStr.Split(ArrayofDel);
                LoopForShowMedatory;
                DotNetStr := grecChecklistzeileSteuerung."ErfArt 002";
                DotNetArrayRecord := DotNetStr.Split(ArrayofDel);
                DotNetStr := grecChecklistzeileSteuerung."Felder 002";
                DotNetArrayField := DotNetStr.Split(ArrayofDel);
                LoopForShowMedatory;
                DotNetStr := grecChecklistzeileSteuerung."ErfArt 003";
                DotNetArrayRecord := DotNetStr.Split(ArrayofDel);
                DotNetStr := grecChecklistzeileSteuerung."Felder 003";
                DotNetArrayField := DotNetStr.Split(ArrayofDel);
                LoopForShowMedatory;
                DotNetStr := grecChecklistzeileSteuerung."ErfArt 004";
                DotNetArrayRecord := DotNetStr.Split(ArrayofDel);
                DotNetStr := grecChecklistzeileSteuerung."Felder 004";
                DotNetArrayField := DotNetStr.Split(ArrayofDel);
                LoopForShowMedatory;
                DotNetStr := grecChecklistzeileSteuerung."ErfArt 005";
                DotNetArrayRecord := DotNetStr.Split(ArrayofDel);
                DotNetStr := grecChecklistzeileSteuerung."Felder 005";
                DotNetArrayField := DotNetStr.Split(ArrayofDel);
                LoopForShowMedatory;
                DotNetStr := grecChecklistzeileSteuerung."ErfArt 006";
                DotNetArrayRecord := DotNetStr.Split(ArrayofDel);
                DotNetStr := grecChecklistzeileSteuerung."Felder 006";
                DotNetArrayField := DotNetStr.Split(ArrayofDel);
                LoopForShowMedatory;
                DotNetStr := grecChecklistzeileSteuerung."ErfArt 007";
                DotNetArrayRecord := DotNetStr.Split(ArrayofDel);
                DotNetStr := grecChecklistzeileSteuerung."Felder 007";
                DotNetArrayField := DotNetStr.Split(ArrayofDel);
                LoopForShowMedatory;

            END;
        END;
        //vaseem end 02.09.2015
    end;

    local procedure LoopForShowMedatory()
    begin
        FOR i := 0 TO DotNetArrayRecord.Length - 1 DO BEGIN

            IF FORMAT(DotNetArrayRecord.GetValue(i)) = '0' THEN BEGIN
                CASE FORMAT(DotNetArrayField.GetValue(i)) OF
                    '1':
                        gboNo := TRUE;
                    '4006498':
                        gboKatalogbezeichnung := TRUE;
                    '3':
                        gboDescription := TRUE;
                    '5':
                        "gboDescription 2" := TRUE;
                    '4006499':
                        "gboKatalogbezeichnung 2" := TRUE;
                    '4':
                        "gboSearch Description" := TRUE;
                    '8':
                        "gboBase Unit of Measure" := TRUE;
                    '5425':
                        "gboSales Unit of Measure" := TRUE;
                    '4006521':
                        gboSystemstatus := TRUE;
                    '4006503':
                        gboStandardartikelgruppe := TRUE;
                    '4006512':
                        gboPublikationsgruppe := TRUE;
                    '4006502':
                        gboVorlagencode := TRUE;
                    '4006505':
                        "gboKatalogartikelnr." := TRUE;
                    '4006524':
                        gboHauptkatalogcode := TRUE;
                    '18':
                        "gboUnit Price" := TRUE;
                    '4006496':
                        "gboEAN Code Katalog" := TRUE;
                    '4006500':
                        gboHersteller := TRUE;
                    '32':
                        "gboVendor Item No." := TRUE;
                    '31':
                        "gboVendor No." := TRUE;
                    '4006520':
                        "gboChecklistennr." := TRUE;
                    '4006510':
                        "gboBilddokument ID" := TRUE;
                    '54':
                        gboBlocked := TRUE;
                    '4006583':
                        gboUebersetzung := TRUE;
                    '4006517':
                        gboKatalogartikel := TRUE;
                    '4006528':
                        "gboZusatzinfo 1" := TRUE;
                    '4006529':
                        "gboZusatzinfo 2" := TRUE;
                    '4006530':
                        "gboZusatzinfo 3" := TRUE;
                    '4006531':
                        "gboZusatzinfo 4" := TRUE;
                    '4006532':
                        "gboZusatzinfo 5" := TRUE;
                    '4006576':
                        "gboVererbung Beschreibungen" := TRUE;
                    '4006577':
                        "gboVererbung Merkmale" := TRUE;
                    '4006587':
                        "gboVererbung Merkmalwerte" := TRUE;
                    '4006578':
                        "gboVererbung Schlagworte" := TRUE;
                    '4006579':
                        "gboVererbung Bilder" := TRUE;
                    '4006580':
                        "gboVererbung Dokumente" := TRUE;
                    '4006581':
                        "gboVererbung Grafik" := TRUE;
                    '4006506':
                        "gboMDM Angelegt am" := TRUE;
                    '4006507':
                        "gboMDM Angelegt von" := TRUE;
                    '4006508':
                        "gboMDM Aktualisiert am" := TRUE;
                    '4006509':
                        "gboMDM Aktualisiert vom" := TRUE;
                    '4006565':
                        "gboDatanaustausch ID" := TRUE;
                    '4006534':
                        "gboSprache 01" := TRUE;
                    '4006535':
                        "gboSprache 02" := TRUE;
                    '4006536':
                        "gboSprache 03" := TRUE;
                    '4006537':
                        "gboSprache 04" := TRUE;
                    '4006538':
                        "gboSprache 05" := TRUE;
                    '4006544':
                        "gboML Bezeichnung 01" := TRUE;
                    '4006545':
                        "gboML Bezeichnung 02" := TRUE;
                    '4006546':
                        "gboML Bezeichnung 03" := TRUE;
                    '4006547':
                        "gboML Bezeichnung 04" := TRUE;
                    '4006548':
                        "gboML Bezeichnung 05" := TRUE;
                    '4006554':
                        "gboML Beschrieb 01" := TRUE;
                    '4006555':
                        "gboML Beschrieb 02" := TRUE;
                    '4006556':
                        "gboML Beschrieb 03" := TRUE;
                    '4006557':
                        "gboML Beschrieb 04" := TRUE;
                    '4006558':
                        "gboML Beschrieb 05" := TRUE;
                END;
            END;
        END;
    end;
}

