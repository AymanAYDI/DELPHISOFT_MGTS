page 50141 "DEL Message"
{



    Caption = 'Message';
    Editable = false;
    PageType = CardPart;
    ShowFilter = false;
    SourceTable = "DEL JSON Requests log";

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



    //TODO dotnet is not used on cloud trigger OnAfterGetRecord()

    //TODO
    // trigger OnAfterGetRecord()

    // var
    //     IStream: InStream;
    //     StreamReader: DotNet StreamReader;
    // begin
    //     CALCFIELDS(Message);
    //     Message.CREATEINSTREAM(IStream);
    //     StreamReader := StreamReader.StreamReader(IStream, TRUE);
    //     JsonMessage := StreamReader.ReadToEnd();
    // end;

    var
        JsonMessage: Text;
}

