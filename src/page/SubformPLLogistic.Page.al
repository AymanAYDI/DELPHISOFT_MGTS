page 50045 "DEL Subform P&L Logistic"
{
    PageType = ListPart;
    SourceTable = "DEL P&L Logistic";
    UsageCategory = None;

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
        TempPLLogistic_Re.COPY(Rec);
        IF TempPLLogistic_Re.FIND(Which) THEN BEGIN
            Rec := TempPLLogistic_Re;
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
        TempPLLogistic_Re.COPY(Rec);
        locResultSteps := TempPLLogistic_Re.NEXT(Steps);
        IF locResultSteps <> 0 THEN
            Rec := TempPLLogistic_Re;
        EXIT(locResultSteps);
    end;

    var
        TempPLLogistic_Re: Record "DEL P&L Logistic" temporary;


    procedure ModifyRec()
    begin
        TempPLLogistic_Re := Rec;
        TempPLLogistic_Re.MODIFY();
    end;


    procedure SetTempRecord(var rRecIn: Record "DEL P&L Logistic" temporary)
    begin
        TempPLLogistic_Re.DELETEALL();
        IF rRecIn.FINDFIRST() THEN
            REPEAT
                TempPLLogistic_Re.COPY(rRecIn);
                IF TempPLLogistic_Re.INSERT() THEN;
            UNTIL rRecIn.NEXT() = 0;
        CurrPage.UPDATE();
    end;
}

