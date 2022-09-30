codeunit 50040 "JSON :  Web Service"
{
    // Mgts10.00.01.00 | 11.01.2020 | Create Web Service
    // 
    // Mgts10.00.03.00 | 07.04.2020 | Add Functions : CreateUpdateProduct,CallWSFunction2
    // 
    // Mgts10.00.04.00      07.12.2021 : Add Functions : GetSalesPrices
    //                                                   CreateItemSalesPrices
    //                                                   UpdateItemSalesPrices
    //                                                   DeleteItemSalesPrices
    //                                                   GetPurchasePrices
    //                                                   CreateItemPurchasePrices
    //                                                   UpdateItemPurchasePrices
    //                                                   DeleteItemPurchasePrices
    //                                                   GetItemCrossReferences
    //                                                   CreateItemCrossReferences
    //                                                   UpdateItemCrossReferences
    //                                                   DeleteItemCrossReferences


    trigger OnRun()
    var
        dur: Duration;
        DateTime11: DateTime;
        Data: Text;
    begin

        Data := '{';
        Data += '"ProductErpCode": "",';
        Data += '"Description": "JSON WS TEST",';
        Data += '"SearchName": "JSON TEST",';
        Data += '"ProductGroupCode": "2020F",';
        Data += '"SupplierErpCode": "AF000091",';
        Data += '"SupplierItemCode": "SupplierItemCode",';
        Data += '"EANCode": "1538035380538",';
        Data += '"NbUnitPerParcel": "2",';
        Data += '"CustomRate": "3.5",';
        Data += '"TARICCode": "87089998",';
        Data += '"ParcelVolume": "4"';
        Data += '}';

        MESSAGE(CreateUpdateProduct(Data));
    end;

    var
        NotImplementedMsg: Label 'Not implemented yet';

    local procedure "-Supplier-"()
    begin
    end;

    [Scope('Internal')]
    procedure CreateSupplier(Data: Text) Response: Text
    begin
        EXIT(CallWSFunction('CreateVendor', Data));
    end;

    [Scope('Internal')]
    procedure UpdateSupplier(Data: Text) Response: Text
    begin
        EXIT(CallWSFunction('UpdateVendor', Data));
    end;

    [Scope('Internal')]
    procedure GetSupplierInfo(ErpSupplierCode: Code[20]) Response: Text
    var
        JSONWSVendorMgt: Codeunit "50042";
        JSONRequestslog: Record "50073";
        JsonMgt: Codeunit "50041";
        _Function: Text;
    begin
        _Function := 'GetVendorInfo';
        JSONWSVendorMgt.SetErpVendor(_Function, ErpSupplierCode);
        IF NOT JSONWSVendorMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, ErpSupplierCode, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, '');
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, ErpSupplierCode, FALSE);
            Response := JSONWSVendorMgt.GetVendorResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    local procedure CallWSFunction(_Function: Text; Data: Text) Response: Text
    var
        JSONWSVendorMgt: Codeunit "50042";
        JsonMgt: Codeunit "50041";
        JsonAsObject: DotNet JObject;
        JSONRequestslog: Record "50073";
    begin
        IF NOT JsonMgt.TextToJsonObject(Data, JsonAsObject) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, '');
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        COMMIT;
        JSONWSVendorMgt.SetFunction(_Function, JsonAsObject);
        IF NOT JSONWSVendorMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonText(JsonAsObject), TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, '');
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonText(JsonAsObject), FALSE);
            Response := JSONWSVendorMgt.SuccesVendorCreationResponse(JSONWSVendorMgt.GetCreatedVendor);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    local procedure "-Item-"()
    begin
    end;

    [Scope('Internal')]
    procedure CreateUpdateProduct(Data: Text): Text
    begin
        EXIT(CallWSFunction2('CreateUpdateItem', Data));
    end;

    local procedure CallWSFunction2(_Function: Text; Data: Text) Response: Text
    var
        JSONWSItemMgt: Codeunit "50050";
        JsonMgt: Codeunit "50041";
        JsonAsObject: DotNet JObject;
        JSONRequestslog: Record "50073";
    begin
        IF NOT JsonMgt.TextToJsonObject(Data, JsonAsObject) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, '');
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        COMMIT;
        JSONWSItemMgt.SetFunction(_Function, JsonAsObject);
        IF NOT JSONWSItemMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonText(JsonAsObject), TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, '');
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonText(JsonAsObject), FALSE);
            Response := JSONWSItemMgt.SuccesItemCreationResponse(JSONWSItemMgt.GetCreatedItem);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    local procedure "-SalesPrice-"()
    begin
    end;

    [Scope('Internal')]
    procedure GetSalesPrices(Data: Text) Response: Text
    var
        JSONWSPriceMgt: Codeunit "50056";
        JsonMgt: Codeunit "50041";
        JSONRequestslog: Record "50073";
        JsonAsObject: DotNet JObject;
        _Function: Text;
    begin
        _Function := 'GetSalesPrices';
        IF NOT JsonMgt.TextToJsonObject(Data, JsonAsObject) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        JSONWSPriceMgt.SetFunctionJObject(_Function, JsonAsObject);
        IF NOT JSONWSPriceMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, FALSE);
            Response := JSONWSPriceMgt.GetSalesPricesResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    [Scope('Internal')]
    procedure CreateItemSalesPrices(Data: Text) Response: Text
    var
        JSONWSPriceMgt: Codeunit "50056";
        JsonMgt: Codeunit "50041";
        JsonAsArray: DotNet JArray;
        JSONRequestslog: Record "50073";
        _Function: Text;
    begin
        _Function := 'CreateItemSalesPrices';
        IF NOT JsonMgt.TextToJsonArrayObject(Data, JsonAsArray) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        COMMIT;
        JSONWSPriceMgt.SetFunctionJArray(_Function, JsonAsArray);
        IF NOT JSONWSPriceMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, '');
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), FALSE);
            Response := JSONWSPriceMgt.GetJsonResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    [Scope('Internal')]
    procedure UpdateItemSalesPrices(Data: Text) Response: Text
    var
        JSONWSPriceMgt: Codeunit "50056";
        JsonMgt: Codeunit "50041";
        JsonAsArray: DotNet JArray;
        JSONRequestslog: Record "50073";
        _Function: Text;
    begin
        _Function := 'UpdateItemSalesPrices';
        IF NOT JsonMgt.TextToJsonArrayObject(Data, JsonAsArray) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        COMMIT;
        JSONWSPriceMgt.SetFunctionJArray(_Function, JsonAsArray);
        IF NOT JSONWSPriceMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), FALSE);
            Response := JSONWSPriceMgt.GetJsonResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    [Scope('Internal')]
    procedure DeleteItemSalesPrices(Data: Text) Response: Text
    var
        JSONWSPriceMgt: Codeunit "50056";
        JsonMgt: Codeunit "50041";
        JSONRequestslog: Record "50073";
        JsonAsArray: DotNet JArray;
        _Function: Text;
    begin
        _Function := 'DeleteItemSalesPrices';
        IF NOT JsonMgt.TextToJsonArrayObject(Data, JsonAsArray) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, '');
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        COMMIT;
        JSONWSPriceMgt.SetFunctionJArray(_Function, JsonAsArray);
        IF NOT JSONWSPriceMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), FALSE);
            Response := JSONWSPriceMgt.GetJsonResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    local procedure "-PurchasePrice-"()
    begin
    end;

    [Scope('Internal')]
    procedure GetPurchasePrices(Data: Text) Response: Text
    var
        JSONWSPriceMgt: Codeunit "50056";
        JsonMgt: Codeunit "50041";
        JSONRequestslog: Record "50073";
        JsonAsObject: DotNet JObject;
        _Function: Text;
    begin
        _Function := 'GetPurchasePrices';
        IF NOT JsonMgt.TextToJsonObject(Data, JsonAsObject) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        JSONWSPriceMgt.SetFunctionJObject(_Function, JsonAsObject);
        IF NOT JSONWSPriceMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, FALSE);
            Response := JSONWSPriceMgt.GetPurchasePricesResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    [Scope('Internal')]
    procedure CreateItemPurchasePrices(Data: Text) Response: Text
    var
        JSONWSPriceMgt: Codeunit "50056";
        JsonMgt: Codeunit "50041";
        JsonAsArray: DotNet JArray;
        JSONRequestslog: Record "50073";
        _Function: Text;
    begin
        _Function := 'CreateItemPurchasePrices';
        IF NOT JsonMgt.TextToJsonArrayObject(Data, JsonAsArray) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;


        COMMIT;
        JSONWSPriceMgt.SetFunctionJArray(_Function, JsonAsArray);
        IF NOT JSONWSPriceMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, '');
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), FALSE);
            Response := JSONWSPriceMgt.GetJsonResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    [Scope('Internal')]
    procedure UpdateItemPurchasePrices(Data: Text) Response: Text
    var
        JSONWSPriceMgt: Codeunit "50056";
        JsonMgt: Codeunit "50041";
        JsonAsArray: DotNet JArray;
        JSONRequestslog: Record "50073";
        _Function: Text;
    begin
        _Function := 'UpdateItemPurchasePrices';
        IF NOT JsonMgt.TextToJsonArrayObject(Data, JsonAsArray) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        COMMIT;
        JSONWSPriceMgt.SetFunctionJArray(_Function, JsonAsArray);
        IF NOT JSONWSPriceMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, '');
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), FALSE);
            Response := JSONWSPriceMgt.GetJsonResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    [Scope('Internal')]
    procedure DeleteItemPurchasePrices(Data: Text) Response: Text
    var
        JSONWSPriceMgt: Codeunit "50056";
        JsonMgt: Codeunit "50041";
        JsonAsArray: DotNet JArray;
        JSONRequestslog: Record "50073";
        _Function: Text;
    begin
        _Function := 'DeleteItemPurchasePrices';
        IF NOT JsonMgt.TextToJsonArrayObject(Data, JsonAsArray) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        COMMIT;
        JSONWSPriceMgt.SetFunctionJArray(_Function, JsonAsArray);
        IF NOT JSONWSPriceMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), FALSE);
            Response := JSONWSPriceMgt.GetJsonResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    local procedure "-ItemCrossReference-"()
    begin
    end;

    [Scope('Internal')]
    procedure GetItemCrossReferences(Data: Text) Response: Text
    var
        JSONWSPriceMgt: Codeunit "50056";
        JsonMgt: Codeunit "50041";
        JSONRequestslog: Record "50073";
        JsonAsObject: DotNet JObject;
        _Function: Text;
    begin
        _Function := 'GetItemCrossReferences';
        IF NOT JsonMgt.TextToJsonObject(Data, JsonAsObject) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        JSONWSPriceMgt.SetFunctionJObject(_Function, JsonAsObject);
        IF NOT JSONWSPriceMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, FALSE);
            Response := JSONWSPriceMgt.GetItemCrossReferencesResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    [Scope('Internal')]
    procedure CreateItemCrossReferences(Data: Text) Response: Text
    var
        JSONWSPriceMgt: Codeunit "50056";
        JsonMgt: Codeunit "50041";
        JsonAsArray: DotNet JArray;
        JSONRequestslog: Record "50073";
        _Function: Text;
    begin
        _Function := 'CreateItemCrossReferences';
        IF NOT JsonMgt.TextToJsonArrayObject(Data, JsonAsArray) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        COMMIT;
        JSONWSPriceMgt.SetFunctionJArray(_Function, JsonAsArray);
        IF NOT JSONWSPriceMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, '');
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), FALSE);
            Response := JSONWSPriceMgt.GetJsonResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    [Scope('Internal')]
    procedure UpdateItemCrossReferences(Data: Text) Response: Text
    var
        JSONWSPriceMgt: Codeunit "50056";
        JsonMgt: Codeunit "50041";
        JsonAsArray: DotNet JArray;
        JSONRequestslog: Record "50073";
        _Function: Text;
    begin
        _Function := 'UpdateItemCrossReferences';
        IF NOT JsonMgt.TextToJsonArrayObject(Data, JsonAsArray) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        COMMIT;
        JSONWSPriceMgt.SetFunctionJArray(_Function, JsonAsArray);
        IF NOT JSONWSPriceMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), FALSE);
            Response := JSONWSPriceMgt.GetJsonResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;

    [Scope('Internal')]
    procedure DeleteItemCrossReferences(Data: Text) Response: Text
    var
        JSONWSPriceMgt: Codeunit "50056";
        JsonMgt: Codeunit "50041";
        JsonAsArray: DotNet JArray;
        JSONRequestslog: Record "50073";
        _Function: Text;
    begin
        _Function := 'DeleteItemCrossReferences';
        IF NOT JsonMgt.TextToJsonArrayObject(Data, JsonAsArray) THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, Data, TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
            EXIT(Response)
        END;

        COMMIT;
        JSONWSPriceMgt.SetFunctionJArray(_Function, JsonAsArray);
        IF NOT JSONWSPriceMgt.RUN THEN BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), TRUE);
            Response := JsonMgt.CreateErrorResponse(_Function, Data);
            JSONRequestslog.InsertLogRecord(2, _Function, Response, TRUE);
        END
        ELSE BEGIN
            JSONRequestslog.InsertLogRecord(1, _Function, JsonMgt.GetFormattedJsonArrayText(JsonAsArray), FALSE);
            Response := JSONWSPriceMgt.GetJsonResponse();
            JSONRequestslog.InsertLogRecord(2, _Function, Response, FALSE);
        END;
    end;
}

