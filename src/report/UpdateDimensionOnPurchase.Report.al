report 50047 "Update Dimension On Purchase"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem100000000; "Purchase Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.", "Line No.")
                                order(ascending)
                                where(Type = CONST(Item));
            RequestFilterFields = "Document Type", "Document No.";

            trigger OnAfterGetRecord()
            begin

                IF GUIALLOWED THEN
                    Window.UPDATE(1, "Document No.");

                TempDimSetEntry.RESET();
                TempDimSetEntry.DELETEALL();

                DimensionSetEntry.RESET();
                DimensionSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");
                IF DimensionSetEntry.FINDSET() THEN
                    REPEAT
                        IF NOT (DimensionSetEntry."Dimension Code" = 'SEGMENT') THEN BEGIN
                            DimensionValue.GET(DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code");
                            IF NOT DimensionValue.Blocked THEN BEGIN
                                TempDimSetEntry.INIT();
                                TempDimSetEntry.VALIDATE("Dimension Code", DimensionSetEntry."Dimension Code");
                                TempDimSetEntry.VALIDATE("Dimension Value Code", DimensionSetEntry."Dimension Value Code");
                                TempDimSetEntry.INSERT();
                            END;
                        END;
                    UNTIL DimensionSetEntry.NEXT() = 0;

                DefaultDimension.RESET();
                DefaultDimension.SETRANGE("Table ID", DATABASE::Item);
                DefaultDimension.SETRANGE("No.", "No.");
                DefaultDimension.SETRANGE("Dimension Code", 'SEGMENT');
                IF NOT DefaultDimension.FINDFIRST() THEN
                    CurrReport.SKIP();

                TempDimSetEntry.INIT();
                TempDimSetEntry.VALIDATE("Dimension Code", 'SEGMENT');
                TempDimSetEntry.VALIDATE("Dimension Value Code", DefaultDimension."Dimension Value Code");
                TempDimSetEntry.INSERT();

                "Dimension Set ID" := TempDimSetEntry.GetDimensionSetID(TempDimSetEntry);
                MODIFY();

            end;

            trigger OnPreDataItem()
            begin

                IF GUIALLOWED THEN
                    Window.OPEN('#1##############');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DefaultDimension: Record "Default Dimension";
        DimensionSetEntry: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        DimensionValue: Record "Dimension Value";
        Window: Dialog;
}

