codeunit 50009 "Update FCY On G/L Entry Auto"
{
    Permissions = TableData "G/L Entry" = rim;

    trigger OnRun()
    var
        baLedgerEntry_Re_Loc: Record "Bank Account Ledger Entry";
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
        //rapporte les montants FCY depuis les écritures détaillées des ledger entries sur la T17
        //sur T17, remise à zéro des champs touchés par le batch
        glEntry_Re_Loc.RESET();
        GeneralSetup.GET();

        IF GeneralSetup."Dernier num séq maj Dev Init" <> 0 THEN
            glEntry_Re_Loc.SETFILTER("Entry No.", '>%1', GeneralSetup."Dernier num séq maj Dev Init")
        ELSE
            glEntry_Re_Loc.SETRANGE("Posting Date", CALCDATE('<-5M>', WORKDATE()), WORKDATE());
        glEntry_Re_Loc.MODIFYALL("DEL Initial Amount (FCY)", 0);
        glEntry_Re_Loc.MODIFYALL("DEL Initial Currency (FCY)", '');

        //toutes les G/L Entries de Source Type différent de vide
        IF glEntry_Re_Loc.FINDFIRST() THEN
            REPEAT
                CASE glEntry_Re_Loc."Source Type" OF
                    glEntry_Re_Loc."Source Type"::Customer:

                        IF custLedgerEntry_Re_Loc.GET(glEntry_Re_Loc."Entry No.") THEN BEGIN
                            custLedgerEntry_Re_Loc.CALCFIELDS(Amount);
                            currency_Co_Loc := custLedgerEntry_Re_Loc."Currency Code";
                            factor_Dec_Loc := custLedgerEntry_Re_Loc."Original Currency Factor";
                            amount_Dec_Loc := custLedgerEntry_Re_Loc.Amount;
                            updateGLEntry(glEntry_Re_Loc, amount_Dec_Loc, currency_Co_Loc, factor_Dec_Loc);
                        END;
                    glEntry_Re_Loc."Source Type"::Vendor:

                        IF vendorLedgerEntry_Re_Loc.GET(glEntry_Re_Loc."Entry No.") THEN BEGIN
                            vendorLedgerEntry_Re_Loc.CALCFIELDS(Amount);
                            currency_Co_Loc := vendorLedgerEntry_Re_Loc."Currency Code";
                            factor_Dec_Loc := vendorLedgerEntry_Re_Loc."Original Currency Factor";
                            amount_Dec_Loc := vendorLedgerEntry_Re_Loc.Amount;
                            updateGLEntry(glEntry_Re_Loc, amount_Dec_Loc, currency_Co_Loc, factor_Dec_Loc);
                        END;
                    glEntry_Re_Loc."Source Type"::"Bank Account":

                        IF baLedgerEntry_Re_Loc.GET(glEntry_Re_Loc."Entry No.") THEN BEGIN
                            currency_Co_Loc := baLedgerEntry_Re_Loc."Currency Code";
                            IF baLedgerEntry_Re_Loc.Amount <> 0 THEN
                                factor_Dec_Loc := baLedgerEntry_Re_Loc."Amount (LCY)" / baLedgerEntry_Re_Loc.Amount;
                            amount_Dec_Loc := baLedgerEntry_Re_Loc.Amount;
                            updateGLEntry(glEntry_Re_Loc, amount_Dec_Loc, currency_Co_Loc, factor_Dec_Loc);
                        END;
                //dans les autres cas on ne fait rien
                END;
                LastEntyModify := glEntry_Re_Loc."Entry No.";
            UNTIL (glEntry_Re_Loc.NEXT() = 0);

        IF LastEntyModify <> 0 THEN BEGIN
            GeneralSetup."Dernier num séq maj Dev Init" := LastEntyModify;
            GeneralSetup.MODIFY();
        END;

        GLAccount_Re_Loc.RESET();
        GLEntry2_Re_Loc.RESET();
        GLAccount_Re_Loc.SETFILTER("Currency Code", '<>%1', '');
        IF GLAccount_Re_Loc.FindSet() THEN
            REPEAT
                Currency2_Co_Loc := GLAccount_Re_Loc."Currency Code";
                GLEntry2_Re_Loc.SETFILTER("G/L Account No.", GLAccount_Re_Loc."No.");
                IF GLEntry2_Re_Loc.FINDFIRST() THEN
                    REPEAT
                        GLEntry2_Re_Loc."DEL Initial Currency (FCY)" := Currency2_Co_Loc;
                        GLEntry2_Re_Loc."DEL Initial Amount (FCY)" := GLEntry2_Re_Loc."Amount (FCY)";
                        GLEntry2_Re_Loc.MODIFY();
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
                    UNTIL GLEntry2_Re_Loc.NEXT() = 0;
            UNTIL GLAccount_Re_Loc.NEXT() = 0;

    end;

    var
        GeneralSetup: Record "DEL General Setup";
        LastEntyModify: Integer;

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

