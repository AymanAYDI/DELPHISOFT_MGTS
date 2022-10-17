report 50019 "DEL Delete doc Sales/Pur"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DeletedocumentSalesPurchase.rdlc';
    Caption = 'Delete documents Sales/Purchase';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "Document Type", "Sell-to Customer No.", "No.", "Order Date";
            column(PostingDate_SalesHeader; "Sales Header"."Posting Date")
            {
            }
            column(OrderDate_SalesHeader; "Sales Header"."Order Date")
            {
            }
            column(BilltoName_SalesHeader; "Sales Header"."Bill-to Name")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
            {
            }
            column(No_SalesHeader; "Sales Header"."No.")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Document Type" = FIELD("Document Type");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    ORDER(Ascending);
                column(DocumentNo_SalesLine; "Sales Line"."Document No.")
                {
                }
                column(LineNo_SalesLine; "Sales Line"."Line No.")
                {
                }
                column(Type_SalesLine; "Sales Line".Type)
                {
                }
                column(No_SalesLine; "Sales Line"."No.")
                {
                }
                column(Description_SalesLine; "Sales Line".Description)
                {
                }
                column(Quantity_SalesLine; "Sales Line".Quantity)
                {
                }
                column(QtyShippedNotInvoiced_SalesLine; "Sales Line"."Qty. Shipped Not Invoiced")
                {
                }
                column(Amount_SalesLine; "Sales Line".Amount)
                {
                }
                column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF DeleteVente THEN
                        "Sales Line".DELETE();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF DeleteVente THEN
                    "Sales Header".DELETE();
            end;
        }
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending);
            RequestFilterFields = "Document Type", "No.", "Buy-from Vendor No.", "Order Date";
            column(OrderDate_PurchaseHeader; "Purchase Header"."Order Date")
            {
            }
            column(PaytoName_PurchaseHeader; "Purchase Header"."Pay-to Name")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Purchase Header"."Buy-from Vendor No.")
            {
            }
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(PostingDate_PurchaseHeader; "Purchase Header"."Posting Date")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    ORDER(Ascending);
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                column(Description_PurchaseLine; "Purchase Line".Description)
                {
                }
                column(Quantity_PurchaseLine; "Purchase Line".Quantity)
                {
                }
                column(DirectUnitCost_PurchaseLine; "Purchase Line"."Direct Unit Cost")
                {
                }
                column(Amount_PurchaseLine; "Purchase Line".Amount)
                {
                }
                column(Type_PurchaseLine; "Purchase Line".Type)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF DeleteAchat THEN
                        "Purchase Line".DELETE();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF DeleteAchat THEN
                    "Purchase Header".DELETE();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Option")
                {
                    Caption = 'Option';
                    field(DeleteVente; DeleteVente)
                    {
                        Caption = 'Delete sales';
                    }
                    field(DeleteAchat; DeleteAchat)
                    {
                        Caption = 'Delete purchase';
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
        DeleteVente: Boolean;
        DeleteAchat: Boolean;
}

