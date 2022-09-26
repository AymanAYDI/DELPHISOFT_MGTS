page 50137 "DocMatrix Selection Card"
{
    // DEL/PD/20190227/LOP003 : object created
    // DEL/PD/20190228/LOP003 : changed "Post - OnValidate": if user changes Post selection, update the fields to match the proper document
    // 20200915/DEL/PD/CR100  : new field "E-Mail from Sales Order"
    // 20201007/DEL/PD/CR100  : published to PROD

    PageType = Worksheet;
    SourceTable = Table50071;

    layout
    {
        area(content)
        {
            group(Posting)
            {
                Visible = boPostVisible;
                field(Post; Post)
                {

                    trigger OnValidate()
                    var
                        lcuDocMatrixMgt: Codeunit "50015";
                    begin
                        lcuDocMatrixMgt.UpdateDocMatrixSelection("No.", "Process Type", 1, Rec, Post = Post::" ");
                        CurrPage.UPDATE(TRUE);
                    end;
                }
            }
            group(Document)
            {
                field("Send to FTP 1"; "Send to FTP 1")
                {
                }
                field("Send to FTP 2"; "Send to FTP 2")
                {
                }
                field("E-Mail from Sales Order"; "E-Mail from Sales Order")
                {
                }
                field("E-Mail To 1"; "E-Mail To 1")
                {
                }
                field("E-Mail To 2"; "E-Mail To 2")
                {
                }
                field("E-Mail To 3"; "E-Mail To 3")
                {
                }
                field("E-Mail From"; "E-Mail From")
                {
                }
                field("Save PDF"; "Save PDF")
                {
                }
                field("Print PDF"; "Print PDF")
                {
                }
                field("Mail Text Code"; "Mail Text Code")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lrecDocMatrixEmailCodes: Record "50070";
                        lpgDocMatrixMailCodes: Page "50134";
                    begin
                        lrecDocMatrixEmailCodes.RESET;
                        IF "Mail Text Langauge Code" <> '' THEN
                            lrecDocMatrixEmailCodes.SETFILTER("Language Code", '%1|%2', "Mail Text Langauge Code", '');
                        IF lrecDocMatrixEmailCodes.FINDSET THEN;
                        lpgDocMatrixMailCodes.SETTABLEVIEW(lrecDocMatrixEmailCodes);
                        lpgDocMatrixMailCodes.LOOKUPMODE := TRUE;
                        IF lpgDocMatrixMailCodes.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            lpgDocMatrixMailCodes.GETRECORD(lrecDocMatrixEmailCodes);
                            "Mail Text Code" := lrecDocMatrixEmailCodes.Code;
                            MODIFY;
                        END;
                    end;
                }
                field("Mail Text Langauge Code"; "Mail Text Langauge Code")
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

    [Scope('Internal')]
    procedure SetPostVisible(pboVisible: Boolean)
    begin
        boPostVisible := pboVisible;
    end;
}

