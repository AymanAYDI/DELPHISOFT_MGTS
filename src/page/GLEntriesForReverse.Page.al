page 50126 "GL Entries For Reverse"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.001
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.001    18.12.19    mhh     List of changes:
    //                                              Created function: SetGLEntry()
    //                                              Added new field: "Customer Provision"
    // ------------------------------------------------------------------------------------------

    Caption = 'General Ledger Entries';
    DataCaptionExpression = GetCaption;
    Editable = false;
    PageType = List;
    Permissions = TableData 17 = rm;
    SourceTable = Table17;
    SourceTableView = SORTING(G/L Account No., Posting Date)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Document Type that the entry belongs to.';
                }
                field("External Document No."; "External Document No.")
                {
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the entry''s Document No.';
                }
                field("G/L Account No."; "G/L Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the account that the entry has been posted to.';
                }
                field("G/L Account Name"; "G/L Account Name")
                {
                    DrillDown = false;
                    ToolTip = 'Specifies the name of the account that the entry has been posted to.';
                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a description of the entry.';
                }
                field("Job No."; "Job No.")
                {
                    ToolTip = 'Specifies the Job No. corresponding the to G/L entry.';
                    Visible = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the dimension value code that the entry is linked to.';
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the dimension value code that the entry is linked to.';
                    Visible = false;
                }
                field("IC Partner Code"; "IC Partner Code")
                {
                    ToolTip = 'Specifies the code of the intercompany partner that the transaction is with if the entry was posted from an intercompany transaction.';
                    Visible = false;
                }
                field("Gen. Posting Type"; "Gen. Posting Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Gen. Posting Type that applies to the entry.';
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the general business posting group that applies to the entry.';
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the general product posting group that applies to the entry.';
                }
                field(Quantity; Quantity)
                {
                    ToolTip = 'Specifies the quantity that was posted on the entry.';
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Amount of the entry.';
                }
                field("Amount (FCY)"; "Amount (FCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the foreign currency amount for G/L entries.';
                }
                field("Additional-Currency Amount"; "Additional-Currency Amount")
                {
                    ToolTip = 'Specifies the general ledger entry that is posted if you post in an additional reporting currency.';
                    Visible = false;
                }
                field("VAT Amount"; "VAT Amount")
                {
                    ToolTip = 'Specifies the VAT Amount that was posted as a result of the entry.';
                    Visible = false;
                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of balancing account used in the entry: G/L Account, Bank Account, Vendor, Customer, or Fixed Asset.';
                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the G/L account or the bank account, that a balancing entry has been posted to.';
                }
                field("User ID"; "User ID")
                {
                    ToolTip = 'Specifies the ID of the user that is associated with the entry.';
                    Visible = false;
                }
                field("Source Code"; "Source Code")
                {
                    ToolTip = 'Specifies the Source Code that is linked to the entry.';
                    Visible = false;
                }
                field("Reason Code"; "Reason Code")
                {
                    ToolTip = 'Specifies the reason code on the entry.';
                    Visible = false;
                }
                field(Reversed; Reversed)
                {
                    ToolTip = 'Specifies if the entry has been part of a reverse transaction (correction) made by the Reverse function.';
                    Visible = false;
                }
                field("Reversed by Entry No."; "Reversed by Entry No.")
                {
                    ToolTip = 'Specifies the number of the correcting entry. If the field Specifies a number, the entry cannot be reversed again.';
                    Visible = false;
                }
                field("Reversed Entry No."; "Reversed Entry No.")
                {
                    ToolTip = 'Specifies the number of the original entry that was undone by the reverse transaction.';
                    Visible = false;
                }
                field("FA Entry Type"; "FA Entry Type")
                {
                    ToolTip = 'This field is automatically updated.';
                    Visible = false;
                }
                field("FA Entry No."; "FA Entry No.")
                {
                    ToolTip = 'This field is automatically updated.';
                    Visible = false;
                }
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the Entry No. that the program has given the entry.';
                }
                field("Initial Currency (FCY)"; "Initial Currency (FCY)")
                {
                }
                field("Initial Amount (FCY)"; "Initial Amount (FCY)")
                {
                }
                field("Customer Provision"; "Customer Provision")
                {
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; 193)
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
            }
            systempart(; Links)
            {
                Visible = false;
            }
            systempart(; Notes)
            {
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
                    AccessByPermission = TableData 348 = R;
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Scope = Repeater;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                        CurrPage.SAVERECORD;
                    end;
                }
                action(GLDimensionOverview)
                {
                    AccessByPermission = TableData 348 = R;
                    ApplicationArea = Suite;
                    Caption = 'G/L Dimension Overview';
                    Image = Dimensions;
                    ToolTip = 'View an overview of general ledger entries and dimensions.';

                    trigger OnAction()
                    var
                        GLEntriesDimensionOverview: Page "563";
                    begin
                        IF ISTEMPORARY THEN BEGIN
                            GLEntriesDimensionOverview.SetTempGLEntry(Rec);
                            GLEntriesDimensionOverview.RUN;
                        END ELSE
                            PAGE.RUN(PAGE::"G/L Entries Dimension Overview", Rec);
                    end;
                }
                action("Value Entries")
                {
                    AccessByPermission = TableData 27 = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Value Entries';
                    Image = ValueLedger;
                    Scope = Repeater;
                    ToolTip = 'View all amounts relating to an item.';

                    trigger OnAction()
                    begin
                        ShowValueEntries;
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
                    Caption = 'Unmark the enry';
                    Image = RemoveLine;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        GLEntry.RESET;
                        CurrPage.SETSELECTIONFILTER(GLEntry);
                        IF GLEntry.FINDSET THEN
                            GLEntry.MODIFYALL("Reverse With Doc. No.", '');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        IncomingDocument: Record "130";
    begin
        HasIncomingDocument := IncomingDocument.PostedDocExists("Document No.", "Posting Date");
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    begin
        IF FINDFIRST THEN;
    end;

    var
        GLAcc: Record "15";
        HasIncomingDocument: Boolean;
        RelatedOrder: Record "36";
        HasRelatedOrder: Boolean;
        Text50001: Label '''''';
        GLEntry: Record "17";

    local procedure GetCaption(): Text[250]
    begin
        IF GLAcc."No." <> "G/L Account No." THEN
            IF NOT GLAcc.GET("G/L Account No.") THEN
                IF GETFILTER("G/L Account No.") <> '' THEN
                    IF GLAcc.GET(GETRANGEMIN("G/L Account No.")) THEN;
        EXIT(STRSUBSTNO('%1 %2', GLAcc."No.", GLAcc.Name))
    end;

    [Scope('Internal')]
    procedure SetRelatedOrder(NewRelatedOrder: Record "36")
    begin

        HasRelatedOrder := TRUE;
        RelatedOrder := NewRelatedOrder;
    end;

    [Scope('Internal')]
    procedure SelectGLEntryForReverse()
    var
        GLEntry: Record "17";
        GLEntries: Page "50127";
        ReverseGLEntry: Record "17";
        GLSetup: Record "98";
    begin

        //MGTS10.00.001; 001; mhh; entire function
        IF NOT GLSetup.GET THEN
            GLSetup.INIT;

        GLSetup.TESTFIELD("Provision Source Code");
        GLSetup.TESTFIELD("Provision Journal Batch");

        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
        GLEntry.FILTERGROUP(2);
        GLEntry.SETRANGE("Source Code", GLSetup."Provision Source Code");
        GLEntry.SETFILTER("Journal Batch Name", GLSetup."Provision Journal Batch");
        GLEntry.SETRANGE("Customer Provision", RelatedOrder."Bill-to Customer No.");
        GLEntry.SETRANGE("Reverse With Doc. No.", Text50001);
        GLEntry.FILTERGROUP(0);

        GLEntry.SETCURRENTKEY("Document No.", "Posting Date");

        CLEAR(GLEntries);
        GLEntries.SETTABLEVIEW(GLEntry);
        GLEntries.LOOKUPMODE(TRUE);
        IF GLEntries.RUNMODAL = ACTION::LookupOK THEN BEGIN
            GLEntries.SetGLEntry(ReverseGLEntry);
            IF ReverseGLEntry.FINDSET THEN
                REPEAT
                    ReverseGLEntry."Reverse With Doc. No." := RelatedOrder."No.";
                    ReverseGLEntry.MODIFY;
                UNTIL ReverseGLEntry.NEXT = 0;
        END;
    end;
}

