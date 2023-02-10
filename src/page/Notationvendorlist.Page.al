page 50063 "DEL Notation vendor list"
{
    ApplicationArea = all;
    Caption = 'Rating vendor list';
    CardPageID = "DEL Vendor Card Notation";
    Editable = false;
    PageType = List;
    SourceTable = Vendor;
    SourceTableView = SORTING("No.")
                ORDER(Ascending)
                  WHERE("Vendor Posting Group" = FILTER('MARCH'));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Qualified vendor"; Rec."DEL Qualified vendor")
                {
                    ApplicationArea = All;
                }
                field("Date updated"; Rec."DEL Date updated")
                {
                    ApplicationArea = All;
                }
                field("Note Quality"; Rec."DEL Note Quality")
                {
                    ApplicationArea = All;
                }
                field("Realisation Date Quality"; Rec."DEL Realisation Date Quality")
                {
                    ApplicationArea = All;
                }
                field("Revision Date quality"; Rec."DEL Revision Date quality")
                {
                    ApplicationArea = All;
                }
                field("Note Soc"; Rec."DEL Note Soc")
                {
                    ApplicationArea = All;
                }
                field("Realisation Date Soc"; Rec."DEL Realisation Date Soc")
                {
                    ApplicationArea = All;
                }
                field("Revision Date Soc"; Rec."DEL Revision Date Soc")
                {
                    ApplicationArea = All;
                }
                field("Note Env"; Rec."DEL Note Env")
                {
                    ApplicationArea = All;
                }
                field("Realisation Date Env"; Rec."DEL Realisation Date Env")
                {
                    ApplicationArea = All;
                }
                field("Revision Date env"; Rec."DEL Revision Date env")
                {
                    ApplicationArea = All;
                }
                field(Derogation; Rec."DEL Derogation")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Vendor_rec.SETRANGE(Vendor_rec."Vendor Posting Group", 'MARCH');
        IF Vendor_rec.FINDFIRST() THEN
            REPEAT

                IF Vendor_rec."DEL Revision Date quality" < TODAY THEN BEGIN
                    Vendor_rec."DEL Quality status" := Vendor_rec."DEL Quality status"::Inactive;
                    IF Vendor_rec."No." = '58698' THEN
                        Vendor_rec."DEL Qualified vendor" := FALSE;
                END;
                IF Vendor_rec."DEL Revision Date Soc" < TODAY THEN BEGIN
                    Vendor_rec."DEL Social status" := Vendor_rec."DEL Social status"::Inactive;
                    IF Vendor_rec."No." = '58698' THEN
                        Vendor_rec."DEL Qualified vendor" := FALSE;
                END;
                IF Vendor_rec."DEL Revision Date env" < TODAY THEN BEGIN
                    IF Vendor_rec."No." = '58698' THEN
                        Vendor_rec."DEL Environmental status" := Vendor_rec."DEL Environmental status"::Inactive;
                    Vendor_rec."DEL Qualified vendor" := FALSE;
                END;
                Vendor_rec.MODIFY(TRUE);
            UNTIL Vendor_rec.NEXT() = 0;
    end;

    var
        Vendor_rec: Record Vendor;
}
