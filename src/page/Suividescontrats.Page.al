
page 50073 "DEL Suivi des contrats"
{

    Caption = 'Follow contracts';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Caption = 'No.';
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    Caption = 'Name';
                }
                field(Address; Rec.Address)
                {
                    Enabled = false;
                    Caption = 'Address';
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                    Caption = 'Post Code';
                }
                field(City; Rec.City)
                {
                    Editable = false;
                    Caption = 'City';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Editable = false;
                    Caption = 'Country/Region Code';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Editable = false;
                    Caption = 'Salesperson Code';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Editable = false;
                    Caption = 'Gen. Bus. Posting Group';
                }
                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    Editable = false;
                    Caption = 'Primary Contact No.';
                }
                //TODO: is already defined field(Contact; Contact)
                // {
                //     Editable = false;
                // }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = false;
                    Caption = 'Phone No.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Editable = false;
                    Caption = 'Email';
                }
                field("Language Code"; Rec."Language Code")
                {
                    Editable = false;
                    Caption = 'Language Code';
                }
                field("Parent Company"; Rec."DEL Parent Company")
                {
                    Caption = 'DEL Parent Company';
                }
            }
            group("Suivi partnership agreement")
            {
                Caption = 'Partnership agreement follow up';
                field("Partnership agreement"; Rec."DEL Partnership agreement")
                {
                    Caption = 'DEL Partnership agreement';
                }
                field("Libellé PA"; Rec."DEL Libellé PA")
                {
                    Caption = 'Partnership agreement description';
                }
                field("Statut PA"; Rec."DEL Statut PA")
                {
                    Caption = 'Partnership agreement status';
                }
                group(Annexes)
                {
                    Caption = 'Annexes:';
                    field("Annexe A PA"; Rec."DEL Annexe A PA")
                    {
                        Caption = 'A';
                    }
                    field("Annexe B PA"; Rec."DEL Annexe B PA")
                    {
                        Caption = 'B';
                    }
                    field("Annexe C PA"; Rec."DEL Annexe C PA")
                    {
                        Caption = 'C';
                    }
                    field("Annexe D PA"; Rec."DEL Annexe D PA")
                    {
                        Caption = 'D';
                    }
                }
                field("Date de début PA"; Rec."DEL Date de début PA")
                {
                    Caption = 'Starting date PA';
                }
                field("Date de fin PA"; Rec."DEL Date de fin PA")
                {
                    Caption = 'End date PA';
                }
                field("URL document PA"; Rec."DEL URL document PA")
                {
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
                        Caption = 'Service agreement';
                    }
                    field("Libellé SSA"; Rec."DEL Libellé SSA")
                    {
                        Caption = 'Service agreement description';
                    }
                    field("Statut SSA"; Rec."DEL Statut SSA")
                    {
                        Caption = 'Status SSA';
                    }
                    field("Date de début SSA"; Rec."DEL Date de début SSA")
                    {
                        Caption = 'Starting date SSA';
                    }
                    field("Date de fin SSA"; Rec."DEL Date de fin SSA")
                    {
                        Caption = 'End date SSA';
                    }
                    field("Comment SSA"; Rec."DEL Comment SSA")
                    {
                        Caption = 'Comment SSA';
                    }
                    field("URL document SSA"; Rec."DEL URL document SSA")
                    {
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
                        Caption = 'Level';
                    }
                    label(AnnexesSSA)
                    {
                        Caption = 'Annexes:';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("Annexe A SSA"; Rec."DEL Annexe A SSA")
                    {
                        Caption = 'A';
                    }
                    field("Renouvellement tacite"; Rec."DEL Renouvellement tacite")
                    {
                        Caption = 'Tacit renewal';
                    }
                    field("Renewal by mail"; Rec."DEL Renewal by mail")
                    {
                        Caption = 'Renewal by mail';
                    }
                    field("Renewal by endorsement"; Rec."DEL Renewal by endorsement")
                    {
                        Caption = 'Renewal by endorsement';
                    }
                    field("Reporting vente"; Rec."DEL Reporting vente")
                    {
                        Caption = 'Sales reports';
                    }
                    field("Segmentation Prod Niveau"; Rec."DEL Segmentation Prod Niveau")
                    {
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
                        Editable = false;
                        Caption = 'Segmentation Description';
                    }
                    label(Mark)
                    {
                        Caption = 'Mark';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("National Mark"; Rec."DEL National Mark")
                    {
                        Caption = 'National Mark';
                    }
                    field(MDD; Rec."DEL MDD")
                    {
                        Caption = 'DEL MDD';
                    }
                    label(Signboard)
                    {
                        Caption = 'Signboard';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field(NORAUTO; Rec."DEL NORAUTO")
                    {
                        Caption = 'DEL NORAUTO';
                    }
                    field(MIDAS; Rec."DEL MIDAS")
                    {
                        Caption = 'DEL MIDAS';
                    }
                    field(ATU; Rec."DEL ATU")
                    {
                        Caption = 'DEL ATU';
                    }
                    field(ATYSE; Rec."DEL ATYSE")
                    {
                        Caption = 'DEL ATYSE';
                    }
                    field("CARTER CASH"; Rec."DEL CARTER CASH")
                    {
                        Caption = 'DEL CARTER CASH';
                    }
                    field(SYNCHRO; Rec."DEL SYNCHRO")
                    {
                        Caption = 'DEL SYNCHRO';
                    }
                    field(Shruvat; Rec."DEL Shruvat")
                    {
                        Caption = 'DEL Shruvat';
                    }
                    field(Bythjul; Rec."DEL Bythjul")
                    {
                        Caption = 'DEL Bythjul';
                    }
                }
                group("Monitoring the denunciation")
                {
                    Caption = 'Monitoring the denunciation';
                    field("Starting date of Relationship"; Rec."DEL Start date of Relationship")
                    {
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
                                    Caption = 'Quote part Mobivia/CA %';
                                }
                                field("Quote part 1 Mobivia/CA Year"; Rec."DEL Qte part 1 Mobivia/CA Year")
                                {
                                    Caption = 'Year';
                                }
                            }
                            group("Quote part 2")
                            {
                                Caption = 'Quote part 2';
                                field("Quote part 2 Mobivia/CA %"; Rec."DEL Quote part 2 Mobivia/CA %")
                                {
                                    ShowCaption = false;
                                    Caption = 'Quote part 2 Mobivia/CA %';
                                }
                                field("Quote part 2 Mobivia/CA Year"; Rec."DEL Qte part 2 Mobivia/CA Year")
                                {
                                    ShowCaption = false;
                                    Caption = 'Quote part 2 Mobivia/CA Year';
                                }
                            }
                        }
                    }
                    field("Period of denunciation"; Rec."DEL Period of denunciation")
                    {
                        Editable = Editablefield;
                        Caption = 'Period of denunciation';
                    }
                    field("Denunciation to analyze"; Rec."DEL Denunciation to analyze")
                    {
                        Editable = false;
                        Caption = 'Denunciation to analyze';
                    }
                    field("Denunciation Replanned"; Rec."DEL Denunciation Replanned")
                    {
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
                        Caption = 'Denunciation realised';
                    }
                    field("Denunciation date"; Rec."DEL Denunciation date")
                    {
                        Caption = 'Denunciation Date';
                    }
                    field("Not denunciation"; Rec."DEL Not denunciation")
                    {
                        Caption = 'Pas de dénonciation';
                    }
                    field("Comment denunciation"; Rec."DEL Comment denunciation")
                    {
                        Caption = 'Comment denunciation';
                    }
                }
                group("Invoice tracking")
                {
                    Caption = 'Invoice tracking';
                    field("En facturation"; Rec."DEL En facturation")
                    {
                        Caption = 'Invoicing';
                    }
                    field("Fréquence de facturation"; Rec."DEL Fréquence de facturation")
                    {
                        Caption = 'Frequency of invoicing';

                        trigger OnValidate()
                        begin
                            CurrPage.UPDATE();
                        end;
                    }
                    field("Date de prochaine facturation"; Rec."DEL Date de proch. fact.")
                    {
                        Editable = false;
                        Caption = 'Next invoice date';
                    }
                    field("Nbre jour avant proch. fact."; Rec."DEL Nbr jr avant proch. fact.")
                    {
                        Editable = false;
                        Caption = 'Nb of days before invoicing';
                    }
                    field("Last Accounting Date"; Rec."DEL Last Accounting Date")
                    {
                        Editable = false;
                        Caption = 'Last accounting date';
                    }
                    field(Facture; Rec."DEL Facture")
                    {
                        Editable = false;
                        Caption = 'Invoce No.';

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
                        Editable = false;
                        Caption = 'Amount';
                    }
                    field("Montant ouvert"; Rec."DEL Montant ouvert")
                    {
                        Editable = false;
                        Caption = 'Pending amount';
                    }
                    field("Amount YTD"; Rec."DEL Amount YTD")
                    {
                        CaptionClass = '3,' + CustDateFilter[1];
                        Caption = 'Amount YTD';

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
                        CaptionClass = '3,' + CustDateFilter[2];
                        Caption = 'Amount YTD-1';

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
                        CaptionClass = '3,' + CustDateFilter[3];
                        Caption = 'Amount YTD-2';

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
                    Style = Strong;
                    StyleExpr = True;
                    Caption = 'Central trading';
                }
                field("Frequency of delivery 1"; Rec."DEL Frequency of delivery 1")
                {
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 1"; Rec."DEL Invoicing Frequency 1")
                {
                    Caption = 'Invoicing Frequency';
                }
                field("Sales data report"; Rec."DEL Sales data report")
                {
                    Caption = 'Sales data report';
                }
                field("Frequency of delivery 2"; Rec."DEL Frequency of delivery 2")
                {
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 2"; Rec."DEL Invoicing Frequency 2")
                {
                    Caption = 'Invoicing Frequency';
                }
                field("Assist in relat. with the BU"; Rec."DEL Ass. in relat. with the BU")
                {
                    Caption = 'Assist in relations with the BU (Blue Helmets)';
                }
                field("Frequency of delivery 3"; Rec."DEL Frequency of delivery 3")
                {
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 3"; Rec."DEL Invoicing Frequency 3")
                {
                    Caption = 'Invoicing Frequency';
                }
                field("Organization of visits"; Rec."DEL Organization of visits")
                {
                    Caption = 'Organization of visits';
                }
                field("Frequency of delivery 4"; Rec."DEL Frequency of delivery 4")
                {
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 4"; Rec."DEL Invoicing Frequency 4")
                {
                    Caption = 'Invoicing Frequency';
                }
                field("Vision and Market Analysis"; Rec."DEL Vision and Market Analysis")
                {
                    Caption = 'Vision and Market Analysis';
                }
                field("Frequency of delivery 5"; Rec."DEL Frequency of delivery 5")
                {
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 5"; Rec."DEL Invoicing Frequency 5")
                {
                    Caption = 'Invoicing Frequency';
                }
                field("Presentation provider strategy"; Rec."DEL Pres. provider strategy")
                {
                    Caption = 'Presentation provider strategy';
                }
                field("Frequency of delivery 6"; Rec."DEL Frequency of delivery 6")
                {
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 6"; Rec."DEL Invoicing Frequency 6")
                {
                    Caption = 'Invoicing Frequency';
                }
                field("Presentation MOBIVIA strategy"; Rec."DEL Pres. MOBIVIA strategy")
                {
                    Caption = 'Presentation MOBIVIA strategy';
                }
                field("Frequency of delivery 7"; Rec."DEL Frequency of delivery 7")
                {
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 7"; Rec."DEL Invoicing Frequency 7")
                {
                    Caption = 'Invoicing Frequency';
                }
                field("Adv on the adapt. of the offer"; Rec."DEL Adv on the adapt.of the offer")
                {
                    Caption = 'Advising on the adaptation of the offer';
                }
                field("Frequency of delivery 8"; Rec."DEL Frequency of delivery 8")
                {
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 8"; Rec."DEL Invoicing Frequency 8")
                {
                    Caption = 'Invoicing Frequency';
                }
                field("Favorite referencing by BU"; Rec."DEL Favorite referencing by BU")
                {
                    Caption = 'Favorite referencing by BU';
                }
                field("Frequency of delivery 9"; Rec."DEL Frequency of delivery 9")
                {
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 9"; Rec."DEL Invoicing Frequency 9")
                {
                    Caption = 'Invoicing Frequency';
                }
                field(Forecast; Rec."DEL Forecast")
                {
                    Caption = 'Forecast';
                }
                field("Frequency of delivery 10"; Rec."DEL Frequency of delivery 10")
                {
                    Caption = 'Frequency of delivery';
                }
                field("Invoicing Frequency 10"; Rec."DEL Invoicing Frequency 10")
                {
                    Caption = 'Invoicing Frequency';
                }
            }
            group("Charte ethique")
            {
                Caption = 'Ethical charter';
                field("Statut CE"; Rec."DEL Statut CE")
                {
                    Caption = 'Ethical Charter status';
                }
                field("Date Signature CE"; Rec."DEL Date Signature CE")
                {
                    Caption = 'Date of signature EC';
                }
                field("URL document CE"; Rec."DEL URL document CE")
                {
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
                        Caption = 'Quality rating';
                    }
                    field("Realisation Date Quality"; Rec."DEL Realisation Date Quality")
                    {
                        Caption = 'Creation date QA';
                    }
                }
                group("Social Audit")
                {
                    Caption = 'Social Audit';
                    field("Note Soc"; Rec."DEL Note Soc")
                    {
                        Caption = 'Social rating';
                    }
                    field("Realisation Date Soc"; Rec."DEL Realisation Date Soc")
                    {
                        Caption = 'Creation date';
                    }
                }
                group("Environmental Audit")
                {
                    Caption = 'Environmental Audit';
                    field("Note Env"; Rec."DEL Note Env")
                    {
                        Caption = 'Environmental rating';
                    }
                    field("Realisation Date Env"; Rec."DEL Realisation Date Env")
                    {
                        Caption = 'Creation date';
                    }
                }
            }
            part("Contact Contrat"; "DEL Contact Contrat")
            {
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
                    Image = AddContacts;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Contact Contrat";
                    RunPageLink = "DEL Customer No." = FIELD("No.");
                }
                action(Print)
                {
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Customer.RESET();
                        Customer.SETRANGE("No.", Rec."No.");
                        REPORT.RUN(Report::"DEL Enregistrement contrat", TRUE, TRUE, Customer);
                    end;
                }
                action("Contract Comments")
                {
                    Caption = 'Contract Comments';
                    Image = TaskList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
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

        // CustLedgerEntry: Record 21;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        // CustLedgerEntry2: Record "21";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        // Customer: Record 18;
        Customer: Record Customer;
        // DocumentLine: Record 50008;
        DocumentLine: Record "DEL Document Line";
        // DimensionValue_Rec: Record 349;
        DimensionValue_Rec: Record "Dimension Value";
        // SalesInvoiceHeader: Record 112;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        // DocumentContrat: Page 50075;
        DocumentContrat: Page "DEL Document Sheet Contrats";
        // PDimensionValue: Page 560;
        PDimensionValue: Page "Dimension Value List";
        Editablefield: Boolean;

        DateFilter1: Text;
        DateFilter2: Text;
        DateFilter3: Text;
        CustDateFilter: array[4] of Text[30];


}

