page 50126 "DEL GL Entries For Reverse"
{
    Caption = 'General Ledger Entries';
    DataCaptionExpression = GetCaption();
    Editable = false;
    PageType = List;
    Permissions = TableData "G/L Entry" = rm;
    SourceTable = "G/L Entry";
    SourceTableView = SORTING("G/L Account No.", "Posting Date")
                      ORDER(Descending);
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Document Type that the entry belongs to.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the entry''s Document No.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the account that the entry has been posted to.';
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = All;
                    DrillDown = false;
                    ToolTip = 'Specifies the name of the account that the entry has been posted to.';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a description of the entry.';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Job No. corresponding the to G/L entry.';
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the dimension value code that the entry is linked to.';
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the dimension value code that the entry is linked to.';
                    Visible = false;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the intercompany partner that the transaction is with if the entry was posted from an intercompany transaction.';
                    Visible = false;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Gen. Posting Type that applies to the entry.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the general business posting group that applies to the entry.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the general product posting group that applies to the entry.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity that was posted on the entry.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Amount of the entry.';
                }
                field("Amount (FCY)"; Rec."Amount (FCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the foreign currency amount for G/L entries.';
                }
                field("Additional-Currency Amount"; Rec."Additional-Currency Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the general ledger entry that is posted if you post in an additional reporting currency.';
                    Visible = false;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT Amount that was posted as a result of the entry.';
                    Visible = false;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of balancing account used in the entry: G/L Account, Bank Account, Vendor, Customer, or Fixed Asset.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the G/L account or the bank account, that a balancing entry has been posted to.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ID of the user that is associated with the entry.';
                    Visible = false;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Source Code that is linked to the entry.';
                    Visible = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the reason code on the entry.';
                    Visible = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the entry has been part of a reverse transaction (correction) made by the Reverse function.';
                    Visible = false;
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the correcting entry. If the field Specifies a number, the entry cannot be reversed again.';
                    Visible = false;
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the original entry that was undone by the reverse transaction.';
                    Visible = false;
                }
                field("FA Entry Type"; Rec."FA Entry Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'This field is automatically updated.';
                    Visible = false;
                }
                field("FA Entry No."; Rec."FA Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'This field is automatically updated.';
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Entry No. that the program has given the entry.';
                }
                field("Initial Currency (FCY)"; Rec."DEL Initial Currency (FCY)")
                {
                    ApplicationArea = All;
                }
                field("Initial Amount (FCY)"; Rec."DEL Initial Amount (FCY)")
                {
                    ApplicationArea = All;
                }
                field("Customer Provision"; Rec."DEL Customer Provision")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Scope = Repeater;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                        CurrPage.SAVERECORD();
                    end;
                }
                action(GLDimensionOverview)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Suite;
                    Caption = 'G/L Dimension Overview';
                    Image = Dimensions;
                    ToolTip = 'View an overview of general ledger entries and dimensions.';

                    trigger OnAction()
                    var
                        GLEntriesDimensionOverview: Page "G/L Entries Dimension Overview";
                    begin
                        IF Rec.ISTEMPORARY THEN BEGIN
                            GLEntriesDimensionOverview.SetTempGLEntry(Rec);
                            GLEntriesDimensionOverview.RUN();
                        END ELSE
                            PAGE.RUN(PAGE::"G/L Entries Dimension Overview", Rec);
                    end;
                }
                action("Value Entries")
                {
                    AccessByPermission = TableData Item = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Value Entries';
                    Image = ValueLedger;
                    Scope = Repeater;
                    ToolTip = 'View all amounts relating to an item.';

                    trigger OnAction()
                    begin
                        Rec.ShowValueEntries();
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Apply more entires for reverse")
                {
                    ApplicationArea = All;
                    Caption = 'Apply more entires for reverse';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        IF NOT HasRelatedOrder THEN
                            EXIT;

                        SelectGLEntryForReverse();
                    end;
                }
                action("Unmark the enry")
                {
                    ApplicationArea = All;
                    Caption = 'Unmark the enry';
                    Image = RemoveLine;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        GLEntry.RESET();
                        CurrPage.SETSELECTIONFILTER(GLEntry);
                        IF GLEntry.FINDSET() THEN
                            GLEntry.MODIFYALL("DEL Reverse With Doc. No.", '');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        IncomingDocument: Record "Incoming Document";
    begin
        HasIncomingDocument := IncomingDocument.PostedDocExists(Rec."Document No.", Rec."Posting Date");
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    begin
        IF Rec.FINDFIRST() THEN;
    end;

    var
        GLAcc: Record "G/L Account";
        GLEntry: Record "G/L Entry";
        RelatedOrder: Record "Sales Header";
        HasIncomingDocument: Boolean;
        HasRelatedOrder: Boolean;
        Text50001: Label '''''';

    local procedure GetCaption(): Text[250]
    var
        "txtLbl12": Label '%1 %2';
    begin
        IF GLAcc."No." <> Rec."G/L Account No." THEN
            IF NOT GLAcc.GET(Rec."G/L Account No.") THEN
                IF Rec.GETFILTER("G/L Account No.") <> '' THEN
                    IF GLAcc.GET(Rec.GETRANGEMIN("G/L Account No.")) THEN;
        EXIT(STRSUBSTNO("txtLbl12", GLAcc."No.", GLAcc.Name))
    end;

    procedure SetRelatedOrder(NewRelatedOrder: Record "Sales Header")
    begin

        HasRelatedOrder := TRUE;
        RelatedOrder := NewRelatedOrder;
    end;

    procedure SelectGLEntryForReverse()
    var
        GLEntry: Record "G/L Entry";
        ReverseGLEntry: Record "G/L Entry";
        GLSetup: Record "General Ledger Setup";
        GLEntries: Page "DEL Gen. Ledger Entr. Reverse";
    begin

        IF NOT GLSetup.GET() THEN
            GLSetup.INIT();

        GLSetup.TESTFIELD("DEL Provision Source Code");
        GLSetup.TESTFIELD("DEL Provision Journal Batch");

        GLEntry.RESET();
        GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
        GLEntry.FILTERGROUP(2);
        GLEntry.SETRANGE("Source Code", GLSetup."DEL Provision Source Code");
        GLEntry.SETFILTER("Journal Batch Name", GLSetup."DEL Provision Journal Batch");
        GLEntry.SETRANGE("DEL Customer Provision", RelatedOrder."Bill-to Customer No.");
        GLEntry.SETRANGE("DEL Reverse With Doc. No.", Text50001);
        GLEntry.FILTERGROUP(0);

        GLEntry.SETCURRENTKEY("Document No.", "Posting Date");

        CLEAR(GLEntries);
        GLEntries.SETTABLEVIEW(GLEntry);
        GLEntries.LOOKUPMODE(TRUE);
        IF GLEntries.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            GLEntries.SetGLEntry(ReverseGLEntry);
            IF ReverseGLEntry.FINDSET() THEN
                REPEAT
                    ReverseGLEntry."DEL Reverse With Doc. No." := RelatedOrder."No.";
                    ReverseGLEntry.MODIFY();
                UNTIL ReverseGLEntry.NEXT() = 0;
        END;
    end;
}
