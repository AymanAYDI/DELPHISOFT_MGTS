pageextension 50017 "DEL IncomingDocuments" extends "Incoming Documents" //190
{
    actions
    {
        //TODO modify(CreateDocument)
        // {
        //     Visible = NOT "Swiss QRBill";
        // }
        // modify(CreateGenJnlLine)
        // {
        //     Visible = NOT "Swiss QRBill";
        // }
        // modify(CreateManually)
        // {
        //     Visible = NOT "Swiss QRBill";
        // }
        addafter("Set View") //73 
        {
            group("DEL Swiss QR-Bill")
            {
                Caption = 'Create From QR-Bill';
                ToolTip = 'QR-Bill processing.';
                action("DEL Swiss QR-Bill Scan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scan QR-Bill';
                    Image = CreateDocument;
                    ToolTip = 'Create a new incoming document record from the scanning of QR-bill with an input scanner, or from manual (copy/paste) of the decoded QR-Code text value into a field.';

                    trigger OnAction()
                    begin
                        //TODO SwissQRBillIncomingDoc.CreateNewIncomingDocFromQRBill(FALSE);
                    end;
                }
                action("DEL Swiss QR-Bill Import")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Scanned QR-Bill File';
                    Image = Import;
                    ToolTip = 'Creates a new incoming document record by importing a scanned QR-bill that is saved as a text file.';

                    trigger OnAction()
                    begin
                        //TODO SwissQRBillIncomingDoc.CreateNewIncomingDocFromQRBill(TRUE);
                    end;
                }
                action("DEL Swiss QR-Bill Create Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Journal Line';
                    Image = TransferToGeneralJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Creates a new journal line from the incoming QR-bill document.';
                    //TODOVisible = "Swiss QRBill";

                    trigger OnAction()
                    begin
                        //TODO  SwissQRBillIncomingDoc.CreateJournalAction(Rec);
                    end;
                }
                action("DEL Swiss QR-Bill Create Purch Inv")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Purchase Invoice';
                    Image = CreateDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Creates a new purchase invoice from the incoming QR-bill document.';
                    //TODO/ REMOVED Visible = "Swiss QRBill";

                    trigger OnAction()
                    begin
                        //TODO SwissQRBillIncomingDoc.CreatePurchaseInvoiceAction(Rec);
                    end;
                }
            }
        }
    }


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
    //TODO: removed SwissQRBillIncomingDoc: Codeunit 11516;
}

