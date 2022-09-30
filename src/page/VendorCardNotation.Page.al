page 50064 "DEL Vendor Card Notation"
{


    Caption = 'Vendor Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Vendor;

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
                }
                field(Address; Rec.Address)
                {
                    Editable = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    Editable = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Editable = false;
                }
            }
            group("Audit Quality")
            {
                Caption = 'Audit Quality';
                //TODO:tableext
                // field("URL Quality"; "URL Quality")
                // {
                // }
                // field("Note Quality"; "Note Quality")
                // {
                //     Importance = Promoted;
                // }
                // field("Realisation Date Quality"; "Realisation Date Quality")
                // {
                // }
                // field("Revision Date quality"; "Revision Date quality")
                // {
                // }
            }
            group("Audit  Social")
            {
                Caption = 'Audit  Social';
                //TODO:tableexxt
                // field("URL social"; "URL social")
                // {
                // }
                // field("Note Soc"; "Note Soc")
                // {
                //     Caption = 'Social rating';
                //     Importance = Promoted;
                // }
                // field("Realisation Date Soc"; "Realisation Date Soc")
                // {
                // }
                // field("Revision Date Soc"; "Revision Date Soc")
                // {
                // }
                part(Control1; "DEL Detail Social Audit")
                {
                    SubPageLink = "Vendor/Contact No." = FIELD("No."),
                                  Type = FILTER(Vendor);
                }
            }
            group("Environmental Audit")
            {
                Caption = 'Environmental Audit';
                //TODO:TABLEEXTT
                // field("URL Environmental";"URL Environmental")
                // {
                // }
                // field("Note Env";"Note Env")
                // {
                //     Importance = Promoted;
                // }
                // field("Realisation Date Env";"Realisation Date Env")
                // {
                // }
                // field("Revision Date env";"Revision Date env")
                // {
                // }
            }
            group("Vendor Qualification")
            {
                Caption = 'Vendor Qualification';
                //TODO:TABLEEXTT
                // field("Qualified vendor";"Qualified vendor")
                // {
                //     Importance = Promoted;
                // }
                // field("Date updated";"Date updated")
                // {
                //     Importance = Promoted;
                // }
                // field(Derogation;Derogation)
                // {
                // }
            }
            part(Comment; "Comment Sheet")
            {
                SubPageLink = "Table Name" = FILTER(Vendor),
                              "No." = FIELD("No.");
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
            }
            part("Vendor Hist. Buy-from FactBox"; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = true;
            }
            part("Vendor Hist. Pay-to FactBox"; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("No."),
                              "Currency Filter" = FIELD("Currency Filter"),
                              "Date Filter" = FIELD("Date Filter"),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                Visible = false;
            }
            systempart(Links; Links)
            {
                Visible = true;
            }
            systempart(Notes; Notes)
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
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Vendor),
                                  "No." = FIELD("No.");
                }
                action("Online Map")
                {
                    Caption = 'Online Map';
                    Image = Map;

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
                }
                action(Purchases)
                {
                    Caption = 'Purchases';
                    Image = Purchase;
                    RunObject = Page "Vendor Purchases";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                 "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
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
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        Text001: Label 'Do you want to allow payment tolerance for entries that are currently open?';
        Text002: Label 'Do you want to remove payment tolerance from entries that are currently open?';
        [InDataSet]
        MapPointVisible: Boolean;
        [InDataSet]
        ContactEditable: Boolean;


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
        Vendor_Fo_Loc: Page "Vendor List";
        Vendor_Re_Loc: Record Vendor;
    //TODO FeeMgt_Cu_Loc: Codeunit 50028;
    begin
        Vendor_Fo_Loc.LOOKUPMODE(TRUE);
        IF Vendor_Fo_Loc.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            Vendor_Fo_Loc.GETRECORD(Vendor_Re_Loc);
            //TODO FeeMgt_Cu_Loc.FNC_FeeCopy(1, Vendor_Re_Loc."No.", Rec."No.");
        END;
    end;
}

