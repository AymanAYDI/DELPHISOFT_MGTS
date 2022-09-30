page 50092 "DEL Matrix Plan of Control"
{

    Caption = 'Plan of Control';
    CardPageID = "DEL Matrix Plan of Cont. Card";
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;

    SourceTable = "DEL Regulation Matrix Line";

    SourceTableView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("Plan of control"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Visible = false;
                    Caption = 'Item Category Code';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Visible = false;
                    Caption = 'Product Group Code';
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    Visible = false;
                    Caption = 'Item category description';
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    Visible = false;
                    Caption = 'Product group description';
                }
                field(Type; Rec.Type)
                {
                    Visible = false;
                    Caption = 'Type';
                }
                field("Test Type"; Rec."Test Type")
                {
                    Editable = false;
                    Caption = 'Test Type';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RegulationMatrixLine.RESET();
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Item Category Code", Rec."Item Category Code");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Product Group Code", Rec."Product Group Code");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Mark, Rec.Mark);
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."Product Description", Rec."Product Description");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine."No.", Rec."No.");
                        RegulationMatrixLine.SETRANGE(RegulationMatrixLine.Type, Rec.Type);
                        PAGE.RUN(Page::"DEL Matrix Plan of Cont. Card", RegulationMatrixLine);
                    end;
                }
                field(Descriptive; Rec.Descriptive)
                {
                    Caption = 'Descriptive';
                }
                field("Support Text"; Rec."Support Text")
                {
                    Caption = 'Support Text';
                }
                field("Control Type"; Rec."Control Type")
                {
                    Caption = 'Type de contrôle';
                }
                field(Frequency; Rec.Frequency)
                {
                    Caption = 'Frequency';
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                    Caption = 'Referent Laboratory';
                }
                field("Livrables 1"; Rec."Livrables 1")
                {
                    Caption = 'Deliverables 1';
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

                    CategCode := Rec.GETFILTER("Item Category Code");
                    ProductCode := Rec.GETFILTER("Product Group Code");
                    Markfilter := Rec.GETFILTER(Mark);
                    DescProduct := Rec.GETFILTER("Product Description");
                    IF CurrGlobLang = 1033 THEN
                        EVALUATE(MarkOptionENU, Markfilter)
                    ELSE
                        EVALUATE(MarkOptionFRS, Markfilter);
                    CLEAR(RegControl);
                    Reglementation.RESET();
                    Reglementation.FILTERGROUP(3);
                    Reglementation.SETRANGE(Reglementation.Type, Reglementation.Type::"Plan of control");
                    RegControl.SETTABLEVIEW(Reglementation);
                    RegControl.LOOKUPMODE := FALSE;
                    IF RegControl.RUNMODAL() = ACTION::OK THEN BEGIN
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
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Matrix Plan of Cont. Card";
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
        RegControl: Page "DEL Plan of Control 2";

        ProductCode: Code[20];
        CategCode: Code[20];
        Markfilter: Text;
        DescProduct: Text;
        MarkOptionENU: Enum "DEL Mark";
        MarkOptionFRS: Enum "DEL Mark";
        CurrGlobLang: Integer;
}

