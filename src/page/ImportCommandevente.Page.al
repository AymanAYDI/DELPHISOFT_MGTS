page 50002 "DEL Import Commande vente"
{
    Caption = 'Sales Order Import';
    InsertAllowed = false;
    PageType = List;
    SourceTable = "DEL Import Commande vente";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field("Line No."; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(Position; Rec.Position)
                {
                    Caption = 'Position';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
            }
        }
        area(factboxes)
        {
            part(List; "DEL Error Import") //Can it be changed to a listpart?
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

                trigger OnAction()
                begin
                    ImportCommandevente.SETRANGE(ImportCommandevente."Document No.", Rec."Document No.");
                    REPORT.RUN(50016, FALSE, FALSE, ImportCommandevente);
                end;
            }
        }
    }

    var
        ImportCommandevente: Record "DEL Import Commande vente";
}

