codeunit 50042 "JSON WS : Vendor Mgt"
{
    // Mgts10.00.01.00 | 11.01.2020 | JSON Business Logic Mgt : Vendor


    trigger OnRun()
    begin
        CASE "Function" OF
            'CreateVendor':
                ErpVendor := CreateVendor(JsonAsObject);
            'UpdateVendor':
                ErpVendor := UpdateVendor(JsonAsObject);
            'GetVendorInfo':
                VendorResponse := GetVendorInfo(ErpVendor);
        END;
    end;

    var
        "Function": Text;
        JsonAsObject: DotNet JObject;
        ErpVendor: Code[20];
        VendorResponse: Text;

    [Scope('Internal')]
    procedure SetFunction(CurrentFunction: Text; CurrentJsonAsObject: DotNet JObject)
    begin
        "Function" := CurrentFunction;
        JsonAsObject := CurrentJsonAsObject
    end;

    [Scope('Internal')]
    procedure SetErpVendor(CurrentFunction: Text; ErpVendorCode: Code[20])
    begin
        ErpVendor := ErpVendorCode;
        "Function" := CurrentFunction;
    end;

    [Scope('Internal')]
    procedure GetCreatedVendor(): Code[20]
    begin
        EXIT(ErpVendor);
    end;

    [Scope('Internal')]
    procedure CreateVendor(JsonAsObject: DotNet JObject) ErpVendorCode: Code[20]
    var
        Vendor: Record "23";
        JsonMgt: Codeunit "50041";
    begin
        WITH Vendor DO BEGIN
            CheckVendorExist(JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SupplierBaseID', 50));
            INIT;
            INSERT(TRUE);
            ApplyVendorTemplate(Vendor);
            "Supplier Base ID" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SupplierBaseID', 50);
            Name := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Name', 50);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SearchName', 50) <> '') THEN
                "Search Name" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SearchName', 50);
            "Purchaser Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PurchaserCode', 10);
            Address := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Address', 50);
            "Address 2" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Address2', 50);
            "Post Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PostCode', 20);
            City := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'City', 30);
            "Country/Region Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Country', 10);
            "Currency Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'CurrencyCode', 10);
            "Payment Terms Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PaymentTermsCode', 10);
            "Payment Method Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PaymentMethodCode', 10);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'LeadTimeCalculation', 10) <> '') THEN
                EVALUATE("Lead Time Calculation", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'LeadTimeCalculation', 10));
            IF (UPPERCASE(JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Qualified', 5)) = 'TRUE') THEN
                "Qualified vendor" := TRUE
            ELSE
                "Qualified vendor" := FALSE;
            IF (UPPERCASE(JsonMgt.GetValueFromJsonObject(JsonAsObject, 'QualificationDate', 10)) <> '') THEN
                EVALUATE("Date updated", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'QualificationDate', 10));
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Derogation', 5) = 'TRUE') THEN
                Derogation := TRUE
            ELSE
                Derogation := FALSE;
            MODIFY(TRUE);
            ErpVendorCode := "No.";
        END;
    end;

    [Scope('Internal')]
    procedure UpdateVendor(JsonAsObject: DotNet JObject) ErpVendorCode: Code[20]
    var
        Vendor: Record "23";
        JsonMgt: Codeunit "50041";
    begin
        WITH Vendor DO BEGIN
            GET(JsonMgt.GetValueFromJsonObject(JsonAsObject, 'ErpSupplierCode', 20));
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Name', 50) <> '') THEN
                Name := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Name', 50);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SearchName', 50) <> '') THEN
                "Search Name" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SearchName', 50);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PurchaserCode', 10) <> '') THEN
                "Purchaser Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PurchaserCode', 10);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Address', 50) <> '') THEN
                Address := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Address', 50);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Address2', 50) <> '') THEN
                "Address 2" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Address2', 50);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PostCode', 20) <> '') THEN
                "Post Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PostCode', 20);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'City', 30) <> '') THEN
                City := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'City', 30);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Country', 10) <> '') THEN
                "Country/Region Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Country', 10);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'CurrencyCode', 10) <> '') THEN
                "Currency Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'CurrencyCode', 10);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PaymentTermsCode', 10) <> '') THEN
                "Payment Terms Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PaymentTermsCode', 10);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PaymentMethodCode', 10) <> '') THEN
                "Payment Method Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PaymentMethodCode', 10);
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'LeadTimeCalculation', 10) <> '') THEN
                EVALUATE("Lead Time Calculation", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'LeadTimeCalculation', 10));
            IF (UPPERCASE(JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Qualified', 5)) = 'TRUE') THEN
                "Qualified vendor" := TRUE
            ELSE
                "Qualified vendor" := FALSE;
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'QualificationDate', 10) <> '') THEN
                EVALUATE("Date updated", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'QualificationDate', 10));
            IF (UPPERCASE(JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Derogation', 5)) = 'TRUE') THEN
                Derogation := TRUE
            ELSE
                Derogation := FALSE;
            MODIFY(TRUE);
            ErpVendorCode := "No.";
        END;
    end;

    [Scope('Internal')]
    procedure GetVendorResponse(): Text
    begin
        EXIT(VendorResponse);
    end;

    [Scope('Internal')]
    procedure SuccesVendorCreationResponse(ErpVendorCode: Code[20]) JsonResponse: Text
    var
        JsonAsObject: DotNet JObject;
        JsonMgt: Codeunit "50041";
    begin
        JsonAsObject := JsonAsObject.JObject();
        JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusCode', '1');
        JsonMgt.AddValueToJsonObject(JsonAsObject, 'Status', 'Succes');
        JsonMgt.AddValueToJsonObject(JsonAsObject, 'ErpSupplierCode', ErpVendorCode);
        JsonMgt.JsonObjectToText(JsonAsObject, JsonResponse);
    end;

    [Scope('Internal')]
    procedure ApplyVendorTemplate(var Vendor: Record "23")
    var
        DimensionsTemplate: Record "1302";
        MgtsSetup: Record "50000";
        ConfigTemplateHeader: Record "8618";
        ConfigTemplateManagement: Codeunit "8612";
        VendorRecRef: RecordRef;
    begin
        IF NOT MgtsSetup.GET THEN
            EXIT;

        IF NOT ConfigTemplateHeader.GET(MgtsSetup."Vendor Template") THEN
            EXIT;

        VendorRecRef.GETTABLE(Vendor);
        ConfigTemplateManagement.UpdateRecord(ConfigTemplateHeader, VendorRecRef);
        DimensionsTemplate.InsertDimensionsFromTemplates(ConfigTemplateHeader, Vendor."No.", DATABASE::Vendor);
        VendorRecRef.SETTABLE(Vendor);
    end;

    local procedure CheckVendorExist(SupplierBaseID: Text[30])
    var
        Vendor: Record "23";
        MstVendorrExist: Label 'Supplier %1  already exist !';
    begin
        Vendor.SETCURRENTKEY("Supplier Base ID");
        Vendor.SETRANGE("Supplier Base ID", SupplierBaseID);
        IF NOT Vendor.ISEMPTY THEN
            ERROR(MstVendorrExist, SupplierBaseID);
    end;

    [Scope('Internal')]
    procedure GetVendorInfo(ErpVendorCode: Code[20]) JsonResponse: Text
    var
        Vendor: Record "23";
        JsonMgt: Codeunit "50041";
        ResponseJsonAsObject: DotNet JObject;
    begin
        WITH Vendor DO BEGIN
            GET(ErpVendorCode);
            ResponseJsonAsObject := ResponseJsonAsObject.JObject();
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'ErpSupplierCode', "No.");
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'SupplierBaseID', "Supplier Base ID");
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'Name', Name);
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'SearchName', "Search Name");
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'PurchaserCode', "Purchaser Code");
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'Address', Address);
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'Address2', "Address 2");
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'PostCode', "Post Code");
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'City', City);
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'Country', "Country/Region Code");
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'Email', "E-Mail");
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'CurrencyCode', "Currency Code");
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'PaymentTermsCode', "Payment Terms Code");
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'PaymentMethodCode', "Payment Method Code");
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'LeadTimeCalculation', FORMAT("Lead Time Calculation"));
            IF "Qualified vendor" THEN
                JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'Qualified', 'TRUE')
            ELSE
                JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'Qualified', 'FALSE');
            JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'QualificationDate', FORMAT("Date updated"));
            IF Derogation THEN
                JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'Derogation', 'TRUE')
            ELSE
                JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'Derogation', 'FALSE');
            JsonMgt.JsonObjectToText(ResponseJsonAsObject, JsonResponse);
        END;
    end;
}

