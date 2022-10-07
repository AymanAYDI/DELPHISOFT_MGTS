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
    //PROC de CDU 80
    procedure OnAfterInsertPostedHeaders(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHdr: Record "Sales Cr.Memo Header"; var ReceiptHeader: Record "Return Receipt Header")
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        element_Re_Loc: Record "DEL Element";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        Element_Cu: Codeunit "DEL Element";
        Deal_Cu: Codeunit "DEL Deal";

        add_Variant_Op_Loc: option New,Existing;

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
                dealShipmentSelection_Re_Loc.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                dealShipmentSelection_Re_Loc.SETRANGE("Document Type",
                    dealShipmentSelection_Re_Loc."Document Type"::"Sales Cr. Memo");
                dealShipmentSelection_Re_Loc.SETRANGE(Checked, TRUE);
                dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
                IF dealShipmentSelection_Re_Loc.FindFirst() THEN
                    Element_Cu.FNC_Add_Sales_Cr_Memo(
                      dealShipmentSelection_Re_Loc.Deal_ID,
                      SalesCrMemoHeader,
                      dealShipmentSelection_Re_Loc."Shipment No.",
                      add_Variant_Op_Loc::New);
            end;
    end;

    procedure SkipCUCommit(Skip: Boolean)
    var

        SkipCommit: Boolean;
    begin
        SkipCommit := Skip;
    end;

    procedure ReverseProvisionEntries(SalesHeader: Record "Sales Header")
    var
        GLEntryProvision: Record "G/L Entry";
        BalGLEntry: Record "G/L Entry";
        TempGLEntry: Record "G/L Entry";
        GLEntryVATEntry: Record "G/L Entry - VAT Entry Link";
        GlobalVATEntry: Record "VAT Entry";
        GlobalGLEntry: Record "G/L Entry";
        VATEntryProvision: Record "VAT Entry";
        GLSetup: Record "General Ledger Setup";
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





}
