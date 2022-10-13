report 50033 "mise à jour axe TRAD"
{
    DefaultLayout = RDLC;
    RDLCLayout = './miseàjouraxeTRAD.rdlc';
    Permissions = TableData 480 = rimd;

    dataset
    {
        dataitem(DataItem1100113000; Table38)
        {
            DataItemTableView = SORTING (Document Type, No.)
                                ORDER(Ascending)
                                WHERE (Dimension Set ID=FILTER(<>0));
            RequestFilterFields = "Document Type","No.";

            trigger OnAfterGetRecord()
            begin
                DimensionSetEntry.INIT;
                DimensionSetEntry.VALIDATE(DimensionSetEntry."Dimension Set ID","Purchase Header"."Dimension Set ID");
                DimensionSetEntry.VALIDATE(DimensionSetEntry."Dimension Code",'ACTIVITES');
                DimensionSetEntry.VALIDATE(DimensionSetEntry."Dimension Value Code",'TRAD');
                //DimensionSetEntry.VALIDATE(DimensionSetEntry."Dimension Value ID",
                IF DimensionSetEntry.INSERT() THEN
                BEGIN
                IF PurchLinesExist THEN
                UpdateAllLineDim("Purchase Header"."Dimension Set ID",0);
                END;
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
        DimensionSetEntry: Record "480";
        PurchLine: Record "39";
        DimMgt: Codeunit "408";

    local procedure UpdateAllLineDim(NewParentDimSetID: Integer;OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.

        IF NewParentDimSetID = OldParentDimSetID THEN
          EXIT;

        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type","Purchase Header"."Document Type");
        PurchLine.SETRANGE("Document No.","Purchase Header"."No.");
        PurchLine.LOCKTABLE;
        IF PurchLine.FIND('-') THEN
          REPEAT
            NewDimSetID := DimMgt.GetDeltaDimSetID(PurchLine."Dimension Set ID",NewParentDimSetID,OldParentDimSetID);
            IF PurchLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
              PurchLine."Dimension Set ID" := NewDimSetID;
              DimMgt.UpdateGlobalDimFromDimSetID(
                PurchLine."Dimension Set ID",PurchLine."Shortcut Dimension 1 Code",PurchLine."Shortcut Dimension 2 Code");
              PurchLine.MODIFY;
            END;
          UNTIL PurchLine.NEXT = 0;
    end;

    [Scope('Internal')]
    procedure PurchLinesExist(): Boolean
    begin
        PurchLine.RESET;
        PurchLine.SETRANGE("Document Type","Purchase Header"."Document Type");
        PurchLine.SETRANGE("Document No.","Purchase Header"."No.");
        EXIT(PurchLine.FINDFIRST);
    end;
}

