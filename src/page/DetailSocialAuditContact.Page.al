page 50068 "Detail Social Audit Contact"
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
                    OptionCaption = ' ,A+,A,A-,B+,B,B-,C+,C,C-,D,E';
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
                            Type := Type::Contact;
                            INSERT;
                        UNTIL Auditsocial.NEXT = 0;
                end;
            }
        }
    }

    var
        Auditsocial: Record "50018";
}

