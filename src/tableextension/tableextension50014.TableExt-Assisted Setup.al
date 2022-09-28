tableextension 50014 tableextension50014 extends "Assisted Setup"
{
    // //DEL_QR/THS/300620- Modify function Initialize, add loac var SwissQRBillInstall and code in

    //Unsupported feature: Variable Insertion (Variable: SwissQRBillInstall) (VariableCollection) on "Initialize(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "Initialize(PROCEDURE 2)".

    //procedure Initialize();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT ISEMPTY THEN
      UpdateStatus;

    #4..140
    AddSetupAssistant(PAGE::"CRM Connection Setup Wizard",CRMConnectionSetupTxt,SortingOrder,TRUE,
      GroupId,FALSE,"Item Type"::"Setup and Help");
    AddSetupAssistantResources(PAGE::"CRM Connection Setup Wizard",'','',0,PAGE::"CRM Connection Setup Wizard",'');
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..143

    SwissQRBillInstall.CheckAndInstall;
    */
    //end;
}

