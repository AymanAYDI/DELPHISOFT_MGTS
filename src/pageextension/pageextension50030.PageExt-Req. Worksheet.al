pageextension 50030 pageextension50030 extends "Req. Worksheet"
{
    // 
    // Interne1    T-00051       STG   24.06.2008   add field 50000 "Requested Delivery Date"
    // --                        THM   31.05.2013   Migration NTO_VolLigne
    // 
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // MHH   MGTS0125                   22.07.19   Added new field: "Purchase Order Due Date"
    //                                             Added new field: "Recalc. Date Of Delivery"
    //                                             Changed trigger: OnAfterGetRecord()
    //                                             Changed trigger: OnNewRecord()
    //                                             Changed trigger: OnInsertRecord()
    //                                             Changed trigger: OnModifyRecord()
    //                                             Changed trigger: OnAfterGetCurrRecord()
    // 
    // Mgts10.00.05.00      04.01.2022 : Replace "Vol cbm" GetVolCBM
    layout
    {

        //Unsupported feature: Property Modification (TableRelation) on "Control 300".


        //Unsupported feature: Property Modification (TableRelation) on "Control 302".


        //Unsupported feature: Property Modification (TableRelation) on "Control 304".


        //Unsupported feature: Property Modification (TableRelation) on "Control 306".


        //Unsupported feature: Property Modification (TableRelation) on "Control 308".


        //Unsupported feature: Property Modification (TableRelation) on "Control 310".

        addafter("Control 44")
        {
            field(NTO_VolLigne; NTO_VolLigne)
            {
                Caption = 'Volume ligne';
            }
        }
        addafter("Control 8")
        {
            field("Requested Delivery Date"; "Requested Delivery Date")
            {
            }
        }
        addafter("Control 14")
        {
            field("Purchase Order Due Date"; "Purchase Order Due Date")
            {
                Style = Attention;
                StyleExpr = ColoredPurchDueDate;
            }
        }
        addafter("Control 48")
        {
            field("Recalc. Date Of Delivery"; "Recalc. Date Of Delivery")
            {
            }
        }
    }

    var
        NTO_VolLigne: Decimal;
        Item: Record "27";
        ColoredPurchDueDate: Boolean;


        //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

        //trigger OnAfterGetCurrRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReqJnlManagement.GetDescriptionAndRcptName(Rec,Description2,BuyFromVendorName);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ReqJnlManagement.GetDescriptionAndRcptName(Rec,Description2,BuyFromVendorName);

        //MGTS0125; MHH; single
        ColoredPurchDueDate := "Purchase Order Due Date" < TODAY;
        */
        //end;


        //Unsupported feature: Code Modification on "OnAfterGetRecord".

        //trigger OnAfterGetRecord()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);

        // NTO  calculs vol ligne

        NTO_VolLigne := 0;
        IF Item.GET("No.") THEN
        //>>Mgts10.00.05.00
        //NTO_VolLigne := Quantity * Item."Vol cbm"
        NTO_VolLigne := Quantity * Item.GetVolCBM(TRUE)
        //<<Mgts10.00.05.00
        ELSE
        NTO_VolLigne := 0;

        //MGTS0125; MHH; single
        ColoredPurchDueDate := "Purchase Order Due Date" < TODAY;
        */
        //end;


        //Unsupported feature: Code Insertion on "OnInsertRecord".

        //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
        //begin
        /*

        //MGTS0125; MHH; single
        ColoredPurchDueDate := "Purchase Order Due Date" < TODAY;
        */
        //end;


        //Unsupported feature: Code Insertion on "OnModifyRecord".

        //trigger OnModifyRecord(): Boolean
        //begin
        /*

        //MGTS0125; MHH; single
        ColoredPurchDueDate := "Purchase Order Due Date" < TODAY;
        */
        //end;


        //Unsupported feature: Code Modification on "OnNewRecord".

        //trigger OnNewRecord(BelowxRec: Boolean)
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReqJnlManagement.SetUpNewLine(Rec,xRec);
        CLEAR(ShortcutDimCode);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ReqJnlManagement.SetUpNewLine(Rec,xRec);
        CLEAR(ShortcutDimCode);

        //MGTS0125; MHH; single
        ColoredPurchDueDate := "Purchase Order Due Date" < TODAY;
        */
        //end;
}

