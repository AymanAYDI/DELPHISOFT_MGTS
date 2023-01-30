page 50068 "DEL Detail Soc. Audit Contact"
{
    Caption = 'Detail Social Audit';
    PageType = ListPart;
    SourceTable = "DEL Note Audit Social";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Axe; Rec.Axe)
                {
                    ApplicationArea = All;
                }
                field(Note; Rec.Note)
                {
                    ApplicationArea = All;
                }
                field("Vendor/Contact No."; Rec."Vendor/Contact No.")
                {
                    Visible = false;
                    ApplicationArea = All;
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
                ApplicationArea = All;

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
