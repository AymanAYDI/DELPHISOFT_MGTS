page 50074 "DEL Liste Suivi des contrats"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00738      YAL     19.10.15           add 12months condition + change conditions values to match with option field
    // T-00767      THM     18.02.16           Open page
    // T-00767      THM     18.02.16           add field
    // T-00784      THM     06.04.16           add Field
    //              THM     15.05.17           Add Fields

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
                field("Partnership agreement"; "Partnership agreement")
                {
                }
                field("Libellé PA"; "Libellé PA")
                {
                }
                field("Statut PA"; "Statut PA")
                {
                }
                field("Annexe A PA"; "Annexe A PA")
                {
                }
                field("Annexe B PA"; "Annexe B PA")
                {
                }
                field("Annexe C PA"; "Annexe C PA")
                {
                }
                field("Annexe D PA"; "Annexe D PA")
                {
                }
                field("Date de début PA"; "Date de début PA")
                {
                }
                field("Date de fin PA"; "Date de fin PA")
                {
                }
                field("Service agreement"; "Service agreement")
                {
                }
                field("En facturation"; "En facturation")
                {
                }
                field("Libellé SSA"; "Libellé SSA")
                {
                }
                field("Statut SSA"; "Statut SSA")
                {
                }
                field("Date de début SSA"; "Date de début SSA")
                {
                }
                field("Date de fin SSA"; "Date de fin SSA")
                {
                }
                field("Fréquence de facturation"; "Fréquence de facturation")
                {
                }
                field("Date de prochaine facturation"; "Date de prochaine facturation")
                {
                }
                field("Nbre jour avant proch. fact."; "Nbre jour avant proch. fact.")
                {
                }
                field(Level; Level)
                {
                }
                field("Annexe A SSA"; "Annexe A SSA")
                {
                }
                field("Renouvellement tacite"; "Renouvellement tacite")
                {
                }
                field("Reporting vente"; "Reporting vente")
                {
                }
                field("Last Accounting Date"; "Last Accounting Date")
                {
                }
                field(Facture; Facture)
                {
                }
                field(Montant; Montant)
                {
                }
                field("Montant ouvert"; "Montant ouvert")
                {
                }
                field("Statut CE"; "Statut CE")
                {
                }
                field("Date Signature CE"; "Date Signature CE")
                {
                }
                field("Starting date of Relationship"; "Starting date of Relationship")
                {
                }
                field("Quote part 1 Mobivia/CA %"; "Quote part 1 Mobivia/CA %")
                {
                }
                field("Quote part 1 Mobivia/CA Year"; "Quote part 1 Mobivia/CA Year")
                {
                }
                field("Quote part 2 Mobivia/CA %"; "Quote part 2 Mobivia/CA %")
                {
                }
                field("Quote part 2 Mobivia/CA Year"; "Quote part 2 Mobivia/CA Year")
                {
                }
                field("Period of denunciation"; "Period of denunciation")
                {
                }
                field("Denunciation to analyze"; "Denunciation to analyze")
                {
                }
                field("Denunciation Replanned"; "Denunciation Replanned")
                {
                }
                field("Denunciation realised"; "Denunciation realised")
                {
                }
                field("Denunciation date"; "Denunciation date")
                {
                }
                field("Not denunciation"; "Not denunciation")
                {
                }
                field("Comment denunciation"; "Comment denunciation")
                {
                }
                field("Amount YTD"; "Amount YTD")
                {
                    CaptionClass = '3,' + CustDateFilter[1];

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CustLedgerEntry2.RESET;
                        CustLedgerEntry2.FILTERGROUP(2);
                        CustLedgerEntry2.SETRANGE(CustLedgerEntry2."Customer No.", Rec."No.");
                        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Sales (LCY)", '<>0');
                        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Posting Date", DateFilter1);

                        PAGE.RUN(25, CustLedgerEntry2);
                    end;
                }
                field("Amount YTD-1"; "Amount YTD-1")
                {
                    CaptionClass = '3,' + CustDateFilter[2];

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CustLedgerEntry2.RESET;
                        CustLedgerEntry2.FILTERGROUP(2);
                        CustLedgerEntry2.SETRANGE(CustLedgerEntry2."Customer No.", Rec."No.");
                        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Sales (LCY)", '<>0');
                        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Posting Date", DateFilter2);
                        PAGE.RUN(25, CustLedgerEntry2);
                    end;
                }
                field("Amount YTD-2"; "Amount YTD-2")
                {
                    CaptionClass = '3,' + CustDateFilter[3];

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CustLedgerEntry2.RESET;
                        CustLedgerEntry2.FILTERGROUP(2);
                        CustLedgerEntry2.SETRANGE(CustLedgerEntry2."Customer No.", Rec."No.");
                        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Sales (LCY)", '<>0');
                        CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Posting Date", DateFilter3);
                        PAGE.RUN(25, CustLedgerEntry2);
                    end;
                }
                field("Parent Company"; "Parent Company")
                {
                }
                field("Renewal by mail"; "Renewal by mail")
                {
                }
                field("Renewal by endorsement"; "Renewal by endorsement")
                {
                }
                field("Segmentation Prod Niveau"; "Segmentation Prod Niveau")
                {
                }
                field("Segmentation Description"; "Segmentation Description")
                {
                    Editable = false;
                }
                field("National Mark"; "National Mark")
                {
                }
                field(MDD; MDD)
                {
                }
                field(NORAUTO; NORAUTO)
                {
                }
                field(MIDAS; MIDAS)
                {
                }
                field(ATU; ATU)
                {
                }
                field(ATYSE; ATYSE)
                {
                }
                field("CARTER CASH"; "CARTER CASH")
                {
                }
                field(SYNCHRO; SYNCHRO)
                {
                }
                field(Shruvat; Shruvat)
                {
                }
                field(Bythjul; Bythjul)
                {
                }
                field("URL document CE"; "URL document CE")
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
                field("Note Quality"; "Note Quality")
                {
                }
                field("Realisation Date Quality"; "Realisation Date Quality")
                {
                }
                field("Note Soc"; "Note Soc")
                {
                }
                field("Realisation Date Soc"; "Realisation Date Soc")
                {
                }
                field("Note Env"; "Note Env")
                {
                }
                field("Realisation Date Env"; "Realisation Date Env")
                {
                }
                field("Central trading"; "Central trading")
                {
                    Visible = false;
                }
                field("Sales data report"; "Sales data report")
                {
                    Visible = false;
                }
                field("Assist in relat. with the BU"; "Assist in relat. with the BU")
                {
                    Visible = false;
                }
                field("Organization of visits"; "Organization of visits")
                {
                    Visible = false;
                }
                field("Vision and Market Analysis"; "Vision and Market Analysis")
                {
                    Visible = false;
                }
                field("Presentation provider strategy"; "Presentation provider strategy")
                {
                    Visible = false;
                }
                field("Presentation MOBIVIA strategy"; "Presentation MOBIVIA strategy")
                {
                    Visible = false;
                }
                field("Adv on the adapt. of the offer"; "Adv on the adapt. of the offer")
                {
                    Visible = false;
                }
                field("Favorite referencing by BU"; "Favorite referencing by BU")
                {
                    Visible = false;
                }
                field(Forecast; Forecast)
                {
                    Visible = false;
                }
                field("Frequency of delivery 1"; "Frequency of delivery 1")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 1"; "Invoicing Frequency 1")
                {
                    Visible = false;
                }
                field("Frequency of delivery 2"; "Frequency of delivery 2")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 2"; "Invoicing Frequency 2")
                {
                    Visible = false;
                }
                field("Frequency of delivery 3"; "Frequency of delivery 3")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 3"; "Invoicing Frequency 3")
                {
                    Visible = false;
                }
                field("Frequency of delivery 4"; "Frequency of delivery 4")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 4"; "Invoicing Frequency 4")
                {
                    Visible = false;
                }
                field("Frequency of delivery 5"; "Frequency of delivery 5")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 5"; "Invoicing Frequency 5")
                {
                    Visible = false;
                }
                field("Frequency of delivery 6"; "Frequency of delivery 6")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 6"; "Invoicing Frequency 6")
                {
                    Visible = false;
                }
                field("Frequency of delivery 7"; "Frequency of delivery 7")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 7"; "Invoicing Frequency 7")
                {
                    Visible = false;
                }
                field("Frequency of delivery 8"; "Frequency of delivery 8")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 8"; "Invoicing Frequency 8")
                {
                    Visible = false;
                }
                field("Frequency of delivery 9"; "Frequency of delivery 9")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 9"; "Invoicing Frequency 9")
                {
                    Visible = false;
                }
                field("Frequency of delivery 10"; "Frequency of delivery 10")
                {
                    Visible = false;
                }
                field("Invoicing Frequency 10"; "Invoicing Frequency 10")
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
        Customer.RESET;
        Customer.SETRANGE(Customer."Customer Posting Group", 'HORS-GRPE');
        IF Customer.FINDFIRST THEN
            REPEAT
                CustLedgerEntry.RESET;
                CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", Customer."No.");
                CustLedgerEntry.SETRANGE(CustLedgerEntry."Document Type", CustLedgerEntry."Document Type"::Invoice);
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

                IF (Customer."Denunciation Replanned") AND (Customer."Period of denunciation" <> 0D) THEN BEGIN
                    Customer."Denunciation Replanned" := FALSE;

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

                Customer."Amount YTD" := CustSalesLCY[1];
                Customer."Amount YTD-1" := CustSalesLCY[2];
                Customer."Amount YTD-2" := CustSalesLCY[3];

                Customer.MODIFY;


            UNTIL Customer.NEXT = 0;
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


