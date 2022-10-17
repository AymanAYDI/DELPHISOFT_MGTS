pageextension 50006 pageextension50006 extends "Posted Sales Invoice"
{
    // THM       08.09.17      MIG2017
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // NGTS:EDD001.01 :TU 24/05/2018 : Minimisation des clics :
    //   # New Action ActionPrint MGTS&Print MGTS
    // +----------------------------------------------------------------------------------------------------------------+
    // 
    // DEL/PD/20190903/LOP003 : new action button "Matrix Print"
    // DEL/PD/20191118/CRQ001 : changed action button "Matrix Print": new parameter for "Purchaser Code", fix "0" not relevant for sales
    // 
    // 
    // MGTSEDI10.00.00.01 | 24.12.2020 | EDI Management : Add action : Send EDI Invoice
    // 
    // MGTSEDI10.00.00.22 | 11.02.2021 | EDI Management : Add field Shipment No
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova
    // Version : MGTS10.030
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version       Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001     MGTS10.030    06.07.21    mhh     List of changes:
    //                                           Changed trigger: <Action100000000> - OnAction()
    // ------------------------------------------------------------------------------------------
    // 
    // MGTS10.031  | 22.07.2021 | Add fields : 50050, 50051

    //Unsupported feature: Property Insertion (Permissions) on ""Posted Sales Invoice"(Page 132)".

    layout
    {


        //Unsupported feature: Code Modification on "Control 30.OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date");
        ChangeExchangeRate.EDITABLE(FALSE);
        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
          "Currency Factor" := ChangeExchangeRate.GetParameter;
          MODIFY;
        END;
        CLEAR(ChangeExchangeRate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
          //MIG2017 START
          // LOCO/ChC -
          //MODIFY;
          //END MIG2017
        END;
        CLEAR(ChangeExchangeRate);
        */
        //end;
        addafter("Control 68")
        {
            field("Shipment No."; "Shipment No.")
            {
            }
        }
        addafter("Control 76")
        {
            field("Fiscal Repr."; "Fiscal Repr.")
            {
                Editable = false;
            }
        }
        addafter("Control 28")
        {
            field("Mention Under Total"; "Mention Under Total")
            {
            }
            field("Amount Mention Under Total"; "Amount Mention Under Total")
            {
            }
        }
        addafter("Control 60")
        {
            field("Your Reference"; "Your Reference")
            {
                Editable = false;
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 57".

        addafter(ChangePaymentService)
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
            separator()
            {
            }
        }
        addafter(Email)
        {
            action("Matrix Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Matrix Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    lrecSalesInvoiceHeader: Record "112";
                    lUsage: Option ,"S.Order","S.Invoice","S.Cr.Memo",,,"P.Order","P.Invoice",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Statement;
                    lcuDocumentMatrixMgt: Codeunit "50015";
                    ProcessType: Option Manual,Automatic;
                    lrecDocMatrixSelection: Record "50071";
                    SalesInvoiceHeader2: Record "112";
                begin
                    //MGTS10.030; 001; mhh; begin
                    IF "Sent To Customer" THEN
                        IF NOT CONFIRM(Text50000) THEN
                            EXIT;

                    lrecSalesInvoiceHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(lrecSalesInvoiceHeader);
                    IF lcuDocumentMatrixMgt.ShowDocMatrixSelection(Rec."Sell-to Customer No.", ProcessType::Manual, lUsage::"S.Invoice", lrecDocMatrixSelection, FALSE) THEN BEGIN
                        lcuDocumentMatrixMgt.ProcessDocumentMatrix(lUsage::"S.Invoice", ProcessType::Manual, lrecSalesInvoiceHeader, Rec.FIELDNO("Sell-to Customer No."), Rec.FIELDNO("No."), lrecDocMatrixSelection, 0);
                        SalesInvoiceHeader2.GET("No.");
                        SalesInvoiceHeader2."Sent To Customer" := TRUE;
                        SalesInvoiceHeader2.MODIFY;
                    END;
                    //MGTS10.030; 001; mhh; end
                end;
            }
        }
        addafter("Action 51")
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

    var
        Text50000: Label 'The document has already been sent. Do you want to send it again?';

        //Unsupported feature: Property Deletion (ModifyAllowed).

}

