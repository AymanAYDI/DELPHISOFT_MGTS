page 50117 "Contact Contrat"
{
    // THM       08.05.17      create

    Caption = 'Follow contracts contacts';
    PageType = List;
    SourceTable = Table5050;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Type Contact"; "Type Contact")
                {
                }
                field("Name Contact"; "Name Contact")
                {
                }
                field("First Name Contact"; "First Name Contact")
                {
                }
                field("E-Mail"; "E-Mail")
                {
                }
                field("Phone No."; "Phone No.")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CodeClient := GETFILTER("Customer No.");
        ContactBusinessRelation.RESET;
        ContactBusinessRelation.SETRANGE(ContactBusinessRelation."Link to Table", ContactBusinessRelation."Link to Table"::Customer);
        ContactBusinessRelation.SETRANGE(ContactBusinessRelation."No.", CodeClient);
        IF ContactBusinessRelation.FINDFIRST THEN BEGIN
            Type := Type::Person;
            VALIDATE("Company No.", ContactBusinessRelation."Contact No.");
            "Customer No." := ContactBusinessRelation."No."
        END;
    end;

    var
        ContactBusinessRelation: Record "5054";
        CodeClient: Text;
}

