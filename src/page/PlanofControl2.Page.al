page 50110 "DEL Plan of Control 2"
{
    Caption = 'Plan of Control';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "DEL Regulation";
    SourceTableView = SORTING("No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("Plan of control"));
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Checked; Rec.Checked)
                {
                    ApplicationArea = All;
                    Caption = 'Checked';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
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
                Caption = 'Card';
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Plan of Control Card";
                RunPageLink = "No." = FIELD("No."),
                              Type = FIELD(Type);
                RunPageMode = View;
            }
        }
    }
}
