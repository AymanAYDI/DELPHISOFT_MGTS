codeunit 50011 "DEL MGTS Set/Get Functions"
{
    SingleInstance = true;

    var

        tempSpecialSHBuffer: Record "Sales Header";
        SpecOrderPosting: Boolean;
        Qty: Decimal;
        PrevLocationCode: Code[10];
        PrevReqDeliveryDate: Date;


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


    procedure SetSpecOrderPosting(NewSpecOrderPost: Boolean)
    begin
        SpecOrderPosting := NewSpecOrderPost;

        tempSpecialSHBuffer.RESET();
        tempSpecialSHBuffer.DELETEALL();

    end;



    procedure GetSpecialOrderBuffer(VAR pTempSH: Record "Sales Header" TEMPORARY)
    begin

        pTempSH.RESET();
        pTempSH.DELETEALL();
        tempSpecialSHBuffer.RESET();
        IF tempSpecialSHBuffer.FINDSET() THEN
            REPEAT
                pTempSH := tempSpecialSHBuffer;
                pTempSH.INSERT();
            UNTIL tempSpecialSHBuffer.NEXT() = 0;

    end;
}
