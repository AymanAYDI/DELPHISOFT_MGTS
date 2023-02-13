table 50088 "DEL Dispute Reason"
{

    Caption = 'Dispute Reason';
    DrillDownPageID = "DEL Disputes Reasons";
    LookupPageID = "DEL Disputes Reasons";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    // fieldgroups
    // {
    //     //     fieldgroup(Brick; "Code", Description)
    //     // Field5900)
    //     //     {
    //     //     }
    //     // }
    // }

}