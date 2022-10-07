page 50117 "DEL Contact Contrat"
{


    Caption = 'Follow contracts contacts';
    PageType = List;
    SourceTable = Contact;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Caption = 'No.';
                }
                field("Type Contact"; Rec."DEL Type Contact")
                {
                    Caption = 'Contact Type';
                }
                field("Name Contact"; Rec."DEL Name Contact")
                {
                    Caption = 'Name';
                }
                field("First Name Contact"; Rec."DEL First Name Contact")
                {
                    Caption = 'First Name';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Caption = 'Phone No.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CodeClient := Rec.GETFILTER("DEL Customer No.");
        ContactBusinessRelation.RESET();
        ContactBusinessRelation.SETRANGE(ContactBusinessRelation."Link to Table", ContactBusinessRelation."Link to Table"::Customer);
        ContactBusinessRelation.SETRANGE(ContactBusinessRelation."No.", CodeClient);
        IF ContactBusinessRelation.FINDFIRST() THEN BEGIN
            Rec.Type := Rec.Type::Person;
            Rec.VALIDATE("Company No.", ContactBusinessRelation."Contact No.");
            Rec."DEL Customer No." := ContactBusinessRelation."No."
        END;
    end;

    var
        ContactBusinessRelation: Record "Contact Business Relation";
        CodeClient: Text;
}

