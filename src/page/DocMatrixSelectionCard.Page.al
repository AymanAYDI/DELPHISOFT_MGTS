page 50137 "DEL DocMatrix Selection Card"
{
    PageType = Worksheet;
    SourceTable = "DEL DocMatrix Selection";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            group(Posting)
            {
                Visible = boPostVisible;
                field(Post; Rec.Post)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        lcuDocMatrixMgt: Codeunit "DEL DocMatrix Management";
                    begin
                        lcuDocMatrixMgt.UpdateDocMatrixSelection(REC."No.", Rec."Process Type", 1, Rec, REC.Post = REC.Post::" ");
                        CurrPage.UPDATE(TRUE);
                    end;
                }
            }
            group(Document)
            {
                field("Send to FTP 1"; Rec."Send to FTP 1")
                {
                    ApplicationArea = All;
                }
                field("Send to FTP 2"; Rec."Send to FTP 2")
                {
                    ApplicationArea = All;
                }
                field("E-Mail from Sales Order"; Rec."E-Mail from Sales Order")
                {
                    ApplicationArea = All;
                }
                field("E-Mail To 1"; Rec."E-Mail To 1")
                {
                    ApplicationArea = All;
                }
                field("E-Mail To 2"; Rec."E-Mail To 2")
                {
                    ApplicationArea = All;
                }
                field("E-Mail To 3"; Rec."E-Mail To 3")
                {
                    ApplicationArea = All;
                }
                field("E-Mail From"; Rec."E-Mail From")
                {
                    ApplicationArea = All;
                }
                field("Save PDF"; Rec."Save PDF")
                {
                    ApplicationArea = All;
                }
                field("Print PDF"; Rec."Print PDF")
                {
                    ApplicationArea = All;
                }
                field("Mail Text Code"; Rec."Mail Text Code")
                {
                    ApplicationArea = All;

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
                    ApplicationArea = All;
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
