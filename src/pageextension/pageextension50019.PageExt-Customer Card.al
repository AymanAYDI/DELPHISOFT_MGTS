pageextension 50019 pageextension50019 extends "Customer Card"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where      Description
    // -----------------------------------------------------------------
    // T-00678    THM       29.09.14   pageAction   add suvi contrat
    // T-00705    THM       19.06.15   PageAction   add CaptionML
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // MGTS:EDD001.01 :TU 24/05/2018 : Minimisation des clics :
    //   #Added new field "FTP Save" in general tab
    // 
    // MGTS:EDD001.02 :TU 06/06/2018 : Minimisation des clics :
    //                               - Add new field "FTP Save 2" in general tab
    // +----------------------------------------------------------------------------------------------------------------+
    // DEL/PD/20190228/LOP003 : new action button "Document Matrix"
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.005
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.005    04.02.20    mhh     List of changes:
    //                                              Added new field: "Change VAT Registration Place"
    // 002    MGTS10.032       30.07.21    ehh     List of changes:
    //                                              Added new field: "Show TVA In Invoice"
    // 
    // ------------------------------------------------------------------------------------------
    layout
    {

        //Unsupported feature: Property Modification (SubPageLink) on "Control 35".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 27".


        //Unsupported feature: Property Modification (SubPageLink) on "SalesHistSelltoFactBox(Control 1903720907)".


        //Unsupported feature: Property Modification (SubPageLink) on "SalesHistBilltoFactBox(Control 1907234507)".


        //Unsupported feature: Property Modification (SubPageLink) on "CustomerStatisticsFactBox(Control 1902018507)".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1905532107".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1907829707".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1902613707".

        addafter("Control 69")
        {
            field("No TVA intracomm. NGTS"; "No TVA intracomm. NGTS")
            {
            }
        }
        addafter("Control 28")
        {
            field("Fiscal Repr."; "Fiscal Repr.")
            {
            }
            field("FTP Save"; "FTP Save")
            {
            }
            field("FTP Save 2"; "FTP Save 2")
            {
            }
            field(EDI; EDI)
            {
            }
        }
        addafter("Control 36")
        {
            field("Change VAT Registration Place"; "Change VAT Registration Place")
            {
            }
            field("Show VAT In Invoice"; "Show VAT In Invoice")
            {
            }
            field("Mention Under Total"; "Mention Under Total")
            {
            }
            field("Amount Mention Under Total"; "Amount Mention Under Total")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 84".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 94".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 78".


        //Unsupported feature: Property Modification (RunPageView) on "Action 80".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 76".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 79".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 77".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 112".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 113".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 136".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 162".

        addafter("Action 118")
        {
            action(Fee)
            {
                Caption = 'Fee';

                trigger OnAction()
                var
                    feeConnection_Re_Loc: Record "50025";
                    feeConnection_Form_Loc: Page "50025";
                begin
                    // T-00551-FEE -
                    feeConnection_Re_Loc.RESET();
                    feeConnection_Re_Loc.SETRANGE(Type, feeConnection_Re_Loc.Type::Customer);
                    feeConnection_Re_Loc.SETFILTER("No.", "No.");

                    CLEAR(feeConnection_Form_Loc);
                    feeConnection_Form_Loc.SETTABLEVIEW(feeConnection_Re_Loc);
                    feeConnection_Form_Loc.SETRECORD(feeConnection_Re_Loc);
                    feeConnection_Form_Loc.LOOKUPMODE(TRUE);
                    feeConnection_Form_Loc.FNC_Set_Type(feeConnection_Re_Loc.Type::Customer, "No.");
                    feeConnection_Form_Loc.RUN
                    // T-00551-FEE +
                end;
            }
            action("Fee Copy")
            {
                Caption = 'Fee Copy';

                trigger OnAction()
                var
                    CustomerList_Fo_Loc: Page "22";
                    Customer_Re_Loc: Record "18";
                    FeeMgt_Cu_Loc: Codeunit "50028";
                begin
                    // T-00551-FEE -
                    CustomerList_Fo_Loc.LOOKUPMODE(TRUE);
                    IF CustomerList_Fo_Loc.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        CustomerList_Fo_Loc.GETRECORD(Customer_Re_Loc);
                        // MESSAGE('%1',Customer_Re_Loc."No.")  ;
                        FeeMgt_Cu_Loc.FNC_FeeCopy(0, Customer_Re_Loc."No.", Rec."No.");

                    END;
                    // T-00551-FEE +
                end;
            }
            separator()
            {
            }
            action("Suivi de contrat")
            {
                Caption = 'Contract follow up';
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50073;
                RunPageLink = No.=FIELD(No.);
            }
        }
        addfirst("Action 7")
        {
            action("Document Matrix")
            {
                Caption = 'Document Matrix';
                Image = TaxSetup;

                trigger OnAction()
                var
                    lrecDocumentMatrix: Record "50067";
                    lpgDocumentMatrix: Page "50130";
                begin
                    lpgDocumentMatrix.SetCustomerFilter("No.");
                    lpgDocumentMatrix.RUNMODAL;
                end;
            }
        }
    }
}

