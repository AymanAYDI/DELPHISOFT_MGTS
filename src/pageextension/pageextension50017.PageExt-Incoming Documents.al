pageextension 50017 pageextension50017 extends "Incoming Documents"
{
    actions
    {
        modify(CreateDocument)
        {
            Visible = NOT "Swiss QRBill";
        }
        modify(CreateGenJnlLine)
        {
            Visible = NOT "Swiss QRBill";
        }
        modify(CreateManually)
        {
            Visible = NOT "Swiss QRBill";
        }
        addafter("Action 73")
        {
            group("Swiss QR-Bill")
            {
                Caption = 'Create From QR-Bill';
                ToolTip = 'QR-Bill processing.';
                action("Swiss QR-Bill Scan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scan QR-Bill';
                    Image = CreateDocument;
                    ToolTip = 'Create a new incoming document record from the scanning of QR-bill with an input scanner, or from manual (copy/paste) of the decoded QR-Code text value into a field.';

                    trigger OnAction()
                    begin
                        SwissQRBillIncomingDoc.CreateNewIncomingDocFromQRBill(FALSE);
                    end;
                }
                action("Swiss QR-Bill Import")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Scanned QR-Bill File';
                    Image = Import;
                    ToolTip = 'Creates a new incoming document record by importing a scanned QR-bill that is saved as a text file.';

                    trigger OnAction()
                    begin
                        SwissQRBillIncomingDoc.CreateNewIncomingDocFromQRBill(TRUE);
                    end;
                }
                action("Swiss QR-Bill Create Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Journal Line';
                    Image = TransferToGeneralJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Creates a new journal line from the incoming QR-bill document.';
                    Visible = "Swiss QRBill";

                    trigger OnAction()
                    begin
                        SwissQRBillIncomingDoc.CreateJournalAction(Rec);
                    end;
                }
                action("Swiss QR-Bill Create Purch Inv")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Purchase Invoice';
                    Image = CreateDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Creates a new purchase invoice from the incoming QR-bill document.';
                    Visible = "Swiss QRBill";

                    trigger OnAction()
                    begin
                        SwissQRBillIncomingDoc.CreatePurchaseInvoiceAction(Rec);
                    end;
                }
            }
        }
    }


    //Unsupported feature: Property Modification (ExternalDataType) on "CreateFromCamera(Action 56).OnAction.CameraOptions(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //CreateFromCamera : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraOptions;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateFromCamera : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=10.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraOptions;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (ExternalDataType) on "CameraProvider(Variable 1008)".

    //var
    //>>>> ORIGINAL VALUE:
    //CameraProvider : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraProvider;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CameraProvider : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=10.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraProvider;
    //Variable type has not been exported.

    var
        SwissQRBillIncomingDoc: Codeunit "11516";
}

