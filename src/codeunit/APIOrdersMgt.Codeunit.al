codeunit 50045 "API Orders  Mgt."
{
    // Mgts10.00.01.00 | 11.01.2020 | Order API Management
    // 
    // Mgts10.00.01.02 | 24.02.2020 | Order API Management : Add C\AL in : OnRun
    // 
    // Mgts10.00.03.01 | 21.04.2020 | Order API Management : Add C\AL in : SendAPIRequest


    trigger OnRun()
    var
        _Function: Text;
        JsonText: Text;
        APIURL: Text;
        APIKEY: Text;
        HttpStatusCode: DotNet HttpStatusCode;
        OrderAPIRecordTracking: Record "50074";
        OrderAPIRecordTracking2: Record "50074";
        JSONRequestslog: Record "50073";
        MgtsSetup: Record "50000";
        IsError: Boolean;
        JsonMgt: Codeunit "50041";
    begin
        //Init request parameters
        MgtsSetup.GET;
        MgtsSetup.TESTFIELD("API URL");
        MgtsSetup.TESTFIELD("API KEY");
        APIURL := MgtsSetup."API URL";
        APIKEY := MgtsSetup."API KEY";
        _Function := 'api/order';

        //Prepare Request Body : Json Data

        //>>Mgts10.00.01.02
        OrderAPIRecordTracking.SETCURRENTKEY("Sent Deal");
        OrderAPIRecordTracking.SETRANGE("Sent Deal", FALSE);
        //<<Mgts10.00.01.02

        IF NOT OrderAPIRecordTracking.ISEMPTY THEN BEGIN
            OrderAPIRecordTracking.FINDSET;
            REPEAT
                CLEAR(JsonMgt);
                CLEARLASTERROR;

                //Prepare Request Body
                JsonText := GetRequestBody(OrderAPIRecordTracking);

                //Log Request
                JSONRequestslog.InsertLogRecord(1, _Function, JsonText, FALSE);

                //Send API Request
                IsError := NOT SendAPIRequest(APIURL, APIKEY, JsonText, HttpStatusCode);

                IF IsError THEN BEGIN
                    JSONRequestslog.Error := TRUE;
                    JSONRequestslog.MODIFY;
                    JSONRequestslog.InsertLogRecord(2, _Function, JsonMgt.CreateErrorResponse(_Function, ''), TRUE); //Log Response ERROR
                END
                ELSE BEGIN
                    JSONRequestslog.InsertLogRecord(2, _Function, HttpStatusCodeToText(HttpStatusCode), (HttpStatusCode.ToString() <> 'OK')); //Log Response
                    IF (HttpStatusCode.ToString() = 'OK') THEN

                    //>>Mgts10.00.01.02
                    //OLD : OrderAPIRecordTracking.DELETE(TRUE);
                    BEGIN
                        OrderAPIRecordTracking2.GET(OrderAPIRecordTracking."Deal ID");
                        OrderAPIRecordTracking2."Sent Deal" := TRUE;
                        OrderAPIRecordTracking2.MODIFY
                    END;
                    COMMIT;
                    //<<Mgts10.00.01.02

                END;
            UNTIL OrderAPIRecordTracking.NEXT = 0;
        END;
    end;

    var
        HttpWebRequestMgt: Codeunit "1297";

    local procedure ReplaceString(OriginalString: Text; FindWhatString: Text; ReplaceWithString: Text) NewString: Text
    begin
        WHILE STRPOS(OriginalString, FindWhatString) > 0 DO
            OriginalString := DELSTR(OriginalString, STRPOS(OriginalString, FindWhatString)) + ReplaceWithString + COPYSTR(OriginalString, STRPOS(OriginalString, FindWhatString) + STRLEN(FindWhatString));
        NewString := OriginalString;
    end;

    local procedure GetRequestBody(OrderAPIRecordTracking: Record "50074") JsonText: Text
    var
        TempBlob: Record "99008535" temporary;
        AdvancedJSONMgt: Codeunit "50043";
        DealsAPIXml: XMLport "50015";
        XmlDocument: DotNet XmlDocument;
        OutStrm: OutStream;
        Instrm: InStream;
        xml: Text;
    begin
        OrderAPIRecordTracking.SETRANGE("Deal ID", OrderAPIRecordTracking."Deal ID");
        DealsAPIXml.SETTABLEVIEW(OrderAPIRecordTracking);
        TempBlob.Blob.CREATEOUTSTREAM(OutStrm);
        DealsAPIXml.SETDESTINATION(OutStrm);
        DealsAPIXml.EXPORT;
        TempBlob.Blob.CREATEINSTREAM(Instrm);
        XmlDocument := XmlDocument.XmlDocument;
        XmlDocument.Load(Instrm);
        xml := XmlDocument.InnerXml;
        xml := ReplaceString(xml, '<Json:orders>', '<Json:orders Json:Array="true">');
        xml := ReplaceString(xml, '<Json:lineDetails>', '<Json:lineDetails Json:Array="true">');
        JsonText := AdvancedJSONMgt.XMLTextToJSONText(xml);
        JsonText := DELCHR(AdvancedJSONMgt.XMLTextToJSONText(xml), '=', '$');
    end;

    [TryFunction]
    local procedure SendAPIRequest(APIURL: Text; APIKEY: Text; JsonBody: Text; var HttpStatusCode: DotNet HttpStatusCode)
    var
        ResponseInStream: InStream;
        ResponseHeaders: DotNet NameValueCollection;
    begin
        CLEAR(HttpStatusCode);
        HttpWebRequestMgt.Initialize(APIURL);
        HttpWebRequestMgt.SetMethod('POST');
        HttpWebRequestMgt.SetContentType('application/json');
        HttpWebRequestMgt.SetTraceLogEnabled(FALSE);
        HttpWebRequestMgt.SetTimeout(60000);
        HttpWebRequestMgt.AddBodyAsAsciiText(JsonBody);
        ;
        HttpWebRequestMgt.AddHeader('APIKEY', APIKEY);
        HttpWebRequestMgt.CreateInstream(ResponseInStream);
        //>>Mgts10.00.03.01
        IF NOT HttpWebRequestMgt.GetResponse(ResponseInStream, HttpStatusCode, ResponseHeaders) THEN
            HttpWebRequestMgt.ProcessFaultResponse('Parse Response Error API Order');
        //<<Mgts10.00.03.01
    end;

    local procedure HttpStatusCodeToText(HttpStatusCode: DotNet HttpStatusCode): Text
    begin
        EXIT(STRSUBSTNO('HttpStatusCode = %1', HttpStatusCode.ToString()));
    end;
}

