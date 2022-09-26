page 50073 "Suivi des contrats"
{
    // 
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00738      YAL     14.10.15           add 12months condition + change conditions values to match with option field
    // T-00767      THM     16.02.16           add Field  and add Open page
    // T-00767      THM     18.02.16
    // T-00784      THM     06.04.16           add Field
    //              THM     08.05.17           Add Field
    // S160001_20   JUH     10.07.17           OnOpenPage Comment Code
    // DEL.SAZ              26.07.18           Add function : "Commentaires Contrat"

    Caption = 'Follow contracts';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Table18;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Name; Name)
                {
                    Editable = false;
                }
                field(Address; Address)
                {
                    Enabled = false;
                }
                field("Post Code"; "Post Code")
                {
                    Editable = false;
                }
                field(City; City)
                {
                    Editable = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    Editable = false;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    Editable = false;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    Editable = false;
                }
                field("Primary Contact No."; "Primary Contact No.")
                {
                    Editable = false;
                }
                field(Contact; Contact)
                {
                    Editable = false;
                }
                field("Phone No."; "Phone No.")
                {
                    Editable = false;
                }
                field("E-Mail"; "E-Mail")
                {
                    Editable = false;
                }
                field("Language Code"; "Language Code")
                {
                    Editable = false;
                }
                field("Parent Company"; "Parent Company")
                {
                }
            }
            group("Suivi partnership agreement")
            {
                Caption = 'Partnership agreement follow up';
                field("Partnership agreement"; "Partnership agreement")
                {
                }
                field("Libellé PA"; "Libellé PA")
                {
                }
                field("Statut PA"; "Statut PA")
                {
                }
                group(Annexes)
                {
                    Caption = 'Annexes:';
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
                }
                field("Date de début PA"; "Date de début PA")
                {
                }
                field("Date de fin PA"; "Date de fin PA")
                {
                }
                field("URL document PA"; "URL document PA")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        CLEAR(DocumentLine);
                        DocumentLine.RESET;
                        DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Customer);
                        DocumentLine.SETRANGE(DocumentLine."No.", "No.");
                        DocumentLine.SETRANGE(DocumentLine."Type contrat", DocumentLine."Type contrat"::Partnership);
                        DocumentContrat.SETTABLEVIEW(DocumentLine);
                        DocumentContrat.RUN;
                    end;
                }
                field("Comment PA"; "Comment PA")
                {
                }
            }
            group("Suivi service agreement")
            {
                Caption = 'Service agreement follow up';
                group("Perimeter of the contract")
                {
                    Caption = 'Perimeter of the contract';
                    field("Service agreement"; "Service agreement")
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
                    field("Comment SSA"; "Comment SSA")
                    {
                    }
                    field("URL document SSA"; "URL document SSA")
                    {

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            CLEAR(DocumentLine);
                            DocumentLine.RESET;
                            DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Customer);
                            DocumentLine.SETRANGE(DocumentLine."No.", "No.");
                            DocumentLine.SETRANGE(DocumentLine."Type contrat", DocumentLine."Type contrat"::Service);
                            DocumentContrat.SETTABLEVIEW(DocumentLine);
                            DocumentContrat.RUN;
                        end;
                    }
                    field(Level; Level)
                    {
                    }
                    label(AnnexesSSA)
                    {
                        Caption = 'Annexes:';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("Annexe A SSA"; "Annexe A SSA")
                    {
                    }
                    field("Renouvellement tacite"; "Renouvellement tacite")
                    {
                    }
                    field("Renewal by mail"; "Renewal by mail")
                    {
                    }
                    field("Renewal by endorsement"; "Renewal by endorsement")
                    {
                    }
                    field("Reporting vente"; "Reporting vente")
                    {
                    }
                    field("Segmentation Prod Niveau"; "Segmentation Prod Niveau")
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
                                IF "Segmentation Prod Niveau" = '' THEN BEGIN
                                    "Segmentation Prod Niveau" := DimensionValue_Rec.Code;
                                    "Segmentation Description" := DimensionValue_Rec.Name;
                                END
                                ELSE BEGIN
                                    "Segmentation Prod Niveau" := "Segmentation Prod Niveau" + ',' + DimensionValue_Rec.Code;
                                    "Segmentation Description" += ',' + DimensionValue_Rec.Name;
                                END;
                            END;
                        end;

                        trigger OnValidate()
                        begin
                            IF "Segmentation Prod Niveau" = '' THEN
                                "Segmentation Description" := '';
                        end;
                    }
                    field("Segmentation Description"; "Segmentation Description")
                    {
                        Editable = false;
                    }
                    label(Mark)
                    {
                        Caption = 'Mark';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                    }
                    field("National Mark"; "National Mark")
                    {
                    }
                    field(MDD; MDD)
                    {
                    }
                    label(Signboard)
                    {
                        Caption = 'Signboard';
                        Style = StrongAccent;
                        StyleExpr = TRUE;
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
                }
                group("Monitoring the denunciation")
                {
                    Caption = 'Monitoring the denunciation';
                    field("Starting date of Relationship"; "Starting date of Relationship")
                    {
                    }
                    group("Quote Part")
                    {
                        Caption = 'Quote part';
                        grid()
                        {
                            GridLayout = Rows;
                            group("Quote part 1")
                            {
                                Caption = 'Quote part 1';
                                field("Quote part 1 Mobivia/CA %"; "Quote part 1 Mobivia/CA %")
                                {
                                    Caption = 'Quote part Mobivia/CA %';
                                }
                                field("Quote part 1 Mobivia/CA Year"; "Quote part 1 Mobivia/CA Year")
                                {
                                    Caption = 'Year';
                                }
                            }
                            group("Quote part 2")
                            {
                                Caption = 'Quote part 2';
                                field("Quote part 2 Mobivia/CA %"; "Quote part 2 Mobivia/CA %")
                                {
                                    ShowCaption = false;
                                }
                                field("Quote part 2 Mobivia/CA Year"; "Quote part 2 Mobivia/CA Year")
                                {
                                    ShowCaption = false;
                                }
                            }
                        }
                    }
                    field("Period of denunciation"; "Period of denunciation")
                    {
                        Editable = Editablefield;
                    }
                    field("Denunciation to analyze"; "Denunciation to analyze")
                    {
                        Editable = false;
                    }
                    field("Denunciation Replanned"; "Denunciation Replanned")
                    {

                        trigger OnValidate()
                        begin
                            Editablefield := FALSE;
                            IF "Denunciation Replanned" THEN BEGIN
                                Editablefield := TRUE;
                            END;
                        end;
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
                }
                group("Invoice tracking")
                {
                    Caption = 'Invoice tracking';
                    field("En facturation"; "En facturation")
                    {
                    }
                    field("Fréquence de facturation"; "Fréquence de facturation")
                    {

                        trigger OnValidate()
                        begin
                            CurrPage.UPDATE;
                        end;
                    }
                    field("Date de prochaine facturation"; "Date de prochaine facturation")
                    {
                        Editable = false;
                    }
                    field("Nbre jour avant proch. fact."; "Nbre jour avant proch. fact.")
                    {
                        Editable = false;
                    }
                    field("Last Accounting Date"; "Last Accounting Date")
                    {
                        Editable = false;
                    }
                    field(Facture; Facture)
                    {
                        Editable = false;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            IF Facture <> '' THEN BEGIN
                                SalesInvoiceHeader.RESET;
                                SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", Facture);
                                PAGE.RUN(132, SalesInvoiceHeader);
                            END;
                        end;
                    }
                    field(Montant; Montant)
                    {
                        Editable = false;
                    }
                    field("Montant ouvert"; "Montant ouvert")
                    {
                        Editable = false;
                    }
                    field("Amount YTD"; "Amount YTD")
                    {
                        CaptionClass = '3,' + CustDateFilter[1];

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            CustLedgerEntry2.RESET;
                            CustLedgerEntry2.FILTERGROUP(2);
                            CustLedgerEntry2.SETRANGE(CustLedgerEntry2."Customer No.", "No.");
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
                            CustLedgerEntry2.SETRANGE(CustLedgerEntry2."Customer No.", "No.");
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
                            CustLedgerEntry2.SETRANGE(CustLedgerEntry2."Customer No.", "No.");
                            CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Sales (LCY)", '<>0');
                            CustLedgerEntry2.SETFILTER(CustLedgerEntry2."Posting Date", DateFilter3);
                            PAGE.RUN(25, CustLedgerEntry2);
                        end;
                    }
                }
            }
            group("Services List")
            {
                Caption = 'Services List';
                field("Central trading"; "Central trading")
                {
                    Style = Strong;
                    StyleExpr = True;
                }
                field("Frequency of delivery 1"; "Frequency of delivery 1")
                {
                }
                field("Invoicing Frequency 1"; "Invoicing Frequency 1")
                {
                }
                field("Sales data report"; "Sales data report")
                {
                }
                field("Frequency of delivery 2"; "Frequency of delivery 2")
                {
                }
                field("Invoicing Frequency 2"; "Invoicing Frequency 2")
                {
                }
                field("Assist in relat. with the BU"; "Assist in relat. with the BU")
                {
                }
                field("Frequency of delivery 3"; "Frequency of delivery 3")
                {
                }
                field("Invoicing Frequency 3"; "Invoicing Frequency 3")
                {
                }
                field("Organization of visits"; "Organization of visits")
                {
                }
                field("Frequency of delivery 4"; "Frequency of delivery 4")
                {
                }
                field("Invoicing Frequency 4"; "Invoicing Frequency 4")
                {
                }
                field("Vision and Market Analysis"; "Vision and Market Analysis")
                {
                }
                field("Frequency of delivery 5"; "Frequency of delivery 5")
                {
                }
                field("Invoicing Frequency 5"; "Invoicing Frequency 5")
                {
                }
                field("Presentation provider strategy"; "Presentation provider strategy")
                {
                }
                field("Frequency of delivery 6"; "Frequency of delivery 6")
                {
                }
                field("Invoicing Frequency 6"; "Invoicing Frequency 6")
                {
                }
                field("Presentation MOBIVIA strategy"; "Presentation MOBIVIA strategy")
                {
                }
                field("Frequency of delivery 7"; "Frequency of delivery 7")
                {
                }
                field("Invoicing Frequency 7"; "Invoicing Frequency 7")
                {
                }
                field("Adv on the adapt. of the offer"; "Adv on the adapt. of the offer")
                {
                }
                field("Frequency of delivery 8"; "Frequency of delivery 8")
                {
                }
                field("Invoicing Frequency 8"; "Invoicing Frequency 8")
                {
                }
                field("Favorite referencing by BU"; "Favorite referencing by BU")
                {
                }
                field("Frequency of delivery 9"; "Frequency of delivery 9")
                {
                }
                field("Invoicing Frequency 9"; "Invoicing Frequency 9")
                {
                }
                field(Forecast; Forecast)
                {
                }
                field("Frequency of delivery 10"; "Frequency of delivery 10")
                {
                }
                field("Invoicing Frequency 10"; "Invoicing Frequency 10")
                {
                }
            }
            group("Charte ethique")
            {
                Caption = 'Ethical charter';
                field("Statut CE"; "Statut CE")
                {
                }
                field("Date Signature CE"; "Date Signature CE")
                {
                }
                field("URL document CE"; "URL document CE")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(DocumentLine);
                        DocumentLine.RESET;
                        DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Customer);
                        DocumentLine.SETRANGE(DocumentLine."No.", "No.");
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
                    field("Note Quality"; "Note Quality")
                    {
                    }
                    field("Realisation Date Quality"; "Realisation Date Quality")
                    {
                    }
                }
                group("Social Audit")
                {
                    Caption = 'Social Audit';
                    field("Note Soc"; "Note Soc")
                    {
                    }
                    field("Realisation Date Soc"; "Realisation Date Soc")
                    {
                    }
                }
                group("Environmental Audit")
                {
                    Caption = 'Environmental Audit';
                    field("Note Env"; "Note Env")
                    {
                    }
                    field("Realisation Date Env"; "Realisation Date Env")
                    {
                    }
                }
            }
            part("Contact Contrat"; 50117)
            {
                Caption = 'Contact';
                Editable = false;
                SubPageLink = Customer No.=FIELD(No.);
                    SubPageView = SORTING(No.)
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
                    RunObject = Page 21;
                    RunPageLink = No.=FIELD(No.);
                }
                action("<Page Document Sheet>")
                {
                    Caption = 'Doc&uments';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50075;
                                    RunPageLink = No.=FIELD(No.);
                    RunPageView = SORTING(Table Name,No.,Comment Entry No.,Line No.)
                                  WHERE(Table Name=CONST(Customer),
                                        Notation Type=FILTER(' '),
                                        Type liasse=FILTER(' '));
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50076;
                                    RunPageLink = Table Name=CONST(Customer),
                                  No.=FIELD(No.);
                }
                action(Contact)
                {
                    Image = AddContacts;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 50117;
                                    RunPageLink = Customer No.=FIELD(No.);
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
                        Customer.SETRANGE("No.",Rec."No.");
                        REPORT.RUN(50028,TRUE,TRUE,Customer);
                    end;
                }
                action("Contract Comments")
                {
                    Caption = 'Contract Comments';
                    Image = TaskList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50119;
                                    RunPageLink = No.=FIELD(No.);
                    RunPageView = SORTING(No.,Line No.);
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Customer.RESET;
        Customer.SETRANGE(Customer."No.","No.");
        IF Customer.FINDFIRST THEN
        BEGIN
          CustLedgerEntry.RESET;
          CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.",Customer."No.");
          CustLedgerEntry.SETRANGE(CustLedgerEntry."Document Type",CustLedgerEntry."Document Type"::Invoice);
          //CustLedgerEntry.SETRANGE();
          IF CustLedgerEntry.FINDLAST THEN
          BEGIN
           CustLedgerEntry.CALCFIELDS(CustLedgerEntry.Amount,CustLedgerEntry."Remaining Amount");
           Customer."Last Accounting Date":=CustLedgerEntry."Posting Date";
           Customer.Facture:=CustLedgerEntry."Document No.";
           Customer.Montant:=CustLedgerEntry.Amount;
           Customer."Montant ouvert":=CustLedgerEntry."Remaining Amount";
        
        //START T-00738
           IF Customer."Fréquence de facturation"=Customer."Fréquence de facturation"::"12 mois" THEN
             Customer."Date de prochaine facturation":=   CALCDATE('<+12M>',CustLedgerEntry."Posting Date");
           IF Customer."Fréquence de facturation"=Customer."Fréquence de facturation"::"6 mois" THEN
            Customer."Date de prochaine facturation":=   CALCDATE('<+6M>',CustLedgerEntry."Posting Date");
           IF Customer."Fréquence de facturation"=Customer."Fréquence de facturation"::"4 mois" THEN
            Customer."Date de prochaine facturation":=   CALCDATE('<+4M>',CustLedgerEntry."Posting Date");
           IF Customer."Fréquence de facturation"=Customer."Fréquence de facturation"::"3 mois" THEN
            Customer."Date de prochaine facturation":=   CALCDATE('<+3M>',CustLedgerEntry."Posting Date");
           IF Customer."Fréquence de facturation"=Customer."Fréquence de facturation"::" " THEN
             Customer."Date de prochaine facturation":=   CALCDATE('<+0M>',CustLedgerEntry."Posting Date");
        //STOP T-00738
           Customer."Nbre jour avant proch. fact.":=Customer."Date de prochaine facturation"-TODAY;
          END;
        IF Customer."Date de fin PA"<TODAY THEN
        Customer."Statut PA":=Customer."Statut PA"::Échu;
        IF Customer."Date de fin SSA"<TODAY THEN
        Customer."Statut SSA":=Customer."Statut SSA"::Échu;
        
        //START T-00767
        IF Customer."Period of denunciation"<TODAY THEN
        Customer."Denunciation to analyze":=TRUE
        ELSE
        Customer."Denunciation to analyze":=FALSE;
        //STOP T-00767
        
        Editablefield:=FALSE;
        IF "Denunciation Replanned" THEN
        BEGIN
           Editablefield:=TRUE;
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

        IF ("Denunciation Replanned")AND ("Period of denunciation"<>0D) THEN
        BEGIN
         "Denunciation Replanned":=FALSE;
         MODIFY;
        END;
         //STOP T-00767
    end;

    var
        DocumentLine: Record "50008";
        DocumentContrat: Page "50075";
                             Customer: Record "18";
                             CustLedgerEntry: Record "21";
                             SalesInvoiceHeader: Record "112";
                             Editablefield: Boolean;
                             PDimensionValue: Page "560";
                             DimensionValue_Rec: Record "349";
                             CustSalesLCY: array [4] of Decimal;
                             CustDateFilter: array [4] of Text[30];
                             i: Integer;
                             Text001: Label 'Sales (LCY)';
        CustLedgerEntry2: Record "21";
        DateFilter1: Text;
        DateFilter2: Text;
        DateFilter3: Text;
}

