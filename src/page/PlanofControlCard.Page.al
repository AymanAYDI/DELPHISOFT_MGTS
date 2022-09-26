page 50107 "Plan of Control Card"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00755      THM     05.01.16           Create Object
    // T-00757      THM     07.01.16           add and modify Field
    // T-00757      THM     08.01.15           Test Type - OnLookup(VAR Text : Text) : Boolean

    Caption = 'Plan of Control Card';
    PageType = Card;
    SourceTable = Table50057;
    SourceTableView = SORTING (No., Type)
                      ORDER(Ascending)
                      WHERE (Type = FILTER (Plan of control));

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Record details';
                field(Type; Type)
                {
                    Editable = false;
                }
                field("Test Type"; "Test Type")
                {
                }
                field("Description Plan of control"; "Description Plan of control")
                {
                }
                field(Descriptive; Descriptive)
                {
                    MultiLine = true;
                }
                field("Support Text"; "Support Text")
                {
                }
                field("Control Type"; "Control Type")
                {
                }
                field(Frequency; Frequency)
                {
                }
                field("Referent Laboratory"; "Referent Laboratory")
                {
                }
                field("Livrables 1"; "Livrables 1")
                {
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
    }

    var
        TestType: Record "50058";
        TestType_Page: Page "50100";
}

