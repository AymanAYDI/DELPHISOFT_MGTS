page 50135 "DEL DocMatrix Email Body"
{
    Caption = 'Email Text';
    PageType = StandardDialog;
    SaveValues = true;
    SourceTable = "DEL DocMatrix Email Codes";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            field("Code"; Rec.Code)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Language Code"; Rec."Language Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("All Language Codes"; Rec."All Language Codes")
            {
                ApplicationArea = All;
                Editable = false;
            }
            group(group)
            {
                group(group1)
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
        BLOBBodyText := DocMatrixEmailText.GetBodyText(Rec.Code, Rec."Language Code");
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

    begin
        BodyText := '';
    end;

    var
        DocMatrixEmailText: Record "DEL DocMatrix Email Codes";
        BodyText: Text;
        PreviousBodyText: Text;
}
