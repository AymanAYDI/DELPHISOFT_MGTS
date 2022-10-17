pageextension 50010 pageextension50010 extends "Posted Purchase Credit Memo"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.024
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.024       10.02.21    mhh     List of changes:
    //                                             Added new field: "Due Date Calculation"
    // ------------------------------------------------------------------------------------------
    layout
    {


        //Unsupported feature: Code Modification on "Control 75.OnAssistEdit".

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
          // LOCO/ChC -
          //MODIFY;
        END;
        CLEAR(ChangeExchangeRate);
        */
        //end;
        addafter("Control 31")
        {
            field("Due Date Calculation"; "Due Date Calculation")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 47".

    }
}

