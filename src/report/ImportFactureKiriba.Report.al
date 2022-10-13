report 50042 "Import Facture Kiriba"
{
    // -------------------------------------------------------------------------------------------------
    // www.delphisoft.ch
    // -------------------------------------------------------------------------------------------------
    // CBO: 26/11/2019 - [DEV261119] : - Add New Code in Trigger
    //                                   import()
    // -------------------------------------------------------------------------------------------------

    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        //DEL.SAZ 20.09.2018
        GenJournalLine2.SETRANGE("Journal Template Name", 'RÈGLEMENTS');
        GenJournalLine2.SETRANGE("Journal Batch Name", 'IMP-KIRIBA');
        IF GenJournalLine2.FINDFIRST THEN BEGIN
            REPEAT
                PaymentToleranceMgt.SetBatchMode(TRUE);
                CustLedgEntry2.SETCURRENTKEY("Document No.");
                CustLedgEntry2.SETRANGE("Document No.", GenJournalLine2."Applies-to Doc. No.");
                CustLedgEntry2.SETRANGE("Customer No.", GenJournalLine2."Account No.");
                CustLedgEntry2.SETRANGE(Open, TRUE);
                IF CustLedgEntry2.FIND('-') THEN
                    IF CustLedgEntry2."Amount to Apply" = 0 THEN BEGIN
                        CustLedgEntry2.CALCFIELDS("Remaining Amount");
                        CustLedgEntry2."Amount to Apply" := CustLedgEntry2."Remaining Amount";
                        CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit", CustLedgEntry2);
                    END;

                PaymentToleranceMgt.PmtTolGenJnl(GenJournalLine2);
                //END DEL.SAZ 20.09.2018
            UNTIL GenJournalLine2.NEXT = 0;
        END;
        //DEL.SAZ 28.03.19
        IF ErrInvG <> '' THEN
            MESSAGE(ErrText + ErrInvG);
        //END DEL.SAZ
    end;

    trigger OnPreReport()
    var
        NewTrmt: Integer;
    begin
        SalesReceivablesSetup.GET();


        SFTP.DowlodSFTPFiles(SalesReceivablesSetup."Host Serveur SFTP Kiriba", SalesReceivablesSetup."Port Serveur SFTP Kiriba", SalesReceivablesSetup."Kiriba SFTP Server Login",
        SalesReceivablesSetup."Kiriba SFTP Server Password", SalesReceivablesSetup."Kiriba SFTP Server Address", SalesReceivablesSetup."Kiriba Local File Path", TRUE);

        FileRec.SETRANGE(Path, SalesReceivablesSetup."Kiriba Local File Path");
        FileRec.SETRANGE(FileRec."Is a file", TRUE);
        GenJournalLine2.SETRANGE("Journal Template Name", 'RÈGLEMENTS');
        GenJournalLine2.SETRANGE("Journal Batch Name", 'IMP-KIRIBA');
        IF GenJournalLine2.FINDSET THEN
            //OLD SAZ 10.02.19 (Deamnde JAP) GenJournalLine2.DELETEALL;
            ERROR(Text001);//New DEL.SAZ (Demande JAP)

        IF FileRec.FIND('-') THEN
            REPEAT
                sNewPath := '';

                //sNewPath:= 'D:\Delphisoft\ImportPayKiriba\Facture.csv';
                sNewPath := FileRec.Path + '\' + FileRec.Name;

                //WTAB:=9;
                //MESSAGE(sNewPath);
                //** choix d'importer directeent dans la feuille pour que si erreur il fait un arret total avec roll bac (feuille doit être équilibré)
                IF EXISTS(sNewPath) THEN BEGIN

                    NewTrmt := CreateNewTreatment();

                    import(sNewPath, ';', NewTrmt);


                    COMMIT;

                    InsertFactureAvoirjournal(NewTrmt);
                    FILE.COPY(sNewPath, SalesReceivablesSetup."Kiriba Archive File Path" + FileRec.Name + FORMAT(TODAY(), 0, '<Year4><Month,2><Day,2>'));
                    //SLEEP(500);
                    DeleteFile(sNewPath);
                END;

            UNTIL FileRec.NEXT = 0;
    end;

    var
        ConnectionFTP: Report "50038";
        SalesReceivablesSetup: Record "311";
        WTAB: Char;
        fileReadG: File;
        fileNameG: Text[1024];
        FileManagement: Codeunit "419";
        ServerFileName: Text;
        sNewPath: Text;
        CustLedgerEntry: Record "21";
        InvoiceNo: Code[20];
        RefNo: Text;
        CustLedgerEntry_Rec: Record "21";
        PaymentToleranceMgt: Codeunit "426";
        CustLedgEntry2: Record "21";
        GenJournalLine2: Record "81";
        SFTP: DotNet SFTP;
        FileRec: Record "2000000022";
        DayC: Integer;
        MonthC: Integer;
        YearC: Integer;
        DayF: Integer;
        MonthF: Integer;
        YearF: Integer;
        BackPath: Text;
        GenJournalLine3: Record "81";
        LineNoJ: Integer;
        GenJournalBatch: Record "232";
        NoSeriesMgt: Codeunit "396";
        SFTP2: DotNet SFTP;
        Text001: Label 'You must have emptied the IMP-KIRIBA entry sheet';
        ErrText: Label 'Le fichier contient des erreurs:';
        ErrInvG: Text;
        LineNoInc: Integer;

    [Scope('Internal')]
    procedure import(filenameP: Text[1024]; separatorP: Text[1]; pNewTrmt: Integer)
    var
        lineL: Text[1024];
        tblL: array[1000] of Text[1024];
        fileReadL: File;
        IntIteration: Integer;
        TempKiriba1: Record "50065";
        TempKiriba2: Record "50065";
    begin
        IntIteration := 0;
        ServerFileName := filenameP;
        IF fileReadL.OPEN(ServerFileName) THEN
            fileReadL.TEXTMODE := TRUE;
        LineNoInc := 1;//SAZ 29.04.19
        WHILE fileReadL.READ(lineL) > 0 DO BEGIN
            //IF IntIteration > 0 THEN BEGIN
            breakApart(lineL, separatorP, tblL);
            importFactureAvoir(tblL, pNewTrmt);
            LineNoInc := LineNoInc + 1;//SAZ 29.04.19
                                       //END
                                       //  ELSE
                                       //   IntIteration += 1;
        END;
        //SAZ 29.04.19

        TempKiriba1.SETRANGE("No Traitement", pNewTrmt);
        IF TempKiriba1.FINDSET THEN BEGIN
            REPEAT
                TempKiriba2.SETRANGE("No Traitement", pNewTrmt);
                TempKiriba2.SETRANGE("N° facture fournisseur", TempKiriba1."N° facture fournisseur");
                //>>CBO: 26/11/2019 - [DEV261119]
                //IF TempKiriba2.COUNT > 1 THEN BEGIN
                IF TempKiriba2.FINDSET THEN
                    //<<CBO: 26/11/2019 - [DEV261119]
                    REPEAT
                TempKiriba2.Erreur := 'Facture ' + TempKiriba2."N° facture fournisseur" + ' existe déja';
                TempKiriba2.MODIFY;
                    UNTIL TempKiriba2.NEXT = 0;
                // END;
            UNTIL TempKiriba1.NEXT = 0;
        END;
        //END SAZ 29.04.19
        fileReadL.CLOSE();
    end;

    local procedure importFactureAvoir(var tblP: array[1000] of Text[1024]; pNewTrmt: Integer)
    var
        VAR_COMP: Text[30];
        VAR_REFNO: Text[30];
        VAR_RNLINE: Text[30];
        VAR_TYPE: Text[30];
        VAR_CUR: Text[30];
        VAR_RTYPE: Text[30];
        VAR_BUAMTVOT: Text[30];
        VAR_VATCO: Text[30];
        VAR_VATMU: Text[30];
        VAR_CUR2: Text[30];
        VAR_ACTYPE: Text[30];
        VAR_ACNO: Text[30];
        VAR_lib1: Text[30];
        VAR_lib2: Text[30];
        VAR_lib3: Text[30];
        VAR_lib4: Text[30];
        VAR_lib5: Text[30];
        "VAR_END$": Text[30];
        nRecord: Integer;
        decLineAmountTTC: Decimal;
        decLineAmountNet: Decimal;
        decLineVATAmount: Decimal;
        decVATPrct: Decimal;
        "--- Record ---": Integer;
        recCustomer: Record "18";
        "--- Report ---": Integer;
        VAR_Axe: Text[30];
        VAR_vendeur: Text;
        VAR_conseiller: Text;
        VAR_Titre: Text[30];
        VAR_ORDNO: Text;
        VAR_DateCompta: Text;
        VAR_DateDoc: Text;
        VAR_DateEche: Text;
        VAR_CUS: Text;
        VAT_Nature: Text;
        VAR_Des: Text;
        VAR_MntHT: Text[30];
        VAR_MntTVA: Text[30];
        VAR_Secteurcode: Text[100];
        VAR_Clientcode: Text;
        VAR_TauxdeTVA: Text;
        VAR_CodeTVA: Text;
        GenJournalLine: Record "81";
        GenJournalLine2: Record "81";
        TauxTva: Decimal;
        GLAccount: Record "15";
        VAR_EmplName: Text[100];
        ErrAxeSect: Text;
        ErrAxeEmp: Text;
        ErrTxt: Label 'Err Axe %1 %2';
        CodeSectSal: Text[50];
        VAR_Fournisseur: Text;
        VAR_Devise: Text;
        VAR_DateFacture: Text;
        VAR_FactFour: Text;
        VAR_CycledeNetting: Text;
        VAR_Typededocument: Text;
        TempKiriba: Record "50065";
        TempKiriba_Rec: Record "50065";
        ErreurInv: Text;
    begin
        // VAR ASSIGNATION
        VAR_Clientcode := tblP[1];
        VAR_Fournisseur := tblP[2];
        VAR_Devise := tblP[3];
        VAR_MntHT := tblP[4];
        VAR_DateFacture := tblP[5];
        VAR_DateCompta := tblP[6];
        VAR_FactFour := tblP[7];
        VAR_CycledeNetting := tblP[8];
        VAR_Typededocument := tblP[9];
        VAR_lib1 := tblP[10];
        VAR_lib2 := tblP[11];
        VAR_lib3 := tblP[12];
        VAR_lib4 := tblP[13];
        VAR_lib5 := tblP[14];

        ///DEL.SAZ 19.03.19
        ErreurInv := '';
        TempKiriba_Rec.RESET;
        TempKiriba_Rec.SETRANGE("N° facture fournisseur", VAR_FactFour);
        IF TempKiriba_Rec.FINDFIRST THEN BEGIN
            ErreurInv := 'Facture ' + VAR_FactFour + ' existe déja';
            ErrInvG := ErrInvG + ' ' + VAR_FactFour;
        END;
        //END DEL.SAZ

        decLineAmountNet := 0;
        IF VAR_MntHT <> '' THEN
            EVALUATE(decLineAmountNet, VAR_MntHT);

        decLineAmountNet := ROUND(decLineAmountNet);

        WITH TempKiriba DO BEGIN
            INIT;

            DayC := 0;
            MonthC := 0;
            YearC := 0;

            IF (VAR_DateCompta <> '') AND (STRLEN(VAR_DateCompta) > 5) THEN BEGIN
                EVALUATE(DayC, COPYSTR(VAR_DateCompta, 7, 2));
                EVALUATE(MonthC, COPYSTR(VAR_DateCompta, 5, 2));
                EVALUATE(YearC, COPYSTR(VAR_DateCompta, 1, 4));
                "Date compta" := DMY2DATE(DayC, MonthC, YearC);
            END;
            // VALIDATE("Date compta");
            DayC := 0;
            MonthC := 0;
            YearC := 0;

            IF (VAR_DateFacture <> '') AND (STRLEN(VAR_DateFacture) > 5) THEN BEGIN

                EVALUATE(DayC, COPYSTR(VAR_DateFacture, 7, 2));
                EVALUATE(MonthC, COPYSTR(VAR_DateFacture, 5, 2));
                EVALUATE(YearC, COPYSTR(VAR_DateFacture, 1, 4));
                "Date facture" := DMY2DATE(DayC, MonthC, YearC);

            END;
            //EVALUATE("Date facture",VAR_DateFacture);
            // VALIDATE("Date facture");

            Devise := VAR_Devise;

            Client := VAR_Clientcode;
            Fournisseur := VAR_Fournisseur;
            "Cycle de netting" := VAR_CycledeNetting;
            "Champ libre 1" := VAR_lib1;
            "Champ libre 2" := VAR_lib2;
            "Champ libre 3" := VAR_lib3;

            EVALUATE("Type de document", VAR_Typededocument);

            "N° facture fournisseur" := VAR_FactFour;
            //DEL.SAZ 19.03.19
            Erreur := ErreurInv;
            //END DEL.SAZ
            VALIDATE(Montant, decLineAmountNet);


            //"Type of movement" := VAR_CodeTVA ;
            "No Traitement" := pNewTrmt;
            LineNo := LineNoInc; //SAZ 29.04.19
            INSERT(TRUE);

        END;
    end;

    local procedure breakApart(lineP: Text[1024]; separatorP: Text[1]; var tblP: array[1000] of Text)
    var
        lastStartL: Integer;
        i: Integer;
        sectionL: Integer;
    begin
        lastStartL := 1;
        FOR i := 1 TO 100 DO
            tblP[i] := '';

        FOR i := 1 TO STRLEN(lineP) DO BEGIN
            IF FORMAT(lineP[i]) = separatorP THEN BEGIN
                sectionL += 1;
                IF i - lastStartL > 0 THEN
                    tblP[sectionL] := COPYSTR(lineP, lastStartL, i - lastStartL);
                lastStartL := i + 1;
            END
            //SAZ Lire dernier colonne
            ELSE
                IF i = STRLEN(lineP) THEN
                    tblP[sectionL + 1] := COPYSTR(lineP, lastStartL, STRLEN(lineP));
            //END SAZ
        END;
    end;

    [Scope('Internal')]
    procedure BackupFile(pPath: Text[1024])
    var
        lFile: File;
        newPath: Text[1024];
        lPath: Text[1024];
        iLength: Integer;
    begin
        lPath := pPath;
        WHILE STRPOS(lPath, '\') <> 0 DO BEGIN
            lPath := COPYSTR(lPath, STRPOS(lPath, '\') + 1);
            iLength += STRPOS(lPath, '\')
        END;

        newPath += COPYSTR(pPath, 1, iLength + 3);

        newPath += 'BACKUP\' + FORMAT(TODAY(), 0, '<Year4><Month,2><Day,2>') + lPath;
        //T-00078
        SLEEP(5000);
        //T-00078
        IF COPY(pPath, newPath) THEN;
    end;

    [Scope('Internal')]
    procedure DeleteFile(pPath: Text[1024])
    begin
        //MESSAGE(pPath);
        ERASE(pPath);
    end;

    [Scope('Internal')]
    procedure CreateNewTreatment() NewTrmt: Integer
    var
        Traitement: Record "50066";
    begin
        //Création nouveau traitement
        IF Traitement.FINDLAST THEN
            NewTrmt := Traitement."No traitement" + 1
        ELSE
            NewTrmt := 1;

        Traitement.INIT;
        Traitement."No traitement" := NewTrmt;
        Traitement.Date := TODAY;
        Traitement.Heure := TIME;
        //Traitement.Type := Traitement.Type::InvoiceCreditMemo;
        Traitement.INSERT;
    end;

    local procedure InsertFactureAvoirjournal(pNewTrmt: Integer)
    var
        VAR_COMP: Text[30];
        VAR_REFNO: Text[30];
        VAR_RNLINE: Text[30];
        VAR_TYPE: Text[30];
        VAR_CUR: Text[30];
        VAR_RTYPE: Text[30];
        VAR_BUAMTVOT: Text[30];
        VAR_VATCO: Text[30];
        VAR_VATMU: Text[30];
        VAR_CUR2: Text[30];
        VAR_ACTYPE: Text[30];
        VAR_ACNO: Text[30];
        VAR_lib1: Text[30];
        VAR_lib2: Text[30];
        VAR_lib3: Text[30];
        VAR_lib4: Text[30];
        VAR_lib5: Text[30];
        "VAR_END$": Text[30];
        nRecord: Integer;
        decLineAmountTTC: Decimal;
        decLineAmountNet: Decimal;
        decLineVATAmount: Decimal;
        decVATPrct: Decimal;
        "--- Record ---": Integer;
        recCustomer: Record "18";
        "--- Report ---": Integer;
        VAR_Axe: Text[30];
        VAR_vendeur: Text;
        VAR_conseiller: Text;
        VAR_Titre: Text[30];
        VAR_ORDNO: Text;
        VAR_DateCompta: Text;
        VAR_DateDoc: Text;
        VAR_DateEche: Text;
        VAR_CUS: Text;
        VAT_Nature: Text;
        VAR_Des: Text;
        VAR_MntHT: Text[30];
        VAR_MntTVA: Text[30];
        VAR_Secteurcode: Text[100];
        VAR_Clientcode: Text;
        VAR_TauxdeTVA: Text;
        VAR_CodeTVA: Text;
        GenJournalLine: Record "81";
        GenJournalLine2: Record "81";
        TauxTva: Decimal;
        GLAccount: Record "15";
        VAR_EmplName: Text[100];
        ErrAxeSect: Text;
        ErrAxeEmp: Text;
        ErrTxt: Label 'Err Axe %1 %2';
        CodeSectSal: Text[50];
        VAR_Fournisseur: Text;
        VAR_Devise: Text;
        VAR_DateFacture: Text;
        VAR_FactFour: Text;
        VAR_CycledeNetting: Text;
        VAR_Typededocument: Text;
        TempKiriba: Record "50065";
    begin
        // VAR ASSIGNATION
        LineNoJ := 0;
        GenJournalLine3.SETRANGE("Journal Template Name", 'RÈGLEMENTS');
        GenJournalLine3.SETRANGE("Journal Batch Name", 'IMP-KIRIBA');
        IF GenJournalLine3.FINDLAST THEN
            LineNoJ := GenJournalLine3."Line No.";

        TempKiriba.SETRANGE("No Traitement", pNewTrmt);

        IF TempKiriba.FINDSET THEN BEGIN
            REPEAT

                WITH GenJournalLine DO BEGIN
                    INIT;
                    LineNoJ := LineNoJ + 10000;
                    VALIDATE("Journal Template Name", 'RÈGLEMENTS');
                    VALIDATE("Journal Batch Name", 'IMP-KIRIBA');
                    VALIDATE("Line No.", LineNoJ);
                    VALIDATE("Posting Date", TempKiriba."Date compta");

                    //Journal Template Name,Name
                    //RÈGLEMENTS ,IMP-KIRIBA
                    IF GenJournalBatch.GET('RÈGLEMENTS', 'IMP-KIRIBA') THEN BEGIN
                        CLEAR(NoSeriesMgt);
                        "Document No." := NoSeriesMgt.GetNextNo(GenJournalBatch."No. Series", TempKiriba."Date compta", TRUE);
                        VALIDATE("Bal. Account Type", "Bal. Account Type"::"G/L Account");
                        VALIDATE("Bal. Account No.", GenJournalBatch."Bal. Account No.");
                    END;


                    //VALIDATE("Document Date",TempKiriba."Date facture");
                    IF TempKiriba.Montant > 0 THEN
                        VALIDATE("Document Type", "Document Type"::Payment)
                    ELSE
                        VALIDATE("Document Type", "Document Type"::Refund);

                    Description := 'Client ' + TempKiriba.Client + ' Facture/Avoir ' + TempKiriba."N° facture fournisseur";



                    //VALIDATE("Applies-to Doc. No." , TempKiriba."N° facture fournisseur");

                    VALIDATE("Currency Code", TempKiriba.Devise);
                    VALIDATE(Amount, -TempKiriba.Montant);

                    INSERT(TRUE);

                    CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                    CustLedgerEntry.SETRANGE("Document No.", TempKiriba."N° facture fournisseur");
                    CustLedgerEntry.SETRANGE(Open, TRUE);
                    IF CustLedgerEntry.FINDFIRST THEN BEGIN
                        VALIDATE("Account Type", "Account Type"::Customer);
                        VALIDATE("Account No.", CustLedgerEntry."Customer No.");
                        VALIDATE("Applies-to Doc. Type", "Applies-to Doc. Type"::Invoice);
                        VALIDATE("Applies-to Doc. No.", TempKiriba."N° facture fournisseur");
                        Description := TempKiriba.Client + ' ' + TempKiriba."N° facture fournisseur";
                    END ELSE BEGIN //DEL.SAZ 310119
                        CustLedgerEntry.RESET;
                        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                        CustLedgerEntry.SETRANGE("Document No.", '0' + TempKiriba."N° facture fournisseur");
                        CustLedgerEntry.SETRANGE(Open, TRUE);
                        IF CustLedgerEntry.FINDFIRST THEN BEGIN
                            VALIDATE("Account Type", "Account Type"::Customer);
                            VALIDATE("Account No.", CustLedgerEntry."Customer No.");
                            VALIDATE("Applies-to Doc. Type", "Applies-to Doc. Type"::Invoice);
                            VALIDATE("Applies-to Doc. No.", '0' + TempKiriba."N° facture fournisseur");
                            Description := TempKiriba.Client + ' ' + TempKiriba."N° facture fournisseur";
                        END//END DEL.SAZ
                    END;
                    MODIFY;
                    CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::"Credit Memo");
                    CustLedgerEntry.SETRANGE("Document No.", TempKiriba."N° facture fournisseur");
                    CustLedgerEntry.SETRANGE(Open, TRUE);
                    IF CustLedgerEntry.FINDFIRST THEN BEGIN
                        VALIDATE("Account Type", "Account Type"::Customer);
                        VALIDATE("Account No.", CustLedgerEntry."Customer No.");
                        VALIDATE("Applies-to Doc. Type", "Applies-to Doc. Type"::"Credit Memo");
                        VALIDATE("Applies-to Doc. No.", TempKiriba."N° facture fournisseur");
                        Description := TempKiriba.Client + ' ' + TempKiriba."N° facture fournisseur";
                    END;
                    MODIFY;

                END;

            UNTIL TempKiriba.NEXT = 0;
        END;
    end;
}

