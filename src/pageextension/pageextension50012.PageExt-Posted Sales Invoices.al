pageextension 50012 pageextension50012 extends "Posted Sales Invoices"
{
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // NGTS:EDD001.01 :TU 24/05/2018 : Minimisation des clics :
    //   #Added new Action Print MGTS&Print MGTS
    // +----------------------------------------------------------------------------------------------------------------+
    // 
    // MGTSEDI10.00.00.01 | 24.12.2020 | EDI Management : Add action : Send EDI Invoice
    // 
    // MGTSEDI10.00.00.22 | 11.02.2021 | EDI Management : Add field Shipment No

    //Unsupported feature: Property Modification (SourceTableView) on ""Posted Sales Invoices"(Page 143)".

    layout
    {
        addafter("Control 11")
        {
            field("Shipment No."; "Shipment No.")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 32".

        addafter(IncomingDoc)
        {
            action(SendEDIDocument)
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
                    MGTSEDIManagement: Codeunit "50052";
                begin
                    MGTSEDIManagement.ResendCustomerInvoice(Rec);
                    CurrPage.UPDATE;
                end;
            }
        }
        addafter("Action 42")
        {
            action("Print MGTS")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print MGTS';
                Ellipsis = true;
                Image = Print;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                Visible = NOT IsOfficeAddin;

                trigger OnAction()
                var
                    SalesInvHeader: Record "112";
                    MinimizingClicksNGTS: Codeunit "50012";
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

