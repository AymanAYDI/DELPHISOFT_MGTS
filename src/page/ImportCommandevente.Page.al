page 50002 "Import Commande vente"
{
    Caption = 'Sales Order Import';
    InsertAllowed = false;
    PageType = List;
    SourceTable = Table50002;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.")
                {
                }
                field("Line No."; "Line No.")
                {
                }
                field(Position; Position)
                {
                }
                field("No."; "No.")
                {
                }
                field(Description; Description)
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Unit Price"; "Unit Price")
                {
                }
                field(Amount; Amount)
                {
                }
            }
        }
        area(factboxes)
        {
            part(; 50003)
            {
                SubPageLink = Document No.=FIELD(Document No.),
                              Line No.=FIELD(Line No.),
                              Position=FIELD(Position);
                SubPageView = SORTING(Document No.,Line No.,Position)
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

                trigger OnAction()
                begin
                    ImportCommandevente.SETRANGE(ImportCommandevente."Document No.","Document No.");
                    REPORT.RUN(50016,FALSE,FALSE,ImportCommandevente);
                end;
            }
        }
    }

    var
        ImportCommandevente: Record "50002";
}

