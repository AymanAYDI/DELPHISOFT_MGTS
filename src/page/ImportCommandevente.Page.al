page 50002 "DEL Import Commande vente"
{
    Caption = 'Sales Order Import';
    InsertAllowed = false;
    PageType = List;
    SourceTable = "DEL Import Commande vente";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Position; Rec.Position)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
        area(factboxes)
        {
            part(List; "DEL Error Import")
            {
                SubPageLink = "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No."),
                              Position = FIELD(Position);
                SubPageView = SORTING("Document No.", "Line No.", Position)
                              ORDER(Ascending);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Appliquer valeur")
            {
                Caption = 'Apply Entry';
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ImportCommandevente.SETRANGE(ImportCommandevente."Document No.", Rec."Document No.");
                    REPORT.RUN(Report::"DEL Import commande vente", FALSE, FALSE, ImportCommandevente);
                end;
            }
        }
    }

    var
        ImportCommandevente: Record "DEL Import Commande vente";
}

