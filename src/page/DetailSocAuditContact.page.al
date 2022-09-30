page 50068 "DEL Detail Soc. Audit Contact"
{
    Caption = 'Detail Social Audit';
    PageType = ListPart;
    SourceTable = "DEL Note Audit Social";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(Axe; Rec.Axe)
                {
                    Caption = 'Dimension';
                }
                field(Note; Rec.Note)
                {
                    Caption = 'Rating';

                }
                field("Vendor/Contact No."; Rec."Vendor/Contact No.")
                {
                    Visible = false;
                    Caption = 'Vendor/Contact No.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Audit social")
            {
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF Auditsocial.FINDFIRST() THEN
                        REPEAT
                            Rec."No." := Auditsocial."No.";
                            Rec.Type := Rec.Type::Contact;
                            Rec.INSERT();
                        UNTIL Auditsocial.NEXT() = 0;
                end;
            }
        }
    }

    var
        Auditsocial: Record "DEL Audit social";
}

