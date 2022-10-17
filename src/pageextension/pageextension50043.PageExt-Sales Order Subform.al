pageextension 50043 pageextension50043 extends "Sales Order Subform"
{
    // THM270318    27.03.18     mettre page editable
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.003,MGTS10.014
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.003    13.01.20    mhh     List of changes:
    //                                              Added new field: "Post With Purch. Order No."
    //                          26.03.20    mhh     List of changes:
    //                                              Added new field: "Shipped With Difference"
    // 
    // 002     MGTS10.014       23.11.20    mhh     List of changes:
    //                                              Added new field: "Ship-to Code"
    //                                              Added new field: "Ship-to Name"
    // 
    // 003     MGTS10.035       21.03.22    RLA     List of changes:
    // 
    //                                                 Remove Repeater properties :
    //                                                 -----------------------------
    //                                                 * IndentationColumnName :  DescriptionIndent  --> Empty
    //                                                 * IndentationControls   :  Description  -->  Empty
    // 
    // ------------------------------------------------------------------------------------------
    layout
    {

        //Unsupported feature: Property Modification (TableRelation) on "Control 300".


        //Unsupported feature: Property Modification (TableRelation) on "Control 302".


        //Unsupported feature: Property Modification (TableRelation) on "Control 304".


        //Unsupported feature: Property Modification (TableRelation) on "Control 306".


        //Unsupported feature: Property Modification (TableRelation) on "Control 308".


        //Unsupported feature: Property Modification (TableRelation) on "Control 310".


        //Unsupported feature: Property Deletion (IndentationColumnName) on "Control 1".


        //Unsupported feature: Property Deletion (IndentationControls) on "Control 1".

        addafter("Control 50")
        {
            field("Requested qtity"; "Requested qtity")
            {
                BlankZero = true;
            }
        }
        addafter("Control 12")
        {
            field("Special Order Purchase No."; "Special Order Purchase No.")
            {
            }
            field("Special Order Purch. Line No."; "Special Order Purch. Line No.")
            {
            }
            field("Post With Purch. Order No."; "Post With Purch. Order No.")
            {
                Caption = 'Post with purchase order No.';
            }
        }
        addafter("Control 52")
        {
            field("VAT %"; "VAT %")
            {
            }
        }
        addafter("Control 24")
        {
            field("Shipped With Difference"; "Shipped With Difference")
            {
            }
        }
        addafter("Control 82")
        {
            field("Estimated Delivery Date"; "Estimated Delivery Date")
            {
            }
        }
        addafter("Control 100")
        {
            field("Ship-to Code"; "Ship-to Code")
            {
            }
            field("Ship-to Name"; "Ship-to Name")
            {
            }
        }
        addafter("Control 148")
        {
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
                Visible = true;
            }
        }
    }


    //Unsupported feature: Code Modification on "OpenSpecialPurchOrderForm(PROCEDURE 14)".

    //procedure OpenSpecialPurchOrderForm();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    TESTFIELD("Special Order Purchase No.");
    PurchHeader.SETRANGE("No.","Special Order Purchase No.");
    IF NOT PurchHeader.ISEMPTY THEN BEGIN
      PurchOrder.SETTABLEVIEW(PurchHeader);
      PurchOrder.EDITABLE := FALSE;
      PurchOrder.RUN;
    END ELSE BEGIN
      PurchRcptHeader.SETRANGE("Order No.","Special Order Purchase No.");
      IF PurchRcptHeader.COUNT = 1 THEN
        PAGE.RUN(PAGE::"Posted Purchase Receipt",PurchRcptHeader)
      ELSE
        PAGE.RUN(PAGE::"Posted Purchase Receipts",PurchRcptHeader);
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
      //THM270318
    //  PurchOrder.EDITABLE := FALSE;
      PurchOrder.EDITABLE := TRUE;
      //END THM270318
    #6..13
    */
    //end;
}

