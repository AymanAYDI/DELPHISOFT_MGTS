page 50020 "DEL Deal"
{
    Caption = 'Shipment/Deal list';
    CardPageID = "DEL Deal Mainboard";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "DEL Deal";
    SourceTableView = SORTING(ID)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(ID; Rec.ID)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Date"; Rec.Date)
                {
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                }
                field("Last Update"; Rec."Last Update")
                {
                    Visible = false;
                }
                field("ACO Document Date"; Rec."ACO Document Date")
                {
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field(VendorName_Te; VendorName_Te)
                {
                    Caption = 'Name';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CALCFIELDS("Vendor No.");
        IF vendor_Re_Loc.GET(Rec."Vendor No.") THEN
            VendorName_Te := vendor_Re_Loc.Name
        ELSE
            VendorName_Te := '';
    end;

    var
        vendor_Re_Loc: Record Vendor;
        VendorName_Te: Text;
}

