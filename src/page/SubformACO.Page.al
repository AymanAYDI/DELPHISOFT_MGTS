page 50031 "Subform ACO"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 20.04.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            20.04.09   Update field Date
    // THM                              24.10.2013 change VendorName_Te length 30 to 50

    Editable = false;
    PageType = ListPart;
    SourceTable = Table50021;

    layout
    {
        area(content)
        {
            repeater()
            {
                Editable = false;
                field("Type No."; "Type No.")
                {
                }
                field("Subject No."; "Subject No.")
                {
                    Caption = 'No.';
                }
                field("<Name>"; VendorName_Te)
                {
                    Caption = 'Name';
                }
                field(Date; Date)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        vendor_Re_Loc: Record "23";
    begin
        IF vendor_Re_Loc.GET("Subject No.") THEN
            VendorName_Te := vendor_Re_Loc.Name
    end;

    var
        VendorName_Te: Text[50];
}

