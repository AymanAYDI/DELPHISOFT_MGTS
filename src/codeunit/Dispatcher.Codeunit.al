codeunit 50026 Dispatcher
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 16.07.09                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01  RC4                       09.09.08   Created Doc
    //                                  20.04.09   Adapted Postion Insert Function Params
    // CHG02                            16.06.09   changed array dimension to 300
    // CHG03                            16.07.09   added FNC_Element_Quantity function


    trigger OnRun()
    begin
    end;

    var
        Element_Cu: Codeunit "50021";
        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';
        Position_Cu: Codeunit "50022";
        Fee_Cu: Codeunit "50023";
        Currency_Exchange_Re: Record "50028";
        DealItem_Cu: Codeunit "50024";
        MyError_Te: Text[1024];

    [Scope('Internal')]
    procedure FNC_Dispatch_Amount(var Value_Ar_Par: array[300] of Decimal; ArrayAmount_Dec_Par: Decimal; ElementAmount_Dec_Par: Decimal)
    var
        arrayIndex: Integer;
    begin
        /*ON CALCULE LE POURCENTAGE DE CHAQUE LIGNE DU TABLEAU PAR RAPPORT AU TOTAL ET ON MULTIPLIE PAR LA SOMME DU FRAIS*/
        arrayIndex := 1;

        WHILE arrayIndex <= 300 DO BEGIN
            Value_Ar_Par[arrayIndex] := ((Value_Ar_Par[arrayIndex] * 1) / ArrayAmount_Dec_Par) * ElementAmount_Dec_Par;
            arrayIndex += 1;
        END;

    end;

    [Scope('Internal')]
    procedure FNC_Element_Value(var Value_Ar_Par: array[300] of Decimal; Element_ID_Co_Par: Code[20]; FilterOnDealID_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
        arrayIndex: Integer;
        applyElement_Re_Loc: Record "50021";
        addPositions_Bo_Loc: Boolean;
    begin
        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        MyError_Te := '';

        //itération sur Element Connection pour savoir à quel(s) Element(s) s'applique(nt) le Fee ou l'Invoice
        elementConnection_Re_Loc.RESET();
        elementConnection_Re_Loc.SETCURRENTKEY(Element_ID, "Split Index");
        elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

        //on peut associer un élément avec max. 300 autres
        IF elementConnection_Re_Loc.COUNT() > 300 THEN
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_Prorata_Value()', 'Array trop petit !');

        //step 1 : SOMME DES AMOUNT DE CHAQUE ELEMENT
        arrayIndex := 1;
        IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN
            REPEAT

                IF FilterOnDealID_Bo_Par THEN BEGIN

                    addPositions_Bo_Loc := FALSE;

                    //Si elementconnection.apply to fait parti de l'affaire elementconnection.dealID
                    applyElement_Re_Loc.RESET();
                    applyElement_Re_Loc.SETRANGE(Deal_ID, elementConnection_Re_Loc.Deal_ID);
                    applyElement_Re_Loc.SETRANGE(ID, elementConnection_Re_Loc."Apply To");
                    IF applyElement_Re_Loc.FINDFIRST THEN
                        addPositions_Bo_Loc := TRUE;

                    IF addPositions_Bo_Loc THEN BEGIN

                        Value_Ar_Par[arrayIndex] := Element_Cu.FNC_Get_Amount_LCY(elementConnection_Re_Loc."Apply To");
                        //CHG
                        IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                            MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                        //CHG
                        arrayIndex += 1;

                    END;

                END ELSE BEGIN

                    Value_Ar_Par[arrayIndex] := Element_Cu.FNC_Get_Amount_LCY(elementConnection_Re_Loc."Apply To");
                    //CHG
                    IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                        MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                    //CHG
                    arrayIndex += 1;

                END;

            UNTIL (elementConnection_Re_Loc.NEXT = 0);

            //CHG
            IF (FNC_Array_Sum(Value_Ar_Par) = 0) THEN
                ERROR('L''élément >' + element_Re_Loc.ID + '< de l''affaire ' + element_Re_Loc.Deal_ID + ' ne peut pas être réparti' +
                ' car le total des éléments auxquel il est lié vaut 0 : ' + MyError_Te);
            //CHG

        END ELSE
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_Value()',
              STRSUBSTNO('Aucune connection élément pour élément ID >%1<', element_Re_Loc.ID));
    end;

    [Scope('Internal')]
    procedure FNC_Element_Volume(var Value_Ar_Par: array[300] of Decimal; Element_ID_Co_Par: Code[20]; FilterOnDealID_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
        arrayIndex: Integer;
        applyElement_Re_Loc: Record "50021";
        addPositions_Bo_Loc: Boolean;
    begin
        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        MyError_Te := '';

        //itération sur Element Connection pour savoir à quel(s) Element(s) s'applique(nt) le Fee ou l'Invoice
        elementConnection_Re_Loc.RESET();
        elementConnection_Re_Loc.SETCURRENTKEY(Element_ID, "Split Index");
        elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

        //on peut associer un élément avec max. 300 autres
        IF elementConnection_Re_Loc.COUNT() > 300 THEN
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_Volume()', 'Array trop petit !');

        //step 1 : SOMME DES VOLUME DE CHAQUE ELEMENT
        arrayIndex := 1;
        IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN
            REPEAT

                IF FilterOnDealID_Bo_Par THEN BEGIN

                    addPositions_Bo_Loc := FALSE;

                    //Si elementconnection.apply to fait parti de l'affaire elementconnection.dealID
                    applyElement_Re_Loc.RESET();
                    applyElement_Re_Loc.SETRANGE(Deal_ID, elementConnection_Re_Loc.Deal_ID);
                    applyElement_Re_Loc.SETRANGE(ID, elementConnection_Re_Loc."Apply To");
                    IF applyElement_Re_Loc.FINDFIRST THEN
                        addPositions_Bo_Loc := TRUE;

                    IF addPositions_Bo_Loc THEN BEGIN

                        Value_Ar_Par[arrayIndex] := Element_Cu.FNC_Get_Volume(elementConnection_Re_Loc."Apply To");
                        //CHG
                        IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                            MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                        //CHG
                        arrayIndex += 1;

                    END;

                END ELSE BEGIN

                    Value_Ar_Par[arrayIndex] := Element_Cu.FNC_Get_Volume(elementConnection_Re_Loc."Apply To");
                    //CHG
                    IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                        MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                    //CHG
                    arrayIndex += 1;

                END;

            UNTIL (elementConnection_Re_Loc.NEXT = 0);

            //CHG
            IF (FNC_Array_Sum(Value_Ar_Par) = 0) THEN
                ERROR('L''élément >' + element_Re_Loc.ID + '< de l''affaire ' + element_Re_Loc.Deal_ID + ' ne peut pas être réparti' +
                ' car le total des éléments auxquel il est lié vaut 0 : ' + MyError_Te);
            //CHG

        END ELSE
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_Element_Volume()',
              STRSUBSTNO('Aucune connection élément pour élément ID >%1<', element_Re_Loc.ID));
    end;

    [Scope('Internal')]
    procedure FNC_Element_VolumeTransport(var Value_Ar_Par: array[300] of Decimal; Element_ID_Co_Par: Code[20]; FilterOnDealID_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
        arrayIndex: Integer;
        applyElement_Re_Loc: Record "50021";
        addPositions_Bo_Loc: Boolean;
    begin
        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        MyError_Te := '';

        //itération sur Element Connection pour savoir à quel(s) Element(s) s'applique(nt) le Fee ou l'Invoice
        elementConnection_Re_Loc.RESET();
        elementConnection_Re_Loc.SETCURRENTKEY(Element_ID, "Split Index");
        elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

        //on peut associer un élément avec max. 300 autres
        IF elementConnection_Re_Loc.COUNT() > 300 THEN
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_VolumeTransport()', 'Array trop petit !');

        //step 1 : SOMME DES VOLUME DE CHAQUE ELEMENT
        arrayIndex := 1;
        IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN
            REPEAT

                IF FilterOnDealID_Bo_Par THEN BEGIN

                    addPositions_Bo_Loc := FALSE;

                    //Si elementconnection.apply to fait parti de l'affaire elementconnection.dealID
                    applyElement_Re_Loc.RESET();
                    applyElement_Re_Loc.SETRANGE(Deal_ID, elementConnection_Re_Loc.Deal_ID);
                    applyElement_Re_Loc.SETRANGE(ID, elementConnection_Re_Loc."Apply To");
                    IF applyElement_Re_Loc.FINDFIRST THEN
                        addPositions_Bo_Loc := TRUE;

                    IF addPositions_Bo_Loc THEN BEGIN

                        Value_Ar_Par[arrayIndex] := Element_Cu.FNC_Get_VolumeTransport(elementConnection_Re_Loc."Apply To");
                        //CHG
                        IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                            MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                        //CHG
                        arrayIndex += 1;

                    END;

                END ELSE BEGIN

                    Value_Ar_Par[arrayIndex] := Element_Cu.FNC_Get_VolumeTransport(elementConnection_Re_Loc."Apply To");
                    //CHG
                    IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                        MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                    //CHG
                    arrayIndex += 1;

                END;

            UNTIL (elementConnection_Re_Loc.NEXT = 0);

            //CHG
            IF (FNC_Array_Sum(Value_Ar_Par) = 0) THEN
                ERROR('L''élément >' + element_Re_Loc.ID + '< de l''affaire ' + element_Re_Loc.Deal_ID + ' ne peut pas être réparti' +
                ' car le total des éléments auxquel il est lié vaut 0 : ' + MyError_Te);
            //CHG

        END ELSE
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_VolumeTransport()',
              STRSUBSTNO('Aucune connection élément pour élément ID >%1<', element_Re_Loc.ID));
    end;

    [Scope('Internal')]
    procedure FNC_Element_Gross_Weight(var Value_Ar_Par: array[300] of Decimal; Element_ID_Co_Par: Code[20]; FilterOnDealID_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
        arrayIndex: Integer;
        applyElement_Re_Loc: Record "50021";
        addPositions_Bo_Loc: Boolean;
    begin
        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        MyError_Te := '';

        //itération sur Element Connection pour savoir à quel(s) Element(s) s'applique(nt) le Fee ou l'Invoice
        elementConnection_Re_Loc.RESET();
        elementConnection_Re_Loc.SETCURRENTKEY(Element_ID, "Split Index");
        elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

        //on peut associer un élément avec max. 300 autres
        IF elementConnection_Re_Loc.COUNT() > 300 THEN
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_Gross_Weight()', 'Array trop petit !');

        //step 1 : SOMME DES POIDS BRUT DE CHAQUE ELEMENT
        arrayIndex := 1;
        IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN
            REPEAT

                IF FilterOnDealID_Bo_Par THEN BEGIN

                    addPositions_Bo_Loc := FALSE;

                    //Si elementconnection.apply to fait parti de l'affaire elementconnection.dealID
                    applyElement_Re_Loc.RESET();
                    applyElement_Re_Loc.SETRANGE(Deal_ID, elementConnection_Re_Loc.Deal_ID);
                    applyElement_Re_Loc.SETRANGE(ID, elementConnection_Re_Loc."Apply To");
                    IF applyElement_Re_Loc.FINDFIRST THEN
                        addPositions_Bo_Loc := TRUE;

                    IF addPositions_Bo_Loc THEN BEGIN

                        Value_Ar_Par[arrayIndex] := Element_Cu.FNC_Get_Gross_Weight(elementConnection_Re_Loc."Apply To");
                        //CHG
                        IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                            MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                        //CHG
                        arrayIndex += 1;

                    END;

                END ELSE BEGIN

                    Value_Ar_Par[arrayIndex] := Element_Cu.FNC_Get_Gross_Weight(elementConnection_Re_Loc."Apply To");
                    //CHG
                    IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                        MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                    //CHG
                    arrayIndex += 1;

                END;

            UNTIL (elementConnection_Re_Loc.NEXT = 0);

            //CHG
            IF (FNC_Array_Sum(Value_Ar_Par) = 0) THEN
                ERROR('L''élément >' + element_Re_Loc.ID + '< de l''affaire ' + element_Re_Loc.Deal_ID + ' ne peut pas être réparti' +
                ' car le total des éléments auxquel il est lié vaut 0 : ' + MyError_Te);
            //CHG

        END ELSE
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_Gross_Weight()',
              STRSUBSTNO('Aucune connection élément pour élément ID >%1<', element_Re_Loc.ID));
    end;

    [Scope('Internal')]
    procedure FNC_Element_SommeCout(var Value_Ar_Par: array[300] of Decimal; Element_ID_Co_Par: Code[20]; FilterOnDealID_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
        arrayIndex: Integer;
        applyElement_Re_Loc: Record "50021";
        addPositions_Bo_Loc: Boolean;
    begin
        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        MyError_Te := '';

        //itération sur Element Connection pour savoir à quel(s) Element(s) s'applique(nt) le Fee ou l'Invoice
        elementConnection_Re_Loc.RESET();
        elementConnection_Re_Loc.SETCURRENTKEY(Element_ID, "Split Index");
        elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

        //on peut associer un élément avec max. 300 autres
        IF elementConnection_Re_Loc.COUNT() > 300 THEN
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_SommeCout()', 'Array trop petit !');

        //step 1 : pour cette règle de répartition, on veut donner à chaque livraison le meme poids ! de cette manière,
        //le frais sera distribué de manière égale sur toutes les livraisons : p.e. un frais de 300.- sur trois livraisons = 100.- sur
        //chaque peut importe le contenu
        arrayIndex := 1;
        IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN
            REPEAT

                IF FilterOnDealID_Bo_Par THEN BEGIN

                    addPositions_Bo_Loc := FALSE;

                    //Si elementconnection.apply to fait parti de l'affaire elementconnection.dealID
                    applyElement_Re_Loc.RESET();
                    applyElement_Re_Loc.SETRANGE(Deal_ID, elementConnection_Re_Loc.Deal_ID);
                    applyElement_Re_Loc.SETRANGE(ID, elementConnection_Re_Loc."Apply To");
                    IF applyElement_Re_Loc.FINDFIRST THEN
                        addPositions_Bo_Loc := TRUE;

                    IF addPositions_Bo_Loc THEN BEGIN

                        Value_Ar_Par[arrayIndex] := 1; //peut importe la valeur.. tant qu'elle est la meme pour tous les éléments du tableau..
                                                       //CHG
                        IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                            MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                        //CHG
                        arrayIndex += 1;

                    END;

                END ELSE BEGIN

                    Value_Ar_Par[arrayIndex] := 1; //peut importe la valeur.. tant qu'elle est la meme pour tous les éléments du tableau..
                                                   //CHG
                    IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                        MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                    //CHG
                    arrayIndex += 1;

                END;

            UNTIL (elementConnection_Re_Loc.NEXT = 0);

            //CHG
            IF (FNC_Array_Sum(Value_Ar_Par) = 0) THEN
                ERROR('L''élément >' + element_Re_Loc.ID + '< de l''affaire ' + element_Re_Loc.Deal_ID + ' ne peut pas être réparti' +
                ' car le total des éléments auxquel il est lié vaut 0 : ' + MyError_Te);
            //CHG

        END ELSE
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_SommeCout()',
              STRSUBSTNO('Aucune connection élément pour élément ID >%1<', element_Re_Loc.ID));
    end;

    [Scope('Internal')]
    procedure FNC_Element_Colis(var Value_Ar_Par: array[300] of Decimal; Element_ID_Co_Par: Code[20]; FilterOnDealID_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
        arrayIndex: Integer;
        applyElement_Re_Loc: Record "50021";
        addPositions_Bo_Loc: Boolean;
    begin
        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        MyError_Te := '';

        //itération sur Element Connection pour savoir à quel(s) Element(s) s'applique(nt) le Fee ou l'Invoice
        elementConnection_Re_Loc.RESET();
        elementConnection_Re_Loc.SETCURRENTKEY(Element_ID, "Split Index");
        elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

        //on peut associer un élément avec max. 300 autres
        IF elementConnection_Re_Loc.COUNT() > 300 THEN
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_Colis()', 'Array trop petit !');

        //step 1 : SOMME DES COLIS DE CHAQUE ELEMENT
        arrayIndex := 1;
        IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN
            REPEAT

                IF FilterOnDealID_Bo_Par THEN BEGIN

                    addPositions_Bo_Loc := FALSE;

                    //Si elementconnection.apply to fait parti de l'affaire elementconnection.dealID
                    applyElement_Re_Loc.RESET();
                    applyElement_Re_Loc.SETRANGE(Deal_ID, elementConnection_Re_Loc.Deal_ID);
                    applyElement_Re_Loc.SETRANGE(ID, elementConnection_Re_Loc."Apply To");
                    IF applyElement_Re_Loc.FINDFIRST THEN
                        addPositions_Bo_Loc := TRUE;

                    IF addPositions_Bo_Loc THEN BEGIN

                        Value_Ar_Par[arrayIndex] := Element_Cu.FNC_Get_Colis(elementConnection_Re_Loc."Apply To");
                        //CHG
                        IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                            MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                        //CHG
                        arrayIndex += 1;

                    END;

                END ELSE BEGIN

                    Value_Ar_Par[arrayIndex] := Element_Cu.FNC_Get_Colis(elementConnection_Re_Loc."Apply To");
                    //CHG
                    IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                        MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                    //CHG
                    arrayIndex += 1;

                END;

            UNTIL (elementConnection_Re_Loc.NEXT = 0);

            //CHG
            IF (FNC_Array_Sum(Value_Ar_Par) = 0) THEN
                ERROR('L''élément >' + element_Re_Loc.ID + '< de l''affaire ' + element_Re_Loc.Deal_ID + ' ne peut pas être réparti' +
                ' car le total des éléments auxquel il est lié vaut 0 : ' + MyError_Te);
            //CHG

        END ELSE
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_Colis()',
              STRSUBSTNO('Aucune connection élément pour élément ID >%1<', element_Re_Loc.ID));
    end;

    [Scope('Internal')]
    procedure FNC_Element_Quantity(var Value_Ar_Par: array[300] of Decimal; Element_ID_Co_Par: Code[20]; FilterOnDealID_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
        arrayIndex: Integer;
        applyElement_Re_Loc: Record "50021";
        addPositions_Bo_Loc: Boolean;
    begin
        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        MyError_Te := '';

        //itération sur Element Connection pour savoir à quel(s) Element(s) s'applique(nt) le Fee ou l'Invoice
        elementConnection_Re_Loc.RESET();
        elementConnection_Re_Loc.SETCURRENTKEY(Element_ID, "Split Index");
        elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

        //on peut associer un élément avec max. 300 autres
        IF elementConnection_Re_Loc.COUNT() > 300 THEN
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_Prorata_Value()', 'Array trop petit !');

        //step 1 : SOMME DES Quantity DE CHAQUE ELEMENT
        arrayIndex := 1;
        IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN
            REPEAT

                IF FilterOnDealID_Bo_Par THEN BEGIN

                    addPositions_Bo_Loc := FALSE;

                    //Si elementconnection.apply to fait parti de l'affaire elementconnection.dealID
                    applyElement_Re_Loc.RESET();
                    applyElement_Re_Loc.SETRANGE(Deal_ID, elementConnection_Re_Loc.Deal_ID);
                    applyElement_Re_Loc.SETRANGE(ID, elementConnection_Re_Loc."Apply To");
                    IF applyElement_Re_Loc.FINDFIRST THEN
                        addPositions_Bo_Loc := TRUE;

                    IF addPositions_Bo_Loc THEN BEGIN

                        Value_Ar_Par[arrayIndex] := Element_Cu.FNC_Get_Quantity(elementConnection_Re_Loc."Apply To");
                        //CHG
                        IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                            MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                        //CHG
                        arrayIndex += 1;

                    END;

                END ELSE BEGIN

                    Value_Ar_Par[arrayIndex] := Element_Cu.FNC_Get_Quantity(elementConnection_Re_Loc."Apply To");
                    //CHG
                    IF (Value_Ar_Par[arrayIndex] = 0) AND (STRLEN(MyError_Te) < MAXSTRLEN(MyError_Te) - 10) THEN
                        MyError_Te := MyError_Te + '\' + elementConnection_Re_Loc."Apply To";
                    //CHG
                    arrayIndex += 1;

                END;

            UNTIL (elementConnection_Re_Loc.NEXT = 0);

            //CHG
            IF (FNC_Array_Sum(Value_Ar_Par) = 0) THEN
                ERROR('L''élément >' + element_Re_Loc.ID + '< de l''affaire ' + element_Re_Loc.Deal_ID + ' ne peut pas être réparti' +
                ' car le total des éléments auxquel il est lié vaut 0 : ' + MyError_Te);
            //CHG

        END ELSE
            ERROR(ERROR_TXT, 'Co50026', 'FNC_Element_Quantity()',
              STRSUBSTNO('Aucune connection élément pour élément ID >%1<', element_Re_Loc.ID));
    end;

    [Scope('Internal')]
    procedure FNC_Position_Prorata_Value(Source_Element_ID_Co_Par: Code[20]; Target_Element_ID_Co_Par: Code[20]; Amount_To_Dispatch_Dec_Par: Decimal; Element_Amount_Dec_Par: Decimal)
    var
        element_Re_Loc: Record "50021";
        source_Element_Re_Loc: Record "50021";
        ACO_Line_Re_Loc: Record "39";
        VCO_Line_Re_Loc: Record "37";
        amount_Dec_Loc: Decimal;
        fee_Re_Loc: Record "50024";
        purchRcptLine_Re_Loc: Record "121";
        BR_Line_Amount_Dec: Decimal;
        dealItem_Re_Loc: Record "50023";
        purchInvLine_Re_Loc: Record "123";
        purchInv_Line_Amount_Dec: Decimal;
        exchangeRate_Dec_Loc: Decimal;
        ACOElement_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
        salesInvLine_Re_Loc: Record "113";
        purchHeader_Re_Loc: Record "38";
        currency_Co_Loc: Code[10];
    begin
        //SOURCE = Fee ou Invoice ou Provision
        Element_Cu.FNC_Set_Element(source_Element_Re_Loc, Source_Element_ID_Co_Par);
        Fee_Cu.FNC_Set(fee_Re_Loc, source_Element_Re_Loc.Fee_ID);

        //CIBLE = ACO, VCO, BR ou Purchase Invoice
        Element_Cu.FNC_Set_Element(element_Re_Loc, Target_Element_ID_Co_Par);

        /*
        IL EXISTE 4 POSSIBILITES DE DISPATCHING :
          1. FEE     -> ACO
          2. FEE     -> VCO
          3. INVOICE / PROVISION -> BR
          4. INVOICE / PROVISION -> PURCHASE INVOICE
        */

        CASE element_Re_Loc.Type OF
            //1. on dispatch un fee sur une ACO
            element_Re_Loc.Type::ACO:
                BEGIN
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST THEN
                        REPEAT
                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((ACO_Line_Re_Loc."Line Amount" * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / ACO_Line_Re_Loc.Quantity;

                            //par défaut on prend la devise du frais
                            currency_Co_Loc := fee_Re_Loc.Currency;

                            //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'ACO
                            IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              ACO_Line_Re_Loc."No.",
                              ACO_Line_Re_Loc.Quantity,
                              currency_Co_Loc,
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                              Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, ACO_Line_Re_Loc."No.")
                            );

                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)
                    ELSE BEGIN

                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        purchInvLine_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                        IF purchInvLine_Re_Loc.FINDFIRST THEN
                            REPEAT

                                //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                amount_Dec_Loc :=
                                  (((purchInvLine_Re_Loc."Line Amount" * 1) /
                                  Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchInvLine_Re_Loc.Quantity;

                                //par défaut on prend la devise du frais
                                currency_Co_Loc := fee_Re_Loc.Currency;

                                //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'ACO
                                IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                    currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                                Position_Cu.FNC_Insert_Position(
                                  element_Re_Loc.Deal_ID,
                                  Source_Element_ID_Co_Par,
                                  purchInvLine_Re_Loc."No.",
                                  purchInvLine_Re_Loc.Quantity,
                                  currency_Co_Loc,
                                  amount_Dec_Loc * -1,
                                  element_Re_Loc.ID,
                                  //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                  Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                  DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.")
                                );

                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;
            //2. on dispatch un fee sur une VCO
            element_Re_Loc.Type::VCO:
                BEGIN

                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                    IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST THEN
                            REPEAT
                                //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                amount_Dec_Loc :=
                                  (((VCO_Line_Re_Loc."Line Amount" * 1) /
                                  Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / VCO_Line_Re_Loc.Quantity;

                                //par défaut on prend la devise du frais
                                currency_Co_Loc := fee_Re_Loc.Currency;

                                //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'VCO
                                IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                    currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                //AJOUTER UNE POSITION
                                Position_Cu.FNC_Insert_Position(
                                  element_Re_Loc.Deal_ID,
                                  Source_Element_ID_Co_Par,
                                  VCO_Line_Re_Loc."No.",
                                  VCO_Line_Re_Loc.Quantity,
                                  currency_Co_Loc,
                                  amount_Dec_Loc * -1,
                                  element_Re_Loc.ID,
                                  //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                  Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                  VCO_Line_Re_Loc."Campaign Code"
                                );

                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        ELSE BEGIN

                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST THEN
                                REPEAT

                                    //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                    amount_Dec_Loc :=
                                      (((VCO_Line_Re_Loc."Line Amount" * 1) /
                                      Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / VCO_Line_Re_Loc.Quantity;

                                    //par défaut on prend la devise du frais
                                    currency_Co_Loc := fee_Re_Loc.Currency;

                                    //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'VCO
                                    IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                        currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                    //AJOUTER UNE POSITION
                                    Position_Cu.FNC_Insert_Position(
                                      element_Re_Loc.Deal_ID,
                                      Source_Element_ID_Co_Par,
                                      VCO_Line_Re_Loc."No.",
                                      VCO_Line_Re_Loc.Quantity,
                                      currency_Co_Loc,
                                      amount_Dec_Loc * -1,
                                      element_Re_Loc.ID,
                                      //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                      Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                      VCO_Line_Re_Loc."Campaign Code"
                                    );

                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            ELSE BEGIN

                                salesInvLine_Re_Loc.RESET();
                                salesInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                salesInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                salesInvLine_Re_Loc.SETRANGE(Type, salesInvLine_Re_Loc.Type::Item);
                                IF salesInvLine_Re_Loc.FINDFIRST THEN
                                    REPEAT

                                        //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                        amount_Dec_Loc :=
                                          (((salesInvLine_Re_Loc."Line Amount" * 1) /
                                          Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / salesInvLine_Re_Loc.Quantity;

                                        //par défaut on prend la devise du frais
                                        currency_Co_Loc := fee_Re_Loc.Currency;

                                        //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'VCO
                                        IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                            currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                        //AJOUTER UNE POSITION
                                        Position_Cu.FNC_Insert_Position(
                                          element_Re_Loc.Deal_ID,
                                          Source_Element_ID_Co_Par,
                                          salesInvLine_Re_Loc."No.",
                                          salesInvLine_Re_Loc.Quantity,
                                          currency_Co_Loc,
                                          amount_Dec_Loc * -1,
                                          element_Re_Loc.ID,
                                          //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                          Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                          DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, salesInvLine_Re_Loc."No.")
                                        );

                                    UNTIL (salesInvLine_Re_Loc.NEXT() = 0);
                            END
                        END
                    END
                END;
            //3. on dispatch une INVOICE sur un BR
            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    IF purchRcptLine_Re_Loc.FINDFIRST THEN
                        REPEAT
                            BR_Line_Amount_Dec :=
                              purchRcptLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Unit_Cost(element_Re_Loc.Deal_ID, purchRcptLine_Re_Loc."No.");

                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((BR_Line_Amount_Dec * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchRcptLine_Re_Loc.Quantity;

                            IF Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par) = 'EUR' THEN
                                exchangeRate_Dec_Loc := 1
                            ELSE
                                exchangeRate_Dec_Loc := Element_Cu.FNC_Get_Exchange_Rate(Source_Element_ID_Co_Par);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              purchRcptLine_Re_Loc."No.",
                              purchRcptLine_Re_Loc.Quantity,
                              //fee_Re_Loc.Currency, //faux.. il faut la currency de l'invoice (element source), pas celle du fee associé..
                              Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par),
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //La provision est un élément reel, donc on veut le taux de change appliqué lors de l'écriture
                              exchangeRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchRcptLine_Re_Loc."No.")
                            );

                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            //4. on dispatch une INVOICE sur une purchase invoice
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    IF purchInvLine_Re_Loc.FINDFIRST THEN
                        REPEAT
                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité

                            purchInv_Line_Amount_Dec := purchInvLine_Re_Loc."Line Amount";

                            amount_Dec_Loc :=
                              (((purchInv_Line_Amount_Dec * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchInvLine_Re_Loc.Quantity;

                            IF Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par) = 'EUR' THEN
                                exchangeRate_Dec_Loc := 1
                            ELSE
                                exchangeRate_Dec_Loc := Element_Cu.FNC_Get_Exchange_Rate(Source_Element_ID_Co_Par);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              purchInvLine_Re_Loc."No.",
                              purchInvLine_Re_Loc.Quantity,
                              //fee_Re_Loc.Currency, //faux.. il faut la currency de l'invoice (element source), pas celle du fee associé..
                              Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par),
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //L'invoice est un élément reel, donc on veut le taux de change appliqué lors de l'écriture
                              exchangeRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.")
                            );

                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);

                END;
            ELSE
                ERROR(
                  ERROR_TXT,
                  'Cu50026',
                  'FNC_Position_Prorata_Value',
                  STRSUBSTNO('Can''t dispatch on Element of type >%1<', element_Re_Loc.Type));
        END;

    end;

    [Scope('Internal')]
    procedure FNC_Position_Prorata_Volume(Source_Element_ID_Co_Par: Code[20]; Target_Element_ID_Co_Par: Code[20]; Amount_To_Dispatch_Dec_Par: Decimal; Element_Amount_Dec_Par: Decimal)
    var
        element_Re_Loc: Record "50021";
        source_Element_Re_Loc: Record "50021";
        ACO_Line_Re_Loc: Record "39";
        VCO_Line_Re_Loc: Record "37";
        amount_Dec_Loc: Decimal;
        fee_Re_Loc: Record "50024";
        purchRcptLine_Re_Loc: Record "121";
        BR_Line_Amount_Dec: Decimal;
        dealItem_Re_Loc: Record "50023";
        purchInvLine_Re_Loc: Record "123";
        purchInv_Line_Amount_Dec: Decimal;
        exchangeRate_Dec_Loc: Decimal;
        volume_Dec_Loc: Decimal;
        ACOElement_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
        salesInvLine_Re_Loc: Record "113";
        currency_Co_Loc: Code[10];
    begin
        //SOURCE = Fee ou Invoice
        Element_Cu.FNC_Set_Element(source_Element_Re_Loc, Source_Element_ID_Co_Par);
        Fee_Cu.FNC_Set(fee_Re_Loc, source_Element_Re_Loc.Fee_ID);

        //CIBLE = ACO, VCO, BR ou Purchase Invoice
        Element_Cu.FNC_Set_Element(element_Re_Loc, Target_Element_ID_Co_Par);

        /*
        IL EXISTE 4 POSSIBILITES DE DISPATCHING :
          1. FEE     -> ACO
          2. FEE     -> VCO
          3. INVOICE -> BR
          4. INVOICE -> PURCHASE INVOICE
        */

        CASE element_Re_Loc.Type OF
            //1. on dispatch un fee sur une ACO
            element_Re_Loc.Type::ACO:
                BEGIN
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST THEN
                        REPEAT

                            volume_Dec_Loc :=
                              ACO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(element_Re_Loc.Deal_ID, ACO_Line_Re_Loc."No.");

                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((volume_Dec_Loc * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / ACO_Line_Re_Loc.Quantity;

                            //par défaut on prend la devise du frais
                            currency_Co_Loc := fee_Re_Loc.Currency;

                            //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'ACO
                            IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              ACO_Line_Re_Loc."No.",
                              ACO_Line_Re_Loc.Quantity,
                              currency_Co_Loc,
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                              Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, ACO_Line_Re_Loc."No.")
                            );

                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)
                    ELSE BEGIN

                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF purchInvLine_Re_Loc.FINDFIRST THEN
                            REPEAT

                                volume_Dec_Loc :=
                                  purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.");

                                //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                amount_Dec_Loc :=
                                  (((volume_Dec_Loc * 1) /
                                  Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchInvLine_Re_Loc.Quantity;

                                //par défaut on prend la devise du frais
                                currency_Co_Loc := fee_Re_Loc.Currency;

                                //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'ACO
                                IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                    currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                                Position_Cu.FNC_Insert_Position(
                                  element_Re_Loc.Deal_ID,
                                  Source_Element_ID_Co_Par,
                                  purchInvLine_Re_Loc."No.",
                                  purchInvLine_Re_Loc.Quantity,
                                  currency_Co_Loc,
                                  amount_Dec_Loc * -1,
                                  element_Re_Loc.ID,
                                  //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                  Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                  DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.")
                                );

                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;

            //2. on dispatch un fee sur une VCO
            element_Re_Loc.Type::VCO:
                BEGIN

                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                    IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST THEN
                            REPEAT

                                volume_Dec_Loc :=
                                  VCO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(element_Re_Loc.Deal_ID, VCO_Line_Re_Loc."No.");

                                //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                amount_Dec_Loc :=
                                  (((volume_Dec_Loc * 1) /
                                  Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / VCO_Line_Re_Loc.Quantity;

                                //par défaut on prend la devise du frais
                                currency_Co_Loc := fee_Re_Loc.Currency;

                                //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de la VCO
                                IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                    currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                //AJOUTER UNE POSITION
                                Position_Cu.FNC_Insert_Position(
                                  element_Re_Loc.Deal_ID,
                                  Source_Element_ID_Co_Par,
                                  VCO_Line_Re_Loc."No.",
                                  VCO_Line_Re_Loc.Quantity,
                                  fee_Re_Loc.Currency,
                                  amount_Dec_Loc * -1,
                                  element_Re_Loc.ID,
                                  //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                  Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, fee_Re_Loc.Currency, 'EUR'),
                                  VCO_Line_Re_Loc."Campaign Code"
                                );

                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        ELSE BEGIN

                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST THEN
                                REPEAT

                                    volume_Dec_Loc :=
                                      VCO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(element_Re_Loc.Deal_ID, VCO_Line_Re_Loc."No.");

                                    //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                    amount_Dec_Loc :=
                                      (((volume_Dec_Loc * 1) /
                                      Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / VCO_Line_Re_Loc.Quantity;

                                    //par défaut on prend la devise du frais
                                    currency_Co_Loc := fee_Re_Loc.Currency;

                                    //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de la VCO
                                    IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                        currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                    //AJOUTER UNE POSITION
                                    Position_Cu.FNC_Insert_Position(
                                      element_Re_Loc.Deal_ID,
                                      Source_Element_ID_Co_Par,
                                      VCO_Line_Re_Loc."No.",
                                      VCO_Line_Re_Loc.Quantity,
                                      currency_Co_Loc,
                                      amount_Dec_Loc * -1,
                                      element_Re_Loc.ID,
                                      //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                      Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                      VCO_Line_Re_Loc."Campaign Code"
                                    );

                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            ELSE BEGIN

                                salesInvLine_Re_Loc.RESET();
                                salesInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                salesInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                salesInvLine_Re_Loc.SETRANGE(Type, salesInvLine_Re_Loc.Type::Item);
                                IF salesInvLine_Re_Loc.FINDFIRST THEN
                                    REPEAT

                                        volume_Dec_Loc :=
                                          salesInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(element_Re_Loc.Deal_ID, salesInvLine_Re_Loc."No.");

                                        //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                        amount_Dec_Loc :=
                                          (((volume_Dec_Loc * 1) /
                                          Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / salesInvLine_Re_Loc.Quantity;

                                        //par défaut on prend la devise du frais
                                        currency_Co_Loc := fee_Re_Loc.Currency;

                                        //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de la VCO
                                        IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                            currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                        //AJOUTER UNE POSITION
                                        Position_Cu.FNC_Insert_Position(
                                          element_Re_Loc.Deal_ID,
                                          Source_Element_ID_Co_Par,
                                          salesInvLine_Re_Loc."No.",
                                          salesInvLine_Re_Loc.Quantity,
                                          currency_Co_Loc,
                                          amount_Dec_Loc * -1,
                                          element_Re_Loc.ID,
                                          //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                          Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                          DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, salesInvLine_Re_Loc."No.")
                                        );
                                    UNTIL (salesInvLine_Re_Loc.NEXT() = 0);
                            END

                        END

                    END

                END;

            //3. on dispatch une INVOICE sur un BR
            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    IF purchRcptLine_Re_Loc.FINDFIRST THEN
                        REPEAT

                            volume_Dec_Loc :=
                              purchRcptLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(element_Re_Loc.Deal_ID, purchRcptLine_Re_Loc."No.");

                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((volume_Dec_Loc * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchRcptLine_Re_Loc.Quantity;

                            IF Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par) = 'EUR' THEN
                                exchangeRate_Dec_Loc := 1
                            ELSE
                                exchangeRate_Dec_Loc := Element_Cu.FNC_Get_Exchange_Rate(Source_Element_ID_Co_Par);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              purchRcptLine_Re_Loc."No.",
                              purchRcptLine_Re_Loc.Quantity,
                              //fee_Re_Loc.Currency, //faux.. il faut la currency de l'invoice (element source), pas celle du fee associé..
                              Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par),
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //L'invoice est un élément reel, donc on veut le taux de change appliqué lors de l'écriture
                              exchangeRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchRcptLine_Re_Loc."No.")
                            );

                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
                //4. on dispatch une INVOICE sur une purchase invoice
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    IF purchInvLine_Re_Loc.FINDFIRST THEN
                        REPEAT

                            volume_Dec_Loc :=
                              purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.");

                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((volume_Dec_Loc * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchInvLine_Re_Loc.Quantity;

                            IF Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par) = 'EUR' THEN
                                exchangeRate_Dec_Loc := 1
                            ELSE
                                exchangeRate_Dec_Loc := Element_Cu.FNC_Get_Exchange_Rate(Source_Element_ID_Co_Par);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              purchInvLine_Re_Loc."No.",
                              purchInvLine_Re_Loc.Quantity,
                              //fee_Re_Loc.Currency, //faux.. il faut la currency de l'invoice (element source), pas celle du fee associé..
                              Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par),
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //L'invoice est un élément reel, donc on veut le taux de change appliqué lors de l'écriture
                              exchangeRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.")
                            );

                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);

                END;
            ELSE
                ERROR(
                  ERROR_TXT,
                  'Cu50026',
                  'FNC_Position_Prorata_Volume',
                  STRSUBSTNO('Can''t dispatch on Element of type >%1<', element_Re_Loc.Type));
        END;

    end;

    [Scope('Internal')]
    procedure FNC_Position_Prorata_G_Weight(Source_Element_ID_Co_Par: Code[20]; Target_Element_ID_Co_Par: Code[20]; Amount_To_Dispatch_Dec_Par: Decimal; Element_Amount_Dec_Par: Decimal)
    var
        element_Re_Loc: Record "50021";
        source_Element_Re_Loc: Record "50021";
        ACO_Line_Re_Loc: Record "39";
        VCO_Line_Re_Loc: Record "37";
        amount_Dec_Loc: Decimal;
        fee_Re_Loc: Record "50024";
        purchRcptLine_Re_Loc: Record "121";
        BR_Line_Amount_Dec: Decimal;
        dealItem_Re_Loc: Record "50023";
        purchInvLine_Re_Loc: Record "123";
        purchInv_Line_Amount_Dec: Decimal;
        exchangeRate_Dec_Loc: Decimal;
        volume_Dec_Loc: Decimal;
        ACOElement_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
        salesInvLine_Re_Loc: Record "113";
        currency_Co_Loc: Code[10];
    begin
        //SOURCE = Fee ou Invoice
        Element_Cu.FNC_Set_Element(source_Element_Re_Loc, Source_Element_ID_Co_Par);
        Fee_Cu.FNC_Set(fee_Re_Loc, source_Element_Re_Loc.Fee_ID);

        //CIBLE = ACO, VCO, BR ou Purchase Invoice
        Element_Cu.FNC_Set_Element(element_Re_Loc, Target_Element_ID_Co_Par);

        /*
        IL EXISTE 4 POSSIBILITES DE DISPATCHING :
          1. FEE     -> ACO
          2. FEE     -> VCO
          3. INVOICE -> BR
          4. INVOICE -> PURCHASE INVOICE
        */

        CASE element_Re_Loc.Type OF
            //1. on dispatch un fee sur une ACO
            element_Re_Loc.Type::ACO:
                BEGIN
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST THEN
                        REPEAT

                            volume_Dec_Loc :=
                              ACO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(element_Re_Loc.Deal_ID, ACO_Line_Re_Loc."No.");

                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((volume_Dec_Loc * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / ACO_Line_Re_Loc.Quantity;

                            //par défaut on prend la devise du frais
                            currency_Co_Loc := fee_Re_Loc.Currency;

                            //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'ACO
                            IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              ACO_Line_Re_Loc."No.",
                              ACO_Line_Re_Loc.Quantity,
                              currency_Co_Loc,
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                              Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, ACO_Line_Re_Loc."No.")
                            );

                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)
                    ELSE BEGIN

                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF purchInvLine_Re_Loc.FINDFIRST THEN
                            REPEAT

                                volume_Dec_Loc :=
                                  purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.");

                                //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                amount_Dec_Loc :=
                                  (((volume_Dec_Loc * 1) /
                                  Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchInvLine_Re_Loc.Quantity;

                                //par défaut on prend la devise du frais
                                currency_Co_Loc := fee_Re_Loc.Currency;

                                //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'ACO
                                IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                    currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                                Position_Cu.FNC_Insert_Position(
                                  element_Re_Loc.Deal_ID,
                                  Source_Element_ID_Co_Par,
                                  purchInvLine_Re_Loc."No.",
                                  purchInvLine_Re_Loc.Quantity,
                                  currency_Co_Loc,
                                  amount_Dec_Loc * -1,
                                  element_Re_Loc.ID,
                                  //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                  Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                  DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.")
                                );

                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;

            //2. on dispatch un fee sur une VCO
            element_Re_Loc.Type::VCO:
                BEGIN

                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                    IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST THEN
                            REPEAT

                                volume_Dec_Loc :=
                                  VCO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(element_Re_Loc.Deal_ID, VCO_Line_Re_Loc."No.");

                                //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                amount_Dec_Loc :=
                                  (((volume_Dec_Loc * 1) /
                                  Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / VCO_Line_Re_Loc.Quantity;

                                //par défaut on prend la devise du frais
                                currency_Co_Loc := fee_Re_Loc.Currency;

                                //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de la VCO
                                IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                    currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                //AJOUTER UNE POSITION
                                Position_Cu.FNC_Insert_Position(
                                  element_Re_Loc.Deal_ID,
                                  Source_Element_ID_Co_Par,
                                  VCO_Line_Re_Loc."No.",
                                  VCO_Line_Re_Loc.Quantity,
                                  currency_Co_Loc,
                                  amount_Dec_Loc * -1,
                                  element_Re_Loc.ID,
                                  //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                  Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                  VCO_Line_Re_Loc."Campaign Code"
                                );

                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        ELSE BEGIN

                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST THEN
                                REPEAT

                                    volume_Dec_Loc :=
                                      VCO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(element_Re_Loc.Deal_ID, VCO_Line_Re_Loc."No.");

                                    //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                    amount_Dec_Loc :=
                                      (((volume_Dec_Loc * 1) /
                                      Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / VCO_Line_Re_Loc.Quantity;

                                    //par défaut on prend la devise du frais
                                    currency_Co_Loc := fee_Re_Loc.Currency;

                                    //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de la VCO
                                    IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                        currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                    //AJOUTER UNE POSITION
                                    Position_Cu.FNC_Insert_Position(
                                      element_Re_Loc.Deal_ID,
                                      Source_Element_ID_Co_Par,
                                      VCO_Line_Re_Loc."No.",
                                      VCO_Line_Re_Loc.Quantity,
                                      currency_Co_Loc,
                                      amount_Dec_Loc * -1,
                                      element_Re_Loc.ID,
                                      //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                      Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                      VCO_Line_Re_Loc."Campaign Code"
                                    );

                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            ELSE BEGIN

                                salesInvLine_Re_Loc.RESET();
                                salesInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                salesInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                salesInvLine_Re_Loc.SETRANGE(Type, salesInvLine_Re_Loc.Type::Item);
                                IF salesInvLine_Re_Loc.FINDFIRST THEN
                                    REPEAT

                                        volume_Dec_Loc :=
                                          salesInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(element_Re_Loc.Deal_ID, salesInvLine_Re_Loc."No.")
                          ;

                                        //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                        amount_Dec_Loc :=
                                          (((volume_Dec_Loc * 1) /
                                          Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / salesInvLine_Re_Loc.Quantity;

                                        //par défaut on prend la devise du frais
                                        currency_Co_Loc := fee_Re_Loc.Currency;

                                        //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de la VCO
                                        IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                            currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                        //AJOUTER UNE POSITION
                                        Position_Cu.FNC_Insert_Position(
                                          element_Re_Loc.Deal_ID,
                                          Source_Element_ID_Co_Par,
                                          salesInvLine_Re_Loc."No.",
                                          salesInvLine_Re_Loc.Quantity,
                                          currency_Co_Loc,
                                          amount_Dec_Loc * -1,
                                          element_Re_Loc.ID,
                                          //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                          Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                          DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, salesInvLine_Re_Loc."No.")
                                        );
                                    UNTIL (salesInvLine_Re_Loc.NEXT() = 0);
                            END

                        END

                    END

                END;

            //3. on dispatch une INVOICE sur un BR
            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    IF purchRcptLine_Re_Loc.FINDFIRST THEN
                        REPEAT

                            volume_Dec_Loc :=
                              purchRcptLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(element_Re_Loc.Deal_ID, purchRcptLine_Re_Loc."No.");

                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((volume_Dec_Loc * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchRcptLine_Re_Loc.Quantity;

                            IF Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par) = 'EUR' THEN
                                exchangeRate_Dec_Loc := 1
                            ELSE
                                exchangeRate_Dec_Loc := Element_Cu.FNC_Get_Exchange_Rate(Source_Element_ID_Co_Par);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              purchRcptLine_Re_Loc."No.",
                              purchRcptLine_Re_Loc.Quantity,
                              //fee_Re_Loc.Currency, //faux.. il faut la currency de l'invoice (element source), pas celle du fee associé..
                              Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par),
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //L'invoice est un élément reel, donc on veut le taux de change appliqué lors de l'écriture
                              exchangeRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchRcptLine_Re_Loc."No.")
                            );

                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            //4. on dispatch une INVOICE sur une purchase invoice
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    IF purchInvLine_Re_Loc.FINDFIRST THEN
                        REPEAT

                            volume_Dec_Loc :=
                              purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.");

                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((volume_Dec_Loc * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchInvLine_Re_Loc.Quantity;

                            IF Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par) = 'EUR' THEN
                                exchangeRate_Dec_Loc := 1
                            ELSE
                                exchangeRate_Dec_Loc := Element_Cu.FNC_Get_Exchange_Rate(Source_Element_ID_Co_Par);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              purchInvLine_Re_Loc."No.",
                              purchInvLine_Re_Loc.Quantity,
                              //fee_Re_Loc.Currency, //faux.. il faut la currency de l'invoice (element source), pas celle du fee associé..
                              Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par),
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //L'invoice est un élément reel, donc on veut le taux de change appliqué lors de l'écriture
                              exchangeRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.")
                            );

                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);

                END;
            ELSE
                ERROR(
                  ERROR_TXT,
                  'Cu50026',
                  'FNC_Position_Prorata_G_Weight',
                  STRSUBSTNO('Can''t dispatch on Element of type >%1<', element_Re_Loc.Type));
        END;

    end;

    [Scope('Internal')]
    procedure FNC_Position_Prorata_Colis(Source_Element_ID_Co_Par: Code[20]; Target_Element_ID_Co_Par: Code[20]; Amount_To_Dispatch_Dec_Par: Decimal; Element_Amount_Dec_Par: Decimal)
    var
        element_Re_Loc: Record "50021";
        source_Element_Re_Loc: Record "50021";
        ACO_Line_Re_Loc: Record "39";
        VCO_Line_Re_Loc: Record "37";
        amount_Dec_Loc: Decimal;
        fee_Re_Loc: Record "50024";
        purchRcptLine_Re_Loc: Record "121";
        BR_Line_Amount_Dec: Decimal;
        dealItem_Re_Loc: Record "50023";
        purchInvLine_Re_Loc: Record "123";
        purchInv_Line_Amount_Dec: Decimal;
        exchangeRate_Dec_Loc: Decimal;
        nbrColis_Dec_Loc: Decimal;
        ACOElement_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
        salesInvLine_Re_Loc: Record "113";
        currency_Co_Loc: Code[10];
    begin
        //SOURCE = Fee ou Invoice
        Element_Cu.FNC_Set_Element(source_Element_Re_Loc, Source_Element_ID_Co_Par);
        Fee_Cu.FNC_Set(fee_Re_Loc, source_Element_Re_Loc.Fee_ID);

        //CIBLE = ACO, VCO, BR ou Purchase Invoice
        Element_Cu.FNC_Set_Element(element_Re_Loc, Target_Element_ID_Co_Par);

        /*
        IL EXISTE 4 POSSIBILITES DE DISPATCHING :
          1. FEE     -> ACO
          2. FEE     -> VCO
          3. INVOICE -> BR
          4. INVOICE -> PURCHASE INVOICE
        */

        CASE element_Re_Loc.Type OF
            //1. on dispatch un fee sur une ACO
            element_Re_Loc.Type::ACO:
                BEGIN

                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST THEN
                        REPEAT

                            nbrColis_Dec_Loc :=
                              ACO_Line_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(element_Re_Loc.Deal_ID, ACO_Line_Re_Loc."No.");

                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((nbrColis_Dec_Loc * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / ACO_Line_Re_Loc.Quantity;

                            //par défaut on prend la devise du frais
                            currency_Co_Loc := fee_Re_Loc.Currency;

                            //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'ACO
                            IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              ACO_Line_Re_Loc."No.",
                              ACO_Line_Re_Loc.Quantity,
                              currency_Co_Loc,
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                              Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, ACO_Line_Re_Loc."No.")
                            );

                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)

                    ELSE BEGIN

                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF purchInvLine_Re_Loc.FINDFIRST THEN
                            REPEAT

                                nbrColis_Dec_Loc :=
                                  purchInvLine_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.");

                                //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                amount_Dec_Loc :=
                                  (((nbrColis_Dec_Loc * 1) /
                                  Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchInvLine_Re_Loc.Quantity;

                                //par défaut on prend la devise du frais
                                currency_Co_Loc := fee_Re_Loc.Currency;

                                //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'ACO
                                IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                    currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                                Position_Cu.FNC_Insert_Position(
                                  element_Re_Loc.Deal_ID,
                                  Source_Element_ID_Co_Par,
                                  purchInvLine_Re_Loc."No.",
                                  purchInvLine_Re_Loc.Quantity,
                                  currency_Co_Loc,
                                  amount_Dec_Loc * -1,
                                  element_Re_Loc.ID,
                                  //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                  Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                  DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.")
                                );

                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;


                END;

                //2. on dispatch un fee sur une VCO
            element_Re_Loc.Type::VCO:
                BEGIN

                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                    IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST THEN
                            REPEAT

                                nbrColis_Dec_Loc :=
                                  VCO_Line_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(element_Re_Loc.Deal_ID, VCO_Line_Re_Loc."No.");

                                //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                amount_Dec_Loc :=
                                  (((nbrColis_Dec_Loc * 1) /
                                  Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / VCO_Line_Re_Loc.Quantity;

                                //par défaut on prend la devise du frais
                                currency_Co_Loc := fee_Re_Loc.Currency;

                                //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de la VCO
                                IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                    currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                //AJOUTER UNE POSITION
                                Position_Cu.FNC_Insert_Position(
                                  element_Re_Loc.Deal_ID,
                                  Source_Element_ID_Co_Par,
                                  VCO_Line_Re_Loc."No.",
                                  VCO_Line_Re_Loc.Quantity,
                                  currency_Co_Loc,
                                  amount_Dec_Loc * -1,
                                  element_Re_Loc.ID,
                                  //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                  Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                  VCO_Line_Re_Loc."Campaign Code"
                                );

                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        ELSE BEGIN

                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST THEN
                                REPEAT

                                    nbrColis_Dec_Loc :=
                                      VCO_Line_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(element_Re_Loc.Deal_ID, VCO_Line_Re_Loc."No.");

                                    //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                    amount_Dec_Loc :=
                                      (((nbrColis_Dec_Loc * 1) /
                                      Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / VCO_Line_Re_Loc.Quantity;

                                    //par défaut on prend la devise du frais
                                    currency_Co_Loc := fee_Re_Loc.Currency;

                                    //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de la VCO
                                    IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                        currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                    //AJOUTER UNE POSITION
                                    Position_Cu.FNC_Insert_Position(
                                      element_Re_Loc.Deal_ID,
                                      Source_Element_ID_Co_Par,
                                      VCO_Line_Re_Loc."No.",
                                      VCO_Line_Re_Loc.Quantity,
                                      currency_Co_Loc,
                                      amount_Dec_Loc * -1,
                                      element_Re_Loc.ID,
                                      //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                      Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                      VCO_Line_Re_Loc."Campaign Code"
                                    );


                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            ELSE BEGIN

                                salesInvLine_Re_Loc.RESET();
                                salesInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                salesInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                salesInvLine_Re_Loc.SETRANGE(Type, salesInvLine_Re_Loc.Type::Item);
                                IF salesInvLine_Re_Loc.FINDFIRST THEN
                                    REPEAT

                                        nbrColis_Dec_Loc :=
                                          salesInvLine_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(element_Re_Loc.Deal_ID, salesInvLine_Re_Loc."No.");

                                        //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                        amount_Dec_Loc :=
                                          (((nbrColis_Dec_Loc * 1) /
                                          Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / salesInvLine_Re_Loc.Quantity;

                                        //par défaut on prend la devise du frais
                                        currency_Co_Loc := fee_Re_Loc.Currency;

                                        //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de la VCO
                                        IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                            currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                        //AJOUTER UNE POSITION
                                        Position_Cu.FNC_Insert_Position(
                                          element_Re_Loc.Deal_ID,
                                          Source_Element_ID_Co_Par,
                                          salesInvLine_Re_Loc."No.",
                                          salesInvLine_Re_Loc.Quantity,
                                          currency_Co_Loc,
                                          amount_Dec_Loc * -1,
                                          element_Re_Loc.ID,
                                          //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                          Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                          DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, salesInvLine_Re_Loc."No.")
                                        );

                                    UNTIL (salesInvLine_Re_Loc.NEXT() = 0);
                            END
                        END
                    END
                END;
            //3. on dispatch une INVOICE sur un BR
            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    IF purchRcptLine_Re_Loc.FINDFIRST THEN
                        REPEAT

                            nbrColis_Dec_Loc :=
                              purchRcptLine_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(element_Re_Loc.Deal_ID, purchRcptLine_Re_Loc."No.");

                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((nbrColis_Dec_Loc * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchRcptLine_Re_Loc.Quantity;

                            IF Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par) = 'EUR' THEN
                                exchangeRate_Dec_Loc := 1
                            ELSE
                                exchangeRate_Dec_Loc := Element_Cu.FNC_Get_Exchange_Rate(Source_Element_ID_Co_Par);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              purchRcptLine_Re_Loc."No.",
                              purchRcptLine_Re_Loc.Quantity,
                              //fee_Re_Loc.Currency, //faux.. il faut la currency de l'invoice (element source), pas celle du fee associé..
                              Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par),
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //L'invoice est un élément reel, donc on veut le taux de change appliqué lors de l'écriture
                              exchangeRate_Dec_Loc,
                              salesInvLine_Re_Loc."No."
                            );

                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            //4. on dispatch une INVOICE sur une purchase invoice
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    IF purchInvLine_Re_Loc.FINDFIRST THEN
                        REPEAT

                            nbrColis_Dec_Loc :=
                              purchInvLine_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.");

                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((nbrColis_Dec_Loc * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchInvLine_Re_Loc.Quantity;

                            IF Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par) = 'EUR' THEN
                                exchangeRate_Dec_Loc := 1
                            ELSE
                                exchangeRate_Dec_Loc := Element_Cu.FNC_Get_Exchange_Rate(Source_Element_ID_Co_Par);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              purchInvLine_Re_Loc."No.",
                              purchInvLine_Re_Loc.Quantity,
                              //fee_Re_Loc.Currency, //faux.. il faut la currency de l'invoice (element source), pas celle du fee associé..
                              Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par),
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //L'invoice est un élément reel, donc on veut le taux de change appliqué lors de l'écriture
                              exchangeRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.")
                            );

                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);

                END;
            ELSE
                ERROR(
                  ERROR_TXT,
                  'Cu50026',
                  'FNC_Position_Prorata_Colis',
                  STRSUBSTNO('Can''t dispatch on Element of type >%1<', element_Re_Loc.Type));
        END;

    end;

    [Scope('Internal')]
    procedure FNC_Position_Prorata_Quantity(Source_Element_ID_Co_Par: Code[20]; Target_Element_ID_Co_Par: Code[20]; Amount_To_Dispatch_Dec_Par: Decimal; Element_Amount_Dec_Par: Decimal)
    var
        element_Re_Loc: Record "50021";
        source_Element_Re_Loc: Record "50021";
        ACO_Line_Re_Loc: Record "39";
        VCO_Line_Re_Loc: Record "37";
        amount_Dec_Loc: Decimal;
        fee_Re_Loc: Record "50024";
        purchRcptLine_Re_Loc: Record "121";
        BR_Line_Amount_Dec: Decimal;
        dealItem_Re_Loc: Record "50023";
        purchInvLine_Re_Loc: Record "123";
        purchInv_Line_Amount_Dec: Decimal;
        exchangeRate_Dec_Loc: Decimal;
        ACOElement_Re_Loc: Record "50021";
        elementConnection_Re_Loc: Record "50027";
        salesInvLine_Re_Loc: Record "113";
        purchHeader_Re_Loc: Record "38";
        currency_Co_Loc: Code[10];
    begin
        //SOURCE = Fee ou Invoice ou Provision
        Element_Cu.FNC_Set_Element(source_Element_Re_Loc, Source_Element_ID_Co_Par);
        Fee_Cu.FNC_Set(fee_Re_Loc, source_Element_Re_Loc.Fee_ID);

        //CIBLE = ACO, VCO, BR ou Purchase Invoice
        Element_Cu.FNC_Set_Element(element_Re_Loc, Target_Element_ID_Co_Par);

        /*
        IL EXISTE 4 POSSIBILITES DE DISPATCHING :
          1. FEE     -> ACO
          2. FEE     -> VCO
          3. INVOICE / PROVISION -> BR
          4. INVOICE / PROVISION -> PURCHASE INVOICE
        */

        CASE element_Re_Loc.Type OF
            //1. on dispatch un fee sur une ACO
            element_Re_Loc.Type::ACO:
                BEGIN
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST THEN
                        REPEAT
                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((ACO_Line_Re_Loc.Quantity * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / ACO_Line_Re_Loc.Quantity;

                            //par défaut on prend la devise du frais
                            currency_Co_Loc := fee_Re_Loc.Currency;

                            //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'ACO
                            IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              ACO_Line_Re_Loc."No.",
                              ACO_Line_Re_Loc.Quantity,
                              currency_Co_Loc,
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                              Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, ACO_Line_Re_Loc."No.")
                            );

                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)

                    ELSE BEGIN

                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        purchInvLine_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                        IF purchInvLine_Re_Loc.FINDFIRST THEN
                            REPEAT

                                //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                amount_Dec_Loc :=
                                  (((purchInvLine_Re_Loc.Quantity * 1) /
                                  Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchInvLine_Re_Loc.Quantity;

                                //par défaut on prend la devise du frais
                                currency_Co_Loc := fee_Re_Loc.Currency;

                                //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'ACO
                                IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                    currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                                Position_Cu.FNC_Insert_Position(
                                  element_Re_Loc.Deal_ID,
                                  Source_Element_ID_Co_Par,
                                  purchInvLine_Re_Loc."No.",
                                  purchInvLine_Re_Loc.Quantity,
                                  currency_Co_Loc,
                                  amount_Dec_Loc * -1,
                                  element_Re_Loc.ID,
                                  //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                  Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                  DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.")
                                );

                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;
            //2. on dispatch un fee sur une VCO
            element_Re_Loc.Type::VCO:
                BEGIN

                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                    IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST THEN
                            REPEAT
                                //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                amount_Dec_Loc :=
                                  (((VCO_Line_Re_Loc.Quantity * 1) /
                                  Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / VCO_Line_Re_Loc.Quantity;

                                //par défaut on prend la devise du frais
                                currency_Co_Loc := fee_Re_Loc.Currency;

                                //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'VCO
                                IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                    currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                //AJOUTER UNE POSITION
                                Position_Cu.FNC_Insert_Position(
                                  element_Re_Loc.Deal_ID,
                                  Source_Element_ID_Co_Par,
                                  VCO_Line_Re_Loc."No.",
                                  VCO_Line_Re_Loc.Quantity,
                                  currency_Co_Loc,
                                  amount_Dec_Loc * -1,
                                  element_Re_Loc.ID,
                                  //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                  Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                  VCO_Line_Re_Loc."Campaign Code"
                                );

                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        ELSE BEGIN

                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST THEN
                                REPEAT

                                    //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                    amount_Dec_Loc :=
                                      (((VCO_Line_Re_Loc.Quantity * 1) /
                                      Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / VCO_Line_Re_Loc.Quantity;

                                    //par défaut on prend la devise du frais
                                    currency_Co_Loc := fee_Re_Loc.Currency;

                                    //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'VCO
                                    IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                        currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                    //AJOUTER UNE POSITION
                                    Position_Cu.FNC_Insert_Position(
                                      element_Re_Loc.Deal_ID,
                                      Source_Element_ID_Co_Par,
                                      VCO_Line_Re_Loc."No.",
                                      VCO_Line_Re_Loc.Quantity,
                                      currency_Co_Loc,
                                      amount_Dec_Loc * -1,
                                      element_Re_Loc.ID,
                                      //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                      Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                      VCO_Line_Re_Loc."Campaign Code"
                                    );

                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            ELSE BEGIN

                                salesInvLine_Re_Loc.RESET();
                                salesInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                salesInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                salesInvLine_Re_Loc.SETRANGE(Type, salesInvLine_Re_Loc.Type::Item);
                                IF salesInvLine_Re_Loc.FINDFIRST THEN
                                    REPEAT

                                        //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                                        amount_Dec_Loc :=
                                          (((salesInvLine_Re_Loc.Quantity * 1) /
                                          Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / salesInvLine_Re_Loc.Quantity;

                                        //par défaut on prend la devise du frais
                                        currency_Co_Loc := fee_Re_Loc.Currency;

                                        //si le montant du fee est calculé sur le champ douane, il faut récupérer la devise de l'VCO
                                        IF fee_Re_Loc.Field = fee_Re_Loc.Field::Douane THEN
                                            currency_Co_Loc := Element_Cu.FNC_Get_Currency(element_Re_Loc.ID);

                                        //AJOUTER UNE POSITION
                                        Position_Cu.FNC_Insert_Position(
                                          element_Re_Loc.Deal_ID,
                                          Source_Element_ID_Co_Par,
                                          salesInvLine_Re_Loc."No.",
                                          salesInvLine_Re_Loc.Quantity,
                                          currency_Co_Loc,
                                          amount_Dec_Loc * -1,
                                          element_Re_Loc.ID,
                                          //le Fee est un élément prévu, donc on veut le taux de change prévu dans la table currency exchange
                                          Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, currency_Co_Loc, 'EUR'),
                                          DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, salesInvLine_Re_Loc."No.")
                                        );

                                    UNTIL (salesInvLine_Re_Loc.NEXT() = 0);
                            END
                        END
                    END
                END;
            //3. on dispatch une INVOICE sur un BR
            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    IF purchRcptLine_Re_Loc.FINDFIRST THEN
                        REPEAT

                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité
                            amount_Dec_Loc :=
                              (((purchRcptLine_Re_Loc.Quantity * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchRcptLine_Re_Loc.Quantity;

                            IF Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par) = 'EUR' THEN
                                exchangeRate_Dec_Loc := 1
                            ELSE
                                exchangeRate_Dec_Loc := Element_Cu.FNC_Get_Exchange_Rate(Source_Element_ID_Co_Par);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              purchRcptLine_Re_Loc."No.",
                              purchRcptLine_Re_Loc.Quantity,
                              //fee_Re_Loc.Currency, //faux.. il faut la currency de l'invoice (element source), pas celle du fee associé..
                              Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par),
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //La provision est un élément reel, donc on veut le taux de change appliqué lors de l'écriture
                              exchangeRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchRcptLine_Re_Loc."No.")
                            );

                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            //4. on dispatch une INVOICE sur une purchase invoice
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    IF purchInvLine_Re_Loc.FINDFIRST THEN
                        REPEAT
                            //somme à ventiler sur 1 article = (% de la valeur de la ligne * somme à ventiler) / quantité

                            amount_Dec_Loc :=
                              (((purchInvLine_Re_Loc.Quantity * 1) /
                              Element_Amount_Dec_Par) * Amount_To_Dispatch_Dec_Par) / purchInvLine_Re_Loc.Quantity;

                            IF Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par) = 'EUR' THEN
                                exchangeRate_Dec_Loc := 1
                            ELSE
                                exchangeRate_Dec_Loc := Element_Cu.FNC_Get_Exchange_Rate(Source_Element_ID_Co_Par);

                            //AJOUTER UNE POSITION AVEC LES PARAMETRES SUIVANTS
                            Position_Cu.FNC_Insert_Position(
                              element_Re_Loc.Deal_ID,
                              Source_Element_ID_Co_Par,
                              purchInvLine_Re_Loc."No.",
                              purchInvLine_Re_Loc.Quantity,
                              //fee_Re_Loc.Currency, //faux.. il faut la currency de l'invoice (element source), pas celle du fee associé..
                              Element_Cu.FNC_Get_Currency(Source_Element_ID_Co_Par),
                              amount_Dec_Loc * -1,
                              element_Re_Loc.ID,
                              //L'invoice est un élément reel, donc on veut le taux de change appliqué lors de l'écriture
                              exchangeRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(element_Re_Loc.Deal_ID, purchInvLine_Re_Loc."No.")
                            );

                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);

                END;
            ELSE
                ERROR(
                  ERROR_TXT,
                  'Cu50026',
                  'FNC_Position_Prorata_Quantity',
                  STRSUBSTNO('Can''t dispatch on Element of type >%1<', element_Re_Loc.Type));
        END;

    end;

    [Scope('Internal')]
    procedure FNC_Array_Sum(Value_Ar_Par: array[300] of Decimal) total_Dec_Ret: Decimal
    var
        arrayIndex: Integer;
    begin
        total_Dec_Ret := 0;
        arrayIndex := 1;
        //CHG02
        WHILE arrayIndex <= 300 DO BEGIN
            total_Dec_Ret += Value_Ar_Par[arrayIndex];
            arrayIndex += 1;
        END;
    end;
}

