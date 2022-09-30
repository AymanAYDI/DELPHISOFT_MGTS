page 50092 "DEL Matrix Plan of Control"
{

    Caption = 'Plan of Control';
    CardPageID = "Matrix Plan of Control Card";
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "DEL Regulation Matrix Line";
    SourceTableView = SORTING(Item Category Code, Product Group Code, Mark, Product Description, No., Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Plan of control));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; "Item Category Code")
                {
                    Visible = false;
                }
                field("Product Group Code"; "Product Group Code")
                {
                    Visible = false;
                }
                field("Item Category Label"; "Item Category Label")
                {
                    Visible = false;
                }
                field("Product Group Label"; "Product Group Label")
                {
                    Visible = false;
                }
                field(Type; Type)
                {
                    Visible = false;
                }
                field("Test Type"; "Test Type")
                {
                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RegulationMatrixLine.RESET;
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Item Category Code", "Item Category Code");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Product Group Code", "Product Group Code");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Mark, Mark);
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Product Description", "Product Description");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."No.", "No.");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Type, Type);
                        PAGE.RUN(Page::"Matrix Plan of Control Card", RegulationMatrixLine);
                    end;
                }
                field(Descriptive; Descriptive)
                {
                }
                field("Support Text"; "Support Text")
                {
                }
                field("Control Type"; "Control Type")
                {
                }
                field(Frequency; Frequency)
                {
                }
                field("Referent Laboratory"; "Referent Laboratory")
                {
                }
                field("Livrables 1"; "Livrables 1")
                {
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

                trigger OnAction()
                begin
                    CurrGlobLang := GLOBALLANGUAGE;

                    CategCode := GETFILTER("Item Category Code");
                    ProductCode := GETFILTER("Product Group Code");
                    Markfilter := GETFILTER(Mark);
                    DescProduct := GETFILTER("Product Description");
                    IF CurrGlobLang = 1033 THEN
                        EVALUATE(MarkOptionENU, Markfilter)
                    ELSE
                        EVALUATE(MarkOptionFRS, Markfilter);
                    CLEAR(RegControl);
                    Reglementation.RESET;
                    Reglementation.FILTERGROUP(3);
                    Reglementation.SETRANGE(Reglementation.Type, Reglementation.Type::"Plan of control");
                    RegControl.SETTABLEVIEW(Reglementation);
                    RegControl.LOOKUPMODE := FALSE;
                    IF RegControl.RUNMODAL = ACTION::OK THEN BEGIN
                        Reglementation.SETRANGE(Reglementation.Checked, TRUE);
                        IF Reglementation.FINDFIRST THEN BEGIN
                            REPEAT
                                RegulationMatrixLine.RESET;
                                RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Item Category Code", CategCode);
                                RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Product Group Code", ProductCode);
                                IF CurrGlobLang = 1033 THEN
                                    RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Mark, MarkOptionENU)
                                ELSE
                                    RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Mark, MarkOptionFRS);

                                RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Product Description", DescProduct);
                                RegulationMatrixLine.SETRANGE(RegulationMatrixLine."No.", Reglementation."No.");
                                RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Type, Reglementation.Type);
                                IF NOT RegulationMatrixLine.FINDFIRST THEN BEGIN
                                    RegulationMatrixLine.INIT;
                                    RegulationMatrixLine."Item Category Code" := CategCode;
                                    RegulationMatrixLine."Product Group Code" := ProductCode;
                                    EVALUATE(RegulationMatrixLine.Mark, Markfilter);
                                    RegulationMatrixLine."Product Description" := DescProduct;
                                    RegulationMatrixLine."No." := Reglementation."No.";
                                    RegulationMatrixLine.Type := Reglementation.Type;
                                    RegulationMatrixLine.INSERT;
                                END;
                            UNTIL Reglementation.NEXT = 0;
                        END;
                        IF Reglementation.FINDFIRST THEN BEGIN
                            REPEAT
                                Reglementation.Checked := FALSE;
                                Reglementation.MODIFY;
                            UNTIL Reglementation.NEXT = 0;
                        END;
                    END;
                end;
            }
            action(Card)
            {
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Matrix Plan of Control Card";
                RunPageLink = Item Category Code=FIELD(Item Category Code),
                              Product Group Code=FIELD(Product Group Code),
                              No.=FIELD(No.),
                              Type=FIELD(Type),
                              Mark=FIELD(Mark),
                              Product Description=FIELD(Product Description);
            }
        }
    }

    var
        RegControl: Page 50110;
                        Reglementation: Record 50057;
                        RegulationMatrixLine: Record 50051;
                        ProductCode: Code[20];
                        CategCode: Code[20];
                        Markfilter: Text;
                        DescProduct: Text;
                        MarkOptionENU: Option " ","Own brand","Supplier brand",Licence,"No Name","Premium Brand",NC,NA,"?","All Marks";
                        MarkOptionFRS: Option " ",MDD,"Marque Fournisseur",Licence,"Sans Marque","Marque Prestige",NC,NA,"?","Toutes Marques";
                        CurrGlobLang: Integer;
}

