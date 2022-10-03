codeunit 50016 "DocMatrix SingleInstance"
{
    // DEL/PD/20190227/LOP003 : object created

    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        SendFromAddress: Text;
        DocumentMatrixProcessActive: Boolean;


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

