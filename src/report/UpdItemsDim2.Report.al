report 50065 "Upd Items Dim 2"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table27)
        {

            trigger OnAfterGetRecord()
            begin
                ModifSegment("Product Group Code", "Item Category Code");
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Finished !');
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

    [Scope('Internal')]
    procedure ModifSegment(var ProductCode: Code[20]; var CategCode: Code[20])
    var
        ProductGroup_Rec: Record "5723";
        DefaultDimension_Rec: Record "352";
        ItemCategory_Rec: Record "5722";
    begin
        //MIG2017
        IF ProductGroup_Rec.GET(CategCode, ProductCode) THEN BEGIN
            IF DefaultDimension_Rec.GET(27, Item."No.", 'Segment') THEN BEGIN
                IF DefaultDimension_Rec."Dimension Value Code" <> ProductGroup_Rec."Code Segment" THEN BEGIN
                    DefaultDimension_Rec.VALIDATE("Dimension Value Code", ProductGroup_Rec."Code Segment");
                    DefaultDimension_Rec.MODIFY;
                END;
            END
            ELSE BEGIN
                DefaultDimension_Rec.INIT;
                DefaultDimension_Rec.VALIDATE("Table ID", 27);
                DefaultDimension_Rec.VALIDATE("No.", Item."No.");
                DefaultDimension_Rec.VALIDATE("Dimension Code", 'Segment');
                DefaultDimension_Rec.VALIDATE("Dimension Value Code", ProductGroup_Rec."Code Segment");
                IF DefaultDimension_Rec.INSERT THEN;
            END;
        END;
        //END MIG2017
    end;

    [Scope('Internal')]
    procedure ModifCategory(var CategCode: Code[20])
    var
        DefaultDimension_Rec: Record "352";
        ItemCategory_Rec: Record "5722";
    begin
        //MIG2017
        // T-00746 START
        IF DefaultDimension_Rec.GET(27, Item."No.", 'Categorie') THEN BEGIN
            IF DefaultDimension_Rec."Dimension Value Code" <> CategCode THEN BEGIN
                DefaultDimension_Rec.VALIDATE("Dimension Value Code", CategCode);
                DefaultDimension_Rec.MODIFY;
            END;
        END
        // T-00746 END
        ELSE BEGIN
            // T-00746 START
            DefaultDimension_Rec.INIT;
            DefaultDimension_Rec.VALIDATE("Table ID", 27);
            DefaultDimension_Rec.VALIDATE("No.", Item."No.");
            DefaultDimension_Rec.VALIDATE("Dimension Code", 'Categorie');
            DefaultDimension_Rec.VALIDATE("Dimension Value Code", CategCode);
            DefaultDimension_Rec.INSERT;
            // T-00746 END
        END;
        //END MIG2017
    end;
}

