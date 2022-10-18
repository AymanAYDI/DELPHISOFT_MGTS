codeunit 50038 "DEL Deal Item Completer"
{
    trigger OnRun()
    begin
        EXIT;

        CompleteDeal_FNC('AFF-');

        MESSAGE('done !');
    end;

    var
        Deal_Cu: Codeunit "DEL Deal";
        DealItem_Cu: Codeunit "DEL Deal Item";
        Element_Cu: Codeunit "DEL Element";


    procedure CompleteDeal_FNC(DealID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";

    begin


        element_Re_Loc.RESET();
        element_Re_Loc.SETRANGE(Deal_ID, DealID_Co_Par);
        IF element_Re_Loc.FINDFIRST() THEN
            REPEAT


                CompleteElement_FNC(element_Re_Loc.ID);


            UNTIL (element_Re_Loc.NEXT() = 0);

    end;


    procedure CompleteElement_FNC(elementID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
    begin
        Element_Cu.FNC_Set_Element(element_Re_Loc, elementID_Co_Par);

        CASE element_Re_Loc.Type OF
            element_Re_Loc.Type::ACO:
                CompleteACO_FNC(element_Re_Loc.Deal_ID, element_Re_Loc."Type No.");
            element_Re_Loc.Type::VCO:
                CompleteVCO_FNC(element_Re_Loc.Deal_ID, element_Re_Loc."Type No.");

            element_Re_Loc.Type::Fee:
                CompleteFee_FNC(element_Re_Loc.Deal_ID, element_Re_Loc."Type No.");
            element_Re_Loc.Type::Invoice:
                CompleteInvoice_FNC(element_Re_Loc.Deal_ID, element_Re_Loc."Type No.");
            element_Re_Loc.Type::BR:
                CompleteBR_FNC(element_Re_Loc.Deal_ID, element_Re_Loc."Type No.");
            element_Re_Loc.Type::BL:
                CompleteBL_FNC(element_Re_Loc.Deal_ID, element_Re_Loc."Type No.");
            element_Re_Loc.Type::"Purchase Invoice":
                CompletePurchInv_FNC(element_Re_Loc.Deal_ID, element_Re_Loc."Type No.");
            element_Re_Loc.Type::"Sales Invoice":
                CompleteSalesInv_FNC(element_Re_Loc.Deal_ID, element_Re_Loc."Type No.");
            element_Re_Loc.Type::"Purch. Cr. Memo":
                CompletePurchCrMemo_FNC(element_Re_Loc.Deal_ID, element_Re_Loc."Type No.");
            element_Re_Loc.Type::"Sales Cr. Memo":
                CompleteSalesCrMemo_FNC(element_Re_Loc.Deal_ID, element_Re_Loc."Type No.");
            element_Re_Loc.Type::Provision:
                CompleteProvision_FNC(element_Re_Loc.Deal_ID, element_Re_Loc."Type No.");
            ELSE
                ERROR('Le type d''élément ' + FORMAT(element_Re_Loc.Type) + 'n''est pas supporté dans la fonction CompleteElement du Cu 500038 !');
        END;
    end;


    procedure CompleteACO_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        PurchLine_Re_Loc: Record "Purchase Line";
        DealItem_Re_Loc: Record "DEL Deal Item";
    begin


        PurchLine_Re_Loc.RESET();
        PurchLine_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        PurchLine_Re_Loc.SETRANGE("Document Type", PurchLine_Re_Loc."Document Type"::Order);
        PurchLine_Re_Loc.SETRANGE("Document No.", DocumentNo_Co_Par);
        PurchLine_Re_Loc.SETRANGE(Type, PurchLine_Re_Loc.Type::Item);
        PurchLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF PurchLine_Re_Loc.FindSet() THEN
            REPEAT
                IF NOT DealItem_Re_Loc.GET(DealID_Co_Par, PurchLine_Re_Loc."No.") THEN
                    DealItem_Cu.FNC_Add(DealID_Co_Par, PurchLine_Re_Loc."No.");

            UNTIL (PurchLine_Re_Loc.NEXT() = 0);

    end;


    procedure CompleteVCO_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        SalesLine_Re_Loc: Record "Sales Line";
        DealItem_Re_Loc: Record "DEL Deal Item";
        ACOElement_Re_Loc: Record "DEL Element";
    begin

        Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, DealID_Co_Par);
        ACOElement_Re_Loc.FINDFIRST();

        SalesLine_Re_Loc.RESET();
        SalesLine_Re_Loc.SETRANGE("Document Type", SalesLine_Re_Loc."Document Type"::Order);
        SalesLine_Re_Loc.SETRANGE("Document No.", DocumentNo_Co_Par);
        SalesLine_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
        SalesLine_Re_Loc.SETRANGE(Type, SalesLine_Re_Loc.Type::Item);
        SalesLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF SalesLine_Re_Loc.FINDFIRST() THEN
            REPEAT

                IF NOT DealItem_Re_Loc.GET(DealID_Co_Par, SalesLine_Re_Loc."No.") THEN
                    DealItem_Cu.FNC_Add(DealID_Co_Par, SalesLine_Re_Loc."No.");


            UNTIL (SalesLine_Re_Loc.NEXT() = 0)

    end;


    procedure CompleteFee_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
    begin
    end;


    procedure CompleteInvoice_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
    begin
    end;


    procedure CompleteBR_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        DealItem_Re_Loc: Record "DEL Deal Item";
    begin


        purchRcptLine_Re_Loc.RESET();
        purchRcptLine_Re_Loc.SETRANGE("Document No.", DocumentNo_Co_Par);
        purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
        purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF purchRcptLine_Re_Loc.FINDFIRST() THEN
            REPEAT

                IF NOT DealItem_Re_Loc.GET(DealID_Co_Par, purchRcptLine_Re_Loc."No.") THEN
                    DealItem_Cu.FNC_Add(DealID_Co_Par, purchRcptLine_Re_Loc."No.");

            UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

    end;


    procedure CompleteBL_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var

    begin
    end;


    procedure CompletePurchInv_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        purchInvLine_Re_Loc: Record "Purch. Inv. Line";
        DealItem_Re_Loc: Record "DEL Deal Item";
    begin

        purchInvLine_Re_Loc.RESET();
        purchInvLine_Re_Loc.SETRANGE("Document No.", DocumentNo_Co_Par);
        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF purchInvLine_Re_Loc.FINDFIRST() THEN
            REPEAT

                IF NOT DealItem_Re_Loc.GET(DealID_Co_Par, purchInvLine_Re_Loc."No.") THEN
                    DealItem_Cu.FNC_Add(DealID_Co_Par, purchInvLine_Re_Loc."No.");


            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);

    end;


    procedure CompleteSalesInv_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        salesInvLine_Re_Loc: Record "Sales Invoice Line";
        DealItem_Re_Loc: Record "DEL Deal Item";
        ACOElement_Re_Loc: Record "DEL Element";
    begin

        Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, DealID_Co_Par);
        ACOElement_Re_Loc.FINDFIRST();

        salesInvLine_Re_Loc.RESET();
        salesInvLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
        salesInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
        salesInvLine_Re_Loc.SETRANGE(Type, salesInvLine_Re_Loc.Type::Item);
        salesInvLine_Re_Loc.SETRANGE("Document No.", DocumentNo_Co_Par);
        salesInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF salesInvLine_Re_Loc.FINDFIRST() THEN
            REPEAT

                IF NOT DealItem_Re_Loc.GET(DealID_Co_Par, salesInvLine_Re_Loc."No.") THEN
                    DealItem_Cu.FNC_Add(DealID_Co_Par, salesInvLine_Re_Loc."No.");
            UNTIL (salesInvLine_Re_Loc.NEXT() = 0);

    end;


    procedure CompletePurchCrMemo_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
    begin
    end;


    procedure CompleteSalesCrMemo_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
    begin
    end;


    procedure CompleteProvision_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
    begin
    end;
}

