pageextension 50012 "DEL PostedSalesInvoices" extends "Posted Sales Invoices" //143
{


    layout
    {
        addafter("Document Exchange Status") //11
        {
            field("DEL Shipment No."; Rec."DEL Shipment No.")
            {
            }
        }
    }
    actions
    {
        addafter(IncomingDoc)
        {
            action("DEL SendEDIDocument")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send EDI Invoice';
                Image = SendElectronicDocument;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    MGTSEDIManagement: Codeunit "DEL MGTS EDI Management";
                begin
                    MGTSEDIManagement.ResendCustomerInvoice(Rec);
                    CurrPage.UPDATE();
                end;
            }
        }
        addafter("Invoice") //42 
        {
            action("DEL Print MGTS")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print MGTS';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                //TODO Visible = NOT IsOfficeAddin;

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                    MinimizingClicksNGTS: Codeunit "DEL Minimizing Clicks - MGTS";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesInvHeader);
                    MinimizingClicksNGTS.FctPrintSalesInvoiceMGTS(SalesInvHeader);
                    SalesInvHeader.PrintRecords(TRUE);
                end;
            }
        }
    }
}

