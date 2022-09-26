page 50035 "Subform P&L Details"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = CardPart;
    SourceTable = Table50029;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Item No."; "Item No.")
                {
                }
                field(Description; Description)
                {
                }
                field("Planned Sales"; "Planned Sales")
                {
                }
                field("Planned Purchases"; "Planned Purchases")
                {
                }
                field("Planned Fees"; "Planned Fees")
                {
                }
                field("Planned Gross Margin"; "Planned Gross Margin")
                {
                }
                field("Planned Final Margin"; "Planned Final Margin")
                {
                }
                field("Planned % Of Gross Margin"; "Planned % Of Gross Margin")
                {
                }
                field("Planned % Of Final Margin"; "Planned % Of Final Margin")
                {
                }
                field("Real Sales"; "Real Sales")
                {
                }
                field("Real Purchases"; "Real Purchases")
                {
                }
                field("Real Fees"; "Real Fees")
                {
                }
                field("Real Gross Margin"; "Real Gross Margin")
                {
                }
                field("Real Final Margin"; "Real Final Margin")
                {
                }
                field("Real % Of Gross Margin"; "Real % Of Gross Margin")
                {
                }
                field("Real % Of Final Margin"; "Real % Of Final Margin")
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
        ModifyRec;
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
        PositionSummary_Re_Temp: Record "50029" temporary;

    [Scope('Internal')]
    procedure ModifyRec()
    begin
        PositionSummary_Re_Temp := Rec;
        PositionSummary_Re_Temp.MODIFY;
    end;

    [Scope('Internal')]
    procedure SetTempRecord(var rRecIn: Record "50029" temporary)
    begin
        PositionSummary_Re_Temp.DELETEALL;
        IF rRecIn.FINDFIRST THEN
            REPEAT
                PositionSummary_Re_Temp.COPY(rRecIn);
                IF PositionSummary_Re_Temp.INSERT THEN;
            UNTIL rRecIn.NEXT = 0;
        CurrPage.UPDATE;
    end;
}

