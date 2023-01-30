page 50035 "DEL Subform P&L Details"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = "DEL Position Summary";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Planned Sales"; Rec."Planned Sales")
                {
                }
                field("Planned Purchases"; Rec."Planned Purchases")
                {
                }
                field("Planned Fees"; Rec."Planned Fees")
                {
                }
                field("Planned Gross Margin"; Rec."Planned Gross Margin")
                {
                }
                field("Planned Final Margin"; Rec."Planned Final Margin")
                {
                }
                field("Planned % Of Gross Margin"; Rec."Planned % Of Gross Margin")
                {
                }
                field("Planned % Of Final Margin"; Rec."Planned % Of Final Margin")
                {
                }
                field("Real Sales"; Rec."Real Sales")
                {
                }
                field("Real Purchases"; Rec."Real Purchases")
                {
                }
                field("Real Fees"; Rec."Real Fees")
                {
                }
                field("Real Gross Margin"; Rec."Real Gross Margin")
                {
                }
                field("Real Final Margin"; Rec."Real Final Margin")
                {
                }
                field("Real % Of Gross Margin"; Rec."Real % Of Gross Margin")
                {
                }
                field("Real % Of Final Margin"; Rec."Real % Of Final Margin")
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
        TempPositionSummary_Re.COPY(Rec);
        IF TempPositionSummary_Re.FIND(Which) THEN BEGIN
            Rec := TempPositionSummary_Re;
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
        TempPositionSummary_Re.COPY(Rec);
        locResultSteps := TempPositionSummary_Re.NEXT(Steps);
        IF locResultSteps <> 0 THEN
            Rec := TempPositionSummary_Re;
        EXIT(locResultSteps);
    end;

    var
        TempPositionSummary_Re: Record "DEL Position Summary" temporary;


    procedure ModifyRec()
    begin
        TempPositionSummary_Re := Rec;
        TempPositionSummary_Re.MODIFY();
    end;


    procedure SetTempRecord(var rRecIn: Record "DEL Position Summary" temporary)
    begin
        TempPositionSummary_Re.DELETEALL();
        IF rRecIn.FINDFIRST() THEN
            REPEAT
                TempPositionSummary_Re.COPY(rRecIn);
                IF TempPositionSummary_Re.INSERT() THEN;
            UNTIL rRecIn.NEXT() = 0;
        CurrPage.UPDATE();
    end;
}

