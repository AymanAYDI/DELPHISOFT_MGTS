pageextension 50006 "DEL PostedSalesInvoice" extends "Posted Sales Invoice" //132
{

    layout
    {


        addafter("Due Date") //68 
        {
            field("DEL Shipment No."; Rec."DEL Shipment No.")
            {
            }
        }
        addafter("Closed") //76 
        {
            field("DEL Fiscal Repr."; Rec."DEL Fiscal Repr.")
            {
                Editable = false;
            }
        }
        addafter("Payment Method Code") //28 
        {
            field("DEL Mention Under Total"; Rec."DEL Mention Under Total")
            {
            }
            field("DEL Amount Mention Under Total"; Rec."DEL Amount Mention Under Total")
            {
            }
        }
        addafter("Bill-to Contact") //60
        {
            field("DEL Your Reference"; Rec."Your Reference")
            {
                Editable = false;
            }
        }
    }
    actions
    {

        addafter(ChangePaymentService)
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
            separator(SPc)
            {
            }
        }
        addafter(Email)
        {
            action("DEL Matrix Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Matrix Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    lrecSalesInvoiceHeader: Record "Sales Invoice Header";
                    lrecDocMatrixSelection: Record "DEL DocMatrix Selection";
                    SalesInvoiceHeader2: Record "Sales Invoice Header";
                    lcuDocumentMatrixMgt: Codeunit "DEL DocMatrix Management";
                    lUsage: Enum "DEL Usage DocMatrix Selection";

                    ProcessType: Enum "DEL Process Type";

                begin
                    IF Rec."DEL Sent To Customer" THEN
                        IF NOT CONFIRM(Text50000) THEN
                            EXIT;

                    lrecSalesInvoiceHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(lrecSalesInvoiceHeader);
                    IF lcuDocumentMatrixMgt.ShowDocMatrixSelection(Rec."Sell-to Customer No.", ProcessType::Manual, lUsage::"S.Invoice", lrecDocMatrixSelection, FALSE) THEN BEGIN
                        lcuDocumentMatrixMgt.ProcessDocumentMatrix(lUsage::"S.Invoice", ProcessType::Manual, lrecSalesInvoiceHeader, Rec.FIELDNO("Sell-to Customer No."), Rec.FIELDNO("No."), lrecDocMatrixSelection, 0);
                        SalesInvoiceHeader2.GET(Rec."No.");
                        SalesInvoiceHeader2."DEL Sent To Customer" := TRUE;
                        SalesInvoiceHeader2.MODIFY();
                    END;
                end;
            }
        }
        addafter(Invoice) //51
        {
            action("DEL Print MGTS")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print MGTS';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Visible = NOT IsOfficeAddin;

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

    var
        Text50000: Label 'The document has already been sent. Do you want to send it again?';

    //TODO Unsupported feature: Property Deletion (ModifyAllowed).

}

