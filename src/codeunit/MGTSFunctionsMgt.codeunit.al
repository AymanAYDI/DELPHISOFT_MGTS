codeunit 50101 "DEL MGTS_Functions Mgt"
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
    //PROC de CDU 80
    procedure OnAfterInsertPostedHeaders(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader:
 Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header";
  var SalesCrMemoHdr: Record "Sales Cr.Memo Header"; var ReceiptHeader: Record "Return Receipt Header")
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        Element_Cu: Codeunit "DEL Element";
        add_Variant_Op_Loc: Enum "New/Existing";
    begin
        if SalesHeader.Invoice then
            if SalesHeader."Document Type" in [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice] then begin
                dealShipmentSelection_Re_Loc.RESET();
                dealShipmentSelection_Re_Loc.SETRANGE("Document No.", SalesHeader."No.");

                IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
                    dealShipmentSelection_Re_Loc.SETRANGE("Document Type",
                      dealShipmentSelection_Re_Loc."Document Type"::"Sales Header")
                ELSE
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN
                        dealShipmentSelection_Re_Loc.SETRANGE("Document Type",
                          dealShipmentSelection_Re_Loc."Document Type"::"Sales Invoice Header");

                dealShipmentSelection_Re_Loc.SETRANGE(Checked, TRUE);
                dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
                IF dealShipmentSelection_Re_Loc.FIND('-') THEN
                    Element_Cu.FNC_Add_Sales_Invoice(
                      dealShipmentSelection_Re_Loc.Deal_ID,
                      SalesInvoiceHeader,
                      dealShipmentSelection_Re_Loc."Shipment No.",
                      add_Variant_Op_Loc::New);
            END ELSE BEGIN
                dealShipmentSelection_Re_Loc.RESET();
                dealShipmentSelection_Re_Loc.SETRANGE("Document No.", SalesCrMemoHdr."No.");
                dealShipmentSelection_Re_Loc.SETRANGE("Document Type",
                    dealShipmentSelection_Re_Loc."Document Type"::"Sales Cr. Memo");
                dealShipmentSelection_Re_Loc.SETRANGE(Checked, TRUE);
                dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
                IF dealShipmentSelection_Re_Loc.FindFirst() THEN
                    Element_Cu.FNC_Add_Sales_Cr_Memo(
                      dealShipmentSelection_Re_Loc.Deal_ID,
                      SalesCrMemoHdr,
                      dealShipmentSelection_Re_Loc."Shipment No.",
                      add_Variant_Op_Loc::New);
            end;
    end;

    procedure SetSuppressCommit(NewSuppressCommit: Boolean)
    var
        SuppressCommit: Boolean;
    begin
        SuppressCommit := NewSuppressCommit;
    end;

    procedure ReverseProvisionEntries(SalesHeader: Record "Sales Header")
    var
        GLEntryProvision: Record "G/L Entry";
        GlobalGLEntry: Record "G/L Entry";
        GLEntryVATEntry: Record "G/L Entry - VAT Entry Link";
        GlobalVATEntry: Record "VAT Entry";
        VATEntryProvision: Record "VAT Entry";
        NextGLEntryNo: Integer;
        NextTransactionNo: Integer;
        NextVATEntryNo: Integer;
    begin
        GlobalGLEntry.LOCKTABLE();
        GlobalVATEntry.LOCKTABLE();

        GlobalGLEntry.RESET();
        IF GlobalGLEntry.FINDLAST() THEN BEGIN
            NextGLEntryNo := GlobalGLEntry."Entry No." + 1;
            NextTransactionNo := GlobalGLEntry."Transaction No." + 1;
        END ELSE BEGIN
            NextGLEntryNo := 1;
            NextTransactionNo := 1;
        END;

        GlobalVATEntry.RESET();
        IF GlobalVATEntry.FINDLAST() THEN
            NextVATEntryNo := GlobalVATEntry."Entry No." + 1
        ELSE
            NextVATEntryNo := 1;

        GlobalGLEntry.RESET();
        GlobalGLEntry.SETCURRENTKEY("DEL Reverse With Doc. No.");
        GlobalGLEntry.SETRANGE("DEL Customer Provision", SalesHeader."Bill-to Customer No.");
        GlobalGLEntry.SETRANGE("DEL Reverse With Doc. No.", SalesHeader."No.");
        GlobalGLEntry.SETRANGE(Reversed, FALSE);
        IF GlobalGLEntry.FINDSET() THEN
            REPEAT
                GLEntryProvision.INIT();
                GLEntryProvision := GlobalGLEntry;
                GLEntryProvision."Entry No." := NextGLEntryNo;
                GLEntryProvision."Transaction No." := NextTransactionNo;
                GLEntryProvision."Posting Date" := SalesHeader."Posting Date";
                GLEntryProvision."Document Date" := SalesHeader."Document Date";
                GLEntryProvision.Reversed := TRUE;
                GLEntryProvision."Reversed Entry No." := GlobalGLEntry."Entry No.";
                GLEntryProvision.Amount := -GlobalGLEntry.Amount;
                GLEntryProvision.Quantity := -GlobalGLEntry.Quantity;
                GLEntryProvision."VAT Amount" := -GlobalGLEntry."VAT Amount";
                GLEntryProvision."Debit Amount" := -GlobalGLEntry."Debit Amount";
                GLEntryProvision."Credit Amount" := -GlobalGLEntry."Credit Amount";
                GLEntryProvision."Additional-Currency Amount" := -GlobalGLEntry."Additional-Currency Amount";
                GLEntryProvision."Add.-Currency Debit Amount" := -GlobalGLEntry."Add.-Currency Debit Amount";
                GLEntryProvision."Add.-Currency Credit Amount" := -GlobalGLEntry."Add.-Currency Credit Amount";
                GLEntryProvision."DEL Initial Amount (FCY)" := -GlobalGLEntry."DEL Initial Amount (FCY)";
                GLEntryProvision."Amount (FCY)" := -GlobalGLEntry."Amount (FCY)";
                GLEntryProvision.INSERT(FALSE);

                GlobalGLEntry.Reversed := TRUE;
                GlobalGLEntry."Reversed by Entry No." := NextGLEntryNo;
                GlobalGLEntry.MODIFY();

                NextGLEntryNo += 1;

                GLEntryVATEntry.RESET();
                GLEntryVATEntry.SETRANGE("G/L Entry No.", GlobalGLEntry."Entry No.");
                IF GLEntryVATEntry.FINDFIRST() THEN
                    IF GlobalVATEntry.GET(GLEntryVATEntry."VAT Entry No.") THEN BEGIN
                        VATEntryProvision.INIT();
                        VATEntryProvision := GlobalVATEntry;
                        VATEntryProvision."Entry No." := NextVATEntryNo;

                        VATEntryProvision."Transaction No." := NextTransactionNo;
                        VATEntryProvision."Posting Date" := SalesHeader."Posting Date";
                        VATEntryProvision."Document Date" := SalesHeader."Document Date";
                        VATEntryProvision.Reversed := TRUE;
                        VATEntryProvision."Reversed Entry No." := GlobalVATEntry."Entry No.";
                        VATEntryProvision.Amount := -GlobalVATEntry.Amount;
                        VATEntryProvision."Amount (FCY)" := -GlobalVATEntry."Amount (FCY)";
                        VATEntryProvision.Base := -GlobalVATEntry.Base;
                        VATEntryProvision."Base (FCY)" := -GlobalVATEntry."Base (FCY)";
                        VATEntryProvision."Unrealized Amount" := -GlobalVATEntry."Unrealized Amount";
                        VATEntryProvision."Unrealized Base" := -GlobalVATEntry."Unrealized Base";
                        VATEntryProvision."Remaining Unrealized Amount" := -GlobalVATEntry."Remaining Unrealized Amount";
                        VATEntryProvision."Remaining Unrealized Base" := -GlobalVATEntry."Remaining Unrealized Base";
                        VATEntryProvision."Add.-Curr. Rem. Unreal. Amount" := -GlobalVATEntry."Add.-Curr. Rem. Unreal. Amount";
                        VATEntryProvision."Add.-Curr. Rem. Unreal. Base" := -GlobalVATEntry."Add.-Curr. Rem. Unreal. Base";
                        VATEntryProvision."Add.-Curr. VAT Difference" := -GlobalVATEntry."Add.-Curr. VAT Difference";
                        VATEntryProvision."Add.-Currency Unrealized Amt." := -GlobalVATEntry."Add.-Currency Unrealized Amt.";
                        VATEntryProvision."Add.-Currency Unrealized Base" := -GlobalVATEntry."Add.-Currency Unrealized Base";
                        VATEntryProvision."Additional-Currency Amount" := -GlobalVATEntry."Additional-Currency Amount";
                        VATEntryProvision."Additional-Currency Base" := -GlobalVATEntry."Additional-Currency Base";
                        VATEntryProvision.INSERT(FALSE);

                        GlobalVATEntry.Reversed := TRUE;
                        GlobalVATEntry."Reversed by Entry No." := NextVATEntryNo;
                        GlobalVATEntry.MODIFY();

                        NextVATEntryNo += 1;
                    END;
            UNTIL GlobalGLEntry.NEXT() = 0;
    END;




    /////COD 231
    procedure OnBeforeCodeFct(var GenJournalLine: Record "Gen. Journal Line"; var HideDialogP: Boolean)
    var

        fee_Re_Loc: Record "DEL Fee";
        TempgenJournalLine_Re: Record "Gen. Journal Line" TEMPORARY;
        Provision_Cu: Codeunit "DEL Provision";
    begin

        IF GenJournalLine.FindSet() THEN
            REPEAT
                TempgenJournalLine_Re.INIT();
                TempgenJournalLine_Re.COPY(GenJournalLine);
                TempgenJournalLine_Re.INSERT();
            UNTIL (GenJournalLine.NEXT() = 0);

        TempgenJournalLine_Re.RESET();
        TempgenJournalLine_Re.SETRANGE("Account Type", TempgenJournalLine_Re."Account Type"::"G/L Account");
        IF TempgenJournalLine_Re.FindSet() THEN BEGIN
            REPEAT

                //pour les provisions, on a pas besoin de controler parce que le lien est g‚r‚ autrement..
                IF TempgenJournalLine_Re."Journal Batch Name" <> 'PROVISION' THEN BEGIN

                    //on regarde si aucune liaison n'a ‚t‚ s‚lectionn‚e
                    TempgenJournalLine_Re.CALCFIELDS("DEL Shipment Selection");

                    IF (TempgenJournalLine_Re."DEL Shipment Selection" <= 0) THEN BEGIN

                        //Les No. de compte qui requiŠrent un deal shipment = ceux qui ont la case "Used for import" = true dans la table 50024 (Fee)
                        fee_Re_Loc.RESET();
                        fee_Re_Loc.SETRANGE("No compte", TempgenJournalLine_Re."Account No.");
                        fee_Re_Loc.SETRANGE("Used For Import", TRUE);
                        //si on trouve un compte qui exige une liaison
                        IF fee_Re_Loc.FindSet() THEN

                            //on affiche un warning : si on accepte, on continue, si on annule, alors error
                            IF (NOT DIALOG.CONFIRM('La ligne %1 (compte de frais %2) n''a pas de livraison liée ! Continuer ?', FALSE,
                              TempgenJournalLine_Re."Line No.",
                              TempgenJournalLine_Re."Account No.")) THEN
                                EXIT;



                    END;

                END;

            UNTIL (TempgenJournalLine_Re.NEXT() = 0);

            //si des ‚critures provisions sont … valider
            TempgenJournalLine_Re.RESET();
            TempgenJournalLine_Re.SETRANGE("Journal Batch Name", 'PROVISION');
            IF TempgenJournalLine_Re.FIND('-') THEN
                Provision_Cu.FNC_RunTest();

        END;
    end;

    procedure OnCodeOnAfterGenJnlPostBatchRunfct(var GenJnlLine: Record "Gen. Journal Line")
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        dss_Re_Loc: Record "DEL Deal Shipment Selection";
        TempgenJournalLine_Re: Record "Gen. Journal Line" TEMPORARY;
        Deal_Cu: Codeunit "DEL Deal";
        Element_Cu: Codeunit "DEL Element";
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        element_ID_Co_Loc: Code[20];
        myTab: ARRAY[300] OF Code[20];
        myUpdateRequests: ARRAY[300] OF Code[20];
        nextEntry: Code[20];
        ConnectionType_Op_Par: Enum "Element/Shipment";
        elementConnectionSplitIndex: Integer;
        i: Integer;
        splittIndex: Integer;

    begin
        TempgenJournalLine_Re.RESET();
        IF TempgenJournalLine_Re.FindSet() THEN BEGIN
            REPEAT

                IF ((TempgenJournalLine_Re."Source Code" = 'ACHATOD') OR (TempgenJournalLine_Re."Source Code" = 'COMPTA')
                OR (TempgenJournalLine_Re."Source Code" = 'VTEREGLT') OR (TempgenJournalLine_Re."Source Code" = 'ACHPAIEMT')) THEN BEGIN

                    //si c'est une ligne de type invoice, payment ou Credit Memo
                    IF ((TempgenJournalLine_Re."Document Type" = GenJnlLine."Document Type"::Invoice)
                      OR (TempgenJournalLine_Re."Document Type" = GenJnlLine."Document Type"::Payment)
                      OR (TempgenJournalLine_Re."Document Type" = GenJnlLine."Document Type"::"Credit Memo")) THEN BEGIN

                        dealShipmentSelection_Re_Loc.RESET();
                        dealShipmentSelection_Re_Loc.SETRANGE("Journal Template Name", TempgenJournalLine_Re."Journal Template Name");
                        dealShipmentSelection_Re_Loc.SETRANGE("Journal Batch Name", TempgenJournalLine_Re."Journal Batch Name");
                        dealShipmentSelection_Re_Loc.SETRANGE("Document No.", TempgenJournalLine_Re."Document No.");
                        dealShipmentSelection_Re_Loc.SETRANGE("Line No.", TempgenJournalLine_Re."Line No.");
                        dealShipmentSelection_Re_Loc.SETRANGE(Checked, TRUE);

                        nextEntry := '';
                        element_ID_Co_Loc := '';
                        i := 1;
                        CLEAR(myTab);
                        splittIndex := 1;

                        IF dealShipmentSelection_Re_Loc.FindSet() THEN
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
                                dss_Re_Loc.SETRANGE("Journal Template Name", TempgenJournalLine_Re."Journal Template Name");
                                dss_Re_Loc.SETRANGE("Journal Batch Name", TempgenJournalLine_Re."Journal Batch Name");
                                dss_Re_Loc.SETRANGE("Document No.", TempgenJournalLine_Re."Document No.");
                                dss_Re_Loc.SETRANGE("Line No.", TempgenJournalLine_Re."Line No.");
                                dss_Re_Loc.SETRANGE(Checked, TRUE);
                                IF dss_Re_Loc.FindSet() THEN
                                    REPEAT
                                        Element_Cu.FNC_Add_New_Invoice_Connection(
                                          element_ID_Co_Loc, dss_Re_Loc, ConnectionType_Op_Par::Element, elementConnectionSplitIndex);
                                        elementConnectionSplitIndex += 1;

                                    UNTIL (dss_Re_Loc.NEXT() = 0);

                                //on enregistre une requete de mise … jour
                                IF nextEntry <> dealShipmentSelection_Re_Loc.Deal_ID THEN BEGIN

                                    myTab[i] := dealShipmentSelection_Re_Loc.Deal_ID;

                                    myUpdateRequests[i] := UpdateRequestManager_Cu.FNC_Add_Request(
                                      dealShipmentSelection_Re_Loc.Deal_ID,
                                      dealShipmentSelection_Re_Loc."Document Type".AsInteger(),
                                      dealShipmentSelection_Re_Loc."Document No.",
                                      CURRENTDATETIME
                                    );

                                    i += 1;

                                END;

                                nextEntry := dealShipmentSelection_Re_Loc.Deal_ID;

                            UNTIL (dealShipmentSelection_Re_Loc.NEXT() = 0);

                        //deleteall
                        dealShipmentSelection_Re_Loc.DELETEALL();

                        i := 1;
                        WHILE i <= 300 DO BEGIN
                            IF myTab[i] <> '' THEN
                                Deal_Cu.FNC_Reinit_Deal(myTab[i], FALSE, FALSE);

                            IF myUpdateRequests[i] <> '' THEN
                                UpdateRequestManager_Cu.FNC_Validate_Request(myUpdateRequests[i]);

                            i += 1;
                        END;
                    END;
                END;
            UNTIL (TempgenJournalLine_Re.NEXT() = 0);
        END;
    end;
    //----------------- CDU81
    procedure OnBeforeConfirmSalesPostFct_SalesHeader(var SalesHeader: Record "Sales Header"; var HideDialogP: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean)
    var

        dealShipmentSelection_Re: Record "DEL Deal Shipment Selection";
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        GLAccount_Re_Loc: Record "G/L Account";
        salesLine_Re_Loc: Record "Sales Line";
        updateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        shipmentSelected_Bo_Loc: Boolean;
        updateRequestID_Co_Loc: Code[20];
    begin

        shipmentSelected_Bo_Loc := FALSE;

        IF
        (
          (SalesHeader."Document Type" = SalesHeader."Document Type"::Order)
          OR
          (SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo")
          OR
          (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice)
        )
        THEN BEGIN
            dealShipmentSelection_Re_Loc.RESET();
            dealShipmentSelection_Re_Loc.SETRANGE("Document No.", SalesHeader."No.");
            dealShipmentSelection_Re_Loc.SETRANGE(Checked, TRUE);
            dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
            IF dealShipmentSelection_Re_Loc.FIND('-') THEN BEGIN

                dealShipmentSelection_Re := dealShipmentSelection_Re_Loc;
                shipmentSelected_Bo_Loc := TRUE;
                IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN BEGIN

                    IF dealShipmentSelection_Re_Loc.COUNT() > 1 THEN
                        ERROR('Il faut choisir au maximum 1 livraison li‚e !');

                END ELSE
                    IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN BEGIN

                        IF dealShipmentSelection_Re_Loc.COUNT() > 1 THEN
                            ERROR('Il faut choisir exactement 1 livraison li‚e !');

                    END ELSE
                        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo") THEN BEGIN

                            IF dealShipmentSelection_Re_Loc.COUNT() > 1 THEN
                                ERROR('Il faut choisir exactement 1 livraison li‚e !');

                            IF dealShipmentSelection_Re_Loc."Sales Invoice No." = '' THEN
                                ERROR('La livraison li‚e n''a pas de Sales Invoice sur laquelle elle doit ˆtre li‚e !');

                        END;

                updateRequestID_Co_Loc := updateRequestManager_Cu.FNC_Add_Request(
                  dealShipmentSelection_Re_Loc.Deal_ID,
                  dealShipmentSelection_Re_Loc."Document Type".AsInteger(),
                  dealShipmentSelection_Re_Loc."Document No.",
                  CURRENTDATETIME
                );
            END ELSE BEGIN

                IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN

                    ERROR('Il faut choisir exactement 1 livraison li‚e !');


                END ELSE
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN BEGIN


                        salesLine_Re_Loc.RESET();
                        salesLine_Re_Loc.SETRANGE("Document Type", salesLine_Re_Loc."Document Type"::"Credit Memo");
                        salesLine_Re_Loc.SETRANGE("Document No.", SalesHeader."No.");
                        IF salesLine_Re_Loc.FIND('-') THEN BEGIN
                            REPEAT

                                IF (salesLine_Re_Loc.Type <> salesLine_Re_Loc.Type::"G/L Account") THEN
                                    ERROR('Il faut choisir exactement 1 livraison li‚e !')
                                ELSE
                                    IF (GLAccount_Re_Loc.GET(salesLine_Re_Loc."No.")) THEN
                                        IF NOT (GLAccount_Re_Loc."DEL Shipment Binding Control") THEN
                                            ERROR('Il faut choisir exactement 1 livraison li‚e !')
                            UNTIL (salesLine_Re_Loc.NEXT() = 0);
                        END;
                    END
                    ELSE
                        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN BEGIN

                            salesLine_Re_Loc.RESET();
                            salesLine_Re_Loc.SETRANGE("Document Type", salesLine_Re_Loc."Document Type"::Invoice);
                            salesLine_Re_Loc.SETRANGE("Document No.", SalesHeader."No.");
                            IF salesLine_Re_Loc.FIND('-') THEN BEGIN
                                REPEAT

                                    IF (salesLine_Re_Loc.Type <> salesLine_Re_Loc.Type::"G/L Account") THEN
                                        ERROR('Il faut choisir exactement 1 livraison li‚e !')
                                    ELSE
                                        IF (GLAccount_Re_Loc.GET(salesLine_Re_Loc."No.")) THEN
                                            IF NOT (GLAccount_Re_Loc."DEL Shipment Binding Control") THEN
                                                ERROR('Il faut choisir exactement 1 livraison li‚e !')
                                UNTIL (salesLine_Re_Loc.NEXT() = 0);

                            END;
                        END;
            END;
        END;

    end;

    procedure OnGenJnlLineSetFilter_Fct(var GenJournalLine: Record "Gen. Journal Line")
    var
        TempgenJournalLine_Re: Record "Gen. Journal Line" TEMPORARY;
        Provision_Cu: Codeunit "DEL Provision";
    begin
        TempgenJournalLine_Re.RESET();
        TempgenJournalLine_Re.SETRANGE("Journal Batch Name", 'PROVISION');
        IF TempgenJournalLine_Re.FIND('-') THEN
            Provision_Cu.FNC_Add2Deals();

    end;


    ////////
    procedure OnAfterConfirmPost(var SalesHeader: Record "Sales Header")
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        Deal_Cu: Codeunit "DEL Deal";
        updateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        shipmentSelected_Bo_Loc: Boolean;
        updateRequestID_Co_Loc: Code[20];
    begin
        IF shipmentSelected_Bo_Loc THEN BEGIN
            //La facture a ‚t‚ associ‚e … une et une seule livraison et donc, on r‚initialise l'affaire qui appartient … cette livraison
            Deal_Cu.FNC_Reinit_Deal(dealShipmentSelection_Re_Loc.Deal_ID, FALSE, FALSE);

            //Le deal a ‚t‚ r‚initialis‚, on peut valider l'updateRequest
            updateRequestManager_Cu.FNC_Validate_Request(updateRequestID_Co_Loc);

            //On vide la table Deal Shipment Selection pour qu'elle soit mise … jour lors de la prochaine ouverture..
            dealShipmentSelection_Re_Loc.RESET();
            dealShipmentSelection_Re_Loc.SETRANGE("Document No.", SalesHeader."No.");
            dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
            dealShipmentSelection_Re_Loc.DELETEALL();
        END;

    end;

    //-------CDU82 ---
    procedure OnBeforeConfirmPostFct_COD82(var SalesHeader: Record "Sales Header"; var HideDialogP: Boolean; var IsHandled: Boolean; var SendReportAsEmail: Boolean; var DefaultOption: Integer)
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        GLAccount_Re_Loc: Record "G/L Account";
        salesLine_Re_Loc: Record "Sales Line";
        GlobalFunction: Codeunit "DEL MGTS Set/Get Functions";
        updateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        updateRequestID_Co_Loc: Code[20];
    begin
        // shipmentSelected_Bo_Loc := FALSE;
        GlobalFunction.SetshipmentSelected_Bo_Loc(FALSE);
        IF
        (
          (SalesHeader."Document Type" = SalesHeader."Document Type"::Order)
          OR
          (SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo")
          OR
          (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice)
        )
        THEN BEGIN
            dealShipmentSelection_Re_Loc.RESET();
            dealShipmentSelection_Re_Loc.SETRANGE("Document No.", SalesHeader."No.");
            dealShipmentSelection_Re_Loc.SETRANGE(Checked, TRUE);
            dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
            IF dealShipmentSelection_Re_Loc.FIND('-') THEN BEGIN

                // shipmentSelected_Bo_Loc := TRUE;
                GlobalFunction.SetshipmentSelected_Bo_Loc(true);
                IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN BEGIN
                    IF dealShipmentSelection_Re_Loc.COUNT() > 1 THEN
                        ERROR('Il faut choisir au maximum 1 livraison liée !');

                END ELSE
                    IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN BEGIN
                        IF dealShipmentSelection_Re_Loc.COUNT() > 1 THEN
                            ERROR('Il faut choisir exactement 1 livraison liée !');

                    END ELSE
                        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo") THEN BEGIN
                            IF dealShipmentSelection_Re_Loc.COUNT() > 1 THEN
                                ERROR('Il faut choisir exactement 1 livraison liée !');

                            IF dealShipmentSelection_Re_Loc."Sales Invoice No." = '' THEN
                                ERROR('La livraison liée n''a pas de Sales Invoice sur laquelle elle doit étre liée !');

                        END;
                updateRequestID_Co_Loc := updateRequestManager_Cu.FNC_Add_Request(
                  dealShipmentSelection_Re_Loc.Deal_ID,
                  dealShipmentSelection_Re_Loc."Document Type".AsInteger(),
                  dealShipmentSelection_Re_Loc."Document No.",
                  CURRENTDATETIME
                );

            END ELSE BEGIN

                IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN

                    ERROR('Il faut choisir exactement 1 livraison liée !');

                END ELSE
                    IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN BEGIN

                        salesLine_Re_Loc.RESET();
                        salesLine_Re_Loc.SETRANGE("Document Type", salesLine_Re_Loc."Document Type"::"Credit Memo");
                        salesLine_Re_Loc.SETRANGE("Document No.", SalesHeader."No.");
                        IF salesLine_Re_Loc.FindSet() THEN BEGIN
                            REPEAT
                                IF (salesLine_Re_Loc.Type <> salesLine_Re_Loc.Type::"G/L Account") THEN
                                    ERROR('Il faut choisir exactement 1 livraison liée !')
                                ELSE
                                    IF (GLAccount_Re_Loc.GET(salesLine_Re_Loc."No.")) THEN
                                        IF NOT (GLAccount_Re_Loc."DEL Shipment Binding Control") THEN
                                            ERROR('Il faut choisir exactement 1 livraison liée !')

                            UNTIL (salesLine_Re_Loc.NEXT() = 0);
                        END;
                    END
                    ELSE
                        IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN BEGIN

                            salesLine_Re_Loc.RESET();
                            salesLine_Re_Loc.SETRANGE("Document Type", salesLine_Re_Loc."Document Type"::Invoice);
                            salesLine_Re_Loc.SETRANGE("Document No.", SalesHeader."No.");
                            IF salesLine_Re_Loc.FindSet() THEN BEGIN
                                REPEAT
                                    IF (salesLine_Re_Loc.Type <> salesLine_Re_Loc.Type::"G/L Account") THEN
                                        ERROR('Il faut choisir exactement 1 livraison liée !')
                                    ELSE
                                        IF (GLAccount_Re_Loc.GET(salesLine_Re_Loc."No.")) THEN
                                            IF NOT (GLAccount_Re_Loc."DEL Shipment Binding Control") THEN
                                                ERROR('Il faut choisir exactement 1 livraison liée !')
                                UNTIL (salesLine_Re_Loc.NEXT() = 0);

                            END;
                        END;
            END;
        END;

    end;

    /////
    /// COD 333

    PROCEDURE SetEDIParam(pHideDialog: Boolean; pFromEDI: Boolean);

    BEGIN
        HideDialog := pHideDialog;
        FromEDI := pFromEDI;
    END;
    /////
    procedure OnAfterInsertPurchOrderHeaderFct(var RequisitionLine: Record "Requisition Line"; var PurchaseOrderHeader: Record "Purchase Header"; CommitIsSuppressed: Boolean; SpecialOrder: Boolean)
    var
        PurchSetup: Record "Purchases & Payables Setup";
        SalesHeader: Record "Sales Header";
    begin
        IF SalesHeader.GET(SalesHeader."Document Type"::Order, RequisitionLine."Sales Order No.") THEN
            PurchaseOrderHeader."DEL Requested Delivery Date" := SalesHeader."Requested Delivery Date";

        IF PurchaseOrderHeader."DEL Requested Delivery Date" <> 0D THEN BEGIN
            IF NOT PurchSetup.GET() THEN
                PurchSetup.INIT();

            CASE PurchaseOrderHeader."DEL Ship Per" OF
                PurchaseOrderHeader."DEL Ship Per"::"Air Flight":
                    BEGIN
                        PurchaseOrderHeader."Expected Receipt Date" := CALCDATE('-' + DELCHR(FORMAT(PurchSetup."DEL SalesShipTimeByAirFlight"), '=', '+'),
                          PurchaseOrderHeader."DEL Requested Delivery Date");
                        PurchaseOrderHeader."Requested Receipt Date" := CALCDATE('-' + DELCHR(FORMAT(PurchSetup."DEL SalesShipTimeByAirFlight"), '=', '+'),
                          PurchaseOrderHeader."DEL Requested Delivery Date");
                    END;

                PurchaseOrderHeader."DEL Ship Per"::"Sea Vessel":
                    BEGIN
                        PurchaseOrderHeader."Expected Receipt Date" := CALCDATE('-' + DELCHR(FORMAT(PurchSetup."DEL SalesShipTimeBySeaVessel"), '=', '+'),
                          PurchaseOrderHeader."DEL Requested Delivery Date");
                        PurchaseOrderHeader."Requested Receipt Date" := CALCDATE('-' + DELCHR(FORMAT(PurchSetup."DEL SalesShipTimeBySeaVessel"), '=', '+'),
                          PurchaseOrderHeader."DEL Requested Delivery Date");
                    END;

                PurchaseOrderHeader."DEL Ship Per"::"Sea/Air":
                    BEGIN
                        PurchaseOrderHeader."Expected Receipt Date" := CALCDATE('-' + DELCHR(FORMAT(PurchSetup."DEL Sales Ship Time By Sea/Air"), '=', '+'),
                          PurchaseOrderHeader."DEL Requested Delivery Date");
                        PurchaseOrderHeader."Requested Receipt Date" := CALCDATE('-' + DELCHR(FORMAT(PurchSetup."DEL Sales Ship Time By Sea/Air"), '=', '+'),
                          PurchaseOrderHeader."DEL Requested Delivery Date");
                    END;

                PurchaseOrderHeader."DEL Ship Per"::Train:
                    BEGIN
                        PurchaseOrderHeader."Expected Receipt Date" := CALCDATE('-' + DELCHR(FORMAT(PurchSetup."DEL Sales Ship Time By Train"), '=', '+'),
                          PurchaseOrderHeader."DEL Requested Delivery Date");
                        PurchaseOrderHeader."Requested Receipt Date" := CALCDATE('-' + DELCHR(FORMAT(PurchSetup."DEL Sales Ship Time By Train"), '=', '+'),
                          PurchaseOrderHeader."DEL Requested Delivery Date");
                    END;

                PurchaseOrderHeader."DEL Ship Per"::Truck:
                    BEGIN
                        PurchaseOrderHeader."Expected Receipt Date" := CALCDATE('-' + DELCHR(FORMAT(PurchSetup."DEL Sales Ship Time By Truck"), '=', '+'),
                          PurchaseOrderHeader."DEL Requested Delivery Date");
                        PurchaseOrderHeader."Requested Receipt Date" := CALCDATE('-' + DELCHR(FORMAT(PurchSetup."DEL Sales Ship Time By Truck"), '=', '+'),
                          PurchaseOrderHeader."DEL Requested Delivery Date");
                    END;
            END;


        END;


        IF SalesHeader.GET(SalesHeader."Document Type"::Order, RequisitionLine."Sales Order No.") THEN BEGIN
            PurchaseOrderHeader."Your Reference" := FORMAT(SalesHeader."DEL Event Code") + '-' + SalesHeader."External Document No.";

            PurchaseOrderHeader."DEL Code événement" := SalesHeader."DEL Event Code";

            PurchaseOrderHeader."DEL Port d'arrivée" := SalesHeader."Location Code";

        END;

        SalesHeader.RESET();
        SalesHeader.SETRANGE("No.", RequisitionLine."Sales Order No.");
        IF SalesHeader.FINDFIRST() THEN BEGIN
            PurchaseOrderHeader."DEL Type Order EDI" := SalesHeader."DEL Type Order EDI";
            PurchaseOrderHeader."DEL GLN" := SalesHeader."DEL GLN";
            IF SpecialOrder THEN BEGIN
                SalesHeader."DEL Has Spec. Purch. Order" := TRUE;

                IF FromEDI THEN BEGIN
                    SalesHeader."DEL Status Purch. Order Create" := SalesHeader."DEL Status Purch. Order Create"::"Create Deal";
                    SalesHeader."DEL Purchase Order Create Date" := CREATEDATETIME(TODAY, TIME);
                    SalesHeader."DEL To Create Purchase Order" := FALSE;
                END;
                SalesHeader.MODIFY();
            END;

        END;


        PurchaseOrderHeader.VALIDATE("Shortcut Dimension 1 Code", PurchaseOrderHeader."No.");  //TODO :A verifier 


    end;

    // COD 7000
    procedure CopySalesPriceToSalesPrice(var FromSalesPrice: Record "Sales Price"; var ToSalesPrice: Record "Sales Price")
    begin
        if FromSalesPrice.FindSet() then
            repeat
                ToSalesPrice := FromSalesPrice;
                ToSalesPrice.Insert();
            until FromSalesPrice.Next() = 0;
    end;

    // procedure specifique codeunit 431 "IC Outbox Export"
    PROCEDURE SendTrans(ICOutboxTransaction: Record "IC Outbox Transaction");
    VAR
        TransitaireMgt: Codeunit "DEL TransitaireMgt";
    BEGIN
        TransitaireMgt.SendToTransitairePartner(ICOutboxTransaction);
        // SendToExternalPartner(ICOutboxTransaction);
        // SendToInternalPartner(ICOutboxTransaction); TODO: procedure local
    END;


    // Duplicate procedure from codeunit 427 ICInboxOutboxMgt
    procedure CheckICPurchaseDocumentAlreadySent(PurchaseHeader: Record "Purchase Header")
    var
        HandledICOutboxTrans: Record "Handled IC Outbox Trans.";
        ConfirmManagement: Codeunit "Confirm Management";
        TransactionAlreadyExistsInOutboxHandledQst: Label '%1 %2 has already been sent to intercompany partner %3. Resending it will create a duplicate %1 for them. Do you want to send it again?';

    begin
        HandledICOutboxTrans.SetRange("Source Type", HandledICOutboxTrans."Source Type"::"Purchase Document");
        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::"Credit Memo":
                HandledICOutboxTrans.SetRange("Document Type", HandledICOutboxTrans."Document Type"::"Credit Memo");
            PurchaseHeader."Document Type"::Invoice:
                HandledICOutboxTrans.SetRange("Document Type", HandledICOutboxTrans."Document Type"::Invoice);
            PurchaseHeader."Document Type"::Order:
                HandledICOutboxTrans.SetRange("Document Type", HandledICOutboxTrans."Document Type"::Order);
            PurchaseHeader."Document Type"::"Return Order":
                HandledICOutboxTrans.SetRange("Document Type", HandledICOutboxTrans."Document Type"::"Return Order");
            else
                exit;
        end;
        HandledICOutboxTrans.SetRange("Document No.", PurchaseHeader."No.");

        if HandledICOutboxTrans.FindFirst() then
            if not ConfirmManagement.GetResponseOrDefault(
                StrSubstNo(
                    TransactionAlreadyExistsInOutboxHandledQst, HandledICOutboxTrans."Document Type",
                    HandledICOutboxTrans."Document No.", HandledICOutboxTrans."IC Partner Code"),
                true)
            then
                Error('');
    end;

    // procedure from codeunit 365 "Format Address"
    procedure NTO_SalesFiscCtct(VAR AddrArray: ARRAY[8] OF Text[50]; VAR NTO_Contact: Record Contact);
    var
        ForAdr: Codeunit "Format Address";
    begin
        ForAdr.FormatAddr(AddrArray, NTO_Contact.Name, NTO_Contact."Name 2", '', NTO_Contact.Address, NTO_Contact."Address 2", NTO_Contact.City, NTO_Contact."Post Code", NTO_Contact.County, NTO_Contact."Country/Region Code");

    end;




    var
        FromEDI: Boolean;
        HideDialog: Boolean;


    /////COD91
    procedure OnBeforeConfirmPostfct_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; var HideDialogP: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        GLAccount_Re_Loc: Record "G/L Account";
        PurchaseLine_Re_Loc: Record "Purchase Line";
        GlobalFunction: Codeunit "DEL MGTS Set/Get Functions";
        updateRequestManager_Cu: Codeunit "DEL Update Request Manager";
    // updateRequestID_Co_Loc: Code[20];


    begin
        IF
        (
          (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order)
          OR
          (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo")
          OR
          (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice)
        )
        THEN BEGIN

            dealShipmentSelection_Re_Loc.RESET();
            dealShipmentSelection_Re_Loc.SETRANGE("Document No.", PurchaseHeader."No.");
            dealShipmentSelection_Re_Loc.SETRANGE(Checked, TRUE);
            dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
            IF dealShipmentSelection_Re_Loc.FindSet() THEN BEGIN

                //shipmentSelected_Bo_Loc := TRUE;
                GlobalFunction.SetshipmentSelected_Bo_Loc(true);
                IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice THEN BEGIN

                    //pour les factures achat, on veut 0 ou 1 livraison li‚e
                    IF dealShipmentSelection_Re_Loc.COUNT() > 1 THEN
                        ERROR('Il faut choisir au maximum 1 livraison liée !');

                END ELSE
                    IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order) THEN BEGIN

                        //pour les commandes il faut exactement 1 livraison li‚e
                        IF dealShipmentSelection_Re_Loc.COUNT() > 1 THEN
                            ERROR('Il faut choisir exactement 1 livraison liée !');

                    END ELSE
                        IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo") THEN BEGIN

                            //pour les notes de cr‚dit, il faut exactement 1 livraison li‚e
                            IF dealShipmentSelection_Re_Loc.COUNT() > 1 THEN
                                ERROR('Il faut choisir exactement 1 livraison liée !');

                            //il faut aussi imp‚rativement avoir une facture li‚e … cette note de cr‚dit
                            IF dealShipmentSelection_Re_Loc."Purchase Invoice No." = '' THEN
                                ERROR('La livraison liée n''a pas de Purchase Invoice sur laquelle elle doit étre liée !');

                        END;


                //On cr‚e une updateRequest, comme ca, si NAV plante plus loin, on sait ce qui n'a pas ‚t‚ updat‚ comme il faut
                // updateRequestID_Co_Loc := updateRequestManager_Cu.FNC_Add_Request(
                //   dealShipmentSelection_Re_Loc.Deal_ID,
                //   dealShipmentSelection_Re_Loc."Document Type",
                //   dealShipmentSelection_Re_Loc."Document No.",
                //   CURRENTDATETIME);

                GlobalFunction.SetupdateRequestID_Co_Loc(updateRequestManager_Cu.FNC_Add_Request(
                                  dealShipmentSelection_Re_Loc.Deal_ID,
                                  dealShipmentSelection_Re_Loc."Document Type".AsInteger(),
                                  dealShipmentSelection_Re_Loc."Document No.",
                                  CURRENTDATETIME));

            END ELSE BEGIN
                //Si aucune livraison n'est s‚lectionn‚e
                IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order THEN BEGIN
                    ERROR('Il faut choisir exactement 1 livraison liée !');
                END


                //si le type de ligne est "G/L Account" et le num 3400, 3401 ou 3410, ... alors pas d'erreur
                ELSE
                    IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" THEN BEGIN

                        //on v‚rifie les lignes du document
                        PurchaseLine_Re_Loc.RESET();
                        PurchaseLine_Re_Loc.SETRANGE("Document Type", PurchaseLine_Re_Loc."Document Type"::"Credit Memo");
                        PurchaseLine_Re_Loc.SETRANGE("Document No.", PurchaseHeader."No.");
                        IF PurchaseLine_Re_Loc.FindSet() THEN BEGIN
                            REPEAT
                                //si c'est pas un compte alors c'est d‚j… grill‚ -> erreur
                                IF (PurchaseLine_Re_Loc.Type <> PurchaseLine_Re_Loc.Type::"G/L Account") THEN
                                    ERROR('Il faut choisir exactement 1 livraison liée !')
                                ELSE
                                    IF (GLAccount_Re_Loc.GET(PurchaseLine_Re_Loc."No.")) THEN
                                        // si coch‚, exclure du contr“le de liaison
                                        IF NOT (GLAccount_Re_Loc."DEL Shipment Binding Control") THEN
                                            ERROR('Il faut choisir exactement 1 livraison liée !')
                            UNTIL (PurchaseLine_Re_Loc.NEXT() = 0);
                        END;
                    END
                    ELSE
                        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice THEN BEGIN

                            //on v‚rifie les lignes du document
                            PurchaseLine_Re_Loc.RESET();
                            PurchaseLine_Re_Loc.SETRANGE("Document Type", PurchaseLine_Re_Loc."Document Type"::Invoice);
                            PurchaseLine_Re_Loc.SETRANGE("Document No.", PurchaseHeader."No.");
                            IF PurchaseLine_Re_Loc.FindSet() THEN BEGIN
                                REPEAT
                                    //si c'est pas un compte alors c'est d‚j… grill‚ -> erreur
                                    IF (PurchaseLine_Re_Loc.Type <> PurchaseLine_Re_Loc.Type::"G/L Account") THEN
                                        ERROR('Il faut choisir exactement 1 livraison liée !')
                                    ELSE
                                        IF (GLAccount_Re_Loc.GET(PurchaseLine_Re_Loc."No.")) THEN
                                            // si coch‚, exclure du contr“le de liaison
                                            IF NOT (GLAccount_Re_Loc."DEL Shipment Binding Control") THEN
                                                ERROR('Il faut choisir exactement 1 livraison liée !')
                                UNTIL (PurchaseLine_Re_Loc.NEXT() = 0);

                            END;
                        END;
            END;

        END;
    end;
    //COD91
    PROCEDURE SetSpecOrderPosting(NewSpecOrderPosting: Boolean)
    var
        SpecOrderPost: Boolean;
    BEGIN
        //MGTS0123; MHH; entire function
        SpecOrderPost := NewSpecOrderPosting;
    END;

    PROCEDURE GetSpecialOrderBuffer(VAR pTempSH: Record "Sales Header" temporary)
    var
        tempSpecialSHBuffer: Record "Sales Header" TEMPORARY;
    BEGIN
        //MGTS0123
        pTempSH.RESET();
        pTempSH.DELETEALL();
        tempSpecialSHBuffer.RESET();
        IF tempSpecialSHBuffer.FINDSET() THEN
            REPEAT
                pTempSH := tempSpecialSHBuffer;
                pTempSH.INSERT();
            UNTIL tempSpecialSHBuffer.NEXT() = 0;
    END;



    procedure SelectPostReturnOrderOption(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer) Result: Boolean //cdu91
    var
        Selection: Integer;
        ShipInvoiceQst: Label '&Ship,&Invoice,Ship &and Invoice';

    begin
        Selection := StrMenu(ShipInvoiceQst, DefaultOption);
        if Selection = 0 then
            exit(false);
        PurchaseHeader.Ship := Selection in [1, 3];
        PurchaseHeader.Invoice := Selection in [2, 3];

        exit(true);
    end;

    procedure SelectPostOrderOption(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer) Result: Boolean
    var
        Selection: Integer;
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';


    begin
        Selection := StrMenu(ReceiveInvoiceQst, DefaultOption);
        if Selection = 0 then
            exit(false);
        PurchaseHeader.Receive := Selection in [1, 3];
        PurchaseHeader.Invoice := Selection in [2, 3];

        exit(true);
    end;

    ///// COD 90 
    procedure ResetTempLines(var TempPurchLineLocal: Record "Purchase Line" temporary)
    var
        TempPurchLineGlobal: Record "Purchase Line" temporary;

    begin
        TempPurchLineLocal.Reset();
        TempPurchLineLocal.Copy(TempPurchLineGlobal, true);

    end;
    //////COD 90
    PROCEDURE UpdateAssosSpecialOrderPostingNos(PurchHeader: Record "Purchase Header"; var PreviewMode: Boolean) SpecialOrder: Boolean;
    VAR
        TempPurchLine: Record "Purchase Line" TEMPORARY;
        SalesOrderHeader: Record "Sales Header";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        ReleaseSalesDocument: Codeunit "Release Sales Document";
    BEGIN

        ResetTempLines(TempPurchLine);
        TempPurchLine.SETFILTER("Special Order Sales Line No.", '<>0');
        IF NOT TempPurchLine.ISEMPTY THEN BEGIN
            SpecialOrder := TRUE;
            IF PurchHeader.Receive THEN BEGIN
                TempPurchLine.FINDSET();
                REPEAT
                    IF SalesOrderHeader."No." <> TempPurchLine."Special Order Sales No." THEN BEGIN
                        SalesOrderHeader.GET(SalesOrderHeader."Document Type"::Order, TempPurchLine."Special Order Sales No.");
                        SalesOrderHeader.TESTFIELD("Bill-to Customer No.");
                        SalesOrderHeader.Ship := TRUE;
                        //TODO:PreviewMode is a global var ---- To check
                        ReleaseSalesDocument.ReleaseSalesHeader(SalesOrderHeader, PreviewMode);
                        IF SalesOrderHeader."Shipping No." = '' THEN BEGIN
                            SalesOrderHeader.TESTFIELD("Shipping No. Series");
                            SalesOrderHeader."Shipping No." :=
                              NoSeriesMgt.GetNextNo(SalesOrderHeader."Shipping No. Series", PurchHeader."Posting Date", TRUE);
                            SalesOrderHeader.MODIFY();
                        END;
                    END;
                UNTIL TempPurchLine.NEXT() = 0;
            END;
        END ELSE
            SpecialOrder := FALSE;
        EXIT(SpecialOrder);
    END;
    //////COD 90
    PROCEDURE CheckSalesDealShipment(PurchOrderNo: Code[20]; SalesOrderNo: Code[20]);
    VAR
        Deal: Record "DEL Deal";
        DealShipment: Record "DEL Deal Shipment";
        DealShipmentSelection: Record "DEL Deal Shipment Selection";
        PostDealShipmentSelection: Record "DEL Deal Shipment Selection"; //Var global dans le spécifique
        PurchDealShipmentSelection: Record "DEL Deal Shipment Selection";
        Element: Record "DEL Element";
        SalesHeader: Record "Sales Header"; //Var global dans le spécifique
        DealShptSalesLine: Record "Sales Line";
        DealCU: Codeunit "DEL Deal"; //Var global dans le spécifique
        DocMatrixManagement: Codeunit "DEL DocMatrix Management";
        //Var global dans le spécifique        ShipmentSelected: Boolean;
        //Var global dans le spécifique        ShptUpdateRequestID: Code[20]; //Var global dans le spécifique
        ValueSpecial: Code[20];


    BEGIN

        PurchDealShipmentSelection.RESET();
        PurchDealShipmentSelection.SETRANGE("Document Type", PurchDealShipmentSelection."Document Type"::"Purchase Header");
        PurchDealShipmentSelection.SETRANGE("Document No.", PurchOrderNo);
        PurchDealShipmentSelection.SETRANGE(Checked, TRUE);
        IF PurchDealShipmentSelection.FINDFIRST() THEN BEGIN
            DealShipmentSelection.RESET();
            DealShipmentSelection.SETRANGE("Document Type", DealShipmentSelection."Document Type"::"Sales Header");
            DealShipmentSelection.SETRANGE("Document No.", SalesOrderNo);
            DealShipmentSelection.SETRANGE(Deal_ID, PurchDealShipmentSelection.Deal_ID);
            DealShipmentSelection.SETRANGE("Shipment No.", PurchDealShipmentSelection."Shipment No.");
            DealShipmentSelection.SETRANGE(Checked, TRUE);
            IF NOT DealShipmentSelection.FINDFIRST() THEN BEGIN
                ValueSpecial := '';
                DealShipmentSelection.RESET();
                DealShipmentSelection.SETRANGE("Document Type", DealShipmentSelection."Document Type"::"Sales Header");
                DealShipmentSelection.SETRANGE("Document No.", SalesOrderNo);
                DealShipmentSelection.DELETEALL();

                DealShptSalesLine.RESET();
                DealShptSalesLine.SETCURRENTKEY("Special Order Purchase No.");
                DealShptSalesLine.ASCENDING(FALSE);
                DealShptSalesLine.SETRANGE("Document Type", DealShptSalesLine."Document Type"::Order);
                DealShptSalesLine.SETRANGE("Document No.", SalesOrderNo);
                DealShptSalesLine.SETFILTER("Special Order Purchase No.", '<>%1', '');
                IF DealShptSalesLine.FIND('-') THEN BEGIN
                    REPEAT
                        IF ValueSpecial <> DealShptSalesLine."Special Order Purchase No." THEN BEGIN
                            Element.SETRANGE("Type No.", DealShptSalesLine."Special Order Purchase No.");
                            IF Element.FIND('-') THEN BEGIN
                                Deal.RESET();
                                Deal.SETRANGE(ID, Element.Deal_ID);
                                Deal.SETFILTER(Status, '<>%1', Deal.Status::Closed);
                                IF Deal.FIND('-') THEN
                                    REPEAT
                                        DealShipment.RESET();
                                        DealShipment.SETRANGE(Deal_ID, Deal.ID);
                                        IF DealShipment.FIND('-') THEN
                                            REPEAT
                                                DealShipmentSelection.INIT();
                                                DealShipmentSelection."Document Type" := DealShipmentSelection."Document Type"::"Sales Header";
                                                DealShipmentSelection."Document No." := SalesOrderNo;
                                                DealShipmentSelection.Deal_ID := Deal.ID;
                                                DealShipmentSelection."Shipment No." := DealShipment.ID;
                                                DealShipmentSelection.USER_ID := USERID;
                                                DealShipmentSelection."BR No." := DealShipment."BR No.";
                                                DealShipmentSelection."Purchase Invoice No." := DealShipment."Purchase Invoice No.";
                                                DealShipmentSelection."Sales Invoice No." := DealShipment."Sales Invoice No.";

                                                IF (Deal.ID = PurchDealShipmentSelection.Deal_ID) AND (DealShipment.ID = PurchDealShipmentSelection."Shipment No.") THEN
                                                    DealShipmentSelection.Checked := TRUE;

                                                DealShipmentSelection.INSERT();
                                            UNTIL DealShipment.NEXT() = 0;
                                    UNTIL Deal.NEXT() = 0;

                                ValueSpecial := DealShptSalesLine."Special Order Purchase No.";
                            END;
                        END;
                    UNTIL DealShptSalesLine.NEXT() = 0;
                END;
            END;
        END;
        // TODO
        // DocMatrixManagement.TestShipmentSelectionBeforeUptdateRequest(SalesHeader, PostDealShipmentSelection, ShptUpdateRequestID, ShipmentSelected);
        // DealCU.FNC_Reinit_Deal(PostDealShipmentSelection.Deal_ID, FALSE, TRUE);
    END;

    PROCEDURE SkipCUCommit(Skip: Boolean)
    var
        SkipCommit: Boolean;
    BEGIN
        SkipCommit := Skip;
    END;
    //TODO COD80  //Get et le set des var boolean 
    // LOCAL PROCEDURE UpdateWhseDocuments();
    // var
    //     FunstionMgt: Codeunit "DEL MGTS_Functions Mgt";
    // BEGIN
    //     IF WhseReceive THEN BEGIN
    //         //MGTS0123; MHH; single
    //         FunstionMgt.SkipCUCommit(SkipCommit);
    //         WhsePostRcpt.PostUpdateWhseDocuments(WhseRcptHeader);
    //         TempWhseRcptHeader.DELETE;
    //     END;
    //     IF WhseShip THEN BEGIN
    //         //MGTS0123; MHH; single
    //         FunstionMgt.SkipCUCommit(SkipCommit);
    //         WhsePostShpt.PostUpdateWhseDocuments(WhseShptHeader);
    //         TempWhseShptHeader.DELETE;
    //     END;
    // END;


}




