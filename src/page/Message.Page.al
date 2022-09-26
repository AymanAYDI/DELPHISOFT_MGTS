page 50141 Message
{
    // Mgts10.00.01.00 | 11.01.2020 | JSON Requests logs

    Caption = 'Message';
    Editable = false;
    PageType = CardPart;
    ShowFilter = false;
    SourceTable = Table50073;

    layout
    {
        area(content)
        {
            field(JsonMessage; JsonMessage)
            {
                MultiLine = true;
                ShowCaption = false;
                Style = StandardAccent;
                StyleExpr = TRUE;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        IStream: InStream;
        StreamReader: DotNet StreamReader;
    begin
        CALCFIELDS(Message);
        Message.CREATEINSTREAM(IStream);
        StreamReader := StreamReader.StreamReader(IStream, TRUE);
        JsonMessage := StreamReader.ReadToEnd();
    end;

    var
        JsonMessage: Text;
}

