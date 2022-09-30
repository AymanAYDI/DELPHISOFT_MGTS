page 50106 "Plan of Control"
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
    CardPageID = "Plan of Control Card";
    Editable = false;
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
    }
}

