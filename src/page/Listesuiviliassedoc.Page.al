page 50070 "Liste suivi liasse doc"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00678     THM      12.09.14           Create Object

    Caption = 'follow General contract doc case List';
    CardPageID = "Fiche suivi liasse doc";
    Editable = false;
    PageType = List;
    SourceTable = Table23;
    SourceTableView = SORTING(No.)
                      ORDER(Ascending)
                      WHERE(Vendor Posting Group=FILTER(MARCH));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                }
                field(Name;Name)
                {
                }
                field("Purchaser Code";"Purchaser Code")
                {
                }
                field("Gen. Bus. Posting Group";"Gen. Bus. Posting Group")
                {
                }
                field(Contact;Contact)
                {
                }
                field("Statut CG";"Statut CG")
                {
                }
                field("Date de maj statut CG";"Date de maj statut CG")
                {
                }
                field("Statut CE";"Statut CE")
                {
                }
                field("Date de maj statut CE";"Date de maj statut CE")
                {
                }
            }
        }
    }

    actions
    {
    }
}

