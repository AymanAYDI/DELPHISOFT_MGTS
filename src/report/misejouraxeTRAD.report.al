report 50033 "DEL mise à jour axe TRAD"
{
    DefaultLayout = RDLC;
    Permissions = TableData "Dimension Set Entry" = rimd;
    RDLCLayout = './src/report/RDL/miseàjouraxeTRAD.rdlc';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending)
                                WHERE("Dimension Set ID" = FILTER(<> 0));
            RequestFilterFields = "Document Type", "No.";

            trigger OnAfterGetRecord()
            begin
                DimensionSetEntry.INIT();
                DimensionSetEntry.VALIDATE(DimensionSetEntry."Dimension Set ID", "Purchase Header"."Dimension Set ID");
                DimensionSetEntry.VALIDATE(DimensionSetEntry."Dimension Code", 'ACTIVITES');
                DimensionSetEntry.VALIDATE(DimensionSetEntry."Dimension Value Code", 'TRAD');
                IF DimensionSetEntry.INSERT() THEN
                    IF PurchLinesExist() THEN
                        UpdateAllLineDim("Purchase Header"."Dimension Set ID", 0);

            end;
        }
    }


    labels
    {
    }

    var
        DimensionSetEntry: Record "Dimension Set Entry";
        PurchLine: Record "Purchase Line";
        DimMgt: Codeunit DimensionManagement;

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.

        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;

        PurchLine.RESET();
        PurchLine.SETRANGE("Document Type", "Purchase Header"."Document Type");
        PurchLine.SETRANGE("Document No.", "Purchase Header"."No.");
        PurchLine.LOCKTABLE();
        IF PurchLine.FIND('-') THEN
            REPEAT
                NewDimSetID := DimMgt.GetDeltaDimSetID(PurchLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                IF PurchLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
                    PurchLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                      PurchLine."Dimension Set ID", PurchLine."Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 2 Code");
                    PurchLine.MODIFY();
                END;
            UNTIL PurchLine.NEXT() = 0;
    end;

    procedure PurchLinesExist(): Boolean
    begin
        PurchLine.RESET();
        PurchLine.SETRANGE("Document Type", "Purchase Header"."Document Type");
        PurchLine.SETRANGE("Document No.", "Purchase Header"."No.");
        EXIT(PurchLine.FINDFIRST());
    end;
}

