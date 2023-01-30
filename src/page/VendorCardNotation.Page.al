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
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Editable = false;
                    ApplicationArea = All;
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
                    Importance = Promoted;
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
                    Caption = 'Social rating';
                    Importance = Promoted;
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
                part(Control1; "DEL Detail Social Audit")
                {
                    SubPageLink = "Vendor/Contact No." = FIELD("No."),
                                  Type = FILTER(Vendor);
                    ApplicationArea = All;
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
                    Importance = Promoted;
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
            }
            group("Vendor Qualification")
            {
                Caption = 'Vendor Qualification';

                field("Qualified vendor"; Rec."DEL Qualified vendor")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Date updated"; Rec."DEL Date updated")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field(Derogation; Rec."DEL Derogation")
                {
                    ApplicationArea = All;
                }
            }
            part(Comment; "Comment Sheet")
            {
                SubPageLink = "Table Name" = FILTER(Vendor),
                              "No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part("Vendor Statistics FactBox"; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
                ApplicationArea = All;
            }
            part("Vendor Hist. Buy-from FactBox"; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
                ApplicationArea = All;
            }
            part("Vendor Hist. Pay-to FactBox"; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                Visible = true;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
                ApplicationArea = All;
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
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Vendor),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Online Map")
                {
                    Caption = 'Online Map';
                    Image = Map;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.DisplayMap();
                    end;
                }
                action("Doc&uments")
                {
                    Caption = 'Audit Report';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Document Sheet";
                    RunPageLink = "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Comment Entry No.", "Line No.")
                                  WHERE("Table Name" = CONST(Vendor));
                    ApplicationArea = All;
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
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action(Purchases)
                {
                    Caption = 'Purchases';
                    Image = Purchase;
                    RunObject = Page "Vendor Purchases";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                 "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ApplicationArea = All;
                }
                action("Entry Statistics")
                {
                    Caption = 'Entry Statistics';
                    Image = EntryStatistics;
                    RunObject = Page "Vendor Entry Statistics";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                    ApplicationArea = All;
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
            FeeMgt_Cu_Loc.FNC_FeeCopy(1, Vendor_Re_Loc."No.", Rec."No.");
        END;
    end;
}
