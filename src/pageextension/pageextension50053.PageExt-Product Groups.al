pageextension 50053 pageextension50053 extends "Product Groups"
{
    // +---------------------------------------------------------------------------------------+
    // | Logico SA                                                                             |
    // | Date: 21.05.2013                                                                      |
    // | Customer: -                                                                           |
    // +---------------------------------------------------------------------------------------+
    // 
    // Requirement     UserID   Date       Where            Description
    // -----------------------------------------------------------------------------------------
    // T-00712         SAZ     21.07.15                    Add  Field Segment
    //                 THM     15.02.17                    add "Salesperson Code","Person Responsible",Salesperson,Responsible
    //                 THM     23.02.18                    add sourceur
    layout
    {
        addafter("Control 4")
        {
            field("Code Segment"; "Code Segment")
            {
            }
            field("Salesperson Code"; "Salesperson Code")
            {
            }
            field(Salesperson; Salesperson)
            {
            }
            field("Responsible Code"; "Responsible Code")
            {
            }
            field(Responsible; Responsible)
            {
            }
            field("Sourceur Code"; "Sourceur Code")
            {
            }
            field(Sourceur; Sourceur)
            {
            }
        }
    }
}

