tableextension 50019 tableextension50019 extends "Vendor Ledger Entry"
{
    // DEL_QR1.00.00.01/02.11.2020  C\AL : Payment Reference - OnValidate()
    fields
    {


        //Unsupported feature: Code Modification on ""Payment Reference"(Field 171).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Payment Reference" <> '' THEN
          TESTFIELD("Creditor No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //>>DEL_QR
        {
        IF "Payment Reference" <> '' THEN
          TESTFIELD("Creditor No.");
        }
        //<<DEL_QR
        */
        //end;
    }
}

