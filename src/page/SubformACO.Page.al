page 50031 "DEL Subform ACO"
{


    Editable = false;
    PageType = ListPart;
    SourceTable = "DEL Element";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("Type No."; Rec."Type No.")
                {
                    Caption = 'Type No.';
                }
                field("Subject No."; Rec."Subject No.")
                {
                    Caption = 'No.';
                }
                field("<Name>"; VendorName_Te)
                {
                    Caption = 'Name';
                }
                field("Date"; Rec.Date)
                {
                    Caption = 'Date';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        vendor_Re_Loc: Record Vendor;
    begin
        IF vendor_Re_Loc.GET(Rec."Subject No.") THEN
            VendorName_Te := vendor_Re_Loc.Name
    end;

    var
        VendorName_Te: Text[50];
}

