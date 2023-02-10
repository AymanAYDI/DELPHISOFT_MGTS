page 50091 "DEL Matrix Sub. regulation"
{
    Caption = 'Substance regulation';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "DEL Regulation Matrix Line";
    SourceTableView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)

                      ORDER(Ascending)
                      WHERE(Type = FILTER(Materials));
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Caption = 'Item Category Code';
                    Visible = false;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Product Group Code';
                    Visible = false;
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    ApplicationArea = All;
                    Caption = 'Item category description';
                    Visible = false;
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    ApplicationArea = All;
                    Caption = 'Product group description';
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RegulationMatrixLine.RESET();
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Item Category Code", Rec."Item Category Code");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Product Group Code", Rec."Product Group Code");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Mark, Rec.Mark);
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Product Description", Rec."Product Description");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."No.", Rec."No.");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Type, Rec.Type);
                        PAGE.RUN(Page::"DEL Matrix Subs. reg Card", RegulationMatrixLine);
                    end;
                }
                field("Description pays"; Rec."Description pays")
                {
                    ApplicationArea = All;
                    Caption = 'Country';
                }
                field("Type of material"; Rec."Type of material")
                {
                    ApplicationArea = All;
                    Caption = 'Type of material';
                }
                field(Usage; Rec.Usage)
                {
                    ApplicationArea = All;
                    Caption = 'Usage';
                }
                field("Description Usage in French"; Rec."Description Usage in French")
                {
                    ApplicationArea = All;
                    Caption = 'Description Usage in French';
                }
                field("Description Usage in English"; Rec."Description Usage in English")
                {
                    ApplicationArea = All;
                    Caption = 'Description Usage in English';
                }
                field("Substance - CAS / EINECS"; Rec."Substance - CAS / EINECS")
                {
                    ApplicationArea = All;
                    Caption = 'Substance ID';
                }
                field("Substance - nom"; Rec."Substance - nom")
                {
                    ApplicationArea = All;
                    Caption = 'Substance name';
                    MultiLine = true;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = All;
                    Caption = 'Origine';
                }
                field("Starting date"; Rec."Starting date")
                {
                    ApplicationArea = All;
                    Caption = 'Starting date';
                }
                field("Date Fin"; Rec."Date Fin")
                {
                    ApplicationArea = All;
                    Caption = 'End date';
                }
                field("Norm of testing"; Rec."Norm of testing")
                {
                    ApplicationArea = All;
                    Caption = 'Norm of testing';
                }
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field("Texte de remplacement"; Rec."Texte de remplacement")
                {
                    ApplicationArea = All;
                    Caption = 'Text of substitution';
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
                ApplicationArea = All;
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

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
                    CLEAR(RegMat);
                    Reglementation.RESET();
                    Reglementation.FILTERGROUP(3);
                    Reglementation.SETRANGE(Reglementation.Type, Reglementation.Type::Materials);
                    RegMat.SETTABLEVIEW(Reglementation);
                    RegMat.LOOKUPMODE := FALSE;
                    IF RegMat.RUNMODAL() = ACTION::OK THEN BEGIN
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
                ApplicationArea = All;
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Matrix Subs. reg Card";
                RunPageLink = "Item Category Code" = FIELD("Item Category Code"),
                              "Product Group Code" = FIELD("Product Group Code"),
                              "No." = FIELD("No."),
                              Type = FIELD(Type),
                              Mark = FIELD(Mark),
                              "Product Description" = FIELD("Product Description");
            }
        }
    }

    var
        Reglementation: Record "DEL Regulation";
        RegulationMatrixLine: Record "DEL Regulation Matrix Line";
        RegMat: Page "DEL Substance regulation 2";
        MarkOptionENU: Enum "DEL Mark";
        //àvérifier MarkOptionFRS: Option " ",MDD,"Marque Fournisseur",Licence,"Sans Marque","Marque Prestige",NC,NA,"?","Toutes Marques";
        //car ce'est le meme enum mais traduit en francais
        MarkOptionFRS: Enum "DEL Mark";
        CurrGlobLang: Integer;
        CategCode: Text; //code[20]
        DescProduct: Text;
        Markfilter: Text;

        ProductCode: Text; //code[20]
}
