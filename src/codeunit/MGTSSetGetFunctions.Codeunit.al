codeunit 50011 "DEL MGTS Set/Get Functions"
{
    SingleInstance = true;

    var

        tempSpecialSHBuffer: Record "Sales Header";
        SpecOrderPosting: Boolean;

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
