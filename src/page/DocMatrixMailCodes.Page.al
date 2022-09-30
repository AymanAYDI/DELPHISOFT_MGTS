page 50134 "DEL DocMatrix Mail Codes"
{
    // 20190227/DEL/PD/LOP003 - object created
    // 20200916/DEL/PD/CR101  - new action button "Mail Place Holders"
    // 20201007/DEL/PD/CR100  : published to PROD

    Caption = 'Email Code';
    PageType = List;
    SourceTable = Table50070;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field("Language Code"; "Language Code")
                {
                }
                field("All Language Codes"; "All Language Codes")
                {
                }
                field(Subject; Subject)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Te&xt")
            {
                Caption = 'Te&xt';
                Image = Text;
                action("Mail Text")
                {
                    Caption = 'Mail Text';
                    Image = Text;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunPageMode = Edit;

                    trigger OnAction()
                    var
                        lpgDocMatrixEmailText: Page "50135";
                    begin
                        lpgDocMatrixEmailText.SETRECORD(Rec);
                        lpgDocMatrixEmailText.RUNMODAL;
                    end;
                }
                action("Mail Place Holders")
                {
                    Caption = 'Mail Place Holders';
                    Image = CodesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        MESSAGE('%1 = %2\%3 = %4\%5 = %6\%7 = %8',
                                '%1', '"Company Information".Name',
                                '%2', '"Sales Order"."Sell-to Customer No.',
                                '%3', '"Sales Order"."External Document No.',
                                '%4', '"Sales Order"."Your Reference'
                                );
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        OrigMailBodyText: Text;
    begin
    end;

    var
        DocMatrixEmailText: Record "50070";
        BodyText: Text;
        PreviousBodyText: Text;


    procedure ReadBLOB(pCode: Code[20]; pLanguage: Code[10])
    var
        DocMatrixEmailCodes: Record "50070";
        MyBigText: BigText;
        BLOBInStream: InStream;
        lpgDocMatrixEmailText: Page "50135";
    begin
        /*--- Code obsolete ---
        //To stream a BLOB into a BigText variable use the command READ.
        IF DocMatrixEmailCodes.GET(pCode, pLanguage) THEN BEGIN
        
          // get the text from the BLOB field
          DocMatrixEmailCodes.CALCFIELDS(Body);
          IF DocMatrixEmailCodes.Body.HASVALUE THEN BEGIN
            CLEAR(MyBigText);
            DocMatrixEmailCodes.Body.CREATEINSTREAM(BLOBInStream);
            MyBigText.READ(BLOBInStream);
            MyBigText.GETSUBTEXT(MyBigText, 1);
          END;
        
          // set the read text to the page global variable to show the value in the page
          lpgDocMatrixEmailText.SETRECORD(DocMatrixEmailCodes);
          lpgDocMatrixEmailText.SetBodyText(MyBigText);
          lpgDocMatrixEmailText.RUNMODAL;
        
        END;
        ---*/

    end;


    procedure WriteBLOB(pCode: Code[20]; pLanguage: Code[10])
    var
        MyBigText: BigText;
        BLOBOutStream: OutStream;
    begin
        /*--- Code obsolete ---
        //To stream a BigText variable into a BLOB use the command WRITE.
        MyBigText.ADDTEXT('Text to be stored in a BLOB field');
        Body.CREATEOUTSTREAM(BLOBOutStream);
        MyBigText.WRITE(BLOBOutStream);
        IF NOT INSERT THEN
          MODIFY;
        ---*/

    end;


    procedure SetBodyText(pbtxBigText: BigText)
    begin
        /*--- Code obsolete ---
        pbtxBigText.GETSUBTEXT(BodyText,1);
        ---*/

    end;
}

