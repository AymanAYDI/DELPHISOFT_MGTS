page 50137 "DEL DocMatrix Selection Card"
{
    PageType = Worksheet;
    SourceTable = "DEL DocMatrix Selection";

    layout
    {
        area(content)
        {
            group(Posting)
            {
                Visible = boPostVisible;
                field(Post; Rec.Post)
                {
                    //TODO CODEUNIT 
                    // trigger OnValidate()
                    // var
                    // lcuDocMatrixMgt: Codeunit "50015";
                    // begin
                    //     lcuDocMatrixMgt.UpdateDocMatrixSelection("No.", "Process Type", 1, Rec, Post = Post::" ");
                    //     CurrPage.UPDATE(TRUE);
                    // end;
                }
            }
            group(Document)
            {
                field("Send to FTP 1"; Rec."Send to FTP 1")
                {
                }
                field("Send to FTP 2"; Rec."Send to FTP 2")
                {
                }
                field("E-Mail from Sales Order"; Rec."E-Mail from Sales Order")
                {
                }
                field("E-Mail To 1"; Rec."E-Mail To 1")
                {
                }
                field("E-Mail To 2"; Rec."E-Mail To 2")
                {
                }
                field("E-Mail To 3"; Rec."E-Mail To 3")
                {
                }
                field("E-Mail From"; Rec."E-Mail From")
                {
                }
                field("Save PDF"; Rec."Save PDF")
                {
                }
                field("Print PDF"; Rec."Print PDF")
                {
                }
                field("Mail Text Code"; Rec."Mail Text Code")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lrecDocMatrixEmailCodes: Record "DEL DocMatrix Email Codes";
                        lpgDocMatrixMailCodes: Page "DEL DocMatrix Mail Codes";
                    begin
                        lrecDocMatrixEmailCodes.RESET();
                        IF Rec."Mail Text Langauge Code" <> '' THEN
                            lrecDocMatrixEmailCodes.SETFILTER("Language Code", '%1|%2', Rec."Mail Text Langauge Code", '');
                        IF lrecDocMatrixEmailCodes.FINDSET() THEN;
                        lpgDocMatrixMailCodes.SETTABLEVIEW(lrecDocMatrixEmailCodes);
                        lpgDocMatrixMailCodes.LOOKUPMODE := TRUE;
                        IF lpgDocMatrixMailCodes.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                            lpgDocMatrixMailCodes.GETRECORD(lrecDocMatrixEmailCodes);
                            Rec."Mail Text Code" := lrecDocMatrixEmailCodes.Code;
                            Rec.MODIFY();
                        END;
                    end;
                }
                field("Mail Text Langauge Code"; Rec."Mail Text Langauge Code")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        boPostVisible: Boolean;


    procedure SetPostVisible(pboVisible: Boolean)
    begin
        boPostVisible := pboVisible;
    end;
}

