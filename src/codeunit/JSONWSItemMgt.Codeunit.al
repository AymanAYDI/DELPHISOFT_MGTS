codeunit 50050 "JSON WS : Item Mgt"
{
    // Mgts10.00.03.00 | 07.04.2020 | JSON Business Logic Mgt : Item
    // 
    // Mgts10.00.03.01 | 11.06.2020 | JSON Business Logic Mgt : Fix dimensions update
    // 
    // Mgts10.00.04.00 | 03.12.2021 | JSON Business Logic Mgt : Add new Functions


    trigger OnRun()
    begin
        CASE "Function" OF
            'CreateUpdateItem':
                ErpItem := CreateUpdateItem(JsonAsObjectGlobal);
        END;
    end;

    var
        "Function": Text;
        JsonAsObjectGlobal: DotNet JObject;
        JsonAsArrayGlobal: DotNet JArray;
        ErpItem: Code[20];

    [Scope('Internal')]
    procedure SetFunction(CurrentFunction: Text; CurrentJsonAsObject: DotNet JObject)
    begin
        "Function" := CurrentFunction;
        JsonAsObjectGlobal := CurrentJsonAsObject;
    end;

    [Scope('Internal')]
    procedure GetCreatedItem(): Code[20]
    begin
        EXIT(ErpItem);
    end;

    [Scope('Internal')]
    procedure CreateUpdateItem(JsonAsObject: DotNet JObject) ErpItemCode: Code[20]
    var
        Item: Record "27";
        ProductGroup: Record "5723";
        MatriseGroupArtGroup: Record "50059";
        JsonMgt: Codeunit "50041";
        Text0001: Label 'Segment code missing product code %1';
    begin
        WITH Item DO BEGIN
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'ProductErpCode', 20) = '') THEN BEGIN
                INIT;
                INSERT(TRUE);
                ApplyItemTemplate(Item);
            END
            ELSE
                GET(JsonMgt.GetValueFromJsonObject(JsonAsObject, 'ProductErpCode', 20));

            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Description', 50) <> '') THEN
                VALIDATE(Description, JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Description', 50));
            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'ProductGroupCode', 10) <> '') THEN BEGIN
                "Product Group Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'ProductGroupCode', 10);

                ProductGroup.SETRANGE(Code, "Product Group Code");
                IF ProductGroup.ISEMPTY THEN
                    ProductGroup.INIT
                ELSE
                    ProductGroup.FINDFIRST;
                "Item Category Code" := ProductGroup."Item Category Code";
                IF ProductGroup."Code Segment" = '' THEN
                    ERROR(Text0001, "Product Group Code");
                MatriseGroupArtGroup.SETRANGE("Product Group Code", "Product Group Code");
                IF NOT MatriseGroupArtGroup.ISEMPTY THEN BEGIN
                    MatriseGroupArtGroup.FINDFIRST;
                    IF MatriseGroupArtGroup.COUNT = 1 THEN
                        Standardartikelgruppe := MatriseGroupArtGroup."Standard Item Group Code"
                END;
            END;

            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SupplierErpCode', 20) <> '') THEN
                VALIDATE("Vendor No.", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SupplierErpCode', 20));

            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SupplierItemCode', 20) <> '') THEN
                VALIDATE("Vendor Item No.", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SupplierItemCode', 20));

            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'EANCode', 13) <> '') THEN
                VALIDATE("Code EAN 13", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'EANCode', 13));

            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'NbUnitPerParcel', 10) <> '') THEN
                EVALUATE(PCB, JsonMgt.GetValueFromJsonObject(JsonAsObject, 'NbUnitPerParcel', 10));

            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'CustomRate', 10) <> '') THEN
                EVALUATE("Droit de douane reduit", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'CustomRate', 10));

            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'TARICCode', 30) <> '') THEN
                VALIDATE("Code nomenclature douaniere", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'TARICCode', 30));

            IF (JsonMgt.GetValueFromJsonObject(JsonAsObject, 'ParcelVolume', 10) <> '') THEN
                EVALUATE("Vol cbm carton transport", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'ParcelVolume', 10));

            //>>Mgts10.00.04.00
            Blocked := (UPPERCASE(JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Blocked', 10)) = 'TRUE');
            "Sale blocked" := (UPPERCASE(JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SalesBlocked', 10)) = 'TRUE');
            //<<Mgts10.00.04.00

            MODIFY(TRUE);

            //>>Mgts10.00.03.01
            ModifCategory("Item Category Code");
            ModifSegment("Product Group Code", "Item Category Code");
            //<<Mgts10.00.03.01

            ErpItemCode := "No.";
        END;
    end;

    [Scope('Internal')]
    procedure SuccesItemCreationResponse(ErpItemrCode: Code[20]) JsonResponse: Text
    var
        JsonAsObject: DotNet JObject;
        JsonMgt: Codeunit "50041";
    begin
        JsonAsObject := JsonAsObject.JObject();
        JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusCode', '1');
        JsonMgt.AddValueToJsonObject(JsonAsObject, 'Status', 'Succes');
        JsonMgt.AddValueToJsonObject(JsonAsObject, 'ProductErpCode', ErpItemrCode);
        JsonMgt.JsonObjectToText(JsonAsObject, JsonResponse);
    end;

    local procedure ApplyItemTemplate(var Item: Record "27")
    var
        DimensionsTemplate: Record "1302";
        MgtsSetup: Record "50000";
        ConfigTemplateHeader: Record "8618";
        ConfigTemplateManagement: Codeunit "8612";
        ItemRecRef: RecordRef;
    begin
        IF NOT MgtsSetup.GET THEN
            EXIT;

        IF NOT ConfigTemplateHeader.GET(MgtsSetup."Item Template") THEN
            EXIT;

        ItemRecRef.GETTABLE(Item);
        ConfigTemplateManagement.UpdateRecord(ConfigTemplateHeader, ItemRecRef);
        DimensionsTemplate.InsertDimensionsFromTemplates(ConfigTemplateHeader, Item."No.", DATABASE::Item);
        ItemRecRef.SETTABLE(Item);
    end;

    trigger JsonAsArrayGlobal::ListChanged(sender: Variant; e: DotNet ListChangedEventArgs)
    begin
    end;

    trigger JsonAsArrayGlobal::AddingNew(sender: Variant; e: DotNet AddingNewEventArgs)
    begin
    end;

    trigger JsonAsArrayGlobal::CollectionChanged(sender: Variant; e: DotNet NotifyCollectionChangedEventArgs)
    begin
    end;
}

