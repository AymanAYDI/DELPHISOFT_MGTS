page 50140 "JSON Requests logs"
{
    // Mgts10.00.01.00 | 11.01.2020 | Create : JSON Requests logs
    // 
    // Mgts10.00.03.00 | 07.04.2020 | Add C\AL in  : Execute Message - OnAction()
    // Mgts10.00.04.00 | 10.12.2021 | Add new action  : Filter Message - OnAction()

    Caption = 'JSON Requests logs';
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table50073;
    SourceTableView = SORTING(Date)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            group()
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
            grid()
            {
                repeater(Group)
                {
                    field(Date; Date)
                    {
                    }
                    field(Type; Type)
                    {
                    }
                    field("Function"; "Function")
                    {
                    }
                    field(Error; Error)
                    {
                    }
                }
                part(; 50141)
                {
                    SubPageLink = Entry No.=FIELD(Entry No.);
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

                trigger OnAction()
                var
                    JSONWebService: Codeunit "50040";
                    Data: Text;
                    IStream: InStream;
                    StreamReader: DotNet StreamReader;
                    Win: Dialog;
                begin
                    TESTFIELD(Type, Type::Request);
                    //TESTFIELD(Error,TRUE);
                    CALCFIELDS(Message);

                    Win.OPEN("Function" + '...');
                    Message.CREATEINSTREAM(IStream);
                    StreamReader := StreamReader.StreamReader(IStream, TRUE);
                    Data := StreamReader.ReadToEnd();
                    CASE "Function" OF
                        'CreateVendor':
                            JSONWebService.CreateSupplier(Data);
                        'UpdateVEndor':
                            JSONWebService.UpdateSupplier(Data);
                        'GetVendorInfo':
                            JSONWebService.GetSupplierInfo(Data);

                        'CreateUpdateItem':
                            JSONWebService.CreateUpdateProduct(Data);
                        'api/order':
                            DIALOG.MESSAGE('Not implemented.');

                        //>>Mgts10.00.04.00
                        'GetItemCrossReferences':
                            JSONWebService.GetItemCrossReferences(Data);
                        'GetSalesPricess':
                            JSONWebService.GetSalesPrices(Data);
                        'GetPurchasePrices':
                            JSONWebService.GetPurchasePrices(Data);
                        'CreateItemSalesPrices':
                            JSONWebService.CreateItemSalesPrices(Data);
                        'UpdateItemSalesPrices':
                            JSONWebService.UpdateItemSalesPrices(Data);
                        'DeleteItemSalesPrices':
                            JSONWebService.DeleteItemSalesPrices(Data);
                        'CreateItemPurchasePrices':
                            JSONWebService.CreateItemPurchasePrices(Data);
                        'UpdateItemPurchasePrices':
                            JSONWebService.UpdateItemPurchasePrices(Data);
                        'DeleteItemPurchasePrices':
                            JSONWebService.DeleteItemPurchasePrices(Data);
                        'CreateItemCrossReferences':
                            JSONWebService.CreateItemCrossReferences(Data);
                        'UpdateItemCrossReferences':
                            JSONWebService.UpdateItemCrossReferences(Data);
                        'DeleteItemCrossReferences':
                            JSONWebService.DeleteItemCrossReferences(Data);
                    //<<Mgts10.00.04.00

                    END;
                    Win.CLOSE;
                end;
            }
            action(Search)
            {
                Caption = 'Search';
                Image = FilterLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    FilterMessage: Report "50054";
                begin
                    FilterMessage.RUNMODAL;
                    FilterMessage.GetResult(TextToFilter);
                    TextToFilter := STRSUBSTNO(Text001, TextToFilter);

                    SETCURRENTKEY(Filtered, Date);
                    SETRANGE(Filtered, TRUE);
                    IF ISEMPTY THEN BEGIN
                        SETRANGE(Filtered);
                        TextToFilter := '';
                    END;

                    CurrPage.UPDATE;
                end;
            }
            action(Init)
            {
                Caption = 'Init';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    JSONRequestslog: Record "50073";
                begin
                    JSONRequestslog.SETCURRENTKEY(Filtered);
                    JSONRequestslog.SETRANGE(Filtered, TRUE);
                    JSONRequestslog.MODIFYALL(Filtered, FALSE);

                    SETCURRENTKEY(Date);
                    SETRANGE(Filtered);
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

