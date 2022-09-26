page 50064 "Vendor Card Notation"
{
    // +------------------------------------------------------------------------------------------+
    // | Logico SA                                                                                |
    // | Status:                                                                                  |
    // | Customer/Project:                                                                        |
    // +------------------------------------------------------------------------------------------+
    // Requirement  UserID   Date       Where             Description
    // -------------------------------------------------------------------------------------------+
    // T-00705      THM     19.06.15                      Add CaptionML

    Caption = 'Vendor Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Table23;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = false;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Name; Name)
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field(Address; Address)
                {
                    Editable = false;
                }
                field("Address 2"; "Address 2")
                {
                    Editable = false;
                }
                field("Post Code"; "Post Code")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    Editable = false;
                }
                field(City; City)
                {
                    Editable = false;
                }
                field(Blocked; Blocked)
                {
                    Editable = false;
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                    Editable = false;
                }
            }
            group("Audit Quality")
            {
                Caption = 'Audit Quality';
                field("URL Quality"; "URL Quality")
                {
                }
                field("Note Quality"; "Note Quality")
                {
                    Importance = Promoted;
                }
                field("Realisation Date Quality"; "Realisation Date Quality")
                {
                }
                field("Revision Date quality"; "Revision Date quality")
                {
                }
            }
            group("Audit  Social")
            {
                Caption = 'Audit  Social';
                field("URL social"; "URL social")
                {
                }
                field("Note Soc"; "Note Soc")
                {
                    Caption = 'Social rating';
                    Importance = Promoted;
                }
                field("Realisation Date Soc"; "Realisation Date Soc")
                {
                }
                field("Revision Date Soc"; "Revision Date Soc")
                {
                }
                part(; 50019)
                {
                    SubPageLink = Vendor/Contact No.=FIELD(No.),
                                  Type=FILTER(Vendor);
                }
            }
            group("Environmental Audit")
            {
                Caption = 'Environmental Audit';
                field("URL Environmental";"URL Environmental")
                {
                }
                field("Note Env";"Note Env")
                {
                    Importance = Promoted;
                }
                field("Realisation Date Env";"Realisation Date Env")
                {
                }
                field("Revision Date env";"Revision Date env")
                {
                }
            }
            group("Vendor Qualification")
            {
                Caption = 'Vendor Qualification';
                field("Qualified vendor";"Qualified vendor")
                {
                    Importance = Promoted;
                }
                field("Date updated";"Date updated")
                {
                    Importance = Promoted;
                }
                field(Derogation;Derogation)
                {
                }
            }
            part(;124)
            {
                SubPageLink = Table Name=FILTER(Vendor),
                              No.=FIELD(No.);
            }
        }
        area(factboxes)
        {
            part(;9094)
            {
                SubPageLink = No.=FIELD(No.),
                              Currency Filter=FIELD(Currency Filter),
                              Date Filter=FIELD(Date Filter),
                              Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                              Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                Visible = true;
            }
            part(;9095)
            {
                SubPageLink = No.=FIELD(No.),
                              Currency Filter=FIELD(Currency Filter),
                              Date Filter=FIELD(Date Filter),
                              Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                              Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                Visible = true;
            }
            part(;9096)
            {
                SubPageLink = No.=FIELD(No.),
                              Currency Filter=FIELD(Currency Filter),
                              Date Filter=FIELD(Date Filter),
                              Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                              Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                Visible = false;
            }
            systempart(;Links)
            {
                Visible = true;
            }
            systempart(;Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ven&dor")
            {
                Caption = 'Ven&dor';
                Image = Vendor;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page 124;
                                    RunPageLink = Table Name=CONST(Vendor),
                                  No.=FIELD(No.);
                }
                action("Online Map")
                {
                    Caption = 'Online Map';
                    Image = Map;

                    trigger OnAction()
                    begin
                        DisplayMap;
                    end;
                }
                action("Doc&uments")
                {
                    Caption = 'Audit Report';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50065;
                                    RunPageLink = No.=FIELD(No.);
                    RunPageView = SORTING(Table Name,No.,Comment Entry No.,Line No.)
                                  WHERE(Table Name=CONST(Vendor));
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page 29;
                                    RunPageLink = Vendor No.=FIELD(No.);
                    RunPageView = SORTING(Vendor No.);
                    ShortCutKey = 'Ctrl+F7';
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 152;
                                    RunPageLink = No.=FIELD(No.),
                                  Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                  Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                    ShortCutKey = 'F7';
                }
                action(Purchases)
                {
                    Caption = 'Purchases';
                    Image = Purchase;
                    RunObject = Page 156;
                                    RunPageLink = No.=FIELD(No.),
                                  Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                  Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                }
                action("Entry Statistics")
                {
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page 303;
                                    RunPageLink = No.=FIELD(No.),
                                  Date Filter=FIELD(Date Filter),
                                  Global Dimension 1 Filter=FIELD(Global Dimension 1 Filter),
                                  Global Dimension 2 Filter=FIELD(Global Dimension 2 Filter);
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ActivateFields;
    end;

    trigger OnAfterGetRecord()
    begin
        ActivateFields;
    end;

    trigger OnInit()
    begin
        ContactEditable := TRUE;
        MapPointVisible := TRUE;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "802";
    begin
        ActivateFields;
        IF NOT MapMgt.TestSetup THEN
          MapPointVisible := FALSE;
    end;

    var
        CalendarMgmt: Codeunit "7600";
        PaymentToleranceMgt: Codeunit "426";
        CustomizedCalEntry: Record "7603";
        CustomizedCalendar: Record "7602";
        Text001: Label 'Do you want to allow payment tolerance for entries that are currently open?';
        Text002: Label 'Do you want to remove payment tolerance from entries that are currently open?';
        [InDataSet]
        MapPointVisible: Boolean;
        [InDataSet]
        ContactEditable: Boolean;

    [Scope('Internal')]
    procedure ActivateFields()
    begin
        ContactEditable := "Primary Contact No." = '';
    end;

    local procedure ContactOnAfterValidate()
    begin
        ActivateFields;
    end;

    [Scope('Internal')]
    procedure FNC_CopieFrais()
    var
        Vendor_Fo_Loc: Page "27";
                           Vendor_Re_Loc: Record "23";
                           FeeMgt_Cu_Loc: Codeunit "50028";
    begin
        Vendor_Fo_Loc.LOOKUPMODE(TRUE);
        IF Vendor_Fo_Loc.RUNMODAL = ACTION::LookupOK THEN BEGIN
          Vendor_Fo_Loc.GETRECORD(Vendor_Re_Loc);
          FeeMgt_Cu_Loc.FNC_FeeCopy(1,Vendor_Re_Loc."No.",Rec."No.");
        END;
    end;
}

