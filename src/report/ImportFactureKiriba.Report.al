report 50042 "DEL Import Facture Kiriba" //TODO
{
    //     ProcessingOnly = true;

    //     dataset
    //     {
    //     }

    //     requestpage
    //     {
    //         layout
    //         {
    //         }

    //         actions
    //         {
    //         }
    //     }

    //     labels
    //     {
    //     }

    //     trigger OnPostReport()
    //     begin

    //         GenJournalLine2.SETRANGE("Journal Template Name", 'RÈGLEMENTS');
    //         GenJournalLine2.SETRANGE("Journal Batch Name", 'IMP-KIRIBA');
    //         IF GenJournalLine2.FINDFIRST THEN BEGIN
    //             REPEAT
    //                //TODO PaymentToleranceMgt.SetBatchMode(TRUE);
    //                 CustLedgEntry2.SETCURRENTKEY("Document No.");
    //                 CustLedgEntry2.SETRANGE("Document No.", GenJournalLine2."Applies-to Doc. No.");
    //                 CustLedgEntry2.SETRANGE("Customer No.", GenJournalLine2."Account No.");
    //                 CustLedgEntry2.SETRANGE(Open, TRUE);
    //                 IF CustLedgEntry2.FIND('-') THEN
    //                     IF CustLedgEntry2."Amount to Apply" = 0 THEN BEGIN
    //                         CustLedgEntry2.CALCFIELDS("Remaining Amount");
    //                         CustLedgEntry2."Amount to Apply" := CustLedgEntry2."Remaining Amount";
    //                         CODEUNIT.RUN(CODEUNIT::"Cust. Entry-Edit", CustLedgEntry2);
    //                     END;

    //                 PaymentToleranceMgt.PmtTolGenJnl(GenJournalLine2);
    //             UNTIL GenJournalLine2.NEXT = 0;
    //         END;
    //         IF ErrInvG <> '' THEN
    //             MESSAGE(ErrText + ErrInvG);
    //     end;

    //     //TODO trigger OnPreReport()
    //     // var
    //     //     NewTrmt: Integer;
    //     // begin
    //     //     SalesReceivablesSetup.GET();


    //     //     SFTP.DowlodSFTPFiles(SalesReceivablesSetup."DEL Host Serveur SFTP Kiriba", SalesReceivablesSetup."DEL Port Serveur SFTP Kiriba", SalesReceivablesSetup."DEL Kiriba SFTP Server Login",
    //     //     SalesReceivablesSetup."DEL Kiriba SFTP Server Password", SalesReceivablesSetup."DEL Kiriba SFTP Server Address", SalesReceivablesSetup."DEL Kiriba Local File Path", TRUE);

    //     //     FileRec.SETRANGE(Path, SalesReceivablesSetup."DEL Kiriba Local File Path");
    //     //     FileRec.SETRANGE(FileRec."Is a file", TRUE);
    //     //     GenJournalLine2.SETRANGE("Journal Template Name", 'RÈGLEMENTS');
    //     //     GenJournalLine2.SETRANGE("Journal Batch Name", 'IMP-KIRIBA');
    //     //     IF GenJournalLine2.FINDSET THEN
    //     //         ERROR(Text001);//New DEL.SAZ (Demande JAP)

    //     //  TODO   IF FileRec.FIND('-') THEN
    //     //         REPEAT
    //     //             sNewPath := '';

    //     //             //sNewPath:= 'D:\Delphisoft\ImportPayKiriba\Facture.csv';
    //     //             sNewPath := FileRec.Path + '\' + FileRec.Name;

    //     //             //** choix d'importer directeent dans la feuille pour que si erreur il fait un arret total avec roll bac (feuille doit être équilibré)
    //     //             //TODO IF EXISTS(sNewPath) THEN BEGIN

    //     //             //     NewTrmt := CreateNewTreatment();

    //     //             //     import(sNewPath, ';', NewTrmt);


    //     //             //     COMMIT;

    //     //             //     InsertFactureAvoirjournal(NewTrmt);
    //     //             //     FILE.COPY(sNewPath, SalesReceivablesSetup."DEL Kiriba Archive File Path" + FileRec.Name + FORMAT(TODAY(), 0, '<Year4><Month,2><Day,2>'));
    //     //             //     DeleteFile(sNewPath);
    //     //             // END;

    //     //         UNTIL FileRec.NEXT = 0;
    //     // end;

    //     var
    //       //TODO  ConnectionFTP: Report "Connection FTP";
    //         SalesReceivablesSetup: Record "Sales & Receivables Setup";
    //         WTAB: Char;
    //         fileReadG: File;
    //         fileNameG: Text[1024];
    //         FileManagement: Codeunit "File Management";
    //         ServerFileName: Text;
    //         sNewPath: Text;
    //         CustLedgerEntry: Record "Cust. Ledger Entry";
    //         InvoiceNo: Code[20];
    //         RefNo: Text;
    //         CustLedgerEntry_Rec: Record "Cust. Ledger Entry";
    //         PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
    //         CustLedgEntry2: Record "Cust. Ledger Entry";
    //         GenJournalLine2: Record "Gen. Journal Line";
    //         // SFTP: DotNet SFTP; TODO
    //         // FileRec: Record File; //
    //         DayC: Integer;
    //         MonthC: Integer;
    //         YearC: Integer;
    //         DayF: Integer;
    //         MonthF: Integer;
    //         YearF: Integer;
    //         BackPath: Text;
    //         GenJournalLine3: Record "Gen. Journal Line";
    //         LineNoJ: Integer;
    //         GenJournalBatch: Record "Gen. Journal Batch";
    //         NoSeriesMgt: Codeunit NoSeriesManagement;
    //        //TODO SFTP2: DotNet SFTP;
    //         Text001: Label 'You must have emptied the IMP-KIRIBA entry sheet';
    //         ErrText: Label 'Le fichier contient des erreurs:';
    //         ErrInvG: Text;
    //         LineNoInc: Integer;


    //     procedure import(filenameP: Text[1024]; separatorP: Text[1]; pNewTrmt: Integer)
    //     var
    //         lineL: Text[1024];
    //         tblL: array[1000] of Text[1024];
    //         fileReadL: File;
    //         IntIteration: Integer;
    //         TempKiriba1: Record "DEL Temp Kiriba";
    //         TempKiriba2: Record "DEL Temp Kiriba";
    //     begin
    //         IntIteration := 0;
    //         ServerFileName := filenameP;
    //         //TODO IF fileReadL.OPEN(ServerFileName) THEN
    //         //     fileReadL.TEXTMODE := TRUE;
    //         LineNoInc := 1;//SAZ 29.04.19
    //         //TODO WHILE fileReadL.READ(lineL) > 0 DO BEGIN
    //         //     //IF IntIteration > 0 THEN BEGIN
    //         //     breakApart(lineL, separatorP, tblL);
    //         //     importFactureAvoir(tblL, pNewTrmt);
    //         //     LineNoInc := LineNoInc + 1;



    //         // END;


    //         TempKiriba1.SETRANGE("No Traitement", pNewTrmt);
    //         IF TempKiriba1.FINDSET THEN BEGIN
    //             REPEAT
    //                 TempKiriba2.SETRANGE("No Traitement", pNewTrmt);
    //                 TempKiriba2.SETRANGE("N° facture fournisseur", TempKiriba1."N° facture fournisseur");
    //                 IF TempKiriba2.FINDSET THEN
    //                     REPEAT
    //                         TempKiriba2.Erreur := 'Facture ' + TempKiriba2."N° facture fournisseur" + ' existe déja';
    //                         TempKiriba2.MODIFY;
    //                     UNTIL TempKiriba2.NEXT = 0;
    //             UNTIL TempKiriba1.NEXT = 0;
    //         END;
    //        //TODO fileReadL.CLOSE();
    //     end;

    //     local procedure importFactureAvoir(var tblP: array[1000] of Text[1024]; pNewTrmt: Integer)
    //     var
    //         VAR_COMP: Text[30];
    //         VAR_REFNO: Text[30];
    //         VAR_RNLINE: Text[30];
    //         VAR_TYPE: Text[30];
    //         VAR_CUR: Text[30];
    //         VAR_RTYPE: Text[30];
    //         VAR_BUAMTVOT: Text[30];
    //         VAR_VATCO: Text[30];
    //         VAR_VATMU: Text[30];
    //         VAR_CUR2: Text[30];
    //         VAR_ACTYPE: Text[30];
    //         VAR_ACNO: Text[30];
    //         VAR_lib1: Text[30];
    //         VAR_lib2: Text[30];
    //         VAR_lib3: Text[30];
    //         VAR_lib4: Text[30];
    //         VAR_lib5: Text[30];
    //         "VAR_END$": Text[30];
    //         nRecord: Integer;
    //         decLineAmountTTC: Decimal;
    //         decLineAmountNet: Decimal;
    //         decLineVATAmount: Decimal;
    //         decVATPrct: Decimal;
    //         "--- Record ---": Integer;
    //         recCustomer: Record Customer;
    //         "--- Report ---": Integer;
    //         VAR_Axe: Text[30];
    //         VAR_vendeur: Text;
    //         VAR_conseiller: Text;
    //         VAR_Titre: Text[30];
    //         VAR_ORDNO: Text;
    //         VAR_DateCompta: Text;
    //         VAR_DateDoc: Text;
    //         VAR_DateEche: Text;
    //         VAR_CUS: Text;
    //         VAT_Nature: Text;
    //         VAR_Des: Text;
    //         VAR_MntHT: Text[30];
    //         VAR_MntTVA: Text[30];
    //         VAR_Secteurcode: Text[100];
    //         VAR_Clientcode: Text;
    //         VAR_TauxdeTVA: Text;
    //         VAR_CodeTVA: Text;
    //         GenJournalLine: Record "Gen. Journal Line";
    //         GenJournalLine2: Record "Gen. Journal Line";
    //         TauxTva: Decimal;
    //         GLAccount: Record "G/L Account";
    //         VAR_EmplName: Text[100];
    //         ErrAxeSect: Text;
    //         ErrAxeEmp: Text;
    //         ErrTxt: Label 'Err Axe %1 %2';
    //         CodeSectSal: Text[50];
    //         VAR_Fournisseur: Text;
    //         VAR_Devise: Text;
    //         VAR_DateFacture: Text;
    //         VAR_FactFour: Text;
    //         VAR_CycledeNetting: Text;
    //         VAR_Typededocument: Text;
    //         TempKiriba: Record "DEL Temp Kiriba";
    //         TempKiriba_Rec: Record "DEL Temp Kiriba";
    //         ErreurInv: Text;
    //     begin
    //         // VAR ASSIGNATION
    //         VAR_Clientcode := tblP[1];
    //         VAR_Fournisseur := tblP[2];
    //         VAR_Devise := tblP[3];
    //         VAR_MntHT := tblP[4];
    //         VAR_DateFacture := tblP[5];
    //         VAR_DateCompta := tblP[6];
    //         VAR_FactFour := tblP[7];
    //         VAR_CycledeNetting := tblP[8];
    //         VAR_Typededocument := tblP[9];
    //         VAR_lib1 := tblP[10];
    //         VAR_lib2 := tblP[11];
    //         VAR_lib3 := tblP[12];
    //         VAR_lib4 := tblP[13];
    //         VAR_lib5 := tblP[14];

    //         ErreurInv := '';
    //         TempKiriba_Rec.RESET;
    //         TempKiriba_Rec.SETRANGE("N° facture fournisseur", VAR_FactFour);
    //         IF TempKiriba_Rec.FINDFIRST THEN BEGIN
    //             ErreurInv := 'Facture ' + VAR_FactFour + ' existe déja';
    //             ErrInvG := ErrInvG + ' ' + VAR_FactFour;
    //         END;

    //         decLineAmountNet := 0;
    //         IF VAR_MntHT <> '' THEN
    //             EVALUATE(decLineAmountNet, VAR_MntHT);

    //         decLineAmountNet := ROUND(decLineAmountNet);

    //         WITH TempKiriba DO BEGIN
    //             INIT;

    //             DayC := 0;
    //             MonthC := 0;
    //             YearC := 0;

    //             IF (VAR_DateCompta <> '') AND (STRLEN(VAR_DateCompta) > 5) THEN BEGIN
    //                 EVALUATE(DayC, COPYSTR(VAR_DateCompta, 7, 2));
    //                 EVALUATE(MonthC, COPYSTR(VAR_DateCompta, 5, 2));
    //                 EVALUATE(YearC, COPYSTR(VAR_DateCompta, 1, 4));
    //                 "Date compta" := DMY2DATE(DayC, MonthC, YearC);
    //             END;
    //             DayC := 0;
    //             MonthC := 0;
    //             YearC := 0;

    //             IF (VAR_DateFacture <> '') AND (STRLEN(VAR_DateFacture) > 5) THEN BEGIN

    //                 EVALUATE(DayC, COPYSTR(VAR_DateFacture, 7, 2));
    //                 EVALUATE(MonthC, COPYSTR(VAR_DateFacture, 5, 2));
    //                 EVALUATE(YearC, COPYSTR(VAR_DateFacture, 1, 4));
    //                 "Date facture" := DMY2DATE(DayC, MonthC, YearC);

    //             END;


    //             Devise := VAR_Devise;

    //             Client := VAR_Clientcode;
    //             Fournisseur := VAR_Fournisseur;
    //             "Cycle de netting" := VAR_CycledeNetting;
    //             "Champ libre 1" := VAR_lib1;
    //             "Champ libre 2" := VAR_lib2;
    //             "Champ libre 3" := VAR_lib3;

    //             EVALUATE("Type de document", VAR_Typededocument);

    //             "N° facture fournisseur" := VAR_FactFour;
    //             Erreur := ErreurInv;
    //             VALIDATE(Montant, decLineAmountNet);


    //             "No Traitement" := pNewTrmt;
    //             LineNo := LineNoInc; 
    //             INSERT(TRUE);

    //         END;
    //     end;

    //     local procedure breakApart(lineP: Text[1024]; separatorP: Text[1]; var tblP: array[1000] of Text)
    //     var
    //         lastStartL: Integer;
    //         i: Integer;
    //         sectionL: Integer;
    //     begin
    //         lastStartL := 1;
    //         FOR i := 1 TO 100 DO
    //             tblP[i] := '';

    //         FOR i := 1 TO STRLEN(lineP) DO BEGIN
    //             IF FORMAT(lineP[i]) = separatorP THEN BEGIN
    //                 sectionL += 1;
    //                 IF i - lastStartL > 0 THEN
    //                     tblP[sectionL] := COPYSTR(lineP, lastStartL, i - lastStartL);
    //                 lastStartL := i + 1;
    //             END
    //             //SAZ Lire dernier colonne
    //             ELSE
    //                 IF i = STRLEN(lineP) THEN
    //                     tblP[sectionL + 1] := COPYSTR(lineP, lastStartL, STRLEN(lineP));
    //         END;
    //     end;

    //     procedure BackupFile(pPath: Text[1024])
    //     var
    //         lFile: File;
    //         newPath: Text[1024];
    //         lPath: Text[1024];
    //         iLength: Integer;
    //     begin
    //         lPath := pPath;
    //         WHILE STRPOS(lPath, '\') <> 0 DO BEGIN
    //             lPath := COPYSTR(lPath, STRPOS(lPath, '\') + 1);
    //             iLength += STRPOS(lPath, '\')
    //         END;

    //         newPath += COPYSTR(pPath, 1, iLength + 3);

    //         newPath += 'BACKUP\' + FORMAT(TODAY(), 0, '<Year4><Month,2><Day,2>') + lPath;
    //         SLEEP(5000);
    //     //TODO     IF COPY(pPath, newPath) THEN;
    //     // end;


    //     //TODO procedure DeleteFile(pPath: Text[1024])
    //     // begin
    //     //     ERASE(pPath);
    //     // end;

    //     procedure CreateNewTreatment() NewTrmt: Integer
    //     var
    //         Traitement: Record "DEL Historique import Kiriba";
    //     begin
    //         //Création nouveau traitement
    //         IF Traitement.FINDLAST THEN
    //             NewTrmt := Traitement."No traitement" + 1
    //         ELSE
    //             NewTrmt := 1;

    //         Traitement.INIT;
    //         Traitement."No traitement" := NewTrmt;
    //         Traitement.Date := TODAY;
    //         Traitement.Heure := TIME;
    //         //Traitement.Type := Traitement.Type::InvoiceCreditMemo;
    //         Traitement.INSERT;
    //     end;

    //     local procedure InsertFactureAvoirjournal(pNewTrmt: Integer)
    //     var
    //         VAR_COMP: Text[30];
    //         VAR_REFNO: Text[30];
    //         VAR_RNLINE: Text[30];
    //         VAR_TYPE: Text[30];
    //         VAR_CUR: Text[30];
    //         VAR_RTYPE: Text[30];
    //         VAR_BUAMTVOT: Text[30];
    //         VAR_VATCO: Text[30];
    //         VAR_VATMU: Text[30];
    //         VAR_CUR2: Text[30];
    //         VAR_ACTYPE: Text[30];
    //         VAR_ACNO: Text[30];
    //         VAR_lib1: Text[30];
    //         VAR_lib2: Text[30];
    //         VAR_lib3: Text[30];
    //         VAR_lib4: Text[30];
    //         VAR_lib5: Text[30];
    //         "VAR_END$": Text[30];
    //         nRecord: Integer;
    //         decLineAmountTTC: Decimal;
    //         decLineAmountNet: Decimal;
    //         decLineVATAmount: Decimal;
    //         decVATPrct: Decimal;
    //         "--- Record ---": Integer;
    //         recCustomer: Record Customer;
    //         "--- Report ---": Integer;
    //         VAR_Axe: Text[30];
    //         VAR_vendeur: Text;
    //         VAR_conseiller: Text;
    //         VAR_Titre: Text[30];
    //         VAR_ORDNO: Text;
    //         VAR_DateCompta: Text;
    //         VAR_DateDoc: Text;
    //         VAR_DateEche: Text;
    //         VAR_CUS: Text;
    //         VAT_Nature: Text;
    //         VAR_Des: Text;
    //         VAR_MntHT: Text[30];
    //         VAR_MntTVA: Text[30];
    //         VAR_Secteurcode: Text[100];
    //         VAR_Clientcode: Text;
    //         VAR_TauxdeTVA: Text;
    //         VAR_CodeTVA: Text;
    //         GenJournalLine: Record "Gen. Journal Line";
    //         GenJournalLine2: Record "Gen. Journal Line";
    //         TauxTva: Decimal;
    //         GLAccount: Record "G/L Account";
    //         VAR_EmplName: Text[100];
    //         ErrAxeSect: Text;
    //         ErrAxeEmp: Text;
    //         ErrTxt: Label 'Err Axe %1 %2';
    //         CodeSectSal: Text[50];
    //         VAR_Fournisseur: Text;
    //         VAR_Devise: Text;
    //         VAR_DateFacture: Text;
    //         VAR_FactFour: Text;
    //         VAR_CycledeNetting: Text;
    //         VAR_Typededocument: Text;
    //         TempKiriba: Record "DEL Temp Kiriba";
    //     begin
    //         // VAR ASSIGNATION
    //         LineNoJ := 0;
    //         GenJournalLine3.SETRANGE("Journal Template Name", 'RÈGLEMENTS');
    //         GenJournalLine3.SETRANGE("Journal Batch Name", 'IMP-KIRIBA');
    //         IF GenJournalLine3.FINDLAST THEN
    //             LineNoJ := GenJournalLine3."Line No.";

    //         TempKiriba.SETRANGE("No Traitement", pNewTrmt);

    //         IF TempKiriba.FINDSET THEN BEGIN
    //             REPEAT

    //                 WITH GenJournalLine DO BEGIN
    //                     INIT;
    //                     LineNoJ := LineNoJ + 10000;
    //                     VALIDATE("Journal Template Name", 'RÈGLEMENTS');
    //                     VALIDATE("Journal Batch Name", 'IMP-KIRIBA');
    //                     VALIDATE("Line No.", LineNoJ);
    //                     VALIDATE("Posting Date", TempKiriba."Date compta");

    //                     //Journal Template Name,Name
    //                     IF GenJournalBatch.GET('RÈGLEMENTS', 'IMP-KIRIBA') THEN BEGIN
    //                         CLEAR(NoSeriesMgt);
    //                         "Document No." := NoSeriesMgt.GetNextNo(GenJournalBatch."No. Series", TempKiriba."Date compta", TRUE);
    //                         VALIDATE("Bal. Account Type", "Bal. Account Type"::"G/L Account");
    //                         VALIDATE("Bal. Account No.", GenJournalBatch."Bal. Account No.");
    //                     END;


    //                     IF TempKiriba.Montant > 0 THEN
    //                         VALIDATE("Document Type", "Document Type"::Payment)
    //                     ELSE
    //                         VALIDATE("Document Type", "Document Type"::Refund);

    //                     Description := 'Client ' + TempKiriba.Client + ' Facture/Avoir ' + TempKiriba."N° facture fournisseur";




    //                     VALIDATE("Currency Code", TempKiriba.Devise);
    //                     VALIDATE(Amount, -TempKiriba.Montant);

    //                     INSERT(TRUE);

    //                     CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
    //                     CustLedgerEntry.SETRANGE("Document No.", TempKiriba."N° facture fournisseur");
    //                     CustLedgerEntry.SETRANGE(Open, TRUE);
    //                     IF CustLedgerEntry.FINDFIRST THEN BEGIN
    //                         VALIDATE("Account Type", "Account Type"::Customer);
    //                         VALIDATE("Account No.", CustLedgerEntry."Customer No.");
    //                         VALIDATE("Applies-to Doc. Type", "Applies-to Doc. Type"::Invoice);
    //                         VALIDATE("Applies-to Doc. No.", TempKiriba."N° facture fournisseur");
    //                         Description := TempKiriba.Client + ' ' + TempKiriba."N° facture fournisseur";
    //                     END ELSE BEGIN 
    //                         CustLedgerEntry.RESET;
    //                         CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
    //                         CustLedgerEntry.SETRANGE("Document No.", '0' + TempKiriba."N° facture fournisseur");
    //                         CustLedgerEntry.SETRANGE(Open, TRUE);
    //                         IF CustLedgerEntry.FINDFIRST THEN BEGIN
    //                             VALIDATE("Account Type", "Account Type"::Customer);
    //                             VALIDATE("Account No.", CustLedgerEntry."Customer No.");
    //                             VALIDATE("Applies-to Doc. Type", "Applies-to Doc. Type"::Invoice);
    //                             VALIDATE("Applies-to Doc. No.", '0' + TempKiriba."N° facture fournisseur");
    //                             Description := TempKiriba.Client + ' ' + TempKiriba."N° facture fournisseur";
    //                         END
    //                     END;
    //                     MODIFY;
    //                     CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::"Credit Memo");
    //                     CustLedgerEntry.SETRANGE("Document No.", TempKiriba."N° facture fournisseur");
    //                     CustLedgerEntry.SETRANGE(Open, TRUE);
    //                     IF CustLedgerEntry.FINDFIRST THEN BEGIN
    //                         VALIDATE("Account Type", "Account Type"::Customer);
    //                         VALIDATE("Account No.", CustLedgerEntry."Customer No.");
    //                         VALIDATE("Applies-to Doc. Type", "Applies-to Doc. Type"::"Credit Memo");
    //                         VALIDATE("Applies-to Doc. No.", TempKiriba."N° facture fournisseur");
    //                         Description := TempKiriba.Client + ' ' + TempKiriba."N° facture fournisseur";
    //                     END;
    //                     MODIFY;

    //                 END;

    //             UNTIL TempKiriba.NEXT = 0;
    //         END;
    //     end;
    // }

}