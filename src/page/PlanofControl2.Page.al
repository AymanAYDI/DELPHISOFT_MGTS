page 50110 "Plan of Control 2"
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

    Caption = 'Plan of Control';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Table50057;
    SourceTableView = SORTING(No., Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Plan of control));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Checked; Checked)
                {
                }
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field("Test Type"; "Test Type")
                {
                }
                field(Descriptive; Descriptive)
                {
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
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Card)
            {
                Caption = 'Card';
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50107;
                RunPageLink = No.=FIELD(No.),
                              Type=FIELD(Type);
                RunPageMode = View;
            }
        }
    }
}

