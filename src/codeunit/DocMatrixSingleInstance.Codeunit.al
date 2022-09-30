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

    [Scope('Internal')]
    procedure SetSendFromAddress(pSendFromAddress: Text)
    begin
        SendFromAddress := pSendFromAddress;
    end;

    [Scope('Internal')]
    procedure GetSendFromAddress(): Text
    begin
        EXIT(SendFromAddress);
    end;

    [Scope('Internal')]
    procedure SetDocumentMatrixProcessActive(pDocumentMatrixProcessActive: Boolean)
    begin
        DocumentMatrixProcessActive := pDocumentMatrixProcessActive;

    end;

    [Scope('Internal')]
    procedure GetDocumentMatrixProcessActive(): Boolean
    begin
        EXIT(DocumentMatrixProcessActive);
    end;
}

