codeunit 50038 "Deal Item Completer"
{
    // Ajoute les deal item manquants pour une affaire


    trigger OnRun()
    begin
        EXIT;

        CompleteDeal_FNC('AFF-');

        MESSAGE('done !');
    end;

    var
        Deal_Cu: Codeunit "50020";
        DealItem_Cu: Codeunit "50024";
        Element_Cu: Codeunit "50021";

    [Scope('Internal')]
    procedure CompleteDeal_FNC(DealID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
    begin
        //parcours les éléments d'une affaire et ajoute les articles dans Deal Item si inexistants

        element_Re_Loc.RESET();
        element_Re_Loc.SETRANGE(Deal_ID, DealID_Co_Par);
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT

                //complète l'élément
                CompleteElement_FNC(element_Re_Loc.ID);

                /*
                //complète les éléments auxquels il s'applique
                elementConnection_Re_Loc.RESET();
                elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                IF elementConnection_Re_Loc.FINDFIRST THEN
                REPEAT
                  CompleteElement_FNC(elementConnection_Re_Loc."Apply To");
                UNTIL(elementConnection_Re_Loc.NEXT()=0);
                */

            UNTIL (element_Re_Loc.NEXT() = 0);

    end;

    [Scope('Internal')]
    procedure CompleteElement_FNC(elementID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "50021";
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

    [Scope('Internal')]
    procedure CompleteACO_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        PurchLine_Re_Loc: Record "39";
        DealItem_Re_Loc: Record "50023";
    begin
        //parcours les lignes d'une commande achat et ajoute l'article dans Deal Item si inexistant

        //MESSAGE('checking ' + DealID_Co_Par + ' and Document No. ' + DocumentNo_Co_Par);

        PurchLine_Re_Loc.RESET();
        PurchLine_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        PurchLine_Re_Loc.SETRANGE("Document Type", PurchLine_Re_Loc."Document Type"::Order);
        PurchLine_Re_Loc.SETRANGE("Document No.", DocumentNo_Co_Par);
        PurchLine_Re_Loc.SETRANGE(Type, PurchLine_Re_Loc.Type::Item);
        PurchLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF PurchLine_Re_Loc.FINDFIRST THEN
            REPEAT
                IF NOT DealItem_Re_Loc.GET(DealID_Co_Par, PurchLine_Re_Loc."No.") THEN BEGIN
                    DealItem_Cu.FNC_Add(DealID_Co_Par, PurchLine_Re_Loc."No.");
                    /*
                    MESSAGE(
                      'Found Deal Item ' + PurchLine_Re_Loc."No." + ' on ACO ' + DocumentNo_Co_Par +
                      ' for Deal ID ' + DealID_Co_Par + ' !'
                    );
                    */
                END;
            UNTIL (PurchLine_Re_Loc.NEXT() = 0);

    end;

    [Scope('Internal')]
    procedure CompleteVCO_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        SalesLine_Re_Loc: Record "37";
        DealItem_Re_Loc: Record "50023";
        ACOElement_Re_Loc: Record "50021";
    begin
        //parcours les lignes d'une commande vente et ajoute l'article dans Deal Item si inexistant

        //MESSAGE('checking ' + DealID_Co_Par + ' and Document No. ' + DocumentNo_Co_Par);

        Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, DealID_Co_Par);
        ACOElement_Re_Loc.FINDFIRST;

        SalesLine_Re_Loc.RESET();
        SalesLine_Re_Loc.SETRANGE("Document Type", SalesLine_Re_Loc."Document Type"::Order);
        SalesLine_Re_Loc.SETRANGE("Document No.", DocumentNo_Co_Par);
        SalesLine_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
        SalesLine_Re_Loc.SETRANGE(Type, SalesLine_Re_Loc.Type::Item);
        SalesLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF SalesLine_Re_Loc.FINDFIRST THEN
            REPEAT

                IF NOT DealItem_Re_Loc.GET(DealID_Co_Par, SalesLine_Re_Loc."No.") THEN BEGIN
                    DealItem_Cu.FNC_Add(DealID_Co_Par, SalesLine_Re_Loc."No.");
                    /*
                    MESSAGE(
                      'Found Deal Item ' + SalesLine_Re_Loc."No." + ' on VCO ' + DocumentNo_Co_Par +
                      ' for Deal ID ' + DealID_Co_Par + ' !'
                    );
                    */
                END;

            UNTIL (SalesLine_Re_Loc.NEXT() = 0)

    end;

    [Scope('Internal')]
    procedure CompleteFee_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        PurchLine_Re_Loc: Record "39";
        DealItem_Re_Loc: Record "50023";
    begin
    end;

    [Scope('Internal')]
    procedure CompleteInvoice_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        PurchLine_Re_Loc: Record "39";
        DealItem_Re_Loc: Record "50023";
    begin
    end;

    [Scope('Internal')]
    procedure CompleteBR_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        purchRcptLine_Re_Loc: Record "121";
        DealItem_Re_Loc: Record "50023";
    begin
        //parcours les lignes d'un bulletin de réception et ajoute l'article dans Deal Item si inexistant

        //MESSAGE('checking ' + DealID_Co_Par + ' and Document No. ' + DocumentNo_Co_Par);

        purchRcptLine_Re_Loc.RESET();
        purchRcptLine_Re_Loc.SETRANGE("Document No.", DocumentNo_Co_Par);
        purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
        purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF purchRcptLine_Re_Loc.FINDFIRST THEN
            REPEAT

                IF NOT DealItem_Re_Loc.GET(DealID_Co_Par, purchRcptLine_Re_Loc."No.") THEN BEGIN
                    DealItem_Cu.FNC_Add(DealID_Co_Par, purchRcptLine_Re_Loc."No.");
                    /*
                    MESSAGE(
                      'Found Deal Item ' + purchRcptLine_Re_Loc."No." + ' on BR ' + DocumentNo_Co_Par +
                      ' for Deal ID ' + DealID_Co_Par + ' !'
                    );
                    */
                END;

            UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

    end;

    [Scope('Internal')]
    procedure CompleteBL_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        PurchLine_Re_Loc: Record "39";
        DealItem_Re_Loc: Record "50023";
    begin
    end;

    [Scope('Internal')]
    procedure CompletePurchInv_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        purchInvLine_Re_Loc: Record "123";
        DealItem_Re_Loc: Record "50023";
    begin
        //parcours les lignes d'une facture achat et ajoute l'article dans Deal Item si inexistant

        //MESSAGE('checking ' + DealID_Co_Par + ' and Document No. ' + DocumentNo_Co_Par);

        purchInvLine_Re_Loc.RESET();
        purchInvLine_Re_Loc.SETRANGE("Document No.", DocumentNo_Co_Par);
        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF purchInvLine_Re_Loc.FINDFIRST THEN
            REPEAT

                IF NOT DealItem_Re_Loc.GET(DealID_Co_Par, purchInvLine_Re_Loc."No.") THEN BEGIN
                    DealItem_Cu.FNC_Add(DealID_Co_Par, purchInvLine_Re_Loc."No.");
                    /*
                    MESSAGE(
                      'Found Deal Item ' + purchInvLine_Re_Loc."No." + ' on purchase inv. ' + DocumentNo_Co_Par +
                      ' for Deal ID ' + DealID_Co_Par + ' !'
                    );
                    */
                END;

            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);

    end;

    [Scope('Internal')]
    procedure CompleteSalesInv_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        salesInvLine_Re_Loc: Record "113";
        DealItem_Re_Loc: Record "50023";
        ACOElement_Re_Loc: Record "50021";
    begin
        //parcours les lignes d'une facture vente et ajoute l'article dans Deal Item si inexistant

        //MESSAGE('checking ' + DealID_Co_Par + ' and Document No. ' + DocumentNo_Co_Par);

        Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, DealID_Co_Par);
        ACOElement_Re_Loc.FINDFIRST;

        salesInvLine_Re_Loc.RESET();
        salesInvLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
        salesInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
        salesInvLine_Re_Loc.SETRANGE(Type, salesInvLine_Re_Loc.Type::Item);
        salesInvLine_Re_Loc.SETRANGE("Document No.", DocumentNo_Co_Par);
        salesInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF salesInvLine_Re_Loc.FINDFIRST THEN
            REPEAT

                IF NOT DealItem_Re_Loc.GET(DealID_Co_Par, salesInvLine_Re_Loc."No.") THEN BEGIN
                    DealItem_Cu.FNC_Add(DealID_Co_Par, salesInvLine_Re_Loc."No.");
                    /*
                    MESSAGE(
                      'Found Deal Item ' + salesInvLine_Re_Loc."No." + ' on sales inv. ' + DocumentNo_Co_Par +
                      ' for Deal ID ' + DealID_Co_Par + ' !'
                    );
                    */
                END;

            UNTIL (salesInvLine_Re_Loc.NEXT() = 0);

    end;

    [Scope('Internal')]
    procedure CompletePurchCrMemo_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        PurchLine_Re_Loc: Record "39";
        DealItem_Re_Loc: Record "50023";
    begin
    end;

    [Scope('Internal')]
    procedure CompleteSalesCrMemo_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        PurchLine_Re_Loc: Record "39";
        DealItem_Re_Loc: Record "50023";
    begin
    end;

    [Scope('Internal')]
    procedure CompleteProvision_FNC(DealID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    var
        PurchLine_Re_Loc: Record "39";
        DealItem_Re_Loc: Record "50023";
    begin
    end;
}

