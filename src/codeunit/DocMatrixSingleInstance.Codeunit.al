codeunit 50016 "DEL DocMatrix SingleInstance"
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        DocumentMatrixProcessActive: Boolean;
        SendFromAddress: Text;


    procedure SetSendFromAddress(pSendFromAddress: Text)
    begin
        SendFromAddress := pSendFromAddress;
    end;

    procedure GetSendFromAddress(): Text
    begin
        EXIT(SendFromAddress);
    end;

    procedure SetDocumentMatrixProcessActive(pDocumentMatrixProcessActive: Boolean)
    begin
        DocumentMatrixProcessActive := pDocumentMatrixProcessActive;

    end;

    procedure GetDocumentMatrixProcessActive(): Boolean
    begin
        EXIT(DocumentMatrixProcessActive);
    end;
}

