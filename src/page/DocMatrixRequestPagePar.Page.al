page 50136 "DEL DocMatrix Request Page Par"
{

    Caption = 'Request Page Parameters';
    Editable = false;
    PageType = StandardDialog;
    SaveValues = true;
    SourceTable = "DEL Document Matrix";

    layout
    {
        area(content)
        {
            group(Control14)
            {
                group(Control13)
                {
                    field(BodyText; txParameters)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Message';
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the body of the email.';
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        txParameters := Rec.GetRequestPageParametersText(DocMatrixSet);
    end;

    trigger OnOpenPage()
    var
        OrigMailBodyText: Text;
    begin
        txParameters := '';
    end;

    var
        DocMatrixSet: Record "DEL DocMatrix Setup";
        txParameters: Text;

}

