page 50020 Deal
{
    // THM       14,09,17      add "Vendor No."

    Caption = 'Shipment/Deal list';
    CardPageID = "Deal Mainboard";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table50020;
    SourceTableView = SORTING (ID)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater()
            {
                field(ID; ID)
                {
                }
                field(Status; Status)
                {
                }
                field(Date; Date)
                {
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                }
                field("Last Update"; "Last Update")
                {
                    Visible = false;
                }
                field("ACO Document Date"; "ACO Document Date")
                {
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                }
                field("Vendor No."; "Vendor No.")
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
        CALCFIELDS("Vendor No.");
        IF vendor_Re_Loc.GET("Vendor No.") THEN
            VendorName_Te := vendor_Re_Loc.Name
        ELSE
            VendorName_Te := '';
    end;

    var
        vendor_Re_Loc: Record "23";
        VendorName_Te: Text;
}

