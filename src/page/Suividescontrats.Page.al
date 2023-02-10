page 50073 "DEL Suivi des contrats"
{
    Caption = 'Follow contracts';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Customer;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Caption = 'Address';
                    Enabled = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Post Code';
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Caption = 'City';
                    Editable = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country/Region Code';
                    Editable = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    Caption = 'Salesperson Code';
                    Editable = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'Gen. Bus. Posting Group';
                    Editable = false;
                }
                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Contact No.';
                    Editable = false;
                }
                //TODO: is already defined field(Contact; Contact)
                // {
                //     Editable = false;
                // }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Phone No.';
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'Email';
                    Editable = false;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                    Caption = 'Language Code';
                    Editable = false;
                }
                field("Parent Company"; Rec."DEL Parent Company")
                {
                    ApplicationArea = All;
                    Caption = 'DEL Parent Company';
                }
            }
            group("Suivi partnership agreement")
            {
                Caption = 'Partnership agreement follow up';
                field("Partnership agreement"; Rec."DEL Partnership agreement")
                {
                    ApplicationArea = All;
                    Caption = 'DEL Partnership agreement';
                }
                field("Libellé PA"; Rec."DEL Libellé PA")
                {
                    ApplicationArea = All;
                    Caption = 'Partnership agreement description';
                }
                field("Statut PA"; Rec."DEL Statut PA")
                {
                    ApplicationArea = All;
                    Caption = 'Partnership agreement status';
                }
                group(Annexes)
                {
                    Caption = 'Annexes:';
                    field("Annexe A PA"; Rec."DEL Annexe A PA")
                    {
                        ApplicationArea = All;
                        Caption = 'A';
                    }
                    field("Annexe B PA"; Rec."DEL Annexe B PA")
                    {
                        ApplicationArea = All;
                        Caption = 'B';
                    }
                    field("Annexe C PA"; Rec."DEL Annexe C PA")
                    {
                        ApplicationArea = All;
                        Caption = 'C';
                    }
                    field("Annexe D PA"; Rec."DEL Annexe D PA")
                    {
                        ApplicationArea = All;
                        Caption = 'D';
                    }
                }
                field("Date de début PA"; Rec."DEL Date de début PA")
                {
                    ApplicationArea = All;
                    Caption = 'Starting date PA';
                }
                field("Date de fin PA"; Rec."DEL Date de fin PA")
                {
                    ApplicationArea = All;
                    Caption = 'End date PA';
                }
                field("URL document PA"; Rec."DEL URL document PA")
                {
                    ApplicationArea = All;
                    Caption = 'URL document PA';

                    trigger OnLookup(var Text: Text): Boolean

                    begin

                        CLEAR(DocumentLine);
                        DocumentLine.RESET();
                        DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Customer);
                        DocumentLine.SETRANGE(DocumentLine."No.", Rec."No.");
                        DocumentLine.SETRANGE(DocumentLine."Type contrat", DocumentLine."Type contrat"::Partnership);
                        DocumentContrat.SETTABLEVIEW(DocumentLine);
                        DocumentContrat.RUN();
                    end;
                }
                field("Comment PA"; Rec."DEL Comment PA")
                {
                    ApplicationArea = All;
                    Caption = 'Comment PA';
                }
            }
            group("Suivi service agreement")
            {
                Caption = 'Service agreement follow up';
                group("Perimeter of the contract")
                {
                    Caption = 'Perimeter of the contract';
                    field("Service agreement"; Rec."DEL Service agreement")
                    {
                        ApplicationArea = All;
                        Caption = 'Service agreement';
                    }
                    field("Libellé SSA"; Rec."DEL Libellé SSA")
                    {
                        ApplicationArea = All;
                        Caption = 'Service agreement description';
                    }
                    field("Statut SSA"; Rec."DEL Statut SSA")
                    {
                        ApplicationArea = All;
                        Caption = 'Status SSA';
                    }
                    field("Date de début SSA"; Rec."DEL Date de début SSA")
                    {
                        ApplicationArea = All;
                        Caption = 'Starting date SSA';
                    }
                    field("Date de fin SSA"; Rec."DEL Date de fin SSA")
                    {
                        ApplicationArea = All;
                        Caption = 'End date SSA';
                    }
                    field("Comment SSA"; Rec."DEL Comment SSA")
                    {
                        ApplicationArea = All;
                        Caption = 'Comment SSA';
                    }
                    field("URL document SSA"; Rec."DEL URL document SSA")
                    {
                        ApplicationArea = All;
                        Caption = 'URL document SSA';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            CLEAR(DocumentLine);
                            DocumentLine.RESET();
                            DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Customer);
                            DocumentLine.SETRANGE(DocumentLine."No.", Rec."No.");
                            DocumentLine.SETRANGE(DocumentLine."Type contrat", DocumentLine."Type contrat"::Service);
                            DocumentContrat.SETTABLEVIEW(DocumentLine);
                            DocumentContrat.RUN();
                        end;
                    }
                    field(Level; Rec."DEL Level")
                    {
                        ApplicationArea = All;
                        Caption = 'Level';
                    }
                    label(AnnexesSSA)
                    {
                        ApplicationArea = All;
                        Caption = 'Annexes:';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("Annexe A SSA"; Rec."DEL Annexe A SSA")
                    {
                        ApplicationArea = All;
                        Caption = 'A';
                    }
                    field("Renouvellement tacite"; Rec."DEL Renouvellement tacite")
                    {
                        ApplicationArea = All;
                        Caption = 'Tacit renewal';
                    }
                    field("Renewal by mail"; Rec."DEL Renewal by mail")
                    {
                        ApplicationArea = All;
                        Caption = 'Renewal by mail';
                    }
                    field("Renewal by endorsement"; Rec."DEL Renewal by endorsement")
                    {
                        ApplicationArea = All;
                        Caption = 'Renewal by endorsement';
                    }
                    field("Reporting vente"; Rec."DEL Reporting vente")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales reports';
                    }
                    field("Segmentation Prod Niveau"; Rec."DEL Segmentation Prod Niveau")
                    {
                        ApplicationArea = All;
                        Caption = 'Segmentation Produit Niveau';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            DimensionValue_Rec.RESET();
                            DimensionValue_Rec.FILTERGROUP(2);
                            DimensionValue_Rec.SETRANGE(DimensionValue_Rec."Dimension Code", 'SEGMENT');

                            CLEAR(PDimensionValue);
                            PDimensionValue.SETTABLEVIEW(DimensionValue_Rec);
                            PDimensionValue.LOOKUPMODE(TRUE);
                            IF PDimensionValue.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                                PDimensionValue.GETRECORD(DimensionValue_Rec);
                                DimensionValue_Rec.TESTFIELD(DimensionValue_Rec."Dimension Value Type", DimensionValue_Rec."Dimension Value Type"::Standard);
                                IF Rec."DEL Segmentation Prod Niveau" = '' THEN BEGIN
                                    Rec."DEL Segmentation Prod Niveau" := DimensionValue_Rec.Code;
                                    Rec."DEL Segmentation Description" := DimensionValue_Rec.Name;
                                END
                                ELSE BEGIN
                                    Rec."DEL Segmentation Prod Niveau" := Rec."DEL Segmentation Prod Niveau" + ',' + DimensionValue_Rec.Code;
                                    Rec."DEL Segmentation Description" += ',' + DimensionValue_Rec.Name;
                                END;
                            END;
                        end;

                        trigger OnValidate()
                        begin
                            IF Rec."DEL Segmentation Prod Niveau" = '' THEN
                                Rec."DEL Segmentation Description" := '';
                        end;
                    }
                    field("Segmentation Description"; Rec."DEL Segmentation Description")
                    {
                        ApplicationArea = All;
                        Caption = 'Segmentation Description';
                        Editable = false;
                    }
                    label(Mark)
                    {
                        ApplicationArea = All;
                        Caption = 'Mark';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("National Mark"; Rec."DEL National Mark")
                    {
                        ApplicationArea = All;
                        Caption = 'National Mark';
                    }
                    field(MDD; Rec."DEL MDD")
                    {
                        ApplicationArea = All;
                        Caption = 'DEL MDD';
                    }
                    label(Signboard)
                    {
                        ApplicationArea = All;
                        Caption = 'Signboard';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field(NORAUTO; Rec."DEL NORAUTO")
                    {
                        ApplicationArea = All;
                        Caption = 'DEL NORAUTO';
                    }
                    field(MIDAS; Rec."DEL MIDAS")
                    {
                        ApplicationArea = All;
                        Caption = 'DEL MIDAS';
                    }
                    field(ATU; Rec."DEL ATU")
                    {
                        ApplicationArea = All;
                        Caption = 'DEL ATU';
                    }
                    field(ATYSE; Rec."DEL ATYSE")
                    {
                        ApplicationArea = All;
                        Caption = 'DEL ATYSE';
                    }
                    field("CARTER CASH"; Rec."DEL CARTER CASH")
                    {
                        ApplicationArea = All;
                        Caption = 'DEL CARTER CASH';
                    }
                    field(SYNCHRO; Rec."DEL SYNCHRO")
                    {
                        ApplicationArea = All;
                        Caption = 'DEL SYNCHRO';
                    }
                    field(Shruvat; Rec."DEL Shruvat")
                    {
                        ApplicationArea = All;
                        Caption = 'DEL Shruvat';
                    }
                    field(Bythjul; Rec."DEL Bythjul")
                    {
                        ApplicationArea = All;
                        Caption = 'DEL Bythjul';
                    }
                }
                group("Monitoring the denunciation")
                {
                    Caption = 'Monitoring the denunciation';
                    field("Starting date of Relationship"; Rec."DEL Start date of Relationship")
                    {
                        ApplicationArea = All;
                        Caption = 'Starting date of Relationship';
                    }
                    group("Quote Part")
                    {
                        Caption = 'Quote part';
                        grid(General)
                        {
                            GridLayout = Rows;
                            group("Quote part 1")
                            {
                                Caption = 'Quote part 1';
                                field("Quote part 1 Mobivia/CA %"; Rec."DEL Quote part 1 Mobivia/CA %")
                                {
                                    ApplicationArea = All;
                                    Caption = 'Quote part Mobivia/CA %';
                                }
                                field("Quote part 1 Mobivia/CA Year"; Rec."DEL Qte part 1 Mobivia/CA Year")
                                {
                                    ApplicationArea = All;
                                    Caption = 'Year';
                                }
                            }
                            group("Quote part 2")
                            {
                                Caption = 'Quote part 2';
                                field("Quote part 2 Mobivia/CA %"; Rec."DEL Quote part 2 Mobivia/CA %")
                                {
                                    ApplicationArea = All;
                                    Caption = 'Quote part 2 Mobivia/CA %';
                                    ShowCaption = false;
                                }
                                field("Quote part 2 Mobivia/CA Year"; Rec."DEL Qte part 2 Mobivia/CA Year")
                                {
                                    ApplicationArea = All;
                                    Caption = 'Quote part 2 Mobivia/CA Year';
                                    ShowCaption = false;
                                }
                            }
                        }
                    }
                    field("Period of denunciation"; Rec."DEL Period of denunciation")
                    {
                        ApplicationArea = All;
                        Caption = 'Period of denunciation';
                        Editable = Editablefield;
                    }
                    field("Denunciation to analyze"; Rec."DEL Denunciation to analyze")
                    {
                        ApplicationArea = All;
                        Caption = 'Denunciation to analyze';
                        Editable = false;
                    }
                    field("Denunciation Replanned"; Rec."DEL Denunciation Replanned")
                    {
                        ApplicationArea = All;
                        Caption = 'Denunciation Replanned';

                        trigger OnValidate()
                        begin
                            Editablefield := FALSE;
                            IF Rec."DEL Denunciation Replanned" THEN
                                Editablefield := TRUE;
                        end;
                    }
                    field("Denunciation realised"; Rec."DEL Denunciation realised")
                    {
                        ApplicationArea = All;
                        Caption = 'Denunciation realised';
                    }
                    field("Denunciation date"; Rec."DEL Denunciation date")
                    {
                        ApplicationArea = All;
                        Caption = 'Denunciation Date';
                    }
                    field("Not denunciation"; Rec."DEL Not denunciation")
                    {
                        ApplicationArea = All;
                        Caption = 'Pas de dénonciation';
                    }
                    field("Comment denunciation"; Rec."DEL Comment denunciation")
                    {
                        ApplicationArea = All;
                        Caption = 'Comment denunciation';
                    }
                }
                group("Invoice tracking")
                {
                    Caption = 'Invoice tracking';
                    field("En facturation"; Rec."DEL En facturation")
                    {
                        ApplicationArea = All;
                        Caption = 'Invoicing';
                    }
                    field("Fréquence de facturation"; Rec."DEL Fréquence de facturation")
                    {
                        ApplicationArea = All;
                        Caption = 'Frequency of invoicing';

                        trigger OnValidate()
                        begin
                            CurrPage.UPDATE();
                        end;
                    }
                    field("Date de prochaine facturation"; Rec."DEL Date de proch. fact.")
                    {
                        ApplicationArea = All;
                        Caption = 'Next invoice date';
                        Editable = false;
                    }
                    field("Nbre jour avant proch. fact."; Rec."DEL Nbr jr avant proch. fact.")
                    {
                        ApplicationArea = All;
                        Caption = 'Nb of days before invoicing';
                        Editable = false;
                    }
                    field("Last Accounting Date"; Rec."DEL Last Accounting Date")
                    {
                        ApplicationArea = All;
                        Caption = 'Last accounting date';
                        Editable = false;
                    }
                    field(Facture; Rec."DEL Facture")
                    {
                        ApplicationArea = All;
                        Caption = 'Invoce No.';
                        Editable = false;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            IF Rec."DEL Facture" <> '' THEN BEGIN
                                SalesInvoiceHeader.RESET();
                                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", Rec."DEL Facture");
                                PAGE.RUN(Page::"Posted Sales Invoice", SalesInvoiceHeader);
                            END;
                        end;
                    }
                    field(Montant; Rec."DEL Montant")
                    {
                        ApplicationArea = All;
                        Caption = 'Amount';
                        Editable = false;
                    }
                    field("Montant ouvert"; Rec."DEL Montant ouvert")
                    {
                        ApplicationArea = All;
                        Caption = 'Pending amount';
                        Editable = false;
                    }
                    field("Amount YTD"; Rec."DEL Amount YTD")
                    {
                        ApplicationArea = All;
                        Caption = 'Amount YTD';
                        CaptionClass = '3,' + CustDateFilter[1];

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            CustLedgerEntry2.RESET();
                            CustLedgerEntry2.FILTERGROUP(2);
                            CustLedgerEntry2.SETRANGE(CustLedgerEntry2."Customer No.", Rec."No.");
                            CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Sales (LCY)", '<>0');
                            CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Posting Date", DateFilter1);

                            PAGE.RUN(Page::"Customer Ledger Entries", CustLedgerEntry2);
                        end;
                    }
                    field("Amount YTD-1"; Rec."DEL Amount YTD-1")
                    {
                        ApplicationArea = All;
                        Caption = 'Amount YTD-1';
                        CaptionClass = '3,' + CustDateFilter[2];

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            CustLedgerEntry2.RESET();
                            CustLedgerEntry2.FILTERGROUP(2);
                            CustLedgerEntry2.SETRANGE(CustLedgerEntry2."Customer No.", Rec."No.");
                            CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Sales (LCY)", '<>0');
                            CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Posting Date", DateFilter2);
                            PAGE.RUN(Page::"Customer Ledger Entries", CustLedgerEntry2);
                        end;
                    }
                    field("Amount YTD-2"; Rec."DEL Amount YTD-2")
                    {
                        ApplicationArea = All;
                        Caption = 'Amount YTD-2';
                        CaptionClass = '3,' + CustDateFilter[3];

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            CustLedgerEntry2.RESET();
                            CustLedgerEntry2.FILTERGROUP(2);
                            CustLedgerEntry2.SETRANGE(CustLedgerEntry2."Customer No.", Rec."No.");
                            CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Sales (LCY)", '<>0');
                            CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Posting Date", DateFilter3);
                            PAGE.RUN(Page::"Customer Ledger Entries", CustLedgerEntry2);
                        end;
                    }
                }
            }
            group("Services List")
            {
                Caption = 'Services List';
                field("Central trading"; Rec."DEL Central trading")
                {
                    ApplicationArea = All;
                    Caption = 'Central trading';
                    Style = Strong;
                    StyleExpr = True;
                }
                field("Frequency of delivery 1"; Rec."DEL Frequency of delivery 1")
                {
                    ApplicationArea = All;
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 1"; Rec."DEL Invoicing Frequency 1")
                {
                    ApplicationArea = All;
                    Caption = 'Invoicing Frequency';
                }
                field("Sales data report"; Rec."DEL Sales data report")
                {
                    ApplicationArea = All;
                    Caption = 'Sales data report';
                }
                field("Frequency of delivery 2"; Rec."DEL Frequency of delivery 2")
                {
                    ApplicationArea = All;
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 2"; Rec."DEL Invoicing Frequency 2")
                {
                    ApplicationArea = All;
                    Caption = 'Invoicing Frequency';
                }
                field("Assist in relat. with the BU"; Rec."DEL Ass. in relat. with the BU")
                {
                    ApplicationArea = All;
                    Caption = 'Assist in relations with the BU (Blue Helmets)';
                }
                field("Frequency of delivery 3"; Rec."DEL Frequency of delivery 3")
                {
                    ApplicationArea = All;
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 3"; Rec."DEL Invoicing Frequency 3")
                {
                    ApplicationArea = All;
                    Caption = 'Invoicing Frequency';
                }
                field("Organization of visits"; Rec."DEL Organization of visits")
                {
                    ApplicationArea = All;
                    Caption = 'Organization of visits';
                }
                field("Frequency of delivery 4"; Rec."DEL Frequency of delivery 4")
                {
                    ApplicationArea = All;
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 4"; Rec."DEL Invoicing Frequency 4")
                {
                    ApplicationArea = All;
                    Caption = 'Invoicing Frequency';
                }
                field("Vision and Market Analysis"; Rec."DEL Vision and Market Analysis")
                {
                    ApplicationArea = All;
                    Caption = 'Vision and Market Analysis';
                }
                field("Frequency of delivery 5"; Rec."DEL Frequency of delivery 5")
                {
                    ApplicationArea = All;
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 5"; Rec."DEL Invoicing Frequency 5")
                {
                    ApplicationArea = All;
                    Caption = 'Invoicing Frequency';
                }
                field("Presentation provider strategy"; Rec."DEL Pres. provider strategy")
                {
                    ApplicationArea = All;
                    Caption = 'Presentation provider strategy';
                }
                field("Frequency of delivery 6"; Rec."DEL Frequency of delivery 6")
                {
                    ApplicationArea = All;
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 6"; Rec."DEL Invoicing Frequency 6")
                {
                    ApplicationArea = All;
                    Caption = 'Invoicing Frequency';
                }
                field("Presentation MOBIVIA strategy"; Rec."DEL Pres. MOBIVIA strategy")
                {
                    ApplicationArea = All;
                    Caption = 'Presentation MOBIVIA strategy';
                }
                field("Frequency of delivery 7"; Rec."DEL Frequency of delivery 7")
                {
                    ApplicationArea = All;
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 7"; Rec."DEL Invoicing Frequency 7")
                {
                    ApplicationArea = All;
                    Caption = 'Invoicing Frequency';
                }

                field("Adv on the adapt. of the offer"; Rec."DEL AdvOntheAdapt.OfTheOffer")
                {
                    ApplicationArea = All;
                    Caption = 'Advising on the adaptation of the offer';
                }
                field("Frequency of delivery 8"; Rec."DEL Frequency of delivery 8")
                {
                    ApplicationArea = All;
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 8"; Rec."DEL Invoicing Frequency 8")
                {
                    ApplicationArea = All;
                    Caption = 'Invoicing Frequency';
                }
                field("Favorite referencing by BU"; Rec."DEL Favorite referencing by BU")
                {
                    ApplicationArea = All;
                    Caption = 'Favorite referencing by BU';
                }
                field("Frequency of delivery 9"; Rec."DEL Frequency of delivery 9")
                {
                    ApplicationArea = All;
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 9"; Rec."DEL Invoicing Frequency 9")
                {
                    ApplicationArea = All;
                    Caption = 'Invoicing Frequency';
                }
                field(Forecast; Rec."DEL Forecast")
                {
                    ApplicationArea = All;
                    Caption = 'Forecast';
                }
                field("Frequency of delivery 10"; Rec."DEL Frequency of delivery 10")
                {
                    ApplicationArea = All;
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 10"; Rec."DEL Invoicing Frequency 10")
                {
                    ApplicationArea = All;
                    Caption = 'Invoicing Frequency';
                }
            }
            group("Charte ethique")
            {
                Caption = 'Ethical charter';
                field("Statut CE"; Rec."DEL Statut CE")
                {
                    ApplicationArea = All;
                    Caption = 'Ethical Charter status';
                }
                field("Date Signature CE"; Rec."DEL Date Signature CE")
                {
                    ApplicationArea = All;
                    Caption = 'Date of signature EC';
                }
                field("URL document CE"; Rec."DEL URL document CE")
                {
                    ApplicationArea = All;
                    Caption = 'URL document CE';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(DocumentLine);
                        DocumentLine.RESET();
                        DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Customer);
                        DocumentLine.SETRANGE(DocumentLine."No.", Rec."No.");
                        DocumentLine.SETRANGE(DocumentLine."Type contrat",
                         DocumentLine."Type contrat"::"Charte ethique");
                        DocumentContrat.SETTABLEVIEW(DocumentLine);
                        DocumentContrat.RUN();
                    end;
                }
            }
            group(Quality)
            {
                Caption = 'Quality';
                group("Audit Quality")
                {
                    Caption = 'Audit Quality';
                    field("Note Quality"; Rec."DEL Note Quality")
                    {
                        ApplicationArea = All;
                        Caption = 'Quality rating';
                    }
                    field("Realisation Date Quality"; Rec."DEL Realisation Date Quality")
                    {
                        ApplicationArea = All;
                        Caption = 'Creation date QA';
                    }
                }
                group("Social Audit")
                {
                    Caption = 'Social Audit';
                    field("Note Soc"; Rec."DEL Note Soc")
                    {
                        ApplicationArea = All;
                        Caption = 'Social rating';
                    }
                    field("Realisation Date Soc"; Rec."DEL Realisation Date Soc")
                    {
                        ApplicationArea = All;
                        Caption = 'Creation date';
                    }
                }
                group("Environmental Audit")
                {
                    Caption = 'Environmental Audit';
                    field("Note Env"; Rec."DEL Note Env")
                    {
                        ApplicationArea = All;
                        Caption = 'Environmental rating';
                    }
                    field("Realisation Date Env"; Rec."DEL Realisation Date Env")
                    {
                        ApplicationArea = All;
                        Caption = 'Creation date';
                    }
                }
            }
            part("Contact Contrat"; "DEL Contact Contrat")
            {
                ApplicationArea = All;
                Caption = 'Contact';
                Editable = false;
                SubPageLink = "DEL Customer No." = FIELD("No.");
                SubPageView = SORTING("No.")
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ven&dor")
            {
                Caption = 'Ven&dor';
                Image = Vendor;
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("<Page Document Sheet>")
                {
                    ApplicationArea = All;
                    Caption = 'Doc&uments';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Document Sheet Contrats";
                    RunPageLink = "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Comment Entry No.", "Line No.")
                                  WHERE("Table Name" = CONST(Customer),
                                        "Notation Type" = FILTER(' '),
                                        "Type liasse" = FILTER(' '));
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Comment Sheet Contrats";
                    RunPageLink = "Table Name" = CONST(Customer),
                                  "No." = FIELD("No.");
                }
                action(Contact)
                {
                    ApplicationArea = All;
                    Image = AddContacts;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Contact Contrat";
                    RunPageLink = "DEL Customer No." = FIELD("No.");
                }
                action(Print)
                {
                    ApplicationArea = All;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Customer.RESET();
                        Customer.SETRANGE("No.", Rec."No.");
                        REPORT.RUN(Report::"DEL Enregistrement contrat", TRUE, TRUE, Customer);
                    end;
                }
                action("Contract Comments")
                {
                    ApplicationArea = All;
                    Caption = 'Contract Comments';
                    Image = TaskList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "DEL Contract comment";
                    RunPageLink = "No." = FIELD("No.");
                    RunPageView = SORTING("No.", "Line No.");
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Customer.RESET();
        Customer.SETRANGE(Customer."No.", Rec."No.");
        IF Customer.FINDFIRST() THEN BEGIN
            CustLedgerEntry.RESET();
            CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", Customer."No.");
            CustLedgerEntry.SETRANGE(CustLedgerEntry."Document Type", CustLedgerEntry."Document Type"::Invoice);

            IF CustLedgerEntry.FINDLAST() THEN BEGIN
                CustLedgerEntry.CALCFIELDS(CustLedgerEntry.Amount, CustLedgerEntry."Remaining Amount");
                Customer."DEL Last Accounting Date" := CustLedgerEntry."Posting Date";
                Customer."DEL Facture" := CustLedgerEntry."Document No.";
                Customer."DEL Montant" := CustLedgerEntry.Amount;
                Customer."DEL Montant ouvert" := CustLedgerEntry."Remaining Amount";

                IF Customer."DEL Fréquence de facturation" = Customer."DEL Fréquence de facturation"::"12 mois" THEN
                    Customer."DEL Date de proch. fact." := CALCDATE('<+12M>', CustLedgerEntry."Posting Date");
                IF Customer."DEL Fréquence de facturation" = Customer."DEL Fréquence de facturation"::"6 mois" THEN
                    Customer."DEL Date de proch. fact." := CALCDATE('<+6M>', CustLedgerEntry."Posting Date");
                IF Customer."DEL Fréquence de facturation" = Customer."DEL Fréquence de facturation"::"4 mois" THEN
                    Customer."DEL Date de proch. fact." := CALCDATE('<+4M>', CustLedgerEntry."Posting Date");
                IF Customer."DEL Fréquence de facturation" = Customer."DEL Fréquence de facturation"::"3 mois" THEN
                    Customer."DEL Date de proch. fact." := CALCDATE('<+3M>', CustLedgerEntry."Posting Date");
                IF Customer."DEL Fréquence de facturation" = Customer."DEL Fréquence de facturation"::" " THEN
                    Customer."DEL Date de proch. fact." := CALCDATE('<+0M>', CustLedgerEntry."Posting Date");

                Customer."DEL Nbr jr avant proch. fact." := Customer."DEL Date de proch. fact." - TODAY;
            END;
            IF Customer."DEL Date de fin PA" < TODAY THEN
                Customer."DEL Statut PA" := Customer."DEL Statut PA"::Échu;
            IF Customer."DEL Date de fin SSA" < TODAY THEN
                Customer."DEL Statut SSA" := Customer."DEL Statut SSA"::Échu;

            IF Customer."DEL Period of denunciation" < TODAY THEN
                Customer."DEL Denunciation to analyze" := TRUE
            ELSE
                Customer."DEL Denunciation to analyze" := FALSE;

            Editablefield := FALSE;
            IF Rec."DEL Denunciation Replanned" THEN
                Editablefield := TRUE;

            Customer.MODIFY();
        END;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        IF Rec."DEL Denunciation Replanned" THEN
            Rec.TESTFIELD("DEL Period of denunciation");

        IF Rec."DEL Denunciation realised" THEN
            Rec.TESTFIELD("DEL Denunciation date");

        IF (Rec."DEL Denunciation Replanned") AND (Rec."DEL Period of denunciation" <> 0D) THEN BEGIN
            Rec."DEL Denunciation Replanned" := FALSE;
            Rec.MODIFY();
        END;
    end;

    var

        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        Customer: Record Customer;
        DocumentLine: Record "DEL Document Line";
        DimensionValue_Rec: Record "Dimension Value";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        DocumentContrat: Page "DEL Document Sheet Contrats";
        PDimensionValue: Page "Dimension Value List";
        Editablefield: Boolean;

        DateFilter1: Text;
        DateFilter2: Text;
        DateFilter3: Text;
        CustDateFilter: array[4] of Text[30];
}
