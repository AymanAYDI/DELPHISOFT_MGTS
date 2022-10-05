codeunit 50035 "DEL Update FCY On G/L Entry"
{
    Permissions = TableData "G/L Entry" = rim;

    trigger OnRun()
    var
        baLedgerEntry_Re_Loc: Record "Bank Account Ledger Entry";
        currExRate_Re_loc: Record "Currency Exchange Rate";
        custLedgerEntry_Re_Loc: Record "Cust. Ledger Entry";
        GLAccount_Re_Loc: Record "G/L Account";
        GLEntry2_Re_Loc: Record "G/L Entry";
        GLEntry3_Re_Loc: Record "G/L Entry";
        glEntry_Re_Loc: Record "G/L Entry";
        vendorLedgerEntry_Re_Loc: Record "Vendor Ledger Entry";
        Currency2_Co_Loc: Code[10];
        currency_Co_Loc: Code[10];
        amount_Dec_Loc: Decimal;
        factor_Dec_Loc: Decimal;
    begin
        IF CONFIRM('Voulez-vous exécuter la fonction ?', TRUE) THEN BEGIN          //grc01
                                                                                   //rapporte les montants FCY depuis les écritures détaillées des ledger entries sur la T17

            //sur T17, remise à zéro des champs touchés par le batch
            glEntry_Re_Loc.RESET();
            // LOCO/ChC -
            // THM
            // old glEntry_Re_Loc.SETRANGE("Posting Date", CALCDATE('<-4M>',WORKDATE), WORKDATE);
            glEntry_Re_Loc.SETRANGE("Posting Date", CALCDATE('<-5M>', WORKDATE()), WORKDATE());
            // THM
            glEntry_Re_Loc.MODIFYALL("DEL Initial Amount (FCY)", 0);
            glEntry_Re_Loc.MODIFYALL("DEL Initial Currency (FCY)", '');
            /*
            IF glEntry_Re_Loc.findfirst THEN
              REPEAT
                glEntry_Re_Loc."DEL Initial Amount (FCY)" := 0;
                glEntry_Re_Loc."DEL Initial Currency (FCY)" := '';
                glEntry_Re_Loc.MODIFY();
              UNTIL(glEntry_Re_Loc.NEXT()=0);
            */
            // LOCO/ChC -

            //toutes les G/L Entries de Source Type différent de vide
            // LOCO/ChC -
            //glEntry_Re_Loc.RESET();
            // LOCO/ChC +

            IF glEntry_Re_Loc.FINDFIRST() THEN
                REPEAT
                    CASE glEntry_Re_Loc."Source Type" OF
                        glEntry_Re_Loc."Source Type"::Customer:

                            IF custLedgerEntry_Re_Loc.GET(glEntry_Re_Loc."Entry No.") THEN BEGIN
                                custLedgerEntry_Re_Loc.CALCFIELDS(Amount);
                                currency_Co_Loc := custLedgerEntry_Re_Loc."Currency Code";
                                //START CHG01
                                factor_Dec_Loc := custLedgerEntry_Re_Loc."Original Currency Factor";
                                //factor_Dec_Loc := currExRate_Re_loc.ExchangeRate(custLedgerEntry_Re_Loc."Posting Date", currency_Co_Loc);
                                //STOP CHG01
                                amount_Dec_Loc := custLedgerEntry_Re_Loc.Amount;
                                updateGLEntry(glEntry_Re_Loc, amount_Dec_Loc, currency_Co_Loc, factor_Dec_Loc);
                            END;

                        glEntry_Re_Loc."Source Type"::Vendor:

                            IF vendorLedgerEntry_Re_Loc.GET(glEntry_Re_Loc."Entry No.") THEN BEGIN
                                vendorLedgerEntry_Re_Loc.CALCFIELDS(Amount);
                                currency_Co_Loc := vendorLedgerEntry_Re_Loc."Currency Code";
                                //START CHG01
                                factor_Dec_Loc := vendorLedgerEntry_Re_Loc."Original Currency Factor";
                                //factor_Dec_Loc := currExRate_Re_loc.ExchangeRate(vendorLedgerEntry_Re_Loc."Posting Date", currency_Co_Loc);
                                //STOP CHG01
                                amount_Dec_Loc := vendorLedgerEntry_Re_Loc.Amount;
                                updateGLEntry(glEntry_Re_Loc, amount_Dec_Loc, currency_Co_Loc, factor_Dec_Loc);
                            END;

                        glEntry_Re_Loc."Source Type"::"Bank Account":

                            IF baLedgerEntry_Re_Loc.GET(glEntry_Re_Loc."Entry No.") THEN BEGIN
                                currency_Co_Loc := baLedgerEntry_Re_Loc."Currency Code";
                                //baLedgerEntry_Re_Loc.CALCFIELDS(Amount, "Amount (LCY)");
                                IF baLedgerEntry_Re_Loc.Amount <> 0 THEN BEGIN
                                    //START CHG01
                                    factor_Dec_Loc := baLedgerEntry_Re_Loc."Amount (LCY)" / baLedgerEntry_Re_Loc.Amount;
                                    //factor_Dec_Loc := currExRate_Re_loc.ExchangeRate(baLedgerEntry_Re_Loc."Posting Date", currency_Co_Loc);
                                    //STOP CHG01
                                END ELSE BEGIN
                                    MESSAGE('Amount is 0 on Bank Account Ledger entry >%1< and exchange rate can ' +
                                    'therefore not be calculated !', glEntry_Re_Loc."Entry No.");
                                END;

                                //factor_Dec_Loc := 1;
                                amount_Dec_Loc := baLedgerEntry_Re_Loc.Amount;
                                updateGLEntry(glEntry_Re_Loc, amount_Dec_Loc, currency_Co_Loc, factor_Dec_Loc);
                            END;
                    //dans les autres cas on ne fait rien


                    END;
                UNTIL (glEntry_Re_Loc.NEXT() = 0);

            //YAH01+
            GLAccount_Re_Loc.RESET();
            GLEntry2_Re_Loc.RESET();
            GLAccount_Re_Loc.SETFILTER("Currency Code", '<>%1', '');
            IF GLAccount_Re_Loc.FINDFIRST() THEN
                REPEAT
                    Currency2_Co_Loc := GLAccount_Re_Loc."Currency Code";
                    GLEntry2_Re_Loc.SETFILTER("G/L Account No.", GLAccount_Re_Loc."No.");
                    IF GLEntry2_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            GLEntry2_Re_Loc."DEL Initial Currency (FCY)" := Currency2_Co_Loc;
                            GLEntry2_Re_Loc."DEL Initial Amount (FCY)" := GLEntry2_Re_Loc."Amount (FCY)";
                            GLEntry2_Re_Loc.MODIFY();
                            // START STG02
                            GLEntry3_Re_Loc.SETCURRENTKEY("Document No.", "Posting Date");
                            GLEntry3_Re_Loc.SETRANGE("Document No.", GLEntry2_Re_Loc."Document No.");
                            GLEntry3_Re_Loc.SETFILTER("Entry No.", '<>%1', GLEntry2_Re_Loc."Entry No.");
                            IF GLEntry3_Re_Loc.FINDFIRST() THEN
                                REPEAT
                                    IF (GLEntry2_Re_Loc."Amount (FCY)" <> 0) THEN BEGIN
                                        factor_Dec_Loc := GLEntry2_Re_Loc.Amount / GLEntry2_Re_Loc."Amount (FCY)";
                                        GLEntry3_Re_Loc."DEL Initial Currency (FCY)" := Currency2_Co_Loc;
                                        IF (GLEntry2_Re_Loc.Amount <> 0) AND (factor_Dec_Loc <> 0) THEN
                                            GLEntry3_Re_Loc."DEL Initial Amount (FCY)" := GLEntry3_Re_Loc.Amount / factor_Dec_Loc;
                                        GLEntry3_Re_Loc.MODIFY();
                                    END;
                                UNTIL GLEntry3_Re_Loc.NEXT() = 0;
                        // STOP STG02
                        UNTIL GLEntry2_Re_Loc.NEXT() = 0;
                UNTIL GLAccount_Re_Loc.NEXT() = 0;
            //YAH01-

            MESSAGE('Mise à jour effectuée !');

        END;

    end;


    procedure updateGLEntry(var GLEntry_Re_Par: Record "G/L Entry"; Amount_Dec_Par: Decimal; Currency_Co_Par: Code[10]; Factor_Dec_Par: Decimal)
    var
        GLEntry_Re_Loc: Record "G/L Entry";
    begin
        IF Currency_Co_Par <> '' THEN BEGIN

            //update la G/L Entry en cours
            GLEntry_Re_Par."DEL Initial Amount (FCY)" := Amount_Dec_Par;
            GLEntry_Re_Par."DEL Initial Currency (FCY)" := Currency_Co_Par;
            GLEntry_Re_Par.MODIFY();

            //update toutes les G/L Entries liées
            GLEntry_Re_Loc.RESET();
            GLEntry_Re_Loc.SETCURRENTKEY("Document No.", "Posting Date");
            GLEntry_Re_Loc.SETRANGE("Document No.", GLEntry_Re_Par."Document No.");
            IF GLEntry_Re_Loc.FINDFIRST() THEN
                REPEAT

                    GLEntry_Re_Loc."DEL Initial Amount (FCY)" := GLEntry_Re_Loc.Amount * Factor_Dec_Par;
                    GLEntry_Re_Loc."DEL Initial Currency (FCY)" := Currency_Co_Par;
                    GLEntry_Re_Loc.MODIFY();

                UNTIL (GLEntry_Re_Loc.NEXT() = 0);

        END
    end;
}

