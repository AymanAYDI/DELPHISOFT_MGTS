page 50032 "DEL Subform VCO"
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
                }
                field("Subject No."; Rec."Subject No.")
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
                field("Date"; Rec.Date)
                {
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    var
        customer_Re_Loc: Record Customer;
        salesHeader_Re_Loc: Record "Sales Header";
    begin
        IF customer_Re_Loc.GET(Rec."Subject No.") THEN
            CustomerName_Te := customer_Re_Loc.Name;
        ExternalDocNo_Co := '';
        CampaignNo_Co := '';
        IF salesHeader_Re_Loc.GET(salesHeader_Re_Loc."Document Type"::Order, Rec."Type No.") THEN BEGIN
            ExternalDocNo_Co := salesHeader_Re_Loc."External Document No.";
            CampaignNo_Co := salesHeader_Re_Loc."Campaign No.";
        END;
        SalesHeaderArchive.RESET();
        SalesHeaderArchive.SETRANGE(SalesHeaderArchive."Document Type", SalesHeaderArchive."Document Type"::Order);
        SalesHeaderArchive.SETRANGE(SalesHeaderArchive."No.", Rec."Type No.");
        IF SalesHeaderArchive.FINDFIRST() THEN BEGIN
            ExternalDocNo_Co := SalesHeaderArchive."External Document No.";
            CampaignNo_Co := SalesHeaderArchive."Campaign No.";

        END;
    end;

    var
        SalesHeaderArchive: Record "Sales Header Archive";
        CampaignNo_Co: Code[20];
        ExternalDocNo_Co: Code[35];
        CustomerName_Te: Text[100];

}

