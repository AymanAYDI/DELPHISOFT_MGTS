codeunit 50101 "DEL MGTS_FctMgt"
{
    Procedure UpdateAllShortDimFromDimSetID(DimSetID: Integer; VAR ShortDimVal3: Code[20]; VAR ShortDimVal4: Code[20]; VAR ShortDimVal5: Code[20]; VAR ShortDimVal6: Code[20]; VAR ShortDimVal7: Code[20]; VAR ShortDimVal8: Code[20])
    var
        DimSetEntry: Record "Dimension Set Entry";
        DimMgt: Codeunit DimensionManagement;
        GLSetupShortcutDimCode: array[8] of Code[20];
    Begin
        DimMgt.GetGLSetup(GLSetupShortcutDimCode);
        ShortDimVal3 := '';
        ShortDimVal4 := '';
        ShortDimVal5 := '';
        ShortDimVal6 := '';
        ShortDimVal7 := '';
        ShortDimVal8 := '';

        IF GLSetupShortcutDimCode[3] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[3]) THEN
                ShortDimVal3 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[4] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[4]) THEN
                ShortDimVal4 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[5] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[5]) THEN
                ShortDimVal5 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[6] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[6]) THEN
                ShortDimVal6 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[7] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[7]) THEN
                ShortDimVal7 := DimSetEntry."Dimension Value Code";
        IF GLSetupShortcutDimCode[8] <> '' THEN
            IF DimSetEntry.GET(DimSetID, GLSetupShortcutDimCode[8]) THEN
                ShortDimVal8 := DimSetEntry."Dimension Value Code";
    End;

    procedure HasItemChargeAssignment(PurchaseHeader: Record "Purchase Header"): Boolean
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
    begin
        ItemChargeAssgntPurch.SetRange("Document Type", PurchaseHeader."Document Type");
        ItemChargeAssgntPurch.SetRange("Document No.", PurchaseHeader."No.");
        ItemChargeAssgntPurch.SetFilter("Amount to Assign", '<>%1', 0);
        exit(not ItemChargeAssgntPurch.IsEmpty);
    end;

}
