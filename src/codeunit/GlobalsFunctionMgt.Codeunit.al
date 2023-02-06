codeunit 50013 "DEL Globals Function Mgt"
{
    procedure SetHideValidationDialog(pHideValidationDialog: Boolean)
    begin
        HideValidationDialog := pHideValidationDialog;
    end;

    procedure GetVATAmount(): Boolean
    begin
        exit(HideValidationDialog);
    end;

    var
        HideValidationDialog: Boolean;
}
