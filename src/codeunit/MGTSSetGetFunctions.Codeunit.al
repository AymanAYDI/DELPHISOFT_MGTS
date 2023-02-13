codeunit 50011 "DEL MGTS Set/Get Functions"
{
    SingleInstance = true;

    var
        SpecialSHBuffer: Record "Sales Header";
        HideValidationDialog: Boolean;
        NotInvoiceSpecOrderPost: boolean;
        shipmentSelected_Bo_CDU90: Boolean;
        shipmentSelected_Bo_Loc: Boolean;
        shipmentSelected_Bo_Loc2: Boolean;
        SpecOrderPost: Boolean;
        SpecOrderPosting: Boolean;
        updateRequestID_Co_Loc2: Boolean;
        PrevLocationCode: Code[10];
        updateRequestID_Co_Loc: Code[20];
        PrevReqDeliveryDate: Date;
        Qty: Decimal;
    //COD 92------------

    procedure SetshipmentSelected_Bo_Loc2(pshipmentSelected_Bo_Loc2: Boolean)
    begin
        shipmentSelected_Bo_Loc2 := pshipmentSelected_Bo_Loc2;
    end;

    procedure GetshipmentSelected_Bo_Loc2(): Boolean
    begin
        exit(shipmentSelected_Bo_Loc2);
    end;
    ///////
    procedure SetupdateRequestID_Co_Loc2(pupdateRequestID_Co_Loc2: Boolean)
    begin
        updateRequestID_Co_Loc2 := pupdateRequestID_Co_Loc2;
    end;

    procedure GetupdateRequestID_Co_Loc2(): Boolean
    begin
        exit(updateRequestID_Co_Loc2);
    end;

    //COD90--------
    Procedure SetNotInvoiceSpecOrderPosting(NewInvSpecOrderPost: Boolean)
    begin
        NotInvoiceSpecOrderPost := NewInvSpecOrderPost;
    end;

    //COD 91------------
    procedure SetsshipmentSelected_Bo_CDU90(pshipmentSelected_Bo_CDU90: Boolean)
    begin
        shipmentSelected_Bo_CDU90 := pshipmentSelected_Bo_CDU90;
    end;

    procedure GetshipmentSelected_Bo_CDU90(): Boolean
    begin
        exit(shipmentSelected_Bo_CDU90);
    end;
    ////
    procedure SetupdateRequestID_Co_Loc(pupdateRequestID_Co_Loc: Code[20])
    begin
        updateRequestID_Co_Loc := pupdateRequestID_Co_Loc;
    end;

    procedure GetupdateRequestID_Co_Loc(): Code[20]
    begin
        exit(updateRequestID_Co_Loc);
    end;
    ////
    procedure SetSpecOrderPosting(pSpecOrderPost: Boolean)
    begin
        SpecOrderPost := pSpecOrderPost;
    end;

    procedure GetSpecOrderPosting(): Boolean
    begin
        exit(SpecOrderPost);
    end;

    //COD 82--------
    procedure SetshipmentSelected_Bo_Loc(pshipmentSelected_Bo_Loc: Boolean)
    begin
        shipmentSelected_Bo_Loc := pshipmentSelected_Bo_Loc;
    end;

    procedure GetshipmentSelected_Bo_Loc(): Boolean
    begin
        exit(shipmentSelected_Bo_Loc);
    end;

    //COD 333--------------
    procedure SetQty(pQty: Decimal)
    begin
        Qty := pQty;
    end;

    procedure GetQty(): Decimal
    begin
        exit(Qty);
    end;
    ////
    procedure SetPrevLocationCode(pPrevLocationCode: Code[10])
    begin
        PrevLocationCode := pPrevLocationCode;
    end;

    procedure GetPrevLocationCode(): Code[10]
    begin
        exit(PrevLocationCode);
    end;
    ////
    procedure SetPrevReqDeliveryDate(pPrevReqDeliveryDate: Date)
    begin
        PrevReqDeliveryDate := pPrevReqDeliveryDate;
    end;

    procedure GetPrevReqDeliveryDate(): Date
    begin
        exit(PrevReqDeliveryDate);
    end;


    procedure SetSpecOrderPost(NewSpecOrderPost: Boolean)
    begin
        SpecOrderPosting := NewSpecOrderPost;

        SpecialSHBuffer.RESET();
        SpecialSHBuffer.DELETEALL();

    end;



    procedure GetSpecialOrderBuffer(VAR pTempSH: Record "Sales Header" TEMPORARY)
    begin

        pTempSH.RESET();
        pTempSH.DELETEALL();
        SpecialSHBuffer.RESET();
        IF SpecialSHBuffer.FINDSET() THEN
            REPEAT
                pTempSH := SpecialSHBuffer;
                pTempSH.INSERT();
            UNTIL SpecialSHBuffer.NEXT() = 0;

    end;

    procedure SetHideValidationDialog(pHideValidationDialog: Boolean)
    begin
        HideValidationDialog := pHideValidationDialog;
    end;

    procedure GetVATAmount(): Boolean
    begin
        exit(HideValidationDialog);
    end;


}
