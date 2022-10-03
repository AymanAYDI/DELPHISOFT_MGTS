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
        PositionSummary_Re_Temp.COPY(Rec);
        IF PositionSummary_Re_Temp.FIND(Which) THEN BEGIN
            Rec := PositionSummary_Re_Temp;
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
        PositionSummary_Re_Temp.COPY(Rec);
        locResultSteps := PositionSummary_Re_Temp.NEXT(Steps);
        IF locResultSteps <> 0 THEN
            Rec := PositionSummary_Re_Temp;
        EXIT(locResultSteps);
    end;

    var
        PositionSummary_Re_Temp: Record "DEL Position Summary" temporary;


    procedure ModifyRec()
    begin
        PositionSummary_Re_Temp := Rec;
        PositionSummary_Re_Temp.MODIFY();
    end;


    procedure SetTempRecord(var rRecIn: Record "DEL Position Summary" temporary)
    begin
        PositionSummary_Re_Temp.DELETEALL();
        IF rRecIn.FINDFIRST() THEN
            REPEAT
                PositionSummary_Re_Temp.COPY(rRecIn);
                IF PositionSummary_Re_Temp.INSERT() THEN;
            UNTIL rRecIn.NEXT() = 0;
        CurrPage.UPDATE();
    end;
}

