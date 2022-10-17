report 50054 "DEL Search Criteria"
{
    Caption = 'Search Criteria';
    ProcessingOnly = true;

    dataset
    {
        dataitem("DEL JSON Requests log"; "DEL JSON Requests log")
        {
            DataItemTableView = SORTING (Date);
            RequestFilterFields = Date, Type, "Function", Error;

            trigger OnAfterGetRecord()
            var
                IStream: InStream;
                // StreamReader: DotNet StreamReader; // TODO: The application object or method 'System.IO.StreamReader' has scope 'OnPrem' and cannot be used for 'Cloud' development
                JsonMessage: Text;
            begin
                Counter := Counter + 1;
                Window.UPDATE(1, FORMAT(Date));
                Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                CALCFIELDS(Message);
                Message.CREATEINSTREAM(IStream);
                // StreamReader := StreamReader.StreamReader(IStream, TRUE);
                // JsonMessage := StreamReader.ReadToEnd(); // TODO: relate to DotNet StreamReader;
                IF STRPOS(UPPERCASE(JsonMessage), UPPERCASE(TextToFilter)) <> 0 THEN BEGIN
                    Filtered := TRUE;
                    MODIFY();
                    CounterFiltered := CounterFiltered + 1;
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE();
                //DIALOG.MESSAGE(Text003,CounterFiltered, CounterTotal);
            end;

            trigger OnPreDataItem()
            var
                JSONRequestslog: Record 50073;
            begin
                IF GETFILTER(Date) = '' THEN
                    DIALOG.ERROR(Text001, FIELDCAPTION(Date));

                IF TextToFilter = '' THEN
                    DIALOG.ERROR(Text001, Text004);

                CounterTotal := COUNT;
                Counter := 0;
                CounterFiltered := 0;

                JSONRequestslog.SETCURRENTKEY(Filtered);
                JSONRequestslog.SETRANGE(Filtered, TRUE);
                JSONRequestslog.MODIFYALL(Filtered, FALSE);

                Window.OPEN(Text002);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(TextToFilter; TextToFilter)
                    {
                        Caption = 'Search';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CounterTotal: Integer;
        Counter: Integer;
        CounterFiltered: Integer;
        Window: Dialog;
        Text001: Label 'You must define a filter on the %1 field.';
        Text002: Label 'Filter Messages   #1########## @2@@@@@@@@@@@@@';
        Text003: Label '%1 messages filtered / %2 Total Messages .';
        TextToFilter: Text;
        Text004: Label 'Search';

   
    procedure GetResult(var _TextToFilter: Text)
    begin
        _TextToFilter := STRSUBSTNO('%1, %2', TextToFilter, "DEL JSON Requests log".GETFILTERS);
    end;
}

