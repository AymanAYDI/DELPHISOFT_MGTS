page 50064 "DEL Vendor Card Notation"
{
    Caption = 'Vendor Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Vendor;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Audit Quality")
            {
                Caption = 'Audit Quality';

                field("URL Quality"; Rec."DEL URL Quality")
                {
                    ApplicationArea = All;
                }
                field("Note Quality"; Rec."DEL Note Quality")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Realisation Date Quality"; Rec."DEL Realisation Date Quality")
                {
                    ApplicationArea = All;
                }
                field("Revision Date quality"; Rec."DEL Revision Date quality")
                {
                    ApplicationArea = All;
                }
            }
            group("Audit  Social")
            {
                Caption = 'Audit  Social';

                field("URL social"; Rec."DEL URL social")
                {
                    ApplicationArea = All;
                }
                field("Note Soc"; Rec."DEL Note Soc")
                {
                    ApplicationArea = All;
                    Caption = 'Social rating';
                    Importance = Promoted;
                }
                field("Realisation Date Soc"; Rec."DEL Realisation Date Soc")
                {
                    ApplicationArea = All;
                }
                field("Revision Date Soc"; Rec."DEL Revision Date Soc")
                {
                    ApplicationArea = All;
                }
                part(Control1; "DEL Detail Social Audit")
                {
                    ApplicationArea = All;
                    SubPageLink = "Vendor/Contact No." = FIELD("No."),
                                  Type = FILTER(Vendor);
                }
            }
            group("Environmental Audit")
            {
                Caption = 'Environmental Audit';

                field("URL Environmental"; Rec."DEL URL Environmental")
                {
                    ApplicationArea = All;
                }
                field("Note Env"; Rec."DEL Note Env")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Realisation Date Env"; Rec."DEL Realisation Date Env")
                {
                    ApplicationArea = All;
                }
                field("Revision Date env"; Rec."DEL Revision Date env")
                {
                    ApplicationArea = All;
                }
            }
            group("Vendor Qualification")
            {
                Caption = 'Vendor Qualification';

                field("Qualified vendor"; Rec."DEL Qualified vendor")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Date updated"; Rec."DEL Date updated")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field(Derogation; Rec."DEL Derogation")
                {
                    ApplicationArea = All;
                }
            }
            part(Comment; "Comment Sheet")
            {
                ApplicationArea = All;
                SubPageLink = "Table Name" = FILTER(Vendor),
                              "No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            part("Vendor Statistics FactBox"; "Vendor Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
            }
            part("Vendor Hist. Buy-from FactBox"; "Vendor Hist. Buy-from FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
            }
            part("Vendor Hist. Pay-to FactBox"; "Vendor Hist. Pay-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Vendor),
                                  "No." = FIELD("No.");
                }
                action("Online Map")
                {
                    ApplicationArea = All;
                    Caption = 'Online Map';
                    Image = Map;

                    trigger OnAction()
                    begin
                        Rec.DisplayMap();
                    end;
                }
                action("Doc&uments")
                {
                    ApplicationArea = All;
                    Caption = 'Audit Report';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Document Sheet";
                    RunPageLink = "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Comment Entry No.", "Line No.")
                                  WHERE("Table Name" = CONST(Vendor));
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Ledger E&ntries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    Promoted = false;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
                action(Purchases)
                {
                    ApplicationArea = All;
                    Caption = 'Purchases';
                    Image = Purchase;
                    RunObject = Page "Vendor Purchases";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                 "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                }
                action("Entry Statistics")
                {
                    ApplicationArea = All;
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page "Vendor Entry Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ActivateFields();
    end;

    trigger OnAfterGetRecord()
    begin
        ActivateFields();
    end;

    trigger OnInit()
    begin
        ContactEditable := TRUE;
        MapPointVisible := TRUE;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin
        ActivateFields();
        IF NOT MapMgt.TestSetup() THEN
            MapPointVisible := FALSE;
    end;

    var
        [InDataSet]
        ContactEditable: Boolean;
        [InDataSet]
        MapPointVisible: Boolean;

    procedure ActivateFields()
    begin
        ContactEditable := Rec."Primary Contact No." = '';
    end;

    local procedure ContactOnAfterValidate()
    begin
        ActivateFields();
    end;

    procedure FNC_CopieFrais()
    var
        Vendor_Re_Loc: Record Vendor;
        FeeMgt_Cu_Loc: Codeunit "DEL Alert and fee copy Mgt";
        Vendor_Fo_Loc: Page "Vendor List";
    begin
        Vendor_Fo_Loc.LOOKUPMODE(TRUE);
        IF Vendor_Fo_Loc.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            Vendor_Fo_Loc.GETRECORD(Vendor_Re_Loc);
            FeeMgt_Cu_Loc.FNC_FeeCopy("Credit Transfer Account Type"::Vendor, Vendor_Re_Loc."No.", Rec."No.");
        END;
    end;
}
