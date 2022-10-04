
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
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    Enabled = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    Editable = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Editable = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Editable = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Editable = false;
                }
                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    Editable = false;
                }
                field(Contact; Rec.Contact)
                {
                    Editable = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Editable = false;
                }
                field("Language Code"; Rec."Language Code")
                {
                    Editable = false;
                }
                field("Parent Company"; Rec."DEL Parent Company")
                {
                }
            }
            group("Suivi partnership agreement")
            {
                Caption = 'Partnership agreement follow up';
                field("Partnership agreement"; Rec."DEL Partnership agreement")
                {
                }
                field("Libellé PA"; Rec."DEL Libellé PA")
                {
                }
                field("Statut PA"; Rec."DEL Statut PA")
                {
                }
                group(Annexes)
                {
                    Caption = 'Annexes:';
                    field("Annexe A PA"; Rec."DEL Annexe A PA")
                    {
                    }
                    field("Annexe B PA"; Rec."DEL Annexe B PA")
                    {
                    }
                    field("Annexe C PA"; Rec."DEL Annexe C PA")
                    {
                    }
                    field("Annexe D PA"; Rec."DEL Annexe D PA")
                    {
                    }
                }
                field("Date de début PA"; Rec."DEL Date de début PA")
                {
                }
                field("Date de fin PA"; Rec."DEL Date de fin PA")
                {
                }
                field("URL document PA"; Rec."DEL URL document PA")
                {

                    trigger OnLookup(var Text: Text): Boolean

                    begin

                        CLEAR(DocumentLine);
                        DocumentLine.RESET;
                        DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Customer);
                        DocumentLine.SETRANGE(DocumentLine."No.", Rec."No.");
                        DocumentLine.SETRANGE(DocumentLine."Type contrat", DocumentLine."Type contrat"::Partnership);
                        DocumentContrat.SETTABLEVIEW(DocumentLine);
                        DocumentContrat.RUN;
                    end;
                }
                field("Comment PA"; Rec."DEL Comment PA")
                {
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
                    }
                    field("Libellé SSA"; Rec."DEL Libellé SSA")
                    {
                    }
                    field("Statut SSA"; Rec."DEL Statut SSA")
                    {
                    }
                    field("Date de début SSA"; Rec."DEL Date de début SSA")
                    {
                    }
                    field("Date de fin SSA"; Rec."DEL Date de fin SSA")
                    {
                    }
                    field("Comment SSA"; Rec."DEL Comment SSA")
                    {
                    }
                    field("URL document SSA"; Rec."DEL URL document SSA")
                    {

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            CLEAR(DocumentLine);
                            DocumentLine.RESET;
                            DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Customer);
                            DocumentLine.SETRANGE(DocumentLine."No.", Rec."No.");
                            DocumentLine.SETRANGE(DocumentLine."Type contrat", DocumentLine."Type contrat"::Service);
                            DocumentContrat.SETTABLEVIEW(DocumentLine);
                            DocumentContrat.RUN;
                        end;
                    }
                    field(Level; Rec."DEL Level")
                    {
                    }
                    label(AnnexesSSA)
                    {
                        Caption = 'Annexes:';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("Annexe A SSA"; Rec."DEL Annexe A SSA")
                    {
                    }
                    field("Renouvellement tacite"; Rec."DEL Renouvellement tacite")
                    {
                    }
                    field("Renewal by mail"; Rec."DEL Renewal by mail")
                    {
                    }
                    field("Renewal by endorsement"; Rec."DEL Renewal by endorsement")
                    {
                    }
                    field("Reporting vente"; Rec."DEL Reporting vente")
                    {
                    }
                    field("Segmentation Prod Niveau"; Rec."DEL Segmentation Prod Niveau")
                    {

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            DimensionValue_Rec.RESET;
                            DimensionValue_Rec.FILTERGROUP(2);
                            DimensionValue_Rec.SETRANGE(DimensionValue_Rec."Dimension Code", 'SEGMENT');

                            CLEAR(PDimensionValue);
                            PDimensionValue.SETTABLEVIEW(DimensionValue_Rec);
                            PDimensionValue.LOOKUPMODE(TRUE);
                            IF PDimensionValue.RUNMODAL = ACTION::LookupOK THEN BEGIN
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
                    }
                    label(Mark)
                    {
                        Caption = 'Mark';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("National Mark"; Rec."DEL National Mark")
                    {
                    }
                    field(MDD; Rec."DEL MDD")
                    {
                    }
                    label(Signboard)
                    {
                        Caption = 'Signboard';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field(NORAUTO; Rec."DEL NORAUTO")
                    {
                    }
                    field(MIDAS; "DEL MIDAS")
                    {
                    }
                    field(ATU; Rec."DEL ATU")
                    {
                    }
                    field(ATYSE; Rec."DEL ATYSE")
                    {
                    }
                    field("CARTER CASH"; Rec."DEL CARTER CASH")
                    {
                    }
                    field(SYNCHRO; Rec."DEL SYNCHRO")
                    {
                    }
                    field(Shruvat; Rec."DEL Shruvat")
                    {
                    }
                    field(Bythjul; Rec."DEL Bythjul")
                    {
                    }
                }
                group("Monitoring the denunciation")
                {
                    Caption = 'Monitoring the denunciation';
                    field("Starting date of Relationship"; Rec."DEL Start date of Relationship")
                    {
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
                                }
                                field("Quote part 2 Mobivia/CA Year"; Rec."DEL Qte part 2 Mobivia/CA Year")
                                {
                                    ShowCaption = false;
                                }
                            }
                        }
                    }
                    field("Period of denunciation"; Rec."DEL Period of denunciation")
                    {
                        Editable = Editablefield;
                    }
                    field("Denunciation to analyze"; Rec."DEL Denunciation to analyze")
                    {
                        Editable = false;
                    }
                    field("Denunciation Replanned"; Rec."DEL Denunciation Replanned")
                    {

                        trigger OnValidate()
                        begin
                            Editablefield := FALSE;
                            IF "DEL Denunciation Replanned" THEN BEGIN
                                Editablefield := TRUE;
                            END;
                        end;
                    }
                    field("Denunciation realised"; Rec."DEL Denunciation realised")
                    {
                    }
                    field("Denunciation date"; Rec."DEL Denunciation date")
                    {
                    }
                    field("Not denunciation"; Rec."DEL Not denunciation")
                    {
                    }
                    field("Comment denunciation"; Rec."DEL Comment denunciation")
                    {
                    }
                }
                group("Invoice tracking")
                {
                    Caption = 'Invoice tracking';
                    field("En facturation"; Rec."DEL En facturation")
                    {
                    }
                    field("Fréquence de facturation"; Rec."DEL Fréquence de facturation")
                    {

                        trigger OnValidate()
                        begin
                            CurrPage.UPDATE();
                        end;
                    }
                    field("Date de prochaine facturation"; Rec."DEL Date de proch. fact.")
                    {
                        Editable = false;
                    }
                    field("Nbre jour avant proch. fact."; Rec."DEL Nbr jr avant proch. fact.")
                    {
                        Editable = false;
                    }
                    field("Last Accounting Date"; Rec."DEL Last Accounting Date")
                    {
                        Editable = false;
                    }
                    field(Facture; Rec."DEL Facture")
                    {
                        Editable = false;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            IF "DEL Facture" <> '' THEN BEGIN
                                SalesInvoiceHeader.RESET;
                                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", "DEL Facture");
                                PAGE.RUN(Page::"Posted Sales Invoice", SalesInvoiceHeader);
                            END;
                        end;
                    }
                    field(Montant; Rec."DEL Montant")
                    {
                        Editable = false;
                    }
                    field("Montant ouvert"; Rec."DEL Montant ouvert")
                    {
                        Editable = false;
                    }
                    field("Amount YTD"; Rec."DEL Amount YTD")
                    {
                        CaptionClass = '3,' + CustDateFilter[1];

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            CustLedgerEntry2.RESET;
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

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            CustLedgerEntry2.RESET;
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

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            CustLedgerEntry2.RESET;
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
                }
                field("Frequency of delivery 1"; Rec."DEL Frequency of delivery 1")
                {
                }
                field("Invoicing Frequency 1"; Rec."DEL Invoicing Frequency 1")
                {
                }
                field("Sales data report"; Rec."DEL Sales data report")
                {
                }
                field("Frequency of delivery 2"; Rec."DEL Frequency of delivery 2")
                {
                }
                field("Invoicing Frequency 2"; Rec."DEL Invoicing Frequency 2")
                {
                }
                field("Assist in relat. with the BU"; Rec."DEL Ass. in relat. with the BU")
                {
                }
                field("Frequency of delivery 3"; Rec."DEL Frequency of delivery 3")
                {
                }
                field("Invoicing Frequency 3"; Rec."DEL Invoicing Frequency 3")
                {
                }
                field("Organization of visits"; Rec."DEL Organization of visits")
                {
                }
                field("Frequency of delivery 4"; Rec."DEL Frequency of delivery 4")
                {
                }
                field("Invoicing Frequency 4"; Rec."DEL Invoicing Frequency 4")
                {
                }
                field("Vision and Market Analysis"; Rec."DEL Vision and Market Analysis")
                {
                }
                field("Frequency of delivery 5"; Rec."DEL Frequency of delivery 5")
                {
                }
                field("Invoicing Frequency 5"; Rec."DEL Invoicing Frequency 5")
                {
                }
                field("Presentation provider strategy"; Rec."DEL Pres. provider strategy")
                {
                }
                field("Frequency of delivery 6"; Rec."DEL Frequency of delivery 6")
                {
                }
                field("Invoicing Frequency 6"; Rec."DEL Invoicing Frequency 6")
                {
                }
                field("Presentation MOBIVIA strategy"; Rec."DEL Pres. MOBIVIA strategy")
                {
                }
                field("Frequency of delivery 7"; Rec."DEL Frequency of delivery 7")
                {
                }
                field("Invoicing Frequency 7"; Rec."DEL Invoicing Frequency 7")
                {
                }
                field("Adv on the adapt. of the offer"; Rec."DEL Adv on the adapt.of the offer")
                {
                }
                field("Frequency of delivery 8"; Rec."DEL Frequency of delivery 8")
                {
                }
                field("Invoicing Frequency 8"; Rec."DEL Invoicing Frequency 8")
                {
                }
                field("Favorite referencing by BU"; Rec."DEL Favorite referencing by BU")
                {
                }
                field("Frequency of delivery 9"; Rec."DEL Frequency of delivery 9")
                {
                }
                field("Invoicing Frequency 9"; Rec."DEL Invoicing Frequency 9")
                {
                }
                field(Forecast; Rec."DEL Forecast")
                {
                }
                field("Frequency of delivery 10"; Rec."DEL Frequency of delivery 10")
                {
                }
                field("Invoicing Frequency 10"; Rec."DEL Invoicing Frequency 10")
                {
                }
            }
            group("Charte ethique")
            {
                Caption = 'Ethical charter';
                field("Statut CE"; Rec."DEL Statut CE")
                {
                }
                field("Date Signature CE"; Rec."DEL Date Signature CE")
                {
                }
                field("URL document CE"; Rec."DEL URL document CE")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(DocumentLine);
                        DocumentLine.RESET;
                        DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Customer);
                        DocumentLine.SETRANGE(DocumentLine."No.", Rec."No.");
                        DocumentLine.SETRANGE(DocumentLine."Type contrat", DocumentLine."Type contrat"::"Charte ethique");
                        DocumentContrat.SETTABLEVIEW(DocumentLine);
                        DocumentContrat.RUN;
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
                    }
                    field("Realisation Date Quality"; Rec."DEL Realisation Date Quality")
                    {
                    }
                }
                group("Social Audit")
                {
                    Caption = 'Social Audit';
                    field("Note Soc"; Rec."DEL Note Soc")
                    {
                    }
                    field("Realisation Date Soc"; Rec."DEL Realisation Date Soc")
                    {
                    }
                }
                group("Environmental Audit")
                {
                    Caption = 'Environmental Audit';
                    field("Note Env"; Rec."DEL Note Env")
                    {
                    }
                    field("Realisation Date Env"; Rec."DEL Realisation Date Env")
                    {
                    }
                }
            }
            part("Contact Contrat"; Rec."Contact Contrat")
            {
                Caption = 'Contact';
                Editable = false;
               //TODO SubPageLink = "Customer No." = FIELD("No.");
                // SubPageView = SORTING("No.")
                //               ORDER(Ascending);
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
                    RunObject = Page "Document Sheet Contrats";
                                    RunPageLink = "No." = FIELD("No.");
                                    RunPageView = SORTING("DEL Table Name", "No.", "Comment Entry No.", "Line No.")
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
                    RunObject = Page "Comment Sheet Contrats";
                                    RunPageLink = "Table Name" = CONST(Customer),
                                  "No." = FIELD("No.");
                }
                action(Contact)
                {
                    Image = AddContacts;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Contact Contrat";
                                    RunPageLink = "Customer No." = FIELD("No.");
                }
                action(Print)
                {
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Customer.RESET;
                        Customer.SETRANGE("No.", Rec."No.");
                        REPORT.RUN(50028, TRUE, TRUE, Customer);
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
        Customer.RESET;
        Customer.SETRANGE(Customer."No.", "No.");
        IF Customer.FINDFIRST THEN BEGIN
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", Customer."No.");
            CustLedgerEntry.SETRANGE(CustLedgerEntry."Document Type", CustLedgerEntry."Document Type"::Invoice);
            //CustLedgerEntry.SETRANGE();
            IF CustLedgerEntry.FINDLAST THEN BEGIN
                CustLedgerEntry.CALCFIELDS(CustLedgerEntry.Amount, CustLedgerEntry."Remaining Amount");
                Customer."Last Accounting Date" := CustLedgerEntry."Posting Date";
                Customer.Facture := CustLedgerEntry."Document No.";
                Customer.Montant := CustLedgerEntry.Amount;
                Customer."Montant ouvert" := CustLedgerEntry."Remaining Amount";

                //START T-00738
                IF Customer."Fréquence de facturation" = Customer."Fréquence de facturation"::"12 mois" THEN
                    Customer."Date de prochaine facturation" := CALCDATE('<+12M>', CustLedgerEntry."Posting Date");
                IF Customer."Fréquence de facturation" = Customer."Fréquence de facturation"::"6 mois" THEN
                    Customer."Date de prochaine facturation" := CALCDATE('<+6M>', CustLedgerEntry."Posting Date");
                IF Customer."Fréquence de facturation" = Customer."Fréquence de facturation"::"4 mois" THEN
                    Customer."Date de prochaine facturation" := CALCDATE('<+4M>', CustLedgerEntry."Posting Date");
                IF Customer."Fréquence de facturation" = Customer."Fréquence de facturation"::"3 mois" THEN
                    Customer."Date de prochaine facturation" := CALCDATE('<+3M>', CustLedgerEntry."Posting Date");
                IF Customer."Fréquence de facturation" = Customer."Fréquence de facturation"::" " THEN
                    Customer."Date de prochaine facturation" := CALCDATE('<+0M>', CustLedgerEntry."Posting Date");
                //STOP T-00738
                Customer."Nbre jour avant proch. fact." := Customer."Date de prochaine facturation" - TODAY;
            END;
            IF Customer."Date de fin PA" < TODAY THEN
                Customer."Statut PA" := Customer."Statut PA"::Échu;
            IF Customer."Date de fin SSA" < TODAY THEN
                Customer."Statut SSA" := Customer."Statut SSA"::Échu;

            //START T-00767
            IF Customer."Period of denunciation" < TODAY THEN
                Customer."Denunciation to analyze" := TRUE
            ELSE
                Customer."Denunciation to analyze" := FALSE;
            //STOP T-00767

            Editablefield := FALSE;
            IF "Denunciation Replanned" THEN BEGIN
                Editablefield := TRUE;
            END;
            /*
            CustDateFilter[1]:=FORMAT(DMY2DATE(1,1,DATE2DMY(TODAY,3)))+'..'+FORMAT(DMY2DATE(31,12,DATE2DMY(TODAY,3)));
            CustDateFilter[2]:=FORMAT(DMY2DATE(1,1,DATE2DMY(TODAY,3)-1))+'..'+FORMAT(DMY2DATE(31,12,DATE2DMY(TODAY,3)-1));
            CustDateFilter[3]:=FORMAT(DMY2DATE(1,1,DATE2DMY(TODAY,3)-2))+'..'+FORMAT(DMY2DATE(31,12,DATE2DMY(TODAY,3)-2));
            DateFilter1:=CustDateFilter[1];
            DateFilter2:=CustDateFilter[2];
            DateFilter3:=CustDateFilter[3];

            FOR i := 1 TO 3 DO BEGIN
              SETFILTER("Date Filter",CustDateFilter[i]);
              CALCFIELDS("Sales (LCY)");
              CustSalesLCY[i] := "Sales (LCY)";

            END;

            CustDateFilter[1]:=Text001+' '+FORMAT(DMY2DATE(1,1,DATE2DMY(TODAY,3)),0,'<Year4>');
            CustDateFilter[2]:=Text001+' '+FORMAT(DMY2DATE(1,1,DATE2DMY(TODAY,3)-1),0,'<Year4>');
            CustDateFilter[3]:=Text001+' '+FORMAT(DMY2DATE(1,1,DATE2DMY(TODAY,3)-2),0,'<Year4>');

            Customer."Amount YTD":=CustSalesLCY[1];
            Customer."Amount YTD-1":=CustSalesLCY[2];
            Customer."Amount YTD-2":=CustSalesLCY[3];
            */
            Customer.MODIFY;

        END;

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //START T-00767
        IF "Denunciation Replanned" THEN
            TESTFIELD("Period of denunciation");

        IF "Denunciation realised" THEN
            TESTFIELD("Denunciation date");

        IF ("Denunciation Replanned") AND ("Period of denunciation" <> 0D) THEN BEGIN
            "Denunciation Replanned" := FALSE;
            MODIFY;
        END;
        //STOP T-00767
    end;

    var

        // DocumentLine: Record 50008;
        DocumentLine: Record "DEL Document Line";
        // Customer: Record 18;
        Customer: Record Customer;
        // CustLedgerEntry: Record 21;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        // SalesInvoiceHeader: Record 112;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        // DimensionValue_Rec: Record 349;
        DimensionValue_Rec: Record "Dimension Value";
        // CustLedgerEntry2: Record "21";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        // DocumentContrat: Page 50075;
        DocumentContrat: Page "Document Sheet Contrats";
                             // PDimensionValue: Page 560;
                             PDimensionValue: Page "Dimension Value List";
                             Editablefield: Boolean;
                             CustSalesLCY: array [4] of Decimal;
                             CustDateFilter: array [4] of Text[30];
                             i: Integer;
                             Text001: Label 'Sales (LCY)';

        DateFilter1: Text;
        DateFilter2: Text;
        DateFilter3: Text;


}

