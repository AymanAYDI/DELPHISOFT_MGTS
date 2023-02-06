pageextension 50063 "DEL IncomingDocument" extends "Incoming Document" //189
{
    actions
    {
        addafter(TextToAccountMapping)
        {
            action("DEL Swiss QR-Bill Scan")
            {
                ApplicationArea = Basic, Suite;
                Image = CreateDocument;
                trigger OnAction()
                begin
                    //TODO SwissQRBillIncomingDoc.ImportQRBillToIncomingDoc(Rec, FALSE);
                end;
            }
            action("DEL Swiss QR-Bill Import")
            {
                ApplicationArea = Basic, Suite;
                Image = Import;

                trigger OnAction()
                begin
                    //SwissQRBillIncomingDoc.ImportQRBillToIncomingDoc(Rec, TRUE);
                end;
            }
            action("DEL Swiss QR-Bill Create Journal")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                //   Visible="Swiss QRBill";
                //   Enabled="Swiss QRBill";
                Image = CreateDocument;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //TODO  SwissQRBillIncomingDoc.CreateJournalAction(Rec);
                end;
            }
            action("DEL Swiss QR-Bill Create Purch Inv")
            {
                ApplicationArea = Basic, Suite;
                Promoted = true;
                //   Visible="Swiss QRBill";
                //   Enabled="Swiss QRBill";
                Image = CreateDocument;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    //TODO SwissQRBillIncomingDoc.CreatePurchaseInvoiceAction(Rec);
                end;
            }
        }
    }



}

