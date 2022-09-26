page 50045 "Subform P&L Logistic"
{
    PageType = ListPart;
    SourceTable = Table50036;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Planned Element Type No."; "Planned Element Type No.")
                {
                    Caption = 'Code de frais planifié';
                }
                field("Planned Amount"; "Planned Amount")
                {
                    Caption = 'Montant planifié';
                }
                field("Real Element Type No."; "Real Element Type No.")
                {
                    Caption = 'Montant réalisé';
                    Visible = false;
                }
                field("Real Amount"; "Real Amount")
                {
                    Caption = 'Montant réalisé';
                }
                field(Delta; Delta)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnFindRecord(Which: Text): Boolean
    begin
        PLLogistic_Re_Temp.COPY(Rec);
        IF PLLogistic_Re_Temp.FIND(Which) THEN BEGIN
            Rec := PLLogistic_Re_Temp;
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        ModifyRec;
        EXIT(FALSE);
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        locResultSteps: Integer;
    begin
        PLLogistic_Re_Temp.COPY(Rec);
        locResultSteps := PLLogistic_Re_Temp.NEXT(Steps);
        IF locResultSteps <> 0 THEN
            Rec := PLLogistic_Re_Temp;
        EXIT(locResultSteps);
    end;

    var
        PLLogistic_Re_Temp: Record "50036" temporary;

    [Scope('Internal')]
    procedure ModifyRec()
    begin
        PLLogistic_Re_Temp := Rec;
        PLLogistic_Re_Temp.MODIFY;
    end;

    [Scope('Internal')]
    procedure SetTempRecord(var rRecIn: Record "50036" temporary)
    begin
        PLLogistic_Re_Temp.DELETEALL;
        IF rRecIn.FINDFIRST THEN
            REPEAT
                PLLogistic_Re_Temp.COPY(rRecIn);
                IF PLLogistic_Re_Temp.INSERT THEN;
            UNTIL rRecIn.NEXT = 0;
        CurrPage.UPDATE;
    end;
}

