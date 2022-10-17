report 50018 "DEL update fact vente/affaires"
{
    DefaultLayout = RDLC;
    RDLCLayout = './updatefacturesventeaffaires.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Posting Date", "No.";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column("USERID"; USERID)
            {
            }
            column(Montant_Total; Montant_Total)
            {
            }
            column(Sales_Invoice_LineCaption; Sales_Invoice_LineCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Sales_Invoice_Line__Document_No__Caption; "Sales Invoice Line".FIELDCAPTION("Document No."))
            {
            }
            column(Sales_Invoice_Line__No__Caption; "Sales Invoice Line".FIELDCAPTION("No."))
            {
            }
            column(Sales_Invoice_Line_DescriptionCaption; "Sales Invoice Line".FIELDCAPTION(Description))
            {
            }
            column(Sales_Invoice_Line_QuantityCaption; "Sales Invoice Line".FIELDCAPTION(Quantity))
            {
            }
            column(Sales_Invoice_Line__Unit_Price_Caption; "Sales Invoice Line".FIELDCAPTION("Unit Price"))
            {
            }
            column(Sales_Invoice_Line__Shortcut_Dimension_1_Code_Caption; "Sales Invoice Line".FIELDCAPTION("Shortcut Dimension 1 Code"))
            {
            }
            column(Sales_Invoice_Line_AmountCaption; "Sales Invoice Line".FIELDCAPTION(Amount))
            {
            }
            column(Sales_Invoice_Line__Posting_Date_Caption; "Sales Invoice Line".FIELDCAPTION("Posting Date"))
            {
            }
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(<> 0),
                                          Type = FILTER(Item));
                column(Sales_Invoice_Line__Document_No__; "Document No.")
                {
                }
                column(Sales_Invoice_Line__No__; "No.")
                {
                }
                column(Sales_Invoice_Line_Description; Description)
                {
                }
                column(Sales_Invoice_Line_Quantity; Quantity)
                {
                }
                column(Sales_Invoice_Line__Unit_Price_; "Unit Price")
                {
                }
                column(Sales_Invoice_Line__Shortcut_Dimension_1_Code_; "Shortcut Dimension 1 Code")
                {
                }
                column(Sales_Invoice_Line_Amount; Amount)
                {
                }
                column(Sales_Invoice_Line__Posting_Date_; "Posting Date")
                {
                }
                column(Sales_Invoice_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Montant_Total := Montant_Total + "Sales Invoice Line".Amount;

                    DealItem.RESET;
                    DealItem.SETRANGE(DealItem.Deal_ID, Deal_ID_Co_Par);
                    DealItem.SETRANGE(DealItem."Item No.", "Sales Invoice Line"."No.");
                    IF NOT DealItem.FIND('-') THEN BEGIN
                        DealItem.INIT;
                        DealItem.Deal_ID := Deal_ID_Co_Par;
                        DealItem."Item No." := "Sales Invoice Line"."No.";
                        DealItem."Unit Price" := "Sales Invoice Line"."Unit Price";
                        DealItem."Currency Price" := "Sales Invoice Header"."Currency Code";
                        DealItem.INSERT;
                    END;

                    Setup.GET();
                    position_ID_Co_Loc := NoSeriesMgt_Cu.GetNextNo(Setup."Position Nos.", TODAY, TRUE);

                    Position_Re.INIT;
                    Position_Re.ID := position_ID_Co_Loc;
                    Position_Re.VALIDATE("Deal_ID", Deal_ID_Co_Par);
                    Position_Re.VALIDATE(Element_ID, element_ID_Ret);
                    Position_Re.VALIDATE(Instance, Position_Re.Instance::Real);
                    Position_Re.VALIDATE(Position_Re."Deal Item No.", "Sales Invoice Line"."No.");
                    Position_Re.VALIDATE(Quantity, "Sales Invoice Line".Quantity);
                    Position_Re.VALIDATE(Currency, "Sales Invoice Header"."Currency Code");
                    Position_Re.VALIDATE(Amount, "Sales Invoice Line"."Unit Price");
                    Position_Re.VALIDATE("Sub Element_ID", '');
                    Position_Re.VALIDATE(Rate, 1);
                    Position_Re."Campaign Code" := '';
                    Position_Re."Line Amount" := Position_Re.Amount * Position_Re.Quantity;
                    Position_Re."Line Amount (EUR)" := Position_Re.Amount * Position_Re.Quantity;
                    Position_Re.INSERT();
                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO("Document No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Deal_ID_Co_Par := '';
                Element.SETRANGE(Element."Type No.", "Sales Invoice Header"."No.");
                IF Element.FIND('-') THEN BEGIN
                    CurrReport.SKIP;
                END

                ELSE BEGIN
                    SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", "Sales Invoice Header"."No.");
                    SalesInvoiceLine.SETRANGE(SalesInvoiceLine.Type, SalesInvoiceLine.Type::Item);
                    IF SalesInvoiceLine.FIND('-') THEN
                        NComAchat := SalesInvoiceLine."Shortcut Dimension 1 Code"
                    ELSE
                        NComAchat := '';

                    IF NComAchat <> '' THEN BEGIN
                        ACOConnection.SETRANGE(ACOConnection."ACO No.", NComAchat);
                        IF ACOConnection.FIND('-') THEN
                            Deal_ID_Co_Par := ACOConnection.Deal_ID
                        ELSE
                            Deal_ID_Co_Par := '';
                    END;
                    IF Deal_ID_Co_Par <> '' THEN BEGIN
                        Setup.GET();

                        element_ID_Ret := NoSeriesMgt_Cu.GetNextNo(Setup."Element Nos.", TODAY, TRUE);

                        Element.INIT();
                        Element.ID := element_ID_Ret;
                        Element.VALIDATE(Deal_ID, Deal_ID_Co_Par);
                        Element.VALIDATE(Instance, Element.Instance::real);
                        //TODO Element.VALIDATE("Customer/Vendor", 7);
                        Element.VALIDATE("Type No.", "Sales Invoice Header"."No.");
                        Element.VALIDATE("Subject No.", "Sales Invoice Header"."Sell-to Customer No.");
                        Element.VALIDATE("Subject Type", 2);
                        Element.Date := "Sales Invoice Header"."Posting Date";
                        Element.VALIDATE("Entry No.", 0);
                        Element.VALIDATE("Bill-to Customer No.", "Sales Invoice Header"."Bill-to Customer No.");
                        Element."Add DateTime" := CURRENTDATETIME;
                        Element.Period := 20130104D;       // 040113D; 
                        Element."Splitt Index" := 0;
                        Element.INSERT;
                    END;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Montant_Total: Decimal;
        Element: Record "DEL Element";
        Position_Re: Record "DEL Position";
        DealItem: Record "DEL Deal Item";
        Setup: Record "DEL General Setup";
        element_ID_Ret: Code[20];
        NoSeriesMgt_Cu: Codeunit NoSeriesManagement;
        SalesInvoiceLine: Record "Sales Invoice Line";
        ACOConnection: Record "DEL ACO Connection";
        NComAchat: Code[20];
        Deal_ID_Co_Par: Code[20];
        position_ID_Co_Loc: Code[20];
        Sales_Invoice_LineCaptionLbl: Label 'Sales Invoice Line';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

