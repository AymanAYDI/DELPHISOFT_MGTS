page 50019 "DEL Detail Social Audit"
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
                }
                field(Axe; Rec.Axe)
                {
                }
                field(Note; Rec.Note)
                {
                }
                field("Vendor/Contact No."; Rec."Vendor/Contact No.")
                {
                    Visible = false;
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
                            Rec.Type := Rec.Type::Vendor;
                            Rec.INSERT();
                        UNTIL Auditsocial.NEXT() = 0;
                end;
            }
        }
    }

    var
        Auditsocial: Record "DEL Audit social";
}

