pageextension 50009 pageextension50009 extends "Posted Purchase Invoice"
{
    // 
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 06.04.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            06.04.09   adapté l'appel de fonction de création de l'affaire
    // DEL/PD/20190903/LOP003 : new Action button "Matrix Print"
    // DEL/PD/20191118/CRQ001 : changed action button "Matrix Print": new parameter for "Purchaser Code"
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.002,MGTS10.024
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.002    08.01.20    mhh     List of changes:
    //                                              Added new field: "Vendor Shipment Date"
    // 
    // 002     MGTS10.024       10.02.21    mhh     List of changes:
    //                                              Added new field: "Due Date Calculation"
    // ------------------------------------------------------------------------------------------
    layout
    {


        //Unsupported feature: Code Modification on "Control 87.OnAssistEdit".

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
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
          // LOCO/ChC -
          //MODIFY;
        END;
        */
        //end;
        addafter("Control 71")
        {
            field("Due Date Calculation"; "Due Date Calculation")
            {
            }
        }
        addafter("Control 104")
        {
            field("Vendor Shipment Date"; "Vendor Shipment Date")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 55".

        addafter("Action 106")
        {
            action("Create Deal")
            {
                Caption = 'Create Deal';
                Image = CreateWhseLoc;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    affaireNo_Co_Loc: Code[20];
                begin

                    //créer un Deal à partir du No ACO
                    affaireNo_Co_Loc := Deal_Cu.FNC_New_Deal("Order No."); //MESSAGE('DEAL CREATION OK');

                    //initialise le Deal
                    //START CHG01
                    Deal_Cu.FNC_Init_Deal(affaireNo_Co_Loc, TRUE, FALSE); //MESSAGE('DEAL INIT OK');
                    //STOP CHG01
                    Deal_Cu.FNC_UpdateStatus(affaireNo_Co_Loc);
                end;
            }
        }
        addafter(Print)
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
                    lUsage: Option ,"S.Order","S.Invoice","S.Cr.Memo",,,"P.Order","P.Invoice",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Statement;
                    lcuDocumentMatrixMgt: Codeunit "50015";
                    ProcessType: Option Manual,Automatic;
                    lrecDocMatrixSelection: Record "50071";
                begin
                    //DEL/PD/20190212/LOP003.begin
                    //PurchInvHeader := Rec;
                    //CurrPage.SETSELECTIONFILTER(PurchInvHeader);
                    IF lcuDocumentMatrixMgt.ShowDocMatrixSelection(Rec."Buy-from Vendor No.", ProcessType::Manual, lUsage::"P.Invoice", lrecDocMatrixSelection, FALSE) THEN
                        lcuDocumentMatrixMgt.ProcessDocumentMatrix(lUsage::"P.Invoice", ProcessType::Manual, Rec, Rec.FIELDNO("Buy-from Vendor No."), Rec.FIELDNO("No."), lrecDocMatrixSelection, Rec.FIELDNO("Purchaser Code"));
                    //DEL/PD/20190212/LOP003.end
                end;
            }
        }
    }

    var
        Deal_Cu: Codeunit "50020";
}

