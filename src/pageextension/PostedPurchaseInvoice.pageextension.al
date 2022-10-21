pageextension 50009 "DEL PostedPurchaseInvoice" extends "Posted Purchase Invoice" //138
{
    layout
    {


        addafter("Document Date") //71
        {
            field("DEL Due Date Calculation"; Rec."DEL Due Date Calculation")
            {
            }
        }
        addafter("Vendor Order No.") //104
        {
            field("DEL Vendor Shipment Date"; Rec."DEL Vendor Shipment Date")
            {
            }
        }
    }
    actions
    {

        addafter("Approvals") //106
        {
            action("DEL Create Deal")
            {
                Caption = 'Create Deal';
                Image = CreateWhseLoc;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    affaireNo_Co_Loc: Code[20];
                begin

                    affaireNo_Co_Loc := Deal_Cu.FNC_New_Deal(Rec."Order No.");

                    Deal_Cu.FNC_Init_Deal(affaireNo_Co_Loc, TRUE, FALSE);
                    Deal_Cu.FNC_UpdateStatus(affaireNo_Co_Loc);
                end;
            }
        }
        addafter(Print)
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
                    lrecDocMatrixSelection: Record "DEL DocMatrix Selection";

                    lcuDocumentMatrixMgt: Codeunit "DEL DocMatrix Management";
                    ProcessType: Enum "DEL Process Type";
                    lUsage: Enum "DEL Usage DocMatrix Selection";
                begin
                    IF lcuDocumentMatrixMgt.ShowDocMatrixSelection(Rec."Buy-from Vendor No.", ProcessType::Manual, lUsage::"P.Invoice", lrecDocMatrixSelection, FALSE) THEN
                        lcuDocumentMatrixMgt.ProcessDocumentMatrix(lUsage::"P.Invoice", ProcessType::Manual, Rec, Rec.FIELDNO("Buy-from Vendor No."), Rec.FIELDNO("No."), lrecDocMatrixSelection, Rec.FIELDNO("Purchaser Code"));
                end;
            }
        }
    }

    var
        Deal_Cu: Codeunit "DEL Deal";
}

