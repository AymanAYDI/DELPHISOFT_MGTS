page 50136 "DocMatrix Request Page Par"
{
    // 20190227/DEL/PD/LOP003 - object created
    // 20190305/DEL/PD/LOP003 - object optimized and corrected

    Caption = 'Request Page Parameters';
    Editable = false;
    PageType = StandardDialog;
    SaveValues = true;
    SourceTable = Table50067;

    layout
    {
        area(content)
        {
            group()
            {
                group()
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
        txParameters := GetRequestPageParametersText(Rec);
    end;

    trigger OnOpenPage()
    var
        OrigMailBodyText: Text;
    begin
        txParameters := '';
    end;

    var
        txParameters: Text;
}

