page 50074 "DEL Liste Suivi des contrats"
{

    Caption = 'Follow contract List';
    CardPageID = "DEL Suivi des contrats";
    Editable = false;
    PageType = List;
    SourceTable = Customer;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("Customer Posting Group" = FILTER('SERVICES'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                }
                field(Contact; Rec.Contact)
                {
                }
                field("Partnership agreement"; Rec."DEL Partnership agreement")
                {
                }
                field("Libellé PA"; Rec."DEL Libellé PA")
                {
                }
                field("Statut PA"; Rec."DEL Statut PA")
                {
                }
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
                field("Date de début PA"; Rec."DEL Date de début PA")
                {
                }
                field("Date de fin PA"; Rec."DEL Date de fin PA")
                {
                }
                field("Service agreement"; Rec."DEL Service agreement")
                {
                }
                field("En facturation"; Rec."DEL En facturation")
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
                field("DEL Fréquence de facturation"; Rec."DEL Fréquence de facturation")
                {
                }
                field("DEL Date de proch. fact."; Rec."DEL Date de proch. fact.")
                {
                }
                field("Nbre jour avant proch. fact."; Rec."DEL Nbr jr avant proch. fact.")
                {
                }
                field(Level; Rec."DEL Level")
                {
                }
                field("Annexe A SSA"; Rec."DEL Annexe A SSA")
                {
                }
                field("Renouvellement tacite"; Rec."DEL Renouvellement tacite")
                {
                }
                field("Reporting vente"; Rec."DEL Reporting vente")
                {
                }
                field("Last Accounting Date"; Rec."DEL Last Accounting Date")
                {
                }
                field(Facture; Rec."DEL Facture")
                {
                }
                field(Montant; Rec."DEL Montant")
                {
                }
                field("Montant ouvert"; Rec."DEL Montant ouvert")
                {
                }
                field("Statut CE"; Rec."DEL Statut CE")
                {
                }
                field("Date Signature CE"; Rec."DEL Date Signature CE")
                {
                }
                field("Starting date of Relationship"; Rec."DEL Start date of Relationship")
                {
                }
                field("Quote part 1 Mobivia/CA %"; Rec."DEL Quote part 1 Mobivia/CA %")
                {
                }
                field("Quote part 1 Mobivia/CA Year"; Rec."DEL Qte part 1 Mobivia/CA Year")
                {
                }
                field("Quote part 2 Mobivia/CA %"; Rec."DEL Quote part 2 Mobivia/CA %")
                {
                }
                field("Quote part 2 Mobivia/CA Year"; Rec."DEL Qte part 2 Mobivia/CA Year")
                {
                }
                field("Period of denunciation"; Rec."DEL Period of denunciation")
                {
                }
                field("Denunciation to analyze"; Rec."DEL Denunciation to analyze")
                {
                }
                field("Denunciation Replanned"; Rec."DEL Denunciation Replanned")
                {
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
                field("Amount YTD"; Rec."DEL Amount YTD")
                {
                    CaptionClass = '3,' + CustDateFilter[1];

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CustLedgerEntry2.RESET();
                        CustLedgerEntry2.FILTERGROUP(2);
                        CustLedgerEntry2.SETRANGE(CustLedgerEntry2."Customer No.", Rec."No.");
                        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Sales (LCY)", '<>0');
                        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Posting Date", DateFilter1);

                        PAGE.RUN(25, CustLedgerEntry2);
                    end;
                }
                field("Amount YTD-1"; Rec."DEL Amount YTD-1")
                {
                    CaptionClass = '3,' + CustDateFilter[2];

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CustLedgerEntry2.RESET();
                        CustLedgerEntry2.FILTERGROUP(2);
                        CustLedgerEntry2.SETRANGE(CustLedgerEntry2."Customer No.", Rec."No.");
                        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Sales (LCY)", '<>0');
                        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Posting Date", DateFilter2);
                        PAGE.RUN(25, CustLedgerEntry2);
                    end;
                }
                field("Amount YTD-2"; Rec."DEL Amount YTD-2")
                {
                    CaptionClass = '3,' + CustDateFilter[3];

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CustLedgerEntry2.RESET();
                        CustLedgerEntry2.FILTERGROUP(2);
                        CustLedgerEntry2.SETRANGE(CustLedgerEntry2."Customer No.", Rec."No.");
                        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Sales (LCY)", '<>0');
                        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Posting Date", DateFilter3);
                        PAGE.RUN(25, CustLedgerEntry2);
                    end;
                }
                field("Parent Company"; Rec."DEL Parent Company")
                {
                }
                field("Renewal by mail"; Rec."DEL Renewal by mail")
                {
                }
                field("Renewal by endorsement"; Rec."DEL Renewal by endorsement")
                {
                }
                field("Segmentation Prod Niveau"; Rec."DEL Segmentation Prod Niveau")
                {
                }
                field("Segmentation Description"; Rec."DEL Segmentation Description")
                {
                    Editable = false;
                }
                field("National Mark"; Rec."DEL National Mark")
                {
                }
                field(MDD; Rec."DEL MDD")
                {
                }
                field(NORAUTO; Rec."DEL NORAUTO")
                {
                }
                field(MIDAS; Rec."DEL MIDAS")
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
                field("URL document CE"; Rec."DEL URL document CE")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(DocumentLine);
                        DocumentLine.RESET();
                        DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Customer);
                        DocumentLine.SETRANGE(DocumentLine."No.", Rec."No.");
                        DocumentLine.SETRANGE(DocumentLine."Type contrat", DocumentLine."Type contrat"::"Charte ethique");
                        DocumentContrat.SETTABLEVIEW(DocumentLine);
                        DocumentContrat.RUN();
                    end;
                }
                field("Note Quality"; Rec."DEL Note Quality")
                {
                }
                field("Realisation Date Quality"; Rec."DEL Realisation Date Quality")
                {
                }
                field("Note Soc"; Rec."DEL Note Soc")
                {
                }
                field("Realisation Date Soc"; Rec."DEL Realisation Date Soc")
                {
                }
                field("Note Env"; Rec."DEL Note Env")
                {
                }
                field("Realisation Date Env"; Rec."DEL Realisation Date Env")
                {
                }
                field("Central trading"; Rec."DEL Central trading")
                {
                    Visible = false;
                }
                field("Sales data report"; Rec."DEL Sales data report")
                {
                    Visible = false;
                }
                field("Assist in relat. with the BU"; Rec."DEL Ass. in relat. with the BU")
                {
                    Visible = false;
                }
                field("Organization of visits"; Rec."DEL Organization of visits")
                {
                    Visible = false;
                }
                field("Vision and Market Analysis"; Rec."DEL Vision and Market Analysis")
                {
                    Visible = false;
                }
                field("Presentation provider strategy"; Rec."DEL Pres. provider strategy")
                {
                    Visible = false;
                }
                field("Presentation MOBIVIA strategy"; Rec."DEL Pres. MOBIVIA strategy")
                {
                    Visible = false;
                }
                field("Adv on the adapt. of the offer"; Rec."DEL Adv on the adapt.of the offer")
                {
                    Visible = false;
                }
                field("Favorite referencing by BU"; Rec."DEL Favorite referencing by BU")
                {
                    Visible = false;
                }
                field(Forecast; Rec."DEL Forecast")
                {
                    Visible = false;
                }
                field("Frequency of delivery 1"; Rec."DEL Frequency of delivery 1")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 1"; Rec."DEL Invoicing Frequency 1")
                {
                    Visible = false;
                }
                field("Frequency of delivery 2"; Rec."DEL Frequency of delivery 2")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 2"; Rec."DEL Invoicing Frequency 2")
                {
                    Visible = false;
                }
                field("Frequency of delivery 3"; Rec."DEL Frequency of delivery 3")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 3"; Rec."DEL Invoicing Frequency 3")
                {
                    Visible = false;
                }
                field("Frequency of delivery 4"; Rec."DEL Frequency of delivery 4")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 4"; Rec."DEL Invoicing Frequency 4")
                {
                    Visible = false;
                }
                field("Frequency of delivery 5"; Rec."DEL Frequency of delivery 5")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 5"; Rec."DEL Invoicing Frequency 5")
                {
                    Visible = false;
                }
                field("Frequency of delivery 6"; Rec."DEL Frequency of delivery 6")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 6"; Rec."DEL Invoicing Frequency 6")
                {
                    Visible = false;
                }
                field("Frequency of delivery 7"; Rec."DEL Frequency of delivery 7")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 7"; Rec."DEL Invoicing Frequency 7")
                {
                    Visible = false;
                }
                field("Frequency of delivery 8"; Rec."DEL Frequency of delivery 8")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 8"; Rec."DEL Invoicing Frequency 8")
                {
                    Visible = false;
                }
                field("Frequency of delivery 9"; Rec."DEL Frequency of delivery 9")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 9"; Rec."DEL Invoicing Frequency 9")
                {
                    Visible = false;
                }
                field("Frequency of delivery 10"; Rec."DEL Frequency of delivery 10")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 10"; Rec."DEL Invoicing Frequency 10")
                {
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part("DEL Contract comment"; "DEL Contract comment")
            {
                SubPageLink = "No." = FIELD("No.");
                SubPageView = SORTING("No.", "Line No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Customer)
            {
                Caption = 'Customer';
                Image = Customer;
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
        Customer.SETRANGE(Customer."Customer Posting Group", 'HORS-GRPE');
        IF Customer.FINDFIRST() THEN
            REPEAT
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

                //START T-00767
                IF Customer."DEL Period of denunciation" < TODAY THEN
                    Customer."DEL Denunciation to analyze" := TRUE
                ELSE
                    Customer."DEL Denunciation to analyze" := FALSE;

                IF (Customer."DEL Denunciation Replanned") AND (Customer."DEL Period of denunciation" <> 0D) THEN BEGIN
                    Customer."DEL Denunciation Replanned" := FALSE;

                END;
                //STOP T-00767

                CustDateFilter[1] := FORMAT(DMY2DATE(1, 1, DATE2DMY(TODAY, 3))) + '..' + FORMAT(DMY2DATE(31, 12, DATE2DMY(TODAY, 3)));
                CustDateFilter[2] := FORMAT(DMY2DATE(1, 1, DATE2DMY(TODAY, 3) - 1)) + '..' + FORMAT(DMY2DATE(31, 12, DATE2DMY(TODAY, 3) - 1));
                CustDateFilter[3] := FORMAT(DMY2DATE(1, 1, DATE2DMY(TODAY, 3) - 2)) + '..' + FORMAT(DMY2DATE(31, 12, DATE2DMY(TODAY, 3) - 2));
                DateFilter1 := CustDateFilter[1];
                DateFilter2 := CustDateFilter[2];
                DateFilter3 := CustDateFilter[3];

                FOR i := 1 TO 3 DO BEGIN
                    Customer.SETFILTER("Date Filter", CustDateFilter[i]);
                    Customer.CALCFIELDS(Customer."Sales (LCY)");
                    CustSalesLCY[i] := Customer."Sales (LCY)";

                END;

                CustDateFilter[1] := Text001 + ' ' + FORMAT(DMY2DATE(1, 1, DATE2DMY(TODAY, 3)), 0, '<Year4>');
                CustDateFilter[2] := Text001 + ' ' + FORMAT(DMY2DATE(1, 1, DATE2DMY(TODAY, 3) - 1), 0, '<Year4>');
                CustDateFilter[3] := Text001 + ' ' + FORMAT(DMY2DATE(1, 1, DATE2DMY(TODAY, 3) - 2), 0, '<Year4>');

                Customer."DEL Amount YTD" := CustSalesLCY[1];
                Customer."DEL Amount YTD-1" := CustSalesLCY[2];
                Customer."DEL Amount YTD-2" := CustSalesLCY[3];

                Customer.MODIFY();


            UNTIL Customer.NEXT() = 0;
    end;

    var
        Customer: Record Customer;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustSalesLCY: array[4] of Decimal;
        CustDateFilter: array[4] of Text[30];
        i: Integer;
        DateFilter1: Text;
        DateFilter2: Text;
        DateFilter3: Text;
        Text001: Label 'Sales (LCY)';
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        DocumentLine: Record "DEL Document Line";
        DocumentContrat: Page "DEL Document Sheet Contrats";
}


