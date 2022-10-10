codeunit 50101 "DEL MGTS_FctMgt"
{
    Procedure UpdateAllShortDimFromDimSetID(DimSetID: Integer; VAR ShortDimVal3: Code[20]; VAR ShortDimVal4: Code[20]; VAR ShortDimVal5: Code[20]; VAR ShortDimVal6: Code[20]; VAR ShortDimVal7: Code[20]; VAR ShortDimVal8: Code[20])
    var
        DimSetEntry: Record "Dimension Set Entry";
        DimMgt: Codeunit DimensionManagement;
        GLSetupShortcutDimCode: array[8] of Code[20];
    Begin
        DimMgt.GetGLSetup(GLSetupShortcutDimCode);
        ShortDimVal3 := '';
        ShortDimVal4 := '';
        ShortDimVal5 := '';
        ShortDimVal6 := '';
        ShortDimVal7 := '';
        ShortDimVal8 := '';

        IF GLSetupShortcutDimCode[3] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[3]) THEN
                ShortDimVal3 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[4] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[4]) THEN
                ShortDimVal4 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[5] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[5]) THEN
                ShortDimVal5 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[6] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[6]) THEN
                ShortDimVal6 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[7] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[7]) THEN
                ShortDimVal7 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[8] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[8]) THEN
                ShortDimVal8 := DimSetEntry."Dimension Value Code";
    End;

    procedure HasItemChargeAssignment(PurchaseHeader: Record "Purchase Header"): Boolean
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
    begin
        ItemChargeAssgntPurch.SetRange("Document Type", PurchaseHeader."Document Type");
        ItemChargeAssgntPurch.SetRange("Document No.", PurchaseHeader."No.");
        ItemChargeAssgntPurch.SetFilter("Amount to Assign", '<>%1', 0);
        exit(not ItemChargeAssgntPurch.IsEmpty);
    end;


    procedure OnBeforeCodeFct(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean)
    var

        fee_Re_Loc: Record "DEL Fee";
        genJournalLine_Re_Temp: Record "Gen. Journal Line" TEMPORARY;
        Provision_Cu: Codeunit "DEL Provision";
    begin

        IF GenJournalLine.FIND('-') THEN
            REPEAT
                genJournalLine_Re_Temp.INIT();
                genJournalLine_Re_Temp.COPY(GenJournalLine);
                genJournalLine_Re_Temp.INSERT();
            UNTIL (GenJournalLine.NEXT() = 0);

        GenJournalLine_Re_Temp.RESET();
        genJournalLine_Re_Temp.SETRANGE("Account Type", genJournalLine_Re_Temp."Account Type"::"G/L Account");
        IF genJournalLine_Re_Temp.FIND('-') THEN BEGIN
            REPEAT

                //pour les provisions, on a pas besoin de controler parce que le lien est g‚r‚ autrement..
                IF genJournalLine_Re_Temp."Journal Batch Name" <> 'PROVISION' THEN BEGIN

                    //on regarde si aucune liaison n'a ‚t‚ s‚lectionn‚e
                    genJournalLine_Re_Temp.CALCFIELDS("DEL Shipment Selection");

                    IF (genJournalLine_Re_Temp."DEL Shipment Selection" <= 0) THEN BEGIN

                        //Les No. de compte qui requiŠrent un deal shipment = ceux qui ont la case "Used for import" = true dans la table 50024 (Fee)
                        fee_Re_Loc.RESET();
                        fee_Re_Loc.SETRANGE("No compte", genJournalLine_Re_Temp."Account No.");
                        fee_Re_Loc.SETRANGE("Used For Import", TRUE);
                        //si on trouve un compte qui exige une liaison
                        IF fee_Re_Loc.FIND('-') THEN

                            //on affiche un warning : si on accepte, on continue, si on annule, alors error
                            IF (NOT DIALOG.CONFIRM('La ligne %1 (compte de frais %2) n''a pas de livraison li‚e ! Continuer ?', FALSE,
                              genJournalLine_Re_Temp."Line No.",
                              genJournalLine_Re_Temp."Account No.")) THEN
                                EXIT;



                    END;

                END;

            UNTIL (genJournalLine_Re_Temp.NEXT() = 0);

            //si des ‚critures provisions sont … valider
            genJournalLine_Re_Temp.RESET();
            genJournalLine_Re_Temp.SETRANGE("Journal Batch Name", 'PROVISION');
            IF genJournalLine_Re_Temp.FIND('-') THEN
                Provision_Cu.FNC_RunTest();

        END;
    end;

    procedure OnCodeOnAfterGenJnlPostBatchRunfct(var GenJnlLine: Record "Gen. Journal Line")
    var
        "---- MIG----": Integer;
        deal_ID_Co_Loc: Code[20];
        dealShipmentSelection_Re_Loc: Record 50031;
        element_Re_Loc: Record 50021;
        BR_Re_Loc: Record 120;
        genJournalLine_Re_Temp: Record 81 TEMPORARY;
        dealShipment_Re_Loc: Record 50030;
        feeConnection_Re_Loc: Record 50025;
        Add_Variant_Op_Loc: Option New,Existing;
        nextEntry: Code[20];
        myTab: ARRAY[300] OF Code[20];
        dss_Re_Loc: Record 50031;
        element_ID_Co_Loc: Code[20];
        i: Integer;
        splittIndex: Integer;
        elementConnectionSplitIndex: Integer;
        ConnectionType_Op_Par: Option Element,Shipment;
        fee_Re_Loc: Record 50024;
        myUpdateRequests: ARRAY[300] OF Code[20];
        provisionDealID_Co_Loc: Code[20];
        updateRequest_Co_Loc: Code[20];
        sps_Re_Loc: Record 50042;
        urm_Re_Loc: Record 50039;
        Provision_Cu: Codeunit 50033;
        Deal_Cu: Codeunit 50020;
        UpdateRequestManager_Cu: Codeunit 50032;
        Element_Cu: Codeunit 50021;

    begin
        genJournalLine_Re_Temp.RESET();
        IF genJournalLine_Re_Temp.FIND('-') THEN BEGIN
            REPEAT

                IF ((genJournalLine_Re_Temp."Source Code" = 'ACHATOD') OR (genJournalLine_Re_Temp."Source Code" = 'COMPTA')
                OR (genJournalLine_Re_Temp."Source Code" = 'VTEREGLT') OR (genJournalLine_Re_Temp."Source Code" = 'ACHPAIEMT')) THEN BEGIN

                    //si c'est une ligne de type invoice, payment ou Credit Memo
                    IF ((genJournalLine_Re_Temp."Document Type" = GenJnlLine."Document Type"::Invoice)
                      OR (genJournalLine_Re_Temp."Document Type" = GenJnlLine."Document Type"::Payment)
                      OR (genJournalLine_Re_Temp."Document Type" = GenJnlLine."Document Type"::"Credit Memo")) THEN BEGIN

                        dealShipmentSelection_Re_Loc.RESET();
                        dealShipmentSelection_Re_Loc.SETRANGE("Journal Template Name", genJournalLine_Re_Temp."Journal Template Name");
                        dealShipmentSelection_Re_Loc.SETRANGE("Journal Batch Name", genJournalLine_Re_Temp."Journal Batch Name");
                        dealShipmentSelection_Re_Loc.SETRANGE("Document No.", genJournalLine_Re_Temp."Document No.");
                        dealShipmentSelection_Re_Loc.SETRANGE("Line No.", genJournalLine_Re_Temp."Line No.");
                        dealShipmentSelection_Re_Loc.SETRANGE(Checked, TRUE);

                        nextEntry := '';
                        element_ID_Co_Loc := '';
                        i := 1;
                        CLEAR(myTab);
                        splittIndex := 1;

                        IF dealShipmentSelection_Re_Loc.FIND('-') THEN
                            REPEAT

                                element_ID_Co_Loc := Element_Cu.FNC_Add_New_Invoice(dealShipmentSelection_Re_Loc, splittIndex);
                                //si un frais est li‚ … 3 livraisons, 3 ‚l‚ments de type "Invoice" sont cr‚‚. Splitt Index indique
                                //le num‚ro de la facture partielle de l'‚l‚ment et est utilis‚ pour d‚finir la proportion du montant
                                //lors de la cr‚ation des positions.
                                splittIndex += 1;

                                //ajouter une shipment connection
                                IF element_ID_Co_Loc <> '' THEN
                                    Element_Cu.FNC_Add_New_Invoice_Connection(
                                      element_ID_Co_Loc, dealShipmentSelection_Re_Loc, ConnectionType_Op_Par::Shipment, 0)
                                ELSE
                                    ERROR('element id vide !');

                                //ajouter les elements connections
                                elementConnectionSplitIndex := 1;
                                dss_Re_Loc.RESET();
                                dss_Re_Loc.SETRANGE("Journal Template Name", genJournalLine_Re_Temp."Journal Template Name");
                                dss_Re_Loc.SETRANGE("Journal Batch Name", genJournalLine_Re_Temp."Journal Batch Name");
                                dss_Re_Loc.SETRANGE("Document No.", genJournalLine_Re_Temp."Document No.");
                                dss_Re_Loc.SETRANGE("Line No.", genJournalLine_Re_Temp."Line No.");
                                dss_Re_Loc.SETRANGE(Checked, TRUE);
                                IF dss_Re_Loc.FIND('-') THEN
                                    REPEAT
                                        Element_Cu.FNC_Add_New_Invoice_Connection(
                                          element_ID_Co_Loc, dss_Re_Loc, ConnectionType_Op_Par::Element, elementConnectionSplitIndex);
                                        elementConnectionSplitIndex += 1;
                                    //MESSAGE('insert invoice connection ok');

                                    UNTIL (dss_Re_Loc.NEXT() = 0);

                                //on enregistre une requete de mise … jour
                                IF nextEntry <> dealShipmentSelection_Re_Loc.Deal_ID THEN BEGIN

                                    //CHG03
                                    myTab[i] := dealShipmentSelection_Re_Loc.Deal_ID;

                                    //START CHG02
                                    myUpdateRequests[i] := UpdateRequestManager_Cu.FNC_Add_Request(
                                      dealShipmentSelection_Re_Loc.Deal_ID,
                                      dealShipmentSelection_Re_Loc."Document Type",
                                      dealShipmentSelection_Re_Loc."Document No.",
                                      CURRENTDATETIME
                                    );
                                    //STOP CHG02

                                    //MESSAGE('update for ' + myTab[i]);
                                    i += 1;

                                END;

                                nextEntry := dealShipmentSelection_Re_Loc.Deal_ID;

                            UNTIL (dealShipmentSelection_Re_Loc.NEXT() = 0);

                        //deleteall
                        dealShipmentSelection_Re_Loc.DELETEALL();

                        i := 1;
                        WHILE i <= 300 DO BEGIN
                            //CHG03
                            IF myTab[i] <> '' THEN
                                Deal_Cu.FNC_Reinit_Deal(myTab[i], FALSE, FALSE);

                            //START CHG02
                            IF myUpdateRequests[i] <> '' THEN
                                UpdateRequestManager_Cu.FNC_Validate_Request(myUpdateRequests[i]);
                            //STOP CHG02

                            i += 1;
                        END;
                    END;
                END;
            UNTIL (genJournalLine_Re_Temp.NEXT() = 0);
        END;
    end;


}
