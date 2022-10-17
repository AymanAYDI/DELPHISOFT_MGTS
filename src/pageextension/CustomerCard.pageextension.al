pageextension 50019 "DEL CustomerCard" extends "Customer Card" //21
{
    layout
    {
        addafter("AdjProfitPct") //69
        {
            field("DEL No TVA intracomm. NGTS"; Rec."DEL No TVA intracomm. NGTS")
            {
            }
        }
        addafter("Last Date Modified") //28 
        {
            field("DEL Fiscal Repr."; Rec."DEL Fiscal Repr.")
            {
            }
            field("DEL FTP Save"; Rec."DEL FTP Save")
            {
            }
            field("DEL FTP Save 2"; Rec."DEL FTP Save 2")
            {
            }
            field("DEL EDI"; "DEL EDI")
            {
            }
        }
        addafter("Copy Sell-to Addr. to Qte From") //TODO CONTROL 36 DOES NOT EXIST
        {
            field("DEL Change VAT Registration Place"; Rec."DEL Change VAT Reg. Place")
            {
            }
            field("DEL Show VAT In Invoice"; Rec."DEL Show VAT In Invoice")
            {
            }
            field("DEL Mention Under Total"; Rec."DEL Mention Under Total")
            {
            }
            field("DEL Amount Mention Under Total"; Rec."DEL Amount Mention Under Total")
            {
            }
        }
    }
    actions
    {


        addafter("Recurring Sales Lines") //118
        {
            action("DEL Fee")
            {
                Caption = 'Fee';

                trigger OnAction()
                var
                    feeConnection_Re_Loc: Record "DEL Fee Connection";
                    feeConnection_Form_Loc: Page "DEL Fee Connection";
                begin
                    feeConnection_Re_Loc.RESET();
                    feeConnection_Re_Loc.SETRANGE(Type, feeConnection_Re_Loc.Type::Customer);
                    feeConnection_Re_Loc.SETFILTER("No.", Rec."No.");

                    CLEAR(feeConnection_Form_Loc);
                    feeConnection_Form_Loc.SETTABLEVIEW(feeConnection_Re_Loc);
                    feeConnection_Form_Loc.SETRECORD(feeConnection_Re_Loc);
                    feeConnection_Form_Loc.LOOKUPMODE(TRUE);
                    feeConnection_Form_Loc.FNC_Set_Type(feeConnection_Re_Loc.Type::Customer, Rec."No.");
                    feeConnection_Form_Loc.RUN()
                end;
            }
            action("DEL Fee Copy")
            {
                Caption = 'Fee Copy';

                trigger OnAction()
                var
                    Customer_Re_Loc: Record Customer;
                    FeeMgt_Cu_Loc: Codeunit "DEL Alert and fee copy Mgt";
                    CustomerList_Fo_Loc: Page "Customer List";

                begin
                    CustomerList_Fo_Loc.LOOKUPMODE(TRUE);
                    IF CustomerList_Fo_Loc.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                        CustomerList_Fo_Loc.GETRECORD(Customer_Re_Loc);
                        FeeMgt_Cu_Loc.FNC_FeeCopy(0, Customer_Re_Loc."No.", Rec."No.");
                    END;
                end;
            }
            separator(spc)
            {
            }
            action("DEL Suivi de contrat")
            {
                Caption = 'Contract follow up';
                Image = Agreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Suivi des contrats";
                RunPageLink = "No." = FIELD("No.");
            }
        }
        addfirst("Documents") //7 
        {
            action("DEL Document Matrix")
            {
                Caption = 'Document Matrix';
                Image = TaxSetup;

                trigger OnAction()
                var
                    lpgDocumentMatrix: Page "DEL Document Matrix";
                begin
                    lpgDocumentMatrix.SetCustomerFilter(Rec."No.");
                    lpgDocumentMatrix.RUNMODAL();
                end;
            }
        }
    }
}

