page 50098 "NGTS DAF-CG Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group()
            {
                part(; 762)
                {
                    Visible = false;
                }
                part(; 770)
                {
                }
                part(; 9073)
                {
                }
                systempart(; Outlook)
                {
                }
            }
            group()
            {
                part(; 760)
                {
                    Visible = false;
                }
                part(; 675)
                {
                    Visible = false;
                }
                part(; 869)
                {
                }
                part(; 9150)
                {
                }
                part(; 9151)
                {
                }
                part(; 9175)
                {
                }
                systempart(; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Provisional Trial Balance")
            {
                Caption = 'Provisional Trial Balance';
                Image = "Report";
                RunObject = Report 11500;
            }
            action("G/L Total-Balance")
            {
                Caption = 'G/L Total-Balance';
                RunObject = Report 11002;
            }
            action("&Bank Detail Trial Balance")
            {
                Caption = '&Bank Detail Trial Balance';
                Image = "Report";
                RunObject = Report 1404;
            }
            action("&Account Schedule")
            {
                Caption = '&Account Schedule';
                Image = "Report";
                RunObject = Report 25;
            }
            action("Bu&dget")
            {
                Caption = 'Bu&dget';
                Image = "Report";
                RunObject = Report 8;
            }
            action("Trial Balance by &Period")
            {
                Caption = 'Trial Balance by &Period';
                Image = "Report";
                RunObject = Report 38;
            }
            action("&Fiscal Year Balance")
            {
                Caption = '&Fiscal Year Balance';
                Image = "Report";
                RunObject = Report 36;
            }
            action("Balance Comp. - Prev. Y&ear")
            {
                Caption = 'Balance Comp. - Prev. Y&ear';
                Image = "Report";
                RunObject = Report 37;
            }
            action("&Closing Trial Balance")
            {
                Caption = '&Closing Trial Balance';
                Image = "Report";
                RunObject = Report 10;
            }
            separator()
            {
            }
            action("Cust. - Balance to Date")
            {
                Caption = 'Cust. - Balance to Date';
                Image = "Report";
                RunObject = Report 11540;
            }
            action("Vendor - Balance to Date")
            {
                Caption = 'Vendor - Balance to Date';
                Image = "Report";
                RunObject = Report 11559;
            }
            action("Cash Flow Date List")
            {
                Caption = 'Cash Flow Date List';
                Image = "Report";
                RunObject = Report 846;
            }
            separator()
            {
            }
            action("Aged Accounts &Receivable")
            {
                Caption = 'Aged Accounts &Receivable';
                Image = "Report";
                RunObject = Report 120;
            }
            action("Aged Accounts Pa&yable")
            {
                Caption = 'Aged Accounts Pa&yable';
                Image = "Report";
                RunObject = Report 322;
            }
            action("Reconcile Cus&t. and Vend. Accs")
            {
                Caption = 'Reconcile Cus&t. and Vend. Accs';
                Image = "Report";
                RunObject = Report 33;
            }
            action("Customer Total-Balance")
            {
                Caption = 'Customer Total-Balance';
                RunObject = Report 11003;
            }
            action("Vendor Total-Balance")
            {
                Caption = 'Vendor Total-Balance';
                RunObject = Report 11004;
            }
            separator()
            {
            }
            action("&VAT Registration No. Check")
            {
                Caption = '&VAT Registration No. Check';
                Image = "Report";
                RunObject = Report 32;
            }
            action("VAT E&xceptions")
            {
                Caption = 'VAT E&xceptions';
                Image = "Report";
                RunObject = Report 31;
            }
            action("VAT &Statement")
            {
                Caption = 'VAT &Statement';
                Image = "Report";
                RunObject = Report 12;
            }
            separator()
            {
            }
            separator()
            {
            }
            action("Cost Accounting P/L Statement")
            {
                Caption = 'Cost Accounting P/L Statement';
                Image = "Report";
                RunObject = Report 1126;
            }
            action("CA P/L Statement per Period")
            {
                Caption = 'CA P/L Statement per Period';
                Image = "Report";
                RunObject = Report 1123;
            }
            action("CA P/L Statement with Budget")
            {
                Caption = 'CA P/L Statement with Budget';
                Image = "Report";
                RunObject = Report 1133;
            }
            action("Cost Accounting Analysis")
            {
                Caption = 'Cost Accounting Analysis';
                Image = "Report";
                RunObject = Report 1127;
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                Caption = 'Chart of Accounts';
                RunObject = Page 16;
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page 27;
            }
            action(Balance)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page 27;
                RunPageView = WHERE (Balance (LCY)=FILTER(<>0));
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page 9307;
            }
            action(Budgets)
            {
                Caption = 'Budgets';
                RunObject = Page 121;
            }
            action("VAT Statements")
            {
                Caption = 'VAT Statements';
                RunObject = Page 320;
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page 31;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page 22;
            }
            action(Balance)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page 22;
                                RunPageView = WHERE(Balance (LCY)=FILTER(<>0));
            }
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page 9305;
            }
            action(Reminders)
            {
                Caption = 'Reminders';
                Image = Reminder;
                RunObject = Page 436;
            }
        }
        area(sections)
        {
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;
                action("Purchase Journals")
                {
                    Caption = 'Purchase Journals';
                    RunObject = Page 251;
                                    RunPageView = WHERE(Template Type=CONST(Purchases),
                                        Recurring=CONST(No));
                }
                action("Sales Journals")
                {
                    Caption = 'Sales Journals';
                    RunObject = Page 251;
                                    RunPageView = WHERE(Template Type=CONST(Sales),
                                        Recurring=CONST(No));
                }
                action("Cash Receipt Journals")
                {
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    RunObject = Page 251;
                                    RunPageView = WHERE(Template Type=CONST(Cash Receipts),
                                        Recurring=CONST(No));
                }
                action("LSV Journals")
                {
                    Caption = 'LSV Journals';
                    RunObject = Page 3010832;
                }
                action("Payment Journals")
                {
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page 251;
                                    RunPageView = WHERE(Template Type=CONST(Payments),
                                        Recurring=CONST(No));
                }
                action("IC General Journals")
                {
                    Caption = 'IC General Journals';
                    RunObject = Page 251;
                                    RunPageView = WHERE(Template Type=CONST(Intercompany),
                                        Recurring=CONST(No));
                }
                action("General Journals")
                {
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page 251;
                                    RunPageView = WHERE(Template Type=CONST(General),
                                        Recurring=CONST(No));
                }
                action("<Action3>")
                {
                    Caption = 'Recurring General Journals';
                    RunObject = Page 251;
                                    RunPageView = WHERE(Template Type=CONST(General),
                                        Recurring=CONST(Yes));
                }
            }
            group("Fixed Assets")
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;
                action("Fixed Assets")
                {
                    Caption = 'Fixed Assets';
                    RunObject = Page 5601;
                }
                action(Insurance)
                {
                    Caption = 'Insurance';
                    RunObject = Page 5645;
                }
                action("Fixed Assets G/L Journals")
                {
                    Caption = 'Fixed Assets G/L Journals';
                    RunObject = Page 251;
                                    RunPageView = WHERE(Template Type=CONST(Assets),
                                        Recurring=CONST(No));
                }
                action("Fixed Assets Journals")
                {
                    Caption = 'Fixed Assets Journals';
                    RunObject = Page 5633;
                                    RunPageView = WHERE(Recurring=CONST(No));
                }
                action("Fixed Assets Reclass. Journals")
                {
                    Caption = 'Fixed Assets Reclass. Journals';
                    RunObject = Page 5640;
                }
                action("Insurance Journals")
                {
                    Caption = 'Insurance Journals';
                    RunObject = Page 5655;
                }
                action("Recurring Fixed Asset Journals")
                {
                    Caption = 'Recurring Fixed Asset Journals';
                    RunObject = Page 5633;
                                    RunPageView = WHERE(Recurring=CONST(Yes));
                }
            }
            group("Cash Flow")
            {
                Caption = 'Cash Flow';
                action("Cash Flow Forecasts")
                {
                    Caption = 'Cash Flow Forecasts';
                    RunObject = Page 849;
                }
                action("Chart of Cash Flow Accounts")
                {
                    Caption = 'Chart of Cash Flow Accounts';
                    RunObject = Page 851;
                }
                action("Cash Flow Manual Revenues")
                {
                    Caption = 'Cash Flow Manual Revenues';
                    RunObject = Page 857;
                }
                action("Cash Flow Manual Expenses")
                {
                    Caption = 'Cash Flow Manual Expenses';
                    RunObject = Page 859;
                }
            }
            group("Cost Accounting")
            {
                Caption = 'Cost Accounting';
                action("Cost Types")
                {
                    Caption = 'Cost Types';
                    RunObject = Page 1100;
                }
                action("Cost Centers")
                {
                    Caption = 'Cost Centers';
                    RunObject = Page 1122;
                }
                action("Cost Objects")
                {
                    Caption = 'Cost Objects';
                    RunObject = Page 1123;
                }
                action("Cost Allocations")
                {
                    Caption = 'Cost Allocations';
                    RunObject = Page 1102;
                }
                action("Cost Budgets")
                {
                    Caption = 'Cost Budgets';
                    RunObject = Page 1116;
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action("Posted Sales Invoices")
                {
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page 143;
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page 144;
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page 146;
                }
                action("Posted Purchase Credit Memos")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page 147;
                }
                action("Issued Reminders")
                {
                    Caption = 'Issued Reminders';
                    Image = OrderReminder;
                    RunObject = Page 440;
                }
                action("Issued Fin. Charge Memos")
                {
                    Caption = 'Issued Fin. Charge Memos';
                    Image = PostedMemo;
                    RunObject = Page 452;
                }
                action("G/L Registers")
                {
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page 116;
                }
                action("Cost Accounting Registers")
                {
                    Caption = 'Cost Accounting Registers';
                    RunObject = Page 1104;
                }
                action("Cost Accounting Budget Registers")
                {
                    Caption = 'Cost Accounting Budget Registers';
                    RunObject = Page 1121;
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                Image = Administration;
                action(Currencies)
                {
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page 5;
                }
                action("Accounting Periods")
                {
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page 100;
                }
                action("Number Series")
                {
                    Caption = 'Number Series';
                    RunObject = Page 456;
                }
                action("Analysis Views")
                {
                    Caption = 'Analysis Views';
                    RunObject = Page 556;
                }
                action("Account Schedules")
                {
                    Caption = 'Account Schedules';
                    RunObject = Page 103;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page 536;
                }
                action("Bank Account Posting Groups")
                {
                    Caption = 'Bank Account Posting Groups';
                    RunObject = Page 373;
                }
            }
        }
        area(creation)
        {
            action("Sales &Credit Memo")
            {
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 44;
                                RunPageMode = Create;
            }
            action("P&urchase Credit Memo")
            {
                Caption = 'P&urchase Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 52;
                                RunPageMode = Create;
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Cas&h Receipt Journal")
            {
                Caption = 'Cas&h Receipt Journal';
                Image = CashReceiptJournal;
                RunObject = Page 255;
            }
            action("Pa&yment Journal")
            {
                Caption = 'Pa&yment Journal';
                Image = PaymentJournal;
                RunObject = Page 256;
            }
            separator()
            {
            }
            action("Analysis &View")
            {
                Caption = 'Analysis &View';
                Image = AnalysisView;
                RunObject = Page 555;
            }
            action("Analysis by &Dimensions")
            {
                Caption = 'Analysis by &Dimensions';
                Image = AnalysisViewDimension;
                RunObject = Page 554;
            }
            action("Calculate Deprec&iation")
            {
                Caption = 'Calculate Deprec&iation';
                Ellipsis = true;
                Image = CalculateDepreciation;
                RunObject = Report 5692;
            }
            action("Import Co&nsolidation from Database")
            {
                Caption = 'Import Co&nsolidation from Database';
                Ellipsis = true;
                Image = ImportDatabase;
                RunObject = Report 90;
            }
            action("Bank Account R&econciliation")
            {
                Caption = 'Bank Account R&econciliation';
                Image = BankAccountRec;
                RunObject = Page 379;
            }
            action("Adjust E&xchange Rates")
            {
                Caption = 'Adjust E&xchange Rates';
                Ellipsis = true;
                Image = AdjustExchangeRates;
                RunObject = Report 595;
            }
            action("P&ost Inventory Cost to G/L")
            {
                Caption = 'P&ost Inventory Cost to G/L';
                Image = PostInventoryToGL;
                RunObject = Report 1002;
            }
            separator()
            {
            }
            action("C&reate Reminders")
            {
                Caption = 'C&reate Reminders';
                Ellipsis = true;
                Image = CreateReminders;
                RunObject = Report 188;
            }
            action("Create Finance Charge &Memos")
            {
                Caption = 'Create Finance Charge &Memos';
                Ellipsis = true;
                Image = CreateFinanceChargememo;
                RunObject = Report 191;
            }
            separator()
            {
            }
            action("Calc. and Pos&t VAT Settlement")
            {
                Caption = 'Calc. and Pos&t VAT Settlement';
                Image = SettleOpenTransactions;
                RunObject = Report 20;
            }
            separator(Administration)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("General &Ledger Setup")
            {
                Caption = 'General &Ledger Setup';
                Image = Setup;
                RunObject = Page 118;
            }
            action("&Sales && Receivables Setup")
            {
                Caption = '&Sales && Receivables Setup';
                Image = Setup;
                RunObject = Page 459;
            }
            action("&Purchases && Payables Setup")
            {
                Caption = '&Purchases && Payables Setup';
                Image = Setup;
                RunObject = Page 460;
            }
            action("&Fixed Asset Setup")
            {
                Caption = '&Fixed Asset Setup';
                Image = Setup;
                RunObject = Page 5607;
            }
            action("Cash Flow Setup")
            {
                Caption = 'Cash Flow Setup';
                Image = CashFlowSetup;
                RunObject = Page 846;
            }
            action("Cost Accounting Setup")
            {
                Caption = 'Cost Accounting Setup';
                Image = CostAccountingSetup;
                RunObject = Page 1113;
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page 344;
            }
        }
    }
}

