page 50140 "DEL JSON Requests logs"
{


    Caption = 'JSON Requests logs';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "DEL JSON Requests log";
    SourceTableView = SORTING(Date)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            group(Controle1)
            {
                Visible = TextToFilter <> '';
                label(TextToFilter)
                {
                    CaptionClass = TextToFilter;
                    Caption = 'Text To Filter';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
            grid(Controle2)
            {
                repeater(Group)
                {
                    field("Date"; Rec.Date)
                    {
                    }
                    field(Type; Rec.Type)
                    {
                    }
                    field(Function; Rec."Function")
                    {
                    }
                    field("Error"; Rec.Error)
                    {
                    }
                }
                part(Message; Message)
                {
                    SubPageLink = "Entry No." = FIELD("Entry No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Execute Message")
            {
                Caption = 'Execute message';
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                //TODO
                // trigger OnAction()
                // var

                //     JSONWebService: Codeunit "50040";
                //     StreamReader: DotNet StreamReader;
                //     Data: Text;
                //     IStream: InStream;

                //     Win: Dialog;
                // begin
                //     Rec.TESTFIELD(Type, Rec.Type::Request);
                //     //TESTFIELD(Error,TRUE);
                //     Rec.CALCFIELDS(Message);

                //     Win.OPEN(Rec."Function" + '...');
                //     Message.CREATEINSTREAM(IStream);
                //     StreamReader := StreamReader.StreamReader(IStream, TRUE);
                //     Data := StreamReader.ReadToEnd();
                //     CASE Rec."Function" OF
                //         'CreateVendor':
                //             JSONWebService.CreateSupplier(Data);
                //         'UpdateVEndor':
                //             JSONWebService.UpdateSupplier(Data);
                //         'GetVendorInfo':
                //             JSONWebService.GetSupplierInfo(Data);

                //         'CreateUpdateItem':
                //             JSONWebService.CreateUpdateProduct(Data);
                //         'api/order':
                //             DIALOG.MESSAGE('Not implemented.');

                //         //>>Mgts10.00.04.00
                //         'GetItemCrossReferences':
                //             JSONWebService.GetItemCrossReferences(Data);
                //         'GetSalesPricess':
                //             JSONWebService.GetSalesPrices(Data);
                //         'GetPurchasePrices':
                //             JSONWebService.GetPurchasePrices(Data);
                //         'CreateItemSalesPrices':
                //             JSONWebService.CreateItemSalesPrices(Data);
                //         'UpdateItemSalesPrices':
                //             JSONWebService.UpdateItemSalesPrices(Data);
                //         'DeleteItemSalesPrices':
                //             JSONWebService.DeleteItemSalesPrices(Data);
                //         'CreateItemPurchasePrices':
                //             JSONWebService.CreateItemPurchasePrices(Data);
                //         'UpdateItemPurchasePrices':
                //             JSONWebService.UpdateItemPurchasePrices(Data);
                //         'DeleteItemPurchasePrices':
                //             JSONWebService.DeleteItemPurchasePrices(Data);
                //         'CreateItemCrossReferences':
                //             JSONWebService.CreateItemCrossReferences(Data);
                //         'UpdateItemCrossReferences':
                //             JSONWebService.UpdateItemCrossReferences(Data);
                //         'DeleteItemCrossReferences':
                //             JSONWebService.DeleteItemCrossReferences(Data);
                //     //<<Mgts10.00.04.00

                //     END;
                //     Win.CLOSE;
                // end;
            }
            action(Search)
            {
                Caption = 'Search';
                Image = FilterLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                //TODO //REPORT 
                // trigger OnAction()
                // var
                //     FilterMessage: Report 50054;
                // begin
                //     FilterMessage.RUNMODAL;
                //     FilterMessage.GetResult(TextToFilter);
                //     TextToFilter := STRSUBSTNO(Text001, TextToFilter);

                //     Rec.SETCURRENTKEY(Filtered, Date);
                //     Rec.SETRANGE(Filtered, TRUE);
                //     IF Rec.ISEMPTY THEN BEGIN
                //         Rec.SETRANGE(Filtered);
                //         TextToFilter := '';
                //     END;

                //     CurrPage.UPDATE;
                // end;
            }
            action("Init")
            {
                Caption = 'Init';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    JSONRequestslog: Record "DEL JSON Requests log";
                begin
                    JSONRequestslog.SETCURRENTKEY(Filtered);
                    JSONRequestslog.SETRANGE(Filtered, TRUE);
                    JSONRequestslog.MODIFYALL(Filtered, FALSE);

                    Rec.SETCURRENTKEY(Date);
                    Rec.SETRANGE(Filtered);
                    TextToFilter := '';
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    var
        [InDataSet]
        TextToFilter: Text;
        Text001: Label 'WARNING ! You are filtered. Search criteria : %1.';
}

