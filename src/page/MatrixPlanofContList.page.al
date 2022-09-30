page 50113 "DEL Matrix Plan of Cont. List"
{


    Caption = 'Plan of Control';
    DeleteAllowed = false;
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

    actions
    {
        area(processing)
        {
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
}

