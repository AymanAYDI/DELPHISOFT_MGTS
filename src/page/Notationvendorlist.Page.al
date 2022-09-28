page 50063 "DEL Notation vendor list"
{


    Caption = 'Rating vendor list';
    CardPageID = "Vendor Card Notation";
    Editable = false;
    PageType = List;
    SourceTable = Vendor;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("Vendor Posting Group" = FILTER(MARCH));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field(Name; Name)
                {
                }
                //-------------//TODO/ TABLEEXT-------------------
                // field("Qualified vendor"; "Qualified vendor")
                // {
                // }
                // field("Date updated"; "Date updated")
                // {
                // }
                // field("Note Quality"; "Note Quality")
                // {
                // }
                // field("Realisation Date Quality"; "Realisation Date Quality")
                // {
                // }
                // field("Revision Date quality"; "Revision Date quality")
                // {
                // }
                // field("Note Soc"; "Note Soc")
                // {
                // }
                // field("Realisation Date Soc"; "Realisation Date Soc")
                // {
                // }
                // field("Revision Date Soc"; "Revision Date Soc")
                // {
                // }
                // field("Note Env"; "Note Env")
                // {
                // }
                // field("Realisation Date Env"; "Realisation Date Env")
                // {
                // }
                // field("Revision Date env"; "Revision Date env")
                // {
                // }
                // field(Derogation; Derogation)
                // {
                // }
                field("Purchaser Code"; "Purchaser Code")
                {
                }
            }
        }
    }

    actions
    {
    }

    // TODO trigger OnOpenPage()
    // begin
    //     Vendor_rec.SETRANGE(Vendor_rec."Vendor Posting Group", 'MARCH');
    //     IF Vendor_rec.FINDFIRST THEN
    //         REPEAT

    //             IF Vendor_rec."Revision Date quality" < TODAY THEN BEGIN
    //                 Vendor_rec."Quality status" := Vendor_rec."Quality status"::Inactif;
    //                 IF Vendor_rec."No." = '58698' THEN
    //                     Vendor_rec."Qualified vendor" := FALSE;
    //             END;
    //             IF Vendor_rec."Revision Date Soc" < TODAY THEN BEGIN
    //                 Vendor_rec."Social status" := Vendor_rec."Social status"::Inactif;
    //                 IF Vendor_rec."No." = '58698' THEN
    //                     Vendor_rec."Qualified vendor" := FALSE;
    //             END;
    //             IF Vendor_rec."Revision Date env" < TODAY THEN BEGIN
    //                 IF Vendor_rec."No." = '58698' THEN
    //                     Vendor_rec."Environmental status" := Vendor_rec."Environmental status"::Inactif;
    //                 Vendor_rec."Qualified vendor" := FALSE;
    //             END;
    //             Vendor_rec.MODIFY(TRUE);
    //         UNTIL Vendor_rec.NEXT = 0;
    // end;

    var
        Vendor_rec: Record Vendor;
}

