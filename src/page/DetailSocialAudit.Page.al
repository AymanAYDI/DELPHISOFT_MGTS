page 50019 "Detail Social Audit"
{
    Caption = 'Detail Social Audit';
    PageType = ListPart;
    SourceTable = Table50017;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field(Axe; Axe)
                {
                }
                field(Note; Note)
                {
                }
                field("Vendor/Contact No."; "Vendor/Contact No.")
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
                    IF Auditsocial.FINDFIRST THEN
                        REPEAT
                            "No." := Auditsocial."No.";
                            Type := Type::Vendor;
                            INSERT;
                        UNTIL Auditsocial.NEXT = 0;
                end;
            }
        }
    }

    var
        Auditsocial: Record "50018";
}

