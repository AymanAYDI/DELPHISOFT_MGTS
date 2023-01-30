page 50090 "DEL Matrix General regulation"
{
    Caption = 'General product regulation';
    DeleteAllowed = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "DEL Regulation Matrix Line";
    SourceTableView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("General product"));
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Ctegory Code"; Rec."Item Category Code")
                {
                    Visible = false;
                    Caption = 'Item Category Code';
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Visible = false;
                    Caption = 'Product Group Code';
                    ApplicationArea = All;
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    Visible = false;
                    Caption = 'Item category description';
                    ApplicationArea = All;
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    Visible = false;
                    Caption = 'Product group description';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Visible = false;
                    Caption = 'Type';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RegulationMatrixLine.RESET();
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Item Category Code", Rec."Item Category Code");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Product Group Code", Rec."Product Group Code");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Mark, Rec.Mark);
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Product Description", Rec."Product Description");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."No.", Rec."No.");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Type, Rec.Type);
                        PAGE.RUN(Page::"DEL Matrix General Reg. Card", RegulationMatrixLine);
                    end;
                }
                field("Description pays"; Rec."Description pays")
                {
                    Caption = 'Country';
                    ApplicationArea = All;
                }
                field(Nature; Rec.Nature)
                {
                    Caption = 'Type of regulation';
                    ApplicationArea = All;
                }
                field("Title in French"; Rec."Title in French")
                {
                    Caption = 'Title in French';
                    ApplicationArea = All;
                }
                field("Title in English"; Rec."Title in English")
                {
                    Caption = 'Title in English';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field("Publication date"; Rec."Publication date")
                {
                    Caption = 'Publication date';
                    ApplicationArea = All;
                }
                field("Date limit of the application"; Rec."Date limit of the application")
                {
                    Caption = 'Date limit of the application';
                    ApplicationArea = All;
                }
                field("Starting date"; Rec."Starting date")
                {
                    Caption = 'Starting date';
                    ApplicationArea = All;
                }
                field("Date Fin"; Rec."Date Fin")
                {
                    Caption = 'End date';
                    ApplicationArea = All;
                }
                field("Texte rattachement"; Rec."Texte rattachement")
                {
                    Caption = 'Text of connection';
                    ApplicationArea = All;
                }
                field(Statut; Rec.Statut)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                }
                field("Texte de remplacement"; Rec."Texte de remplacement")
                {
                    Caption = 'Text of substitution';
                    ApplicationArea = All;
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                    Caption = 'ICS';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Selection)
            {
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrGlobLang := GLOBALLANGUAGE;

                    CategCode := Rec.GETFILTER("Item Category Code");
                    ProductCode := Rec.GETFILTER("Product Group Code");
                    Markfilter := Rec.GETFILTER(Mark);
                    DescProduct := Rec.GETFILTER("Product Description");
                    IF CurrGlobLang = 1033 THEN
                        EVALUATE(MarkOptionENU, Markfilter)
                    ELSE
                        EVALUATE(MarkOptionFRS, Markfilter);
                    CLEAR(RegGen);
                    Reglementation.RESET();
                    Reglementation.FILTERGROUP(3);
                    Reglementation.SETRANGE(Reglementation.Type, Reglementation.Type::"General product");
                    RegGen.SETTABLEVIEW(Reglementation);
                    RegGen.LOOKUPMODE := FALSE;
                    IF RegGen.RUNMODAL() = ACTION::OK THEN BEGIN
                        Reglementation.SETRANGE(Reglementation.Checked, TRUE);
                        IF Reglementation.FINDFIRST() THEN
                            REPEAT
                                RegulationMatrixLine.RESET();
                                RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Item Category Code", CategCode);
                                RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Product Group Code", ProductCode);
                                IF CurrGlobLang = 1033 THEN
                                    RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Mark, MarkOptionENU)
                                ELSE
                                    RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Mark, MarkOptionFRS);
                                RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Product Description", DescProduct);
                                RegulationMatrixLine.SETRANGE(RegulationMatrixLine."No.", Reglementation."No.");
                                RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Type, Reglementation.Type);
                                IF NOT RegulationMatrixLine.FINDFIRST() THEN BEGIN
                                    RegulationMatrixLine.INIT();
                                    RegulationMatrixLine."Item Category Code" := CategCode;
                                    RegulationMatrixLine."Product Group Code" := ProductCode;
                                    EVALUATE(RegulationMatrixLine.Mark, Markfilter);
                                    RegulationMatrixLine."Product Description" := DescProduct;
                                    RegulationMatrixLine."No." := Reglementation."No.";
                                    RegulationMatrixLine.Type := Reglementation.Type;
                                    RegulationMatrixLine.INSERT();
                                END;
                            UNTIL Reglementation.NEXT() = 0;
                        IF Reglementation.FINDFIRST() THEN
                            REPEAT
                                Reglementation.Checked := FALSE;
                                Reglementation.MODIFY();
                            UNTIL Reglementation.NEXT() = 0;
                    END;
                end;
            }
            action(Card)
            {
                Image = Line;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Matrix General Reg. Card";
                RunPageLink = "Item Category Code" = FIELD("Item Category Code"),
                              "Product Group Code" = FIELD("Product Group Code"),
                              "No." = FIELD("No."),
                              Type = FIELD(Type),
                              Mark = FIELD(Mark),
                              "Product Description" = FIELD("Product Description");
                ApplicationArea = All;
            }
        }
    }

    var
        Reglementation: Record "DEL Regulation";
        RegulationMatrixLine: Record "DEL Regulation Matrix Line";
        RegGen: Page "DEL Gen. product regulation 2";
        CategCode: Code[20];
        ProductCode: Code[20];
        CurrGlobLang: Integer;
        MarkOptionFRS: Option " ",MDD,"Marque Fournisseur",Licence,"Sans Marque","Marque Prestige",NC,NA,"?","Toutes Marques";
        MarkOptionENU: Enum "DEL Mark";
        DescProduct: Text;
        Markfilter: Text;
}
