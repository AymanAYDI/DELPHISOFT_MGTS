codeunit 50056 "DEL JSON WS : Price Mgt" //TODO: dotnet
{
    //     trigger OnRun()
    //     begin
    //         CASE "Function" OF
    //             'GetItemCrossReferences':
    //                 ItemCrossReferencesResponse := GetItemCrossReferences(JsonAsObjectGlobal);
    //             'GetSalesPrices':
    //                 SalesPricesResponse := GetSalesPrices(JsonAsObjectGlobal);
    //             'GetPurchasePrices':
    //                 PurchasePricesResponse := GetPurchasePrices(JsonAsObjectGlobal);
    //             'CreateItemSalesPrices':
    //                 JsonResponseGlobal := CreateItemSalesPrices(JsonAsArrayGlobal);
    //             'UpdateItemSalesPrices':
    //                 JsonResponseGlobal := UpdateItemSalesPrices(JsonAsArrayGlobal);
    //             'DeleteItemSalesPrices':
    //                 JsonResponseGlobal := DeleteItemSalesPrices(JsonAsArrayGlobal);
    //             'CreateItemPurchasePrices':
    //                 JsonResponseGlobal := CreateItemPurchasePrices(JsonAsArrayGlobal);
    //             'UpdateItemPurchasePrices':
    //                 JsonResponseGlobal := UpdateItemPurchasePrices(JsonAsArrayGlobal);
    //             'DeleteItemPurchasePrices':
    //                 JsonResponseGlobal := DeleteItemPurchasePrices(JsonAsArrayGlobal);
    //             'CreateItemCrossReferences':
    //                 JsonResponseGlobal := CreateItemCrossReferences(JsonAsArrayGlobal);
    //             'UpdateItemCrossReferences':
    //                 JsonResponseGlobal := UpdateItemCrossReferences(JsonAsArrayGlobal);
    //             'DeleteItemCrossReferences':
    //                 JsonResponseGlobal := DeleteItemCrossReferences(JsonAsArrayGlobal);
    //         END;
    //     end;

    //     var
    //         SalesPricesResponse: Text;
    //         PurchasePricesResponse: Text;
    //         JsonAsObjectGlobal: DotNet JObject;
    //         JsonAsArrayGlobal: DotNet JArray;
    //         ErpItem: Code[20];
    //         JsonResponseGlobal: Text;
    //         ItemCrossReferencesResponse: Text;
    //         "Function": Text;

    //     [EventSubscriber(ObjectType::Table, 7002, 'OnBeforeInsertEvent', '', false, false)]
    //     local procedure OnBeforInsertSalesPrice(var Rec: Record "Sales Price"; RunTrigger: Boolean)
    //     begin
    //         IF Rec."DEL Entry No." = 0 THEN
    //             Rec."DEL Entry No." := GetNextEntryNoSalesPrice();
    //     end;

    //     local procedure GetNextEntryNoSalesPrice(): Integer
    //     var
    //         SalesPrice: Record "Sales Price";
    //     begin
    //         SalesPrice.SETCURRENTKEY("DEL Entry No.");
    //         SalesPrice.SETFILTER("DEL Entry No.", '<>%1', 0);
    //         IF SalesPrice.FINDLAST THEN
    //             EXIT(SalesPrice."DEL Entry No." + 1);
    //         EXIT(1);
    //     end;

    //     [EventSubscriber(ObjectType::Table, 7012, 'OnBeforeInsertEvent', '', false, false)]
    //     local procedure OnBeforInsertPurchasePrice(var Rec: Record "Purchase Price"; RunTrigger: Boolean)
    //     begin
    //         IF Rec."DEL Entry No." = 0 THEN
    //             Rec."DEL Entry No." := GetNextEntryNoPurchasePrice();
    //     end;

    //     local procedure GetNextEntryNoPurchasePrice(): Integer
    //     var
    //         PurchasePrice: Record "Purchase Price";
    //     begin
    //         PurchasePrice.SETCURRENTKEY("DEL Entry No.");
    //         PurchasePrice.SETFILTER("DEL Entry No.", '<>%1', 0);
    //         IF PurchasePrice.FINDLAST THEN
    //             EXIT(PurchasePrice."DEL Entry No." + 1);
    //         EXIT(1);
    //     end;

    //     [EventSubscriber(ObjectType::Table, 5717, 'OnBeforeInsertEvent', '', false, false)]
    //     local procedure OnBeforInsertItemCrossReference(var Rec: Record "Item Reference"; RunTrigger: Boolean)
    //     begin
    //         IF Rec."DEL Entry No." = 0 THEN
    //             Rec."DEL Entry No." := GetNextEntryNoItemCrossReference();
    //     end;

    //     local procedure GetNextEntryNoItemCrossReference(): Integer
    //     var
    //         ItemCrossReference: Record "Item Reference";
    //     begin
    //         ItemCrossReference.SETCURRENTKEY("DEL Entry No.");
    //         ItemCrossReference.SETFILTER("DEL Entry No.", '<>%1', 0);
    //         IF ItemCrossReference.FINDLAST THEN
    //             EXIT(ItemCrossReference."DEL Entry No." + 1);
    //         EXIT(1);
    //     end;

    //     local procedure GetRecordSalesPrice(EntryNo: BigInteger; var SalesPrice: Record "Sales Price"): Boolean
    //     begin
    //         SalesPrice.SETCURRENTKEY("DEL Entry No.");
    //         SalesPrice.SETRANGE("DEL Entry No.", EntryNo);
    //         EXIT(SalesPrice.FINDFIRST);
    //     end;

    //     local procedure GetRecordPurchasePrice(EntryNo: BigInteger; var PurchasePrice: Record "Purchase Price"): Boolean
    //     begin
    //         PurchasePrice.SETCURRENTKEY("DEL Entry No.");
    //         PurchasePrice.SETRANGE("DEL Entry No.", EntryNo);
    //         EXIT(PurchasePrice.FINDFIRST);
    //     end;

    //     local procedure GetRecordItemCrossReference(EntryNo: BigInteger; var ItemCrossReference: Record "Item Reference"): Boolean
    //     begin
    //         ItemCrossReference.SETCURRENTKEY("DEL Entry No.");
    //         ItemCrossReference.SETRANGE("DEL Entry No.", EntryNo);
    //         EXIT(ItemCrossReference.FINDFIRST);
    //     end;

    //     local procedure "-SalesPrice-"()
    //     begin
    //     end;


    //     procedure GetSalesPriceInfo(SalesPrice: Record "Sales Price") JsonResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         ResponseJsonAsObject: DotNet JObject;
    //     begin
    //         WITH SalesPrice DO BEGIN
    //             ResponseJsonAsObject := ResponseJsonAsObject.JObject();
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'SalesPriceID', FORMAT("DEL Entry No."));
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'ProductErpCode', "Item No.");
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'SalesCode', "Sales Code");
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'SalesPriceStart', FORMAT("Starting Date"));
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'SalesPriceEnd', FORMAT("Ending Date"));
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'SalesPrice', FORMAT("Unit Price"));
    //             IF "Currency Code" = '' THEN
    //                 JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'SalesCurrencyCode', 'CHF')
    //             ELSE
    //                 JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'SalesCurrencyCode', "Currency Code");
    //             JsonMgt.JsonObjectToText(ResponseJsonAsObject, JsonResponse);
    //         END;
    //     end;


    //     procedure GetSalesPrices(JsonAsObject: DotNet JObject) JsonResponse: Text
    //     var
    //         RecordModificationTracking: Record "DEL Record Modifs. Tracking";
    //         I: Integer;
    //         SalesPrice: Record "Sales Price";
    //         FromDate: DateTime;
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //     begin
    //         IF NOT EVALUATE(FromDate, JsonMgt.GetValueFromJsonObject(JsonAsObject, 'FromDate', 20)) THEN
    //             CLEAR(FromDate);
    //         WITH RecordModificationTracking DO BEGIN
    //             I := 0;
    //             SETCURRENTKEY("Table ID", Synchronized);
    //             SETRANGE("Table ID", DATABASE::"Sales Price");
    //             IF FromDate <> 0DT THEN
    //                 SETFILTER("Last Date Modified", '%1..', FromDate)
    //             ELSE
    //                 SETRANGE(Synchronized, FALSE);

    //             JsonResponse := '[';
    //             IF NOT ISEMPTY THEN BEGIN
    //                 FINDSET;
    //                 REPEAT
    //                     IF SalesPrice.GET("Record ID") THEN BEGIN
    //                         IF (I > 0) THEN
    //                             JsonResponse += ',';
    //                         JsonResponse += GetSalesPriceInfo(SalesPrice);
    //                         I += 1;
    //                     END;

    //                 UNTIL (NEXT = 0);
    //             END;
    //             JsonResponse += ']';
    //             SETRANGE(Synchronized, FALSE);
    //             MODIFYALL("Last Date Synchronized", CURRENTDATETIME);
    //             MODIFYALL(Synchronized, TRUE);
    //         END;
    //     end;


    //     procedure GetSalesPricesResponse(): Text
    //     begin
    //         EXIT(SalesPricesResponse);
    //     end;

    //     local procedure AddItemSalesPrice(JsonAsObject: DotNet JObject) PriceCreationResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         SalesPrice: Record "Sales Price";
    //         ItemNo: Code[20];
    //         Item: Record Item;
    //     begin
    //         SalesPrice.INIT;
    //         SalesPrice.VALIDATE("Item No.", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'ProductErpCode', 20));
    //         IF Item.GET(SalesPrice."Item No.") THEN BEGIN
    //             SalesPrice."Sales Type" := SalesPrice."Sales Type"::"Customer Price Group";
    //             SalesPrice."Sales Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SalesCode', 20);
    //             EVALUATE(SalesPrice."Starting Date", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SalesPriceStart', 10));
    //             EVALUATE(SalesPrice."Ending Date", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SalesPriceEnd', 10));
    //             EVALUATE(SalesPrice."Unit Price", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SalesPrice', 10));
    //             SalesPrice."Currency Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SalesCurrencyCode', 10);
    //             SalesPrice.VALIDATE("Starting Date");
    //             SalesPrice.VALIDATE("Currency Code");
    //             SalesPrice.INSERT;
    //             EXIT(SuccesSalesPriceCreationResponse(SalesPrice, 'Created'));
    //         END
    //         ELSE
    //             EXIT(ErrorSalesPriceCreationResponse(SalesPrice));
    //     end;

    //     local procedure UpdateItemSalesPrice(JsonAsObject: DotNet JObject) PriceCreationResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         SalesPrice: Record Item;
    //         ItemNo: Code[20];
    //         EntryNo: BigInteger;
    //     begin
    //         EVALUATE(EntryNo, JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SalesPriceID', 20));
    //         IF GetRecordSalesPrice(EntryNo, SalesPrice) THEN BEGIN
    //             EVALUATE(SalesPrice."Ending Date", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SalesPriceEnd', 10));
    //             EVALUATE(SalesPrice."Unit Price", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SalesPrice', 10));
    //             SalesPrice.VALIDATE("Starting Date");
    //             SalesPrice.VALIDATE("Currency Code");
    //             SalesPrice.MODIFY(TRUE);
    //             EXIT(SuccesSalesPriceCreationResponse(SalesPrice, 'Updated'));
    //         END
    //         ELSE
    //             EXIT(ErrorSalesPriceCreationResponse(SalesPrice));
    //     end;

    //     local procedure DeleteItemSalesPrice(JsonAsObject: DotNet JObject) PriceCreationResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         SalesPrice: Record "Sales Price";
    //         ItemNo: Code[20];
    //         EntryNo: BigInteger;
    //     begin
    //         EVALUATE(EntryNo, JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SalesPriceID', 20));
    //         IF GetRecordSalesPrice(EntryNo, SalesPrice) THEN BEGIN
    //             SalesPrice.DELETE(TRUE);
    //             EXIT(SuccesSalesPriceCreationResponse(SalesPrice, 'Deleted'));
    //         END
    //         ELSE
    //             EXIT(ErrorSalesPriceCreationResponse(SalesPrice));
    //     end;


    //     procedure CreateItemSalesPrices(JsonAsArray: DotNet JArray) JsonResponse: Text
    //     var
    //         Text0001: Label 'Segment code missing product code %1';
    //         JsonAsObject: DotNet JArray;
    //         I: Integer;
    //     begin
    //         JsonResponse := '[';
    //         FOR I := 0 TO (JsonAsArray.Count - 1) DO BEGIN
    //             JsonAsObject := JsonAsArray.Item(I);
    //             IF (I > 0) THEN
    //                 JsonResponse += ',';
    //             JsonResponse += AddItemSalesPrice(JsonAsObject);
    //         END;
    //         JsonResponse += ']';
    //     end;


    //     procedure UpdateItemSalesPrices(JsonAsArray: DotNet JArray) JsonResponse: Text
    //     var
    //         Text0001: Label 'Segment code missing product code %1';
    //         JsonAsObject: DotNet JArray;
    //         I: Integer;
    //     begin
    //         JsonResponse := '[';
    //         FOR I := 0 TO (JsonAsArray.Count - 1) DO BEGIN
    //             JsonAsObject := JsonAsArray.Item(I);
    //             IF (I > 0) THEN
    //                 JsonResponse += ',';
    //             JsonResponse += UpdateItemSalesPrice(JsonAsObject);
    //         END;
    //         JsonResponse += ']';
    //     end;


    //     procedure DeleteItemSalesPrices(JsonAsArray: DotNet JArray) JsonResponse: Text
    //     var
    //         Text0001: Label 'Segment code missing product code %1';
    //         JsonAsObject: DotNet JArray;
    //         I: Integer;
    //     begin
    //         JsonResponse := '[';
    //         FOR I := 0 TO (JsonAsArray.Count - 1) DO BEGIN
    //             JsonAsObject := JsonAsArray.Item(I);
    //             IF (I > 0) THEN
    //                 JsonResponse += ',';
    //             JsonResponse += DeleteItemSalesPrice(JsonAsObject);
    //         END;
    //         JsonResponse += ']';
    //     end;


    //     procedure SuccesSalesPriceCreationResponse(SalesPrice: Record "Sales Price"; StatusMessage: Text) JsonResponse: Text
    //     var
    //         JsonAsObject: DotNet JObject;
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //     begin
    //         JsonAsObject := JsonAsObject.JObject();
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusCode', '1');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'Status', 'Succes');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusMessage', StatusMessage);
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'ProductErpCode', SalesPrice."Item No.");
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'SalesPriceID', FORMAT(SalesPrice."Entry No."));
    //         JsonMgt.JsonObjectToText(JsonAsObject, JsonResponse);
    //     end;


    //     procedure ErrorSalesPriceCreationResponse(SalesPrice: Record "Sales Price") JsonResponse: Text
    //     var
    //         JsonAsObject: DotNet JObject;
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //     begin
    //         JsonAsObject := JsonAsObject.JObject();
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusCode', '-1');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'Status', 'Error');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusMessage', 'NotFound');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'ProductErpCode', SalesPrice."Item No.");
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'SalesPriceID', FORMAT(SalesPrice."Entry No."));
    //         JsonMgt.JsonObjectToText(JsonAsObject, JsonResponse);
    //     end;

    //     local procedure "-PurchasePrice-"()
    //     begin
    //     end;


    //     procedure GetPurchasePriceInfo(PurchasePrice: Record "Purchase Price") JsonResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         ResponseJsonAsObject: DotNet JObject;
    //     begin
    //         WITH PurchasePrice DO BEGIN
    //             ResponseJsonAsObject := ResponseJsonAsObject.JObject();

    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'PurchasePriceID', FORMAT("Entry No."));
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'ProductErpCode', "Item No.");
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'PurchasePriceStart', FORMAT("Starting Date"));
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'PurchasePriceEnd', FORMAT("Ending Date"));
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'PurchasePrice', FORMAT("Direct Unit Cost"));
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'OptimalQty', FORMAT("Qty. optimale"));
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'PurchaseUnitCode', FORMAT("Unit of Measure Code"));
    //             IF "Currency Code" = '' THEN
    //                 JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'SalesCurrencyCode', 'CHF')
    //             ELSE
    //                 JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'SalesCurrencyCode', "Currency Code");
    //             JsonMgt.JsonObjectToText(ResponseJsonAsObject, JsonResponse);
    //         END;
    //     end;


    //     procedure GetPurchasePrices(JsonAsObject: DotNet JObject) JsonResponse: Text
    //     var
    //         RecordModificationTracking: Record "DEL Record Modifs. Tracking";
    //         I: Integer;
    //         PurchasePrice: Record "Purchase Price";
    //         FromDate: DateTime;
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //     begin
    //         IF NOT EVALUATE(FromDate, JsonMgt.GetValueFromJsonObject(JsonAsObject, 'FromDate', 20)) THEN
    //             CLEAR(FromDate);

    //         WITH RecordModificationTracking DO BEGIN
    //             I := 0;
    //             SETCURRENTKEY("Table ID", Synchronized);
    //             SETRANGE("Table ID", DATABASE::"Purchase Price");
    //             IF FromDate <> 0DT THEN
    //                 SETFILTER("Last Date Modified", '%1..', FromDate)
    //             ELSE
    //                 SETRANGE(Synchronized, FALSE);
    //             JsonResponse := '[';
    //             IF NOT ISEMPTY THEN BEGIN
    //                 FINDSET;
    //                 REPEAT
    //                     IF PurchasePrice.GET("Record ID") THEN BEGIN
    //                         IF (I > 0) THEN
    //                             JsonResponse += ',';
    //                         JsonResponse += GetPurchasePriceInfo(PurchasePrice);
    //                         I += 1;
    //                     END;
    //                 UNTIL (NEXT = 0);
    //             END;
    //             JsonResponse += ']';
    //             SETRANGE(Synchronized, FALSE);
    //             MODIFYALL("Last Date Synchronized", CURRENTDATETIME);
    //             MODIFYALL(Synchronized, TRUE);
    //         END;
    //     end;


    //     procedure GetPurchasePricesResponse(): Text
    //     begin
    //         EXIT(PurchasePricesResponse);
    //     end;

    //     local procedure AddItemPurchasePrice(JsonAsObject: DotNet JObject) PriceCreationResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         PurchasePrice: Record "Purchase Price";
    //         Item: Record Item;
    //         Vendor: Record Vendor;
    //     begin
    //         PurchasePrice.INIT;
    //         PurchasePrice."Item No." := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'ProductErpCode', 20);
    //         IF Item.GET(PurchasePrice."Item No.") THEN BEGIN
    //             PurchasePrice."Vendor No." := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'SupplierErpCode', 20);
    //             IF NOT Vendor.GET(PurchasePrice."Vendor No.") THEN
    //                 PurchasePrice."Vendor No." := Item."Vendor No.";
    //             EVALUATE(PurchasePrice."Starting Date", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PurchasePriceStart', 10));
    //             EVALUATE(PurchasePrice."Ending Date", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PurchasePriceEnd', 10));
    //             EVALUATE(PurchasePrice."Direct Unit Cost", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PurchasePrice', 10));
    //             EVALUATE(PurchasePrice."Qty. optimale", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'OptimalQty', 10));
    //             PurchasePrice."Unit of Measure Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PurchaseUnitCode', 10);
    //             PurchasePrice."Currency Code" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PurchaseCurrencyCode', 10);
    //             PurchasePrice.VALIDATE("Starting Date");
    //             PurchasePrice.VALIDATE("Currency Code");
    //             PurchasePrice.INSERT(TRUE);
    //             EXIT(SuccesPurchasePriceCreationResponse(PurchasePrice, 'Created'));
    //         END
    //         ELSE
    //             EXIT(ErrorPurchasePriceCreationResponse(PurchasePrice));
    //     end;

    //     local procedure UpdateItemPurchasePrice(JsonAsObject: DotNet JObject) PriceCreationResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         PurchasePrice: Record "Purchase Price";
    //         ItemNo: Code[20];
    //         VendorNo: Code[20];
    //         EntryNo: BigInteger;
    //     begin
    //         EVALUATE(EntryNo, JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PurchasePriceID', 20));
    //         IF GetRecordPurchasePrice(EntryNo, PurchasePrice) THEN BEGIN
    //             EVALUATE(PurchasePrice."Ending Date", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PurchasePriceEnd', 10));
    //             EVALUATE(PurchasePrice."Direct Unit Cost", JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PurchasePrice', 10));
    //             PurchasePrice.VALIDATE("Starting Date");
    //             PurchasePrice.VALIDATE("Currency Code");
    //             PurchasePrice.MODIFY(TRUE);
    //             EXIT(SuccesPurchasePriceCreationResponse(PurchasePrice, 'Updated'));
    //         END
    //         ELSE
    //             EXIT(ErrorPurchasePriceCreationResponse(PurchasePrice));
    //     end;

    //     local procedure DeleteItemPurchasePrice(JsonAsObject: DotNet JObject) PriceCreationResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         PurchasePrice: Record "Purchase Price";
    //         ItemNo: Code[20];
    //         VendorNo: Code[20];
    //         EntryNo: BigInteger;
    //     begin
    //         EVALUATE(EntryNo, JsonMgt.GetValueFromJsonObject(JsonAsObject, 'PurchasePriceID', 20));
    //         IF GetRecordPurchasePrice(EntryNo, PurchasePrice) THEN BEGIN
    //             PurchasePrice.DELETE(TRUE);
    //             EXIT(SuccesPurchasePriceCreationResponse(PurchasePrice, 'Deleted'));
    //         END
    //         ELSE
    //             EXIT(ErrorPurchasePriceCreationResponse(PurchasePrice));
    //     end;


    //     procedure CreateItemPurchasePrices(JsonAsArray: DotNet JArray) JsonResponse: Text
    //     var
    //         Text0001: Label 'Segment code missing product code %1';
    //         JsonAsObject: DotNet JArray;
    //         I: Integer;
    //     begin
    //         JsonResponse := '[';
    //         FOR I := 0 TO (JsonAsArray.Count - 1) DO BEGIN
    //             JsonAsObject := JsonAsArray.Item(I);
    //             IF (I > 0) THEN
    //                 JsonResponse += ',';
    //             JsonResponse += AddItemPurchasePrice(JsonAsObject);
    //         END;
    //         JsonResponse += ']';
    //     end;


    //     procedure UpdateItemPurchasePrices(JsonAsArray: DotNet JArray) JsonResponse: Text
    //     var
    //         Text0001: Label 'Segment code missing product code %1';
    //         JsonAsObject: DotNet JArray;
    //         I: Integer;
    //     begin
    //         JsonResponse := '[';
    //         FOR I := 0 TO (JsonAsArray.Count - 1) DO BEGIN
    //             JsonAsObject := JsonAsArray.Item(I);
    //             IF (I > 0) THEN
    //                 JsonResponse += ',';
    //             JsonResponse += UpdateItemPurchasePrice(JsonAsObject);
    //         END;
    //         JsonResponse += ']';
    //     end;


    //     procedure DeleteItemPurchasePrices(JsonAsArray: DotNet JArray) JsonResponse: Text
    //     var
    //         Text0001: Label 'Segment code missing product code %1';
    //         JsonAsObject: DotNet JArray;
    //         I: Integer;
    //     begin
    //         JsonResponse := '[';
    //         FOR I := 0 TO (JsonAsArray.Count - 1) DO BEGIN
    //             JsonAsObject := JsonAsArray.Item(I);
    //             IF (I > 0) THEN
    //                 JsonResponse += ',';
    //             JsonResponse += DeleteItemPurchasePrice(JsonAsObject);
    //         END;
    //         JsonResponse += ']';
    //     end;


    //     procedure SuccesPurchasePriceCreationResponse(PurchasePrice: Record "Purchase Price"; StatusMessage: Text) JsonResponse: Text
    //     var
    //         JsonAsObject: DotNet JObject;
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //     begin
    //         JsonAsObject := JsonAsObject.JObject();
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusCode', '1');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'Status', 'Succes');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusMessage', StatusMessage);
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'ProductErpCode', PurchasePrice."Item No.");
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'PurchasePriceID', FORMAT(PurchasePrice."Entry No."));
    //         JsonMgt.JsonObjectToText(JsonAsObject, JsonResponse);
    //     end;


    //     procedure ErrorPurchasePriceCreationResponse(PurchasePrice: Record "Purchase Price") JsonResponse: Text
    //     var
    //         JsonAsObject: DotNet JObject;
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //     begin
    //         JsonAsObject := JsonAsObject.JObject();
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusCode', '-1');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'Status', 'Error');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusMessage', 'NotFound');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'ProductErpCode', PurchasePrice."Item No.");
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'PurchasePriceID', FORMAT(PurchasePrice."Entry No."));
    //         JsonMgt.JsonObjectToText(JsonAsObject, JsonResponse);
    //     end;

    //     local procedure "-ItemCrossReferences-"()
    //     begin
    //     end;


    //     procedure GetItemCrossReferenceInfo(ItemCrossReference: Record "Item Reference") JsonResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         ResponseJsonAsObject: DotNet JObject;
    //     begin
    //         WITH ItemCrossReference DO BEGIN
    //             ResponseJsonAsObject := ResponseJsonAsObject.JObject();
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'CrossReferenceID', FORMAT("Entry No."));
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'ProductErpCode', "Item No.");
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'ExternalType', "Cross-Reference Type No.");
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'ExternalNo', "Cross-Reference No.");
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'Description', Description);
    //             JsonMgt.AddValueToJsonObject(ResponseJsonAsObject, 'UnitofMeasure', "Unit of Measure");
    //             JsonMgt.JsonObjectToText(ResponseJsonAsObject, JsonResponse);
    //         END;
    //     end;


    //     procedure GetItemCrossReferences(JsonAsObject: DotNet JObject) JsonResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         RecordModificationTracking: Record "DEL Record Modifs. Tracking";
    //         I: Integer;
    //         ItemCrossReference: Record "Item Reference";
    //         FromDate: DateTime;
    //     begin
    //         IF NOT EVALUATE(FromDate, JsonMgt.GetValueFromJsonObject(JsonAsObject, 'FromDate', 20)) THEN
    //             CLEAR(FromDate);
    //         WITH RecordModificationTracking DO BEGIN
    //             I := 0;
    //             SETCURRENTKEY("Table ID", Synchronized);
    //             SETRANGE("Table ID", DATABASE::"Item Cross Reference");
    //             IF FromDate <> 0DT THEN
    //                 SETFILTER("Last Date Modified", '%1..', FromDate)
    //             ELSE
    //                 SETRANGE(Synchronized, FALSE);
    //             JsonResponse := '[';
    //             IF NOT ISEMPTY THEN BEGIN
    //                 FINDSET;
    //                 REPEAT
    //                     IF ItemCrossReference.GET("Record ID") THEN BEGIN
    //                         IF (I > 0) THEN
    //                             JsonResponse += ',';
    //                         JsonResponse += GetItemCrossReferenceInfo(ItemCrossReference);
    //                         I += 1;
    //                     END;
    //                 UNTIL (NEXT = 0);
    //             END;
    //             JsonResponse += ']';
    //             SETRANGE(Synchronized, FALSE);
    //             MODIFYALL("Last Date Synchronized", CURRENTDATETIME);
    //             MODIFYALL(Synchronized, TRUE);
    //         END;
    //     end;


    //     procedure GetItemCrossReferencesResponse(): Text
    //     begin
    //         EXIT(ItemCrossReferencesResponse);
    //     end;

    //     local procedure AddItemCrossReference(JsonAsObject: DotNet JObject) PriceCreationResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         ItemCrossReference: Record "Item Reference";
    //         Item: Record Item;
    //         ItemNo: Code[20];
    //     begin
    //         ItemCrossReference.INIT;
    //         ItemCrossReference."Item No." := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'ProductErpCode', 20);
    //         IF Item.GET(ItemCrossReference."Item No.") THEN BEGIN
    //             ItemCrossReference."Cross-Reference Type" := ItemCrossReference."Cross-Reference Type"::Customer;
    //             ItemCrossReference."Cross-Reference Type No." := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'ExternalType', 30);
    //             ItemCrossReference."Cross-Reference No." := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'ExternalNo', 20);
    //             ItemCrossReference.Description := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Description', 50);
    //             ItemCrossReference."Unit of Measure" := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'UnitofMeasure', 10);
    //             IF (ItemCrossReference."Unit of Measure" = '') THEN
    //                 ItemCrossReference."Unit of Measure" := Item."Base Unit of Measure";
    //             ItemCrossReference.TESTFIELD("Cross-Reference Type No.");
    //             ItemCrossReference.TESTFIELD("Cross-Reference No.");
    //             ItemCrossReference.INSERT(TRUE);
    //             EXIT(SuccesItemCrossReferenceCreationResponse(ItemCrossReference, 'Created'));
    //         END
    //         ELSE
    //             EXIT(ErrorItemCrossReferenceCreationResponse(ItemCrossReference));
    //     end;

    //     local procedure UpdateItemCrossReference(JsonAsObject: DotNet JObject) PriceCreationResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         ItemCrossReference: Record "Item Reference";
    //         Item: Record Item;
    //         ItemNo: Code[20];
    //         EntryNo: BigInteger;
    //     begin
    //         EVALUATE(EntryNo, JsonMgt.GetValueFromJsonObject(JsonAsObject, 'CrossReferenceID', 20));
    //         IF GetRecordItemCrossReference(EntryNo, ItemCrossReference) THEN BEGIN
    //             ItemCrossReference.Description := JsonMgt.GetValueFromJsonObject(JsonAsObject, 'Description', 50);
    //             ItemCrossReference.TESTFIELD("Cross-Reference Type No.");
    //             ItemCrossReference.TESTFIELD("Cross-Reference No.");
    //             ItemCrossReference.MODIFY(TRUE);
    //             EXIT(SuccesItemCrossReferenceCreationResponse(ItemCrossReference, 'Updated'));
    //         END
    //         ELSE
    //             EXIT(ErrorItemCrossReferenceCreationResponse(ItemCrossReference));
    //     end;

    //     local procedure DeleteItemCrossReference(JsonAsObject: DotNet JObject) PriceCreationResponse: Text
    //     var
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //         ItemCrossReference: Record "Item Reference";
    //         EntryNo: BigInteger;
    //     begin
    //         EVALUATE(EntryNo, JsonMgt.GetValueFromJsonObject(JsonAsObject, 'CrossReferenceID', 20));
    //         IF GetRecordItemCrossReference(EntryNo, ItemCrossReference) THEN BEGIN
    //             ItemCrossReference.DELETE(TRUE);
    //             EXIT(SuccesItemCrossReferenceCreationResponse(ItemCrossReference, 'Deleted'));
    //         END
    //         ELSE
    //             EXIT(ErrorItemCrossReferenceCreationResponse(ItemCrossReference));
    //     end;


    //     procedure CreateItemCrossReferences(JsonAsArray: DotNet JArray) JsonResponse: Text
    //     var
    //         Text0001: Label 'Segment code missing product code %1';
    //         JsonAsObject: DotNet JArray;
    //         I: Integer;
    //     begin
    //         JsonResponse := '[';
    //         FOR I := 0 TO (JsonAsArray.Count - 1) DO BEGIN
    //             JsonAsObject := JsonAsArray.Item(I);
    //             IF (I > 0) THEN
    //                 JsonResponse += ',';
    //             JsonResponse += AddItemCrossReference(JsonAsObject);
    //         END;
    //         JsonResponse += ']';
    //     end;


    //     procedure UpdateItemCrossReferences(JsonAsArray: DotNet JArray) JsonResponse: Text
    //     var
    //         Text0001: Label 'Segment code missing product code %1';
    //         JsonAsObject: DotNet JArray;
    //         I: Integer;
    //     begin
    //         JsonResponse := '[';
    //         FOR I := 0 TO (JsonAsArray.Count - 1) DO BEGIN
    //             JsonAsObject := JsonAsArray.Item(I);
    //             IF (I > 0) THEN
    //                 JsonResponse += ',';
    //             JsonResponse += UpdateItemCrossReference(JsonAsObject);
    //         END;
    //         JsonResponse += ']';
    //     end;


    //     procedure DeleteItemCrossReferences(JsonAsArray: DotNet JArray) JsonResponse: Text
    //     var
    //         Text0001: Label 'Segment code missing product code %1';
    //         JsonAsObject: DotNet JArray;
    //         I: Integer;
    //     begin
    //         JsonResponse := '[';
    //         FOR I := 0 TO (JsonAsArray.Count - 1) DO BEGIN
    //             JsonAsObject := JsonAsArray.Item(I);
    //             IF (I > 0) THEN
    //                 JsonResponse += ',';
    //             JsonResponse += DeleteItemCrossReference(JsonAsObject);
    //         END;
    //         JsonResponse += ']';
    //     end;


    //     procedure SuccesItemCrossReferenceCreationResponse(ItemCrossReference: Record "Item Reference"; StatusMessage: Text) JsonResponse: Text
    //     var
    //         JsonAsObject: DotNet JObject;
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //     begin
    //         JsonAsObject := JsonAsObject.JObject();
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusCode', '1');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'Status', 'Succes');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusMessage', StatusMessage);
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'ProductErpCode', ItemCrossReference."Item No.");
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'CrossReferenceID', FORMAT(ItemCrossReference."Entry No."));
    //         JsonMgt.JsonObjectToText(JsonAsObject, JsonResponse);
    //     end;


    //     procedure ErrorItemCrossReferenceCreationResponse(ItemCrossReference: Record "Item Reference") JsonResponse: Text
    //     var
    //         JsonAsObject: DotNet JObject;
    //         JsonMgt: Codeunit "DEL JSON Mgt";
    //     begin
    //         JsonAsObject := JsonAsObject.JObject();
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusCode', '-1');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'Status', 'Error');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'StatusMessage', 'NotFound');
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'ProductErpCode', ItemCrossReference."Item No.");
    //         JsonMgt.AddValueToJsonObject(JsonAsObject, 'CrossReferenceID', FORMAT(ItemCrossReference."Entry No."));
    //         JsonMgt.JsonObjectToText(JsonAsObject, JsonResponse);
    //     end;


    //     procedure SetFunctionJArray(_Function: Text; _JsonAsArray: DotNet JArray)
    //     begin
    //         "Function" := _Function;
    //         JsonAsArrayGlobal := _JsonAsArray;
    //     end;


    //     procedure SetFunctionJObject(_Function: Text; _JsonAsObject: DotNet JObject)
    //     begin
    //         "Function" := _Function;
    //         JsonAsObjectGlobal := _JsonAsObject;
    //     end;


    //     procedure GetJsonResponse(): Text
    //     begin
    //         EXIT(JsonResponseGlobal);
    //     end;

    //     trigger JsonAsObjectGlobal::PropertyChanged(sender: Variant; e: DotNet PropertyChangedEventArgs)
    //     begin
    //     end;

    //     trigger JsonAsObjectGlobal::PropertyChanging(sender: Variant; e: DotNet PropertyChangingEventArgs)
    //     begin
    //     end;

    //     trigger JsonAsObjectGlobal::ListChanged(sender: Variant; e: DotNet ListChangedEventArgs)
    //     begin
    //     end;

    //     trigger JsonAsObjectGlobal::AddingNew(sender: Variant; e: DotNet AddingNewEventArgs)
    //     begin
    //     end;

    //     trigger JsonAsObjectGlobal::CollectionChanged(sender: Variant; e: DotNet NotifyCollectionChangedEventArgs)
    //     begin
    //     end;

    //     trigger JsonAsArrayGlobal::ListChanged(sender: Variant; e: DotNet ListChangedEventArgs)
    //     begin
    //     end;

    //     trigger JsonAsArrayGlobal::AddingNew(sender: Variant; e: DotNet AddingNewEventArgs)
    //     begin
    //     end;

    //     trigger JsonAsArrayGlobal::CollectionChanged(sender: Variant; e: DotNet NotifyCollectionChangedEventArgs)
    //     begin
    //     end;
}

