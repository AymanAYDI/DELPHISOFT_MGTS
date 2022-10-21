pageextension 50030 "DEL ReqWorksheet" extends "Req. Worksheet"
{
    layout
    {


        addafter("Location Code")
        {
            field("DEL NTO_VolLigne"; NTO_VolLigne)
            {
                Caption = 'Volume ligne';
            }
        }
        addafter("Quantity")
        {
            field("DEL Requested Delivery Date"; Rec."DEL Requested Delivery Date")
            {
            }
        }
        addafter("Due Date")
        {
            field("DEL Purchase Order Due Date"; Rec."DEL Purchase Order Due Date")
            {
                Style = Attention;
                StyleExpr = ColoredPurchDueDate;
            }
        }
        addafter("Order Date")
        {
            field("DEL Recalc. Date Of Delivery"; Rec."DEL Recalc. Date Of Delivery")
            {
            }
        }
    }

    var
        ColoredPurchDueDate: Boolean;
        NTO_VolLigne: Decimal;

    //TODO 
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

