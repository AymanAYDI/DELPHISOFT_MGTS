codeunit 50041 "DEL JSON Mgt"
{
    // Mgts10.00.01.00 | 11.01.2020 | JSON Management

    // TODO: Dotnet 
    trigger OnRun()
    begin
        // TEST();
    end;

    // [TryFunction]

    // procedure TextToJsonArrayObject(JsonAsText: Text; var JsonAsArray: DotNet JArray)
    // begin
    //     CLEARLASTERROR();
    //     CLEAR(JsonAsArray);
    //     JsonAsArray := JsonAsArray.Parse(JsonAsText);
    // end;

    // [TryFunction]

    // procedure TextToJsonObject(JsonAsText: Text; var JsonAsObject: DotNet JObject)
    // begin
    //     CLEARLASTERROR();
    //     CLEAR(JsonAsObject);
    //     JsonAsObject := JsonAsObject.Parse(JsonAsText);
    // end;

    // [TryFunction]

    // procedure JsonObjectToText(JsonAsObject: DotNet JObject; var JsonAsText: Text)
    // var
    //     JsonConverter: DotNet JsonConvert;
    //     JsonFormatting: DotNet Formatting;
    // begin
    //     CLEARLASTERROR();
    //     CLEAR(JsonAsText);
    //     IF ISNULL(JsonAsObject) THEN
    //         DataFormatError();
    //     JsonAsText := JsonConverter.SerializeObject(JsonAsObject, JsonFormatting.Indented);
    // end;


    // procedure GetFormattedJsonText(JsonAsObject: DotNet JObject) FormattedJsonAsText: Text
    // var
    //     JsonConverter: DotNet JsonConvert;
    //     JsonFormatting: DotNet Formatting;
    // begin
    //     CLEAR(FormattedJsonAsText);
    //     FormattedJsonAsText := JsonConverter.SerializeObject(JsonAsObject, JsonFormatting.Indented);
    // end;


    // procedure GetFormattedJsonArrayText(JsonAsArray: DotNet JArray) FormattedJsonAsText: Text
    // var
    //     JsonConverter: DotNet JsonConvert;
    //     JsonFormatting: DotNet Formatting;
    // begin
    //     CLEAR(FormattedJsonAsText);
    //     FormattedJsonAsText := JsonConverter.SerializeObject(JsonAsArray, JsonFormatting.Indented);
    // end;


    // procedure GetValueFromJsonObject(JsonAsObject: DotNet JObject; "Key": Text; Length: Integer) Value: Text
    // var
    //     JToken: DotNet JsonToken;
    // begin
    //     IF ISNULL(JsonAsObject) THEN
    //         DataFormatError();
    //     JToken := JsonAsObject.GetValue(Key);
    //     Value := JToken.ToString();
    //     IF (STRLEN(Value) > Length) THEN
    //         Value := COPYSTR(Value, 1, Length);
    // end;


    // procedure AddValueToJsonObject(var JsonAsObject: DotNet JObject; "Key": Text; Value: Text)
    // var
    //     JValue: DotNet JValue;
    // begin
    //     IF ISNULL(JsonAsObject) THEN
    //         DataFormatError();
    //     JValue := JValue.JValue(Value);
    //     JsonAsObject.Add(Key, JValue);
    // end;


    // procedure DataFormatError()
    // var
    //     MsgDataFormatError: Label 'Data Format Error';
    // begin
    //     ERROR(MsgDataFormatError);
    // end;


    // procedure CreateErrorResponse("Function": Text; Data: Text) JsonError: Text
    // var
    //     JsonAsObject: DotNet JObject;
    // begin
    //     JsonAsObject := JsonAsObject.JObject();
    //     AddValueToJsonObject(JsonAsObject, 'StatusCode', '-1');
    //     AddValueToJsonObject(JsonAsObject, 'Status', 'Error');
    //     AddValueToJsonObject(JsonAsObject, 'NavFunction', "Function");
    //     AddValueToJsonObject(JsonAsObject, 'Data', Data);
    //     AddValueToJsonObject(JsonAsObject, 'ErrorCode', GETLASTERRORCODE);
    //     AddValueToJsonObject(JsonAsObject, 'ErrorText', GETLASTERRORTEXT);
    //     AddValueToJsonObject(JsonAsObject, 'ErrorCallStack', GETLASTERRORCALLSTACK);
    //     JsonObjectToText(JsonAsObject, JsonError);
    // end;

    // local procedure TEST()
    // var
    //     xml: Text;
    //     JsonText: Text;
    //     xml2: Label '<person><name>Alan</name><url>wwwgooglecom</url><role>Admin1</role></person>';
    //     AdvancedJSONMgt: Codeunit "50043";
    //     DealsAPIXml: XMLport "50015";
    //     XmlDocument: DotNet XmlDocument;
    //     OutStrm: OutStream;
    //     TempBlob: Record "99008535";
    //     Instrm: InStream;
    // begin
    //     TempBlob.Blob.CREATEOUTSTREAM(OutStrm);
    //     DealsAPIXml.SETDESTINATION(OutStrm);
    //     DealsAPIXml.EXPORT;
    //     TempBlob.Blob.CREATEINSTREAM(Instrm);
    //     XmlDocument := XmlDocument.XmlDocument;
    //     XmlDocument.Load(Instrm);
    //     //XMLDOMMgt.LoadXMLDocumentFromOutStream(Instrm,XmlDocument);
    //     xml := XmlDocument.InnerXml;
    //     JsonText := AdvancedJSONMgt.XMLTextToJSONText(xml);
    //     MESSAGE(JsonText);
    //     MESSAGE(xml);
    // end;

}

