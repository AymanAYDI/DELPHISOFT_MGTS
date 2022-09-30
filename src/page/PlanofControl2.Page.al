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

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Checked; Rec.Checked)
                {
                    Caption = 'Checked';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
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

