report 50065 "DEL Upd Items Dim 2"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            // TODO //PRODUCT GRP 
            // trigger OnAfterGetRecord()
            // begin
            //     ModifSegment("Product Group Code", "Item Category Code");
            // end;

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
    // TODO //PRODUCT GRP 
    // procedure ModifSegment(var ProductCode: Code[20]; var CategCode: Code[20])
    // var
    //     // ProductGroup_Rec: Record "Product Group"; // TODO: Record "Product Group" is removed
    //     DefaultDimension_Rec: Record "Default Dimension";
    //     ItemCategory_Rec: Record "Item Category";
    // begin
    //     //MIG2017
    //     IF ProductGroup_Rec.GET(CategCode, ProductCode) THEN
    //         IF DefaultDimension_Rec.GET(27, Item."No.", 'Segment') THEN BEGIN
    //             IF DefaultDimension_Rec."Dimension Value Code" <> ProductGroup_Rec."Code Segment" THEN BEGIN
    //                 DefaultDimension_Rec.VALIDATE("Dimension Value Code", ProductGroup_Rec."Code Segment");
    //                 DefaultDimension_Rec.MODIFY();
    //             END;
    //         END
    //         ELSE BEGIN
    //             DefaultDimension_Rec.INIT();
    //             DefaultDimension_Rec.VALIDATE("Table ID", 27);
    //             DefaultDimension_Rec.VALIDATE("No.", Item."No.");
    //             DefaultDimension_Rec.VALIDATE("Dimension Code", 'Segment');
    //             DefaultDimension_Rec.VALIDATE("Dimension Value Code", ProductGroup_Rec."Code Segment");
    //             IF DefaultDimension_Rec.INSERT() THEN;
    //         END;
    //     //END MIG2017
    // end;

    procedure ModifCategory(var CategCode: Code[20])
    var
        DefaultDimension_Rec: Record "Default Dimension";
    begin
        IF DefaultDimension_Rec.GET(27, Item."No.", 'Categorie') THEN BEGIN
            IF DefaultDimension_Rec."Dimension Value Code" <> CategCode THEN BEGIN
                DefaultDimension_Rec.VALIDATE("Dimension Value Code", CategCode);
                DefaultDimension_Rec.MODIFY();
            END;
        END
        ELSE BEGIN
            DefaultDimension_Rec.INIT();
            DefaultDimension_Rec.VALIDATE("Table ID", 27);
            DefaultDimension_Rec.VALIDATE("No.", Item."No.");
            DefaultDimension_Rec.VALIDATE("Dimension Code", 'Categorie');
            DefaultDimension_Rec.VALIDATE("Dimension Value Code", CategCode);
            DefaultDimension_Rec.INSERT();
        END;
    end;
}

