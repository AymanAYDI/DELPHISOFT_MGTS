page 50098 "DEL NGTS DAF-CG Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1)
            {
                part("Finance Performance"; "Finance Performance")
                {
                    Visible = false;
                }
                part("Sales Performance"; "Sales Performance")
                {
                }
                part("Small Business Owner Act."; "Small Business Owner Act.")
                {
                }
                systempart(Outlook; Outlook)
                {
                }
            }
            group(Control2)
            {
                part("Trailing Sales Orders Chart"; "Trailing Sales Orders Chart")
                {
                    Visible = false;
                }
                part("My Job Queue"; "My Job Queue")
                {
                    Visible = false;
                }
                part("Cash Flow Forecast Chart"; "Cash Flow Forecast Chart")
                {
                }
                part("My Customers"; "My Customers")
                {
                }
                part("My Vendors"; "My Vendors")
                {
                }
                part("Copy Profile"; "Copy Profile")
                {
                }
                systempart(MyNotes; MyNotes)
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
                // RunObject = Report 11500; TODO:
            }
            action("G/L Total-Balance")
            {
                Caption = 'G/L Total-Balance';
                // RunObject = Report 11002; TODO:
            }
            action("&Bank Detail Trial Balance")
            {
                Caption = '&Bank Detail Trial Balance';
                Image = "Report";
                RunObject = Report "Bank Acc. - Detail Trial Bal.";
            }
            action("&Account Schedule")
            {
                Caption = '&Account Schedule';
                Image = "Report";
                RunObject = Report "Account Schedule";
            }
            action("Bu&dget")
            {
                Caption = 'Bu&dget';
                Image = "Report";
                RunObject = Report Budget;
            }
            action("Trial Balance by &Period")
            {
                Caption = 'Trial Balance by &Period';
                Image = "Report";
                RunObject = Report "Trial Balance by Period";
            }
            action("&Fiscal Year Balance")
            {
                Caption = '&Fiscal Year Balance';
                Image = "Report";
                RunObject = Report "Fiscal Year Balance";
            }
            action("Balance Comp. - Prev. Y&ear")
            {
                Caption = 'Balance Comp. - Prev. Y&ear';
                Image = "Report";
                RunObject = Report "Balance Comp. - Prev. Year";
            }
            action("&Closing Trial Balance")
            {
                Caption = '&Closing Trial Balance';
                Image = "Report";
                RunObject = Report "Closing Trial Balance";
            }
            separator(SEP1)
            {
            }
            action("Cust. - Balance to Date")
            {
                Caption = 'Cust. - Balance to Date';
                Image = "Report";
                // RunObject = Report 11540; TODO:
            }
            action("Vendor - Balance to Date")
            {
                Caption = 'Vendor - Balance to Date';
                Image = "Report";
                // RunObject = Report 11559; TODO:
            }
            action("Cash Flow Date List")
            {
                Caption = 'Cash Flow Date List';
                Image = "Report";
                RunObject = Report "Cash Flow Date List";
            }
            separator(SEP2)
            {
            }
            action("Aged Accounts &Receivable")
            {
                Caption = 'Aged Accounts &Receivable';
                Image = "Report";
                RunObject = Report "Aged Accounts Receivable";
            }
            action("Aged Accounts Pa&yable")
            {
                Caption = 'Aged Accounts Pa&yable';
                Image = "Report";
                RunObject = Report "Aged Accounts Payable";
            }
            action("Reconcile Cus&t. and Vend. Accs")
            {
                Caption = 'Reconcile Cus&t. and Vend. Accs';
                Image = "Report";
                RunObject = Report "Reconcile Cust. and Vend. Accs";
            }
            action("Customer Total-Balance")
            {
                Caption = 'Customer Total-Balance';
                // RunObject = Report 11003; TODO:
            }
            action("Vendor Total-Balance")
            {
                Caption = 'Vendor Total-Balance';
                // RunObject = Report 11004; TODO:
            }
            separator(SEP3)
            {
            }
            action("&VAT Registration No. Check")
            {
                Caption = '&VAT Registration No. Check';
                Image = "Report";
                RunObject = Report "VAT Registration No. Check";
            }
            action("VAT E&xceptions")
            {
                Caption = 'VAT E&xceptions';
                Image = "Report";
                RunObject = Report "VAT Exceptions";
            }
            action("VAT &Statement")
            {
                Caption = 'VAT &Statement';
                Image = "Report";
                RunObject = Report "VAT Statement";
            }
            separator(SEP4)
            {
            }
            separator(SEP5)
            {
            }
            action("Cost Accounting P/L Statement")
            {
                Caption = 'Cost Accounting P/L Statement';
                Image = "Report";
                RunObject = Report "Cost Acctg. Statement";
            }
            action("CA P/L Statement per Period")
            {
                Caption = 'CA P/L Statement per Period';
                Image = "Report";
                RunObject = Report "Cost Acctg. Stmt. per Period";
            }
            action("CA P/L Statement with Budget")
            {
                Caption = 'CA P/L Statement with Budget';
                Image = "Report";
                RunObject = Report "Cost Acctg. Statement/Budget";
            }
            action("Cost Accounting Analysis")
            {
                Caption = 'Cost Accounting Analysis';
                Image = "Report";
                RunObject = Report "Cost Acctg. Analysis";
            }
        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
            action(Balance)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
            }
            action("Purchase Orders")
            {
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
            }
            action(Budgets)
            {
                Caption = 'Budgets';
                RunObject = Page "G/L Budget Names";
            }
            action("VAT Statements")
            {
                Caption = 'VAT Statements';
                RunObject = Page "VAT Statement Names";
            }
            action(Items)
            {
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
            }
            action(Balance2)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
            }
            action("Sales Orders")
            {
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
            }
            action(Reminders)
            {
                Caption = 'Reminders';
                Image = Reminder;
                RunObject = Page "Reminder List";
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
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Purchases), Recurring = CONST(false));
                }
                action("Sales Journals")
                {
                    Caption = 'Sales Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Sales), Recurring = CONST(false));
                }
                action("Cash Receipt Journals")
                {
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"), Recurring = CONST(false));
                }
                action("LSV Journals")
                {
                    Caption = 'LSV Journals';
                    // RunObject = Page 3010832; TODO:
                }
                action("Payment Journals")
                {
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments), Recurring = CONST(false));
                }
                action("IC General Journals")
                {
                    Caption = 'IC General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Intercompany), Recurring = CONST(false));
                }
                action("General Journals")
                {
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General), Recurring = CONST(false));
                }
                action("<Action3>")
                {
                    Caption = 'Recurring General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General), Recurring = CONST(true));
                }
            }
            group("Fixed Assets")
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;
                action("_Fixed Assets")
                {
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                }
                action(Insurance)
                {
                    Caption = 'Insurance';
                    RunObject = Page "Insurance List";
                }
                action("Fixed Assets G/L Journals")
                {
                    Caption = 'Fixed Assets G/L Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets), Recurring = CONST(false));
                }
                action("Fixed Assets Journals")
                {
                    Caption = 'Fixed Assets Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                }
                action("Fixed Assets Reclass. Journals")
                {
                    Caption = 'Fixed Assets Reclass. Journals';
                    RunObject = Page "FA Reclass. Journal Batches";
                }
                action("Insurance Journals")
                {
                    Caption = 'Insurance Journals';
                    RunObject = Page "Insurance Journal Batches";
                }
                action("Recurring Fixed Asset Journals")
                {
                    Caption = 'Recurring Fixed Asset Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                }
            }
            group("Cash Flow")
            {
                Caption = 'Cash Flow';
                action("Cash Flow Forecasts")
                {
                    Caption = 'Cash Flow Forecasts';
                    RunObject = Page "Cash Flow Forecast List";
                }
                action("Chart of Cash Flow Accounts")
                {
                    Caption = 'Chart of Cash Flow Accounts';
                    RunObject = Page "Chart of Cash Flow Accounts";
                }
                action("Cash Flow Manual Revenues")
                {
                    Caption = 'Cash Flow Manual Revenues';
                    RunObject = Page "Cash Flow Manual Revenues";
                }
                action("Cash Flow Manual Expenses")
                {
                    Caption = 'Cash Flow Manual Expenses';
                    RunObject = Page "Cash Flow Manual Expenses";
                }
            }
            group("Cost Accounting")
            {
                Caption = 'Cost Accounting';
                action("Cost Types")
                {
                    Caption = 'Cost Types';
                    RunObject = Page "Chart of Cost Types";
                }
                action("Cost Centers")
                {
                    Caption = 'Cost Centers';
                    RunObject = Page "Chart of Cost Centers";
                }
                action("Cost Objects")
                {
                    Caption = 'Cost Objects';
                    RunObject = Page "Chart of Cost Objects";
                }
                action("Cost Allocations")
                {
                    Caption = 'Cost Allocations';
                    RunObject = Page "Cost Allocation Sources";
                }
                action("Cost Budgets")
                {
                    Caption = 'Cost Budgets';
                    RunObject = Page "Cost Budget Names";
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
                    RunObject = Page "Posted Sales Invoices";
                }
                action("Posted Sales Credit Memos")
                {
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action("Posted Purchase Invoices")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("Posted Purchase Credit Memos")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                action("Issued Reminders")
                {
                    Caption = 'Issued Reminders';
                    Image = OrderReminder;
                    RunObject = Page "Issued Reminder List";
                }
                action("Issued Fin. Charge Memos")
                {
                    Caption = 'Issued Fin. Charge Memos';
                    Image = PostedMemo;
                    RunObject = Page "Issued Fin. Charge Memo List";
                }
                action("G/L Registers")
                {
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                }
                action("Cost Accounting Registers")
                {
                    Caption = 'Cost Accounting Registers';
                    RunObject = Page "Cost Registers";
                }
                action("Cost Accounting Budget Registers")
                {
                    Caption = 'Cost Accounting Budget Registers';
                    RunObject = Page "Cost Budget Registers";
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
                    RunObject = Page Currencies;
                }
                action("Accounting Periods")
                {
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                }
                action("Number Series")
                {
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                }
                action("Analysis Views")
                {
                    Caption = 'Analysis Views';
                    RunObject = Page "Analysis View List";
                }
                action("Account Schedules")
                {
                    Caption = 'Account Schedules';
                    RunObject = Page "Account Schedule Names";
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page Dimensions;
                }
                action("Bank Account Posting Groups")
                {
                    Caption = 'Bank Account Posting Groups';
                    RunObject = Page "Bank Account Posting Groups";
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
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
            }
            action("P&urchase Credit Memo")
            {
                Caption = 'P&urchase Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Credit Memo";
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
                RunObject = Page "Cash Receipt Journal";
            }
            action("Pa&yment Journal")
            {
                Caption = 'Pa&yment Journal';
                Image = PaymentJournal;
                RunObject = Page "Payment Journal";
            }
            separator(SEP6)
            {
            }
            action("Analysis &View")
            {
                Caption = 'Analysis &View';
                Image = AnalysisView;
                RunObject = Page "Analysis View Card";
            }
            action("Analysis by &Dimensions")
            {
                Caption = 'Analysis by &Dimensions';
                Image = AnalysisViewDimension;
                RunObject = Page "Analysis by Dimensions";
            }
            action("Calculate Deprec&iation")
            {
                Caption = 'Calculate Deprec&iation';
                Ellipsis = true;
                Image = CalculateDepreciation;
                RunObject = Report "Calculate Depreciation";
            }
            action("Import Co&nsolidation from Database")
            {
                Caption = 'Import Co&nsolidation from Database';
                Ellipsis = true;
                Image = ImportDatabase;
                RunObject = Report "Import Consolidation from DB";
            }
            action("Bank Account R&econciliation")
            {
                Caption = 'Bank Account R&econciliation';
                Image = BankAccountRec;
                RunObject = Page "Bank Acc. Reconciliation";
            }
            action("Adjust E&xchange Rates")
            {
                Caption = 'Adjust E&xchange Rates';
                Ellipsis = true;
                Image = AdjustExchangeRates;
                RunObject = Report "Adjust Exchange Rates";
            }
            action("P&ost Inventory Cost to G/L")
            {
                Caption = 'P&ost Inventory Cost to G/L';
                Image = PostInventoryToGL;
                RunObject = Report "Post Inventory Cost to G/L";
            }
            separator(SEP7)
            {
            }
            action("C&reate Reminders")
            {
                Caption = 'C&reate Reminders';
                Ellipsis = true;
                Image = CreateReminders;
                RunObject = Report "Create Reminders";
            }
            action("Create Finance Charge &Memos")
            {
                Caption = 'Create Finance Charge &Memos';
                Ellipsis = true;
                Image = CreateFinanceChargememo;
                RunObject = Report "Create Finance Charge Memos";
            }
            separator(SEP8)
            {
            }
            action("Calc. and Pos&t VAT Settlement")
            {
                Caption = 'Calc. and Pos&t VAT Settlement';
                Image = SettleOpenTransactions;
                RunObject = Report "Calc. and Post VAT Settlement";
            }
            separator(_Administration)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("General &Ledger Setup")
            {
                Caption = 'General &Ledger Setup';
                Image = Setup;
                RunObject = Page "General Ledger Setup";
            }
            action("&Sales && Receivables Setup")
            {
                Caption = '&Sales && Receivables Setup';
                Image = Setup;
                RunObject = Page "Sales & Receivables Setup";
            }
            action("&Purchases && Payables Setup")
            {
                Caption = '&Purchases && Payables Setup';
                Image = Setup;
                RunObject = Page "Purchases & Payables Setup";
            }
            action("&Fixed Asset Setup")
            {
                Caption = '&Fixed Asset Setup';
                Image = Setup;
                RunObject = Page "Fixed Asset Setup";
            }
            action("Cash Flow Setup")
            {
                Caption = 'Cash Flow Setup';
                Image = CashFlowSetup;
                RunObject = Page "Cash Flow Setup";
            }
            action("Cost Accounting Setup")
            {
                Caption = 'Cost Accounting Setup';
                Image = CostAccountingSetup;
                RunObject = Page "Cost Accounting Setup";
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
                RunObject = Page Navigate;
            }
        }
    }
}

