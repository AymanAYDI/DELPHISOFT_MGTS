page 50093 "DEL Matrix Plan of Cont. Card"
{


    Caption = 'Plan of Control Card';
    Editable = false;
    PageType = Card;
    SourceTable = "DEL Regulation Matrix Line";
    SourceTableView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("Plan of control"));
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Record details';
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Caption = 'Product Group Code';
                    ApplicationArea = All;
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    Caption = 'Item category description';
                    ApplicationArea = All;
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    Caption = 'Product group description';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    ApplicationArea = All;
                }
                field("Test Type"; Rec."Test Type")
                {
                    Caption = 'Test Type';
                    ApplicationArea = All;
                }
                field(Descriptive; Rec.Descriptive)
                {
                    Caption = 'Descriptive';
                    ApplicationArea = All;
                }
                field("Support Text"; Rec."Support Text")
                {
                    Caption = 'Support Text';
                    ApplicationArea = All;
                }
                field("Control Type"; Rec."Control Type")
                {
                    Caption = 'Type de contrôle';
                    ApplicationArea = All;
                }
                field(Frequency; Rec.Frequency)
                {
                    Caption = 'Frequency';
                    ApplicationArea = All;
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                    Caption = 'Referent Laboratory';
                    ApplicationArea = All;
                }
                field("Livrables 1"; Rec."Livrables 1")
                {
                    Caption = 'Deliverables 1';
                    ApplicationArea = All;
                }
            }
        }
    }


}

