page 50045 "DEL Subform P&L Logistic"
{
    PageType = ListPart;
    SourceTable = "DEL P&L Logistic";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Planned Element Type No."; Rec."Planned Element Type No.")
                {
                    Caption = 'Code de frais planifié';
                }
                field("Planned Amount"; Rec."Planned Amount")
                {
                    Caption = 'Montant planifié';
                }
                field("Real Element Type No."; Rec."Real Element Type No.")
                {
                    Caption = 'Montant réalisé';
                    Visible = false;
                }
                field("Real Amount"; Rec."Real Amount")
                {
                    Caption = 'Montant réalisé';
                }
                field(Delta; Rec.Delta)
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
        ModifyRec();
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
        PLLogistic_Re_Temp: Record "DEL P&L Logistic" temporary;


    procedure ModifyRec()
    begin
        PLLogistic_Re_Temp := Rec;
        PLLogistic_Re_Temp.MODIFY();
    end;


    procedure SetTempRecord(var rRecIn: Record "DEL P&L Logistic" temporary)
    begin
        PLLogistic_Re_Temp.DELETEALL();
        IF rRecIn.FINDFIRST() THEN
            REPEAT
                PLLogistic_Re_Temp.COPY(rRecIn);
                IF PLLogistic_Re_Temp.INSERT() THEN;
            UNTIL rRecIn.NEXT() = 0;
        CurrPage.UPDATE();
    end;
}

