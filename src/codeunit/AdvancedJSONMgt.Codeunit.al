codeunit 50043 "Advanced JSON Mgt"
{
    // Mgts10.00.01.00 | 11.01.2020 | JSON Management


    trigger OnRun()
    begin
    end;

    var
        JsonArray: DotNet JArray;
        JsonObject: DotNet JObject;

    procedure InitializeCollection(JSONString: Text)
    begin
        InitializeCollectionFromString(JSONString);
    end;

    procedure InitializeEmptyCollection()
    begin
        JsonArray := JsonArray.JArray;
    end;

    procedure InitializeObject(JSONString: Text)
    begin
        InitializeObjectFromString(JSONString);
    end;

    [Scope('Internal')]
    procedure InitializeObjectFromJObject(NewJsonObject: DotNet JObject)
    begin
        JsonObject := NewJsonObject;
    end;

    [Scope('Internal')]
    procedure InitializeCollectionFromJArray(NewJsonArray: DotNet JArray)
    begin
        JsonArray := NewJsonArray;
    end;

    procedure InitializeEmptyObject()
    begin
        JsonObject := JsonObject.JObject;
    end;

    local procedure InitializeCollectionFromString(JSONString: Text)
    begin
        CLEAR(JsonArray);
        IF JSONString <> '' THEN
            JsonArray := JsonArray.Parse(JSONString)
        ELSE
            InitializeEmptyCollection;
    end;

    local procedure InitializeObjectFromString(JSONString: Text)
    begin
        CLEAR(JsonObject);
        IF JSONString <> '' THEN
            JsonObject := JsonObject.Parse(JSONString)
        ELSE
            InitializeEmptyObject;
    end;

    [Scope('Internal')]
    procedure GetJSONObject(var JObject: DotNet JObject)
    begin
        JObject := JsonObject;
    end;

    [Scope('Internal')]
    procedure GetJsonArray(var JArray: DotNet JArray)
    begin
        JArray := JsonArray;
    end;

    [Scope('Internal')]
    procedure GetJObjectFromCollectionByIndex(var JObject: DotNet JObject; Index: Integer): Boolean
    begin
        IF (GetCollectionCount = 0) OR (GetCollectionCount <= Index) THEN
            EXIT(FALSE);

        JObject := JsonArray.Item(Index);
        EXIT(NOT ISNULL(JObject))
    end;

    [Scope('Internal')]
    procedure GetJObjectFromCollectionByPropertyValue(var JObject: DotNet JObject; propertyName: Text; value: Text): Boolean
    var
        IEnumerable: DotNet IEnumerable_Of_T;
        IEnumerator: DotNet IEnumerator_Of_T;
    begin
        CLEAR(JObject);
        IEnumerable := JsonArray.SelectTokens(STRSUBSTNO('$[?(@.%1 == ''%2'')]', propertyName, value), FALSE);
        IEnumerator := IEnumerable.GetEnumerator;

        IF IEnumerator.MoveNext THEN BEGIN
            JObject := IEnumerator.Current;
            EXIT(TRUE);
        END;
    end;

    [Scope('Internal')]
    procedure GetPropertyValueFromJObjectByName(JObject: DotNet JObject; propertyName: Text; var value: Variant): Boolean
    var
        JProperty: DotNet JProperty;
        JToken: DotNet JToken;
    begin
        CLEAR(value);
        IF JObject.TryGetValue(propertyName, JToken) THEN BEGIN
            JProperty := JObject.Property(propertyName);
            value := JProperty.Value;
            EXIT(TRUE);
        END;
    end;

    [Scope('Internal')]
    procedure GetPropertyValueFromJObjectByPathSetToFieldRef(JObject: DotNet JObject; propertyPath: Text; var FieldRef: FieldRef): Boolean
    var
        OutlookSynchTypeConv: Codeunit "5302";
        JProperty: DotNet JProperty;
        Value: Variant;
        DecimalVal: Decimal;
        BoolVal: Boolean;
        GuidVal: Guid;
        DateVal: Date;
        Success: Boolean;
        IntVar: Integer;
    begin
        Success := FALSE;
        JProperty := JObject.SelectToken(propertyPath);

        IF ISNULL(JProperty) THEN
            EXIT(FALSE);

        Value := FORMAT(JProperty.Value);

        CASE FORMAT(FieldRef.TYPE) OF
            'Integer',
            'Decimal':
                BEGIN
                    Success := EVALUATE(DecimalVal, Value, 9);
                    FieldRef.VALUE(DecimalVal);
                END;
            'Date':
                BEGIN
                    Success := EVALUATE(DateVal, Value, 9);
                    FieldRef.VALUE(DateVal);
                END;
            'Boolean':
                BEGIN
                    Success := EVALUATE(BoolVal, Value, 9);
                    FieldRef.VALUE(BoolVal);
                END;
            'GUID':
                BEGIN
                    Success := EVALUATE(GuidVal, Value);
                    FieldRef.VALUE(GuidVal);
                END;
            'Text',
            'Code':
                BEGIN
                    FieldRef.VALUE(COPYSTR(Value, 1, FieldRef.LENGTH));
                    Success := TRUE;
                END;
            'Option':
                BEGIN
                    IF NOT EVALUATE(IntVar, Value) THEN
                        IntVar := OutlookSynchTypeConv.TextToOptionValue(Value, FieldRef.OPTIONCAPTION);
                    IF IntVar >= 0 THEN BEGIN
                        FieldRef.VALUE := IntVar;
                        Success := TRUE;
                    END;
                END;
        END;

        EXIT(Success);
    end;

    [Scope('Internal')]
    procedure GetPropertyValueFromJObjectByPath(JObject: DotNet JObject; fullyQualifiedPropertyName: Text; var value: Variant): Boolean
    var
        containerJObject: DotNet JObject;
        propertyName: Text;
    begin
        CLEAR(value);
        DecomposeQualifiedPathToContainerObjectAndPropertyName(JObject, fullyQualifiedPropertyName, containerJObject, propertyName);
        IF ISNULL(containerJObject) THEN
            EXIT(FALSE);

        EXIT(GetPropertyValueFromJObjectByName(containerJObject, propertyName, value));
    end;

    [Scope('Internal')]
    procedure GetStringPropertyValueFromJObjectByName(JObject: DotNet JObject; propertyName: Text; var value: Text): Boolean
    var
        VariantValue: Variant;
    begin
        CLEAR(value);
        IF GetPropertyValueFromJObjectByName(JObject, propertyName, VariantValue) THEN BEGIN
            value := FORMAT(VariantValue);
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    [Scope('Internal')]
    procedure GetStringPropertyValueFromJObjectByPath(JObject: DotNet JObject; fullyQualifiedPropertyName: Text; var value: Text): Boolean
    var
        VariantValue: Variant;
    begin
        CLEAR(value);
        IF GetPropertyValueFromJObjectByPath(JObject, fullyQualifiedPropertyName, VariantValue) THEN BEGIN
            value := FORMAT(VariantValue);
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    [Scope('Internal')]
    procedure GetEnumPropertyValueFromJObjectByName(JObject: DotNet JObject; propertyName: Text; var value: Option)
    var
        StringValue: Text;
    begin
        GetStringPropertyValueFromJObjectByName(JObject, propertyName, StringValue);
        EVALUATE(value, StringValue, 0);
    end;

    [Scope('Internal')]
    procedure GetBoolPropertyValueFromJObjectByName(JObject: DotNet JObject; propertyName: Text; var value: Boolean): Boolean
    var
        StringValue: Text;
    begin
        IF GetStringPropertyValueFromJObjectByName(JObject, propertyName, StringValue) THEN BEGIN
            EVALUATE(value, StringValue, 2);
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    [Scope('Internal')]
    procedure GetArrayPropertyValueFromJObjectByName(JObject: DotNet JObject; propertyName: Text; var JArray: DotNet JArray): Boolean
    var
        JProperty: DotNet JProperty;
        JToken: DotNet JToken;
    begin
        CLEAR(JArray);
        IF JObject.TryGetValue(propertyName, JToken) THEN BEGIN
            JProperty := JObject.Property(propertyName);
            JArray := JProperty.Value;
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    [Scope('Internal')]
    procedure GetObjectPropertyValueFromJObjectByName(JObject: DotNet JObject; propertyName: Text; var JSubObject: DotNet JObject): Boolean
    var
        JProperty: DotNet JProperty;
        JToken: DotNet JToken;
    begin
        CLEAR(JSubObject);
        IF JObject.TryGetValue(propertyName, JToken) THEN BEGIN
            JProperty := JObject.Property(propertyName);
            JSubObject := JProperty.Value;
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    [Scope('Internal')]
    procedure GetDecimalPropertyValueFromJObjectByName(JObject: DotNet JObject; propertyName: Text; var value: Decimal): Boolean
    var
        StringValue: Text;
    begin
        IF GetStringPropertyValueFromJObjectByName(JObject, propertyName, StringValue) THEN BEGIN
            EVALUATE(value, StringValue);
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    [Scope('Internal')]
    procedure GetGuidPropertyValueFromJObjectByName(JObject: DotNet JObject; propertyName: Text; var value: Guid): Boolean
    var
        StringValue: Text;
    begin
        IF GetStringPropertyValueFromJObjectByName(JObject, propertyName, StringValue) THEN BEGIN
            EVALUATE(value, StringValue);
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    local procedure GetValueFromJObject(JObject: DotNet JObject; var value: Variant)
    var
        JValue: DotNet JValue;
    begin
        CLEAR(value);
        JValue := JObject;
        value := JValue.Value;
    end;

    [Scope('Internal')]
    procedure GetStringValueFromJObject(JObject: DotNet JObject; var value: Text)
    var
        VariantValue: Variant;
    begin
        CLEAR(value);
        GetValueFromJObject(JObject, VariantValue);
        value := FORMAT(VariantValue);
    end;

    [Scope('Internal')]
    procedure AddJArrayToJObject(var JObject: DotNet JObject; propertyName: Text; value: Variant)
    var
        JArray2: DotNet JArray;
        JProperty: DotNet JProperty;
    begin
        JArray2 := value;
        JObject.Add(JProperty.JProperty(propertyName, JArray2));
    end;

    [Scope('Internal')]
    procedure AddJObjectToJObject(var JObject: DotNet JObject; propertyName: Text; value: Variant)
    var
        JObject2: DotNet JObject;
        JToken: DotNet JToken;
        ValueText: Text;
    begin
        JObject2 := value;
        ValueText := FORMAT(value);
        JObject.Add(propertyName, JToken.Parse(ValueText));
    end;

    [Scope('Internal')]
    procedure AddJObjectToJArray(var JArray: DotNet JArray; value: Variant)
    var
        JObject: DotNet JObject;
    begin
        JObject := value;
        JArray.Add(JObject.DeepClone);
    end;

    [Scope('Internal')]
    procedure AddJPropertyToJObject(var JObject: DotNet JObject; propertyName: Text; value: Variant)
    var
        JProperty: DotNet JProperty;
        ValueText: Text;
    begin
        IF value.ISINTEGER THEN
            JProperty := JProperty.JProperty(propertyName, value)
        ELSE BEGIN
            ValueText := FORMAT(value, 0, 9);
            JProperty := JProperty.JProperty(propertyName, ValueText);
        END;

        JObject.Add(JProperty);
    end;

    [Scope('Internal')]
    procedure AddNullJPropertyToJObject(var JObject: DotNet JObject; propertyName: Text)
    var
        JValue: DotNet JValue;
    begin
        JObject.Add(propertyName, JValue.CreateNull);
    end;

    [Scope('Internal')]
    procedure AddJValueToJObject(var JObject: DotNet JObject; value: Variant)
    var
        JValue: DotNet JValue;
    begin
        JObject := JValue.JValue(value);
    end;

    [Scope('Internal')]
    procedure AddJObjectToCollection(JObject: DotNet JObject)
    begin
        JsonArray.Add(JObject.DeepClone);
    end;

    [Scope('Internal')]
    procedure AddJArrayContentToCollection(JArray: DotNet JArray)
    begin
        JsonArray.Merge(JArray.DeepClone);
    end;

    [Scope('Internal')]
    procedure ReplaceOrAddJPropertyInJObject(var JObject: DotNet JObject; propertyName: Text; value: Variant): Boolean
    var
        JProperty: DotNet JProperty;
        OldProperty: DotNet JProperty;
        oldValue: Variant;
    begin
        JProperty := JObject.Property(propertyName);
        IF NOT ISNULL(JProperty) THEN BEGIN
            OldProperty := JObject.Property(propertyName);
            oldValue := OldProperty.Value;
            JProperty.Replace(JProperty.JProperty(propertyName, value));
            EXIT(FORMAT(oldValue) <> FORMAT(value));
        END;

        AddJPropertyToJObject(JObject, propertyName, value);
        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure ReplaceOrAddDescendantJPropertyInJObject(var JObject: DotNet JObject; fullyQualifiedPropertyName: Text; value: Variant): Boolean
    var
        containerJObject: DotNet JObject;
        propertyName: Text;
    begin
        DecomposeQualifiedPathToContainerObjectAndPropertyName(JObject, fullyQualifiedPropertyName, containerJObject, propertyName);
        EXIT(ReplaceOrAddJPropertyInJObject(containerJObject, propertyName, value));
    end;

    procedure GetCollectionCount(): Integer
    begin
        EXIT(JsonArray.Count);
    end;

    procedure WriteCollectionToString(): Text
    begin
        EXIT(JsonArray.ToString);
    end;

    procedure WriteObjectToString(): Text
    begin
        EXIT(JsonObject.ToString);
    end;

    local procedure GetLastIndexOfPeriod(String: Text) LastIndex: Integer
    var
        Index: Integer;
    begin
        Index := STRPOS(String, '.');
        LastIndex := Index;
        WHILE Index > 0 DO BEGIN
            String := COPYSTR(String, Index + 1);
            Index := STRPOS(String, '.');
            LastIndex += Index;
        END;
    end;

    local procedure GetSubstringToLastPeriod(String: Text): Text
    var
        Index: Integer;
    begin
        Index := GetLastIndexOfPeriod(String);
        IF Index > 0 THEN
            EXIT(COPYSTR(String, 1, Index - 1));
    end;

    local procedure DecomposeQualifiedPathToContainerObjectAndPropertyName(var JObject: DotNet JObject; fullyQualifiedPropertyName: Text; var containerJObject: DotNet JObject; var propertyName: Text)
    var
        containerJToken: DotNet JToken;
        containingPath: Text;
    begin
        CLEAR(containerJObject);
        propertyName := '';

        containingPath := GetSubstringToLastPeriod(fullyQualifiedPropertyName);
        containerJToken := JObject.SelectToken(containingPath);
        IF ISNULL(containerJToken) THEN
            EXIT;

        containerJObject := containerJToken;
        IF containingPath <> '' THEN
            propertyName := COPYSTR(fullyQualifiedPropertyName, STRLEN(containingPath) + 2)
        ELSE
            propertyName := fullyQualifiedPropertyName;
    end;

    procedure XMLTextToJSONText(Xml: Text) Json: Text
    var
        XMLDOMMgt: Codeunit "6224";
        JsonConvert: DotNet JsonConvert;
        JsonFormatting: DotNet Formatting;
        XmlDocument: DotNet XmlDocument;
    begin
        XMLDOMMgt.LoadXMLDocumentFromText(Xml, XmlDocument);
        Json := JsonConvert.SerializeXmlNode(XmlDocument.DocumentElement, JsonFormatting.Indented, TRUE);
    end;

    procedure JSONTextToXMLText(Json: Text; DocumentElementName: Text) Xml: Text
    var
        JsonConvert: DotNet JsonConvert;
        XmlDocument: DotNet XmlDocument;
    begin
        XmlDocument := JsonConvert.DeserializeXmlNode(Json, DocumentElementName);
        Xml := XmlDocument.OuterXml;
    end;

    [TryFunction]
    procedure TryParseJObjectFromString(var JObject: DotNet JObject; StringToParse: Variant)
    begin
        JObject := JObject.Parse(FORMAT(StringToParse));
    end;

    trigger JsonArray::ListChanged(sender: Variant; e: DotNet ListChangedEventArgs)
    begin
    end;

    trigger JsonArray::AddingNew(sender: Variant; e: DotNet AddingNewEventArgs)
    begin
    end;

    trigger JsonArray::CollectionChanged(sender: Variant; e: DotNet NotifyCollectionChangedEventArgs)
    begin
    end;

    trigger JsonObject::PropertyChanged(sender: Variant; e: DotNet PropertyChangedEventArgs)
    begin
    end;

    trigger JsonObject::PropertyChanging(sender: Variant; e: DotNet PropertyChangingEventArgs)
    begin
    end;

    trigger JsonObject::ListChanged(sender: Variant; e: DotNet ListChangedEventArgs)
    begin
    end;

    trigger JsonObject::AddingNew(sender: Variant; e: DotNet AddingNewEventArgs)
    begin
    end;

    trigger JsonObject::CollectionChanged(sender: Variant; e: DotNet NotifyCollectionChangedEventArgs)
    begin
    end;
}

