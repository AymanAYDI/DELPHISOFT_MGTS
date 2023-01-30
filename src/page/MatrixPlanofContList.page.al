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
                field("Test Type"; Rec."Test Type")
                {
                    ApplicationArea = All;
                    Caption = 'Test Type';
                }
                field(Descriptive; Rec.Descriptive)
                {
                    ApplicationArea = All;
                    Caption = 'Descriptive';
                }
                field("Support Text"; Rec."Support Text")
                {
                    ApplicationArea = All;
                    Caption = 'Support Text';
                }
                field("Control Type"; Rec."Control Type")
                {
                    ApplicationArea = All;
                    Caption = 'Type de contrôle';
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                    Caption = 'Frequency';
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                    ApplicationArea = All;
                    Caption = 'Referent Laboratory';
                }
                field("Livrables 1"; Rec."Livrables 1")
                {
                    ApplicationArea = All;
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
                ApplicationArea = All;
                Image = Line;
                Promoted = true;
                PromotedOnly = true;
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
