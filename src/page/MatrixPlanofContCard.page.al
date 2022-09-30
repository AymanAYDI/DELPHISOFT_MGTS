page 50093 "DEL Matrix Plan of Cont. Card"
{


    Caption = 'Plan of Control Card';
    Editable = false;
    PageType = Card;
    SourceTable = "DEL Regulation Matrix Line";
    SourceTableView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("Plan of control"));

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
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Caption = 'Product Group Code';
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    Caption = 'Item category description';
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    Caption = 'Product group description';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field("Test Type"; Rec."Test Type")
                {
                    Caption = 'Test Type';
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


}

