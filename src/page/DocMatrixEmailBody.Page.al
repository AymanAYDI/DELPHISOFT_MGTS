page 50135 "DocMatrix Email Body"
{
    // 20190227/DEL/PD/LOP003 - object created (adapted form P9700 "Email Dialog")

    Caption = 'Email Text';
    PageType = StandardDialog;
    SaveValues = true;
    SourceTable = Table50070;

    layout
    {
        area(content)
        {
            field(Code; Code)
            {
                Editable = false;
            }
            field("Language Code"; "Language Code")
            {
                Editable = false;
            }
            field("All Language Codes"; "All Language Codes")
            {
                Editable = false;
            }
            group()
            {
                group()
                {
                    field(BodyText; BodyText)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Message';
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the body of the email.';

                        trigger OnValidate()
                        begin
                            DocMatrixEmailText.SetBodyText(BodyText);
                            PreviousBodyText := BodyText;
                        end;
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    var
        BLOBBodyText: Text;
    begin
        BLOBBodyText := DocMatrixEmailText.GetBodyText(Code, "Language Code");
        IF BLOBBodyText <> '' THEN
            BodyText := BLOBBodyText
        ELSE
            DocMatrixEmailText.SetBodyText(BodyText);
    end;

    trigger OnClosePage()
    begin
        Rec := DocMatrixEmailText;
    end;

    trigger OnOpenPage()
    var
        OrigMailBodyText: Text;
    begin
        BodyText := '';
    end;

    var
        DocMatrixEmailText: Record "50070";
        BodyText: Text;
        PreviousBodyText: Text;
}

