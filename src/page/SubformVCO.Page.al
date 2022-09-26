page 50032 "Subform VCO"
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
    // THM                              30.07.13   length ExternalDocNo_Co-->35
    // THM                              24.10.2013 change CustomerName_Te length 30 to 50

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
                field("<Name>"; CustomerName_Te)
                {
                    Caption = 'Name';
                }
                field("<External Doc. No.>"; ExternalDocNo_Co)
                {
                    Caption = 'External Doc. No.';
                }
                field("<Campagne>"; CampaignNo_Co)
                {
                    Caption = 'Campaign No.';
                }
                field(Date; Date)
                {
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
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
        customer_Re_Loc: Record "18";
        salesHeader_Re_Loc: Record "36";
    begin
        IF customer_Re_Loc.GET("Subject No.") THEN
            CustomerName_Te := customer_Re_Loc.Name;
        ExternalDocNo_Co := '';
        CampaignNo_Co := '';
        IF salesHeader_Re_Loc.GET(salesHeader_Re_Loc."Document Type"::Order, "Type No.") THEN BEGIN
            ExternalDocNo_Co := salesHeader_Re_Loc."External Document No.";
            CampaignNo_Co := salesHeader_Re_Loc."Campaign No.";
        END;
        SalesHeaderArchive.RESET;
        SalesHeaderArchive.SETRANGE(SalesHeaderArchive."Document Type", SalesHeaderArchive."Document Type"::Order);
        SalesHeaderArchive.SETRANGE(SalesHeaderArchive."No.", "Type No.");
        IF SalesHeaderArchive.FINDFIRST THEN BEGIN
            ExternalDocNo_Co := SalesHeaderArchive."External Document No.";
            CampaignNo_Co := SalesHeaderArchive."Campaign No.";

        END;
    end;

    var
        CustomerName_Te: Text[50];
        ExternalDocNo_Co: Code[35];
        CampaignNo_Co: Code[20];
        SalesHeaderArchive: Record "5107";
}

