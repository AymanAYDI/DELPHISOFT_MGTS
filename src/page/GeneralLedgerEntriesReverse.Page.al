page 50127 "General Ledger Entries Reverse"
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
    SourceTable = Table17;
    SourceTableView = SORTING(Document No., Posting Date)
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
                action(ReverseTransaction)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reverse Transaction';
                    Ellipsis = true;
                    Image = ReverseRegister;
                    Scope = Repeater;
                    ToolTip = 'Reverse a posted general ledger entry.';

                    trigger OnAction()
                    var
                        ReversalEntry: Record "179";
                    begin
                        CLEAR(ReversalEntry);
                        IF Reversed THEN
                            ReversalEntry.AlreadyReversedEntry(TABLECAPTION, "Entry No.");
                        IF "Journal Batch Name" = '' THEN
                            ReversalEntry.TestFieldError;
                        TESTFIELD("Transaction No.");
                        ReversalEntry.ReverseTransaction("Transaction No.")
                    end;
                }
                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'View Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        ToolTip = 'View any incoming document records and file attachments that exist for the entry or document.';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "130";
                        begin
                            IncomingDocument.ShowCard("Document No.", "Posting Date");
                        end;
                    }
                    action(SelectIncomingDoc)
                    {
                        AccessByPermission = TableData 130 = R;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Select Incoming Document';
                        Enabled = NOT HasIncomingDocument;
                        Image = SelectLineToApply;
                        ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                        trigger OnAction()
                        var
                            IncomingDocument: Record "130";
                        begin
                            IncomingDocument.SelectIncomingDocumentForPostedDocument("Document No.", "Posting Date", RECORDID);
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Create Incoming Document from File';
                        Ellipsis = true;
                        Enabled = NOT HasIncomingDocument;
                        Image = Attach;
                        ToolTip = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.';

                        trigger OnAction()
                        var
                            IncomingDocumentAttachment: Record "133";
                        begin
                            IncomingDocumentAttachment.NewAttachmentFromPostedDocument("Document No.", "Posting Date");
                        end;
                    }
                }
            }
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';

                trigger OnAction()
                var
                    Navigate: Page "344";
                begin
                    Navigate.SetDoc("Posting Date", "Document No.");
                    Navigate.RUN;
                end;
            }
            action(DocsWithoutIC)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Documents without Incoming Document';
                Image = Documents;
                ToolTip = 'View posted purchase and sales documents under the G/L account that do not have related incoming document records.';

                trigger OnAction()
                var
                    PostedDocsWithNoIncBuf: Record "134";
                begin
                    COPYFILTER("G/L Account No.", PostedDocsWithNoIncBuf."G/L Account No. Filter");
                    PAGE.RUN(PAGE::"Posted Docs. With No Inc. Doc.", PostedDocsWithNoIncBuf);
                end;
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

    local procedure GetCaption(): Text[250]
    begin
        IF GLAcc."No." <> "G/L Account No." THEN
            IF NOT GLAcc.GET("G/L Account No.") THEN
                IF GETFILTER("G/L Account No.") <> '' THEN
                    IF GLAcc.GET(GETRANGEMIN("G/L Account No.")) THEN;
        EXIT(STRSUBSTNO('%1 %2', GLAcc."No.", GLAcc.Name))
    end;


    procedure SetGLEntry(var GLEntry: Record "17")
    begin

        //MGTS10.00.001; 001; mhh; entire function
        CurrPage.SETSELECTIONFILTER(GLEntry);
    end;
}

