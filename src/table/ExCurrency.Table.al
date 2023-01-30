
table 99200 "DEL Ex_Currency"
{
    Caption = 'Currency';
    LookupPageID = Currencies;
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Last Date Adjusted"; Date)
        {
            Caption = 'Last Date Adjusted';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "Unrealized Gains Acc."; Code[20])
        {
            Caption = 'Unrealized Gains Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(7; "Realized Gains Acc."; Code[20])
        {
            Caption = 'Realized Gains Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(8; "Unrealized Losses Acc."; Code[20])
        {
            Caption = 'Unrealized Losses Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(9; "Realized Losses Acc."; Code[20])
        {
            Caption = 'Realized Losses Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(10; "Invoice Rounding Precision"; Decimal)
        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            Caption = 'Invoice Rounding Precision';
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(12; "Invoice Rounding Type"; Enum "DEL Invoice Rounding Type")
        {
            Caption = 'Invoice Rounding Type';
            DataClassification = CustomerContent;
        }
        field(13; "Amount Rounding Precision"; Decimal)
        {
            Caption = 'Amount Rounding Precision';
            DecimalPlaces = 2 : 5;
            InitValue = 0.01;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(14; "Unit-Amount Rounding Precision"; Decimal)
        {
            Caption = 'Unit-Amount Rounding Precision';
            DecimalPlaces = 0 : 9;
            InitValue = 0.00001;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(15; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(17; "Amount Decimal Places"; Text[5])
        {
            Caption = 'Amount Decimal Places';
            InitValue = '2:2';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(18; "Unit-Amount Decimal Places"; Text[5])
        {
            Caption = 'Unit-Amount Decimal Places';
            InitValue = '2:5';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(19; "Customer Filter"; Code[20])
        {
            Caption = 'Customer Filter';
            FieldClass = FlowFilter;
            TableRelation = Customer;
        }
        field(20; "Vendor Filter"; Code[20])
        {
            Caption = 'Vendor Filter';
            FieldClass = FlowFilter;
            TableRelation = Vendor;
        }
        field(21; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(22; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(23; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(24; "Cust. Ledg. Entries in Filter"; Boolean)
        {

            CalcFormula = Exist("Cust. Ledger Entry" WHERE("Customer No." = FIELD("Customer Filter"),

                                                            "Currency Code" = FIELD(Code)));
            Caption = 'Cust. Ledg. Entries in Filter';
            Editable = false;
            FieldClass = FlowField;
        }

        field(25; "Customer Balance"; Decimal)

        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("Customer Filter"),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Posting Date" = FIELD("Date Filter"),
                                                                         "Currency Code" = FIELD(Code)));
            Caption = 'Customer Balance';
            Editable = false;
            FieldClass = FlowField;
        }

        field(26; "Customer Outstanding Orders"; Decimal)

        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Outstanding Amount" WHERE("Document Type" = CONST(Order),
                                                                       "Bill-to Customer No." = FIELD("Customer Filter"),
                                                                       "Currency Code" = FIELD(Code),
                                                                       "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                       "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
            Caption = 'Customer Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }

        field(27; "Customer Shipped Not Invoiced"; Decimal)

        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Shipped Not Invoiced" WHERE("Document Type" = CONST(Order),
                                                                         "Bill-to Customer No." = FIELD("Customer Filter"),
                                                                         "Currency Code" = FIELD(Code),
                                                                         "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                         "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
            Caption = 'Customer Shipped Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }

        field(28; "Customer Balance Due"; Decimal)

        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("Customer Filter"),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Initial Entry Due Date" = FIELD("Date Filter"),
                                                                         "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                         "Currency Code" = FIELD(Code)));
            Caption = 'Customer Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }

        field(29; "Vendor Ledg. Entries in Filter"; Boolean)

        {
            CalcFormula = Exist("Vendor Ledger Entry" WHERE("Vendor No." = FIELD("Vendor Filter"),
                                                             "Currency Code" = FIELD(Code)));
            Caption = 'Vendor Ledg. Entries in Filter';
            Editable = false;
            FieldClass = FlowField;
        }

        field(30; "Vendor Balance"; Decimal)

        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("Vendor Filter"),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Posting Date" = FIELD("Date Filter"),
                                                                           "Currency Code" = FIELD(Code)));
            Caption = 'Vendor Balance';
            Editable = false;
            FieldClass = FlowField;
        }

        field(31; "Vendor Outstanding Orders"; Decimal)

        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Outstanding Amount" WHERE("Document Type" = CONST(Order),
                                                                          "Pay-to Vendor No." = FIELD("Vendor Filter"),
                                                                          "Currency Code" = FIELD(Code),
                                                                          "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                          "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
            Caption = 'Vendor Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }

        field(32; "Vendor Amt. Rcd. Not Invoiced"; Decimal)

        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Amt. Rcd. Not Invoiced" WHERE("Document Type" = CONST(Order),
                                                                              "Pay-to Vendor No." = FIELD("Vendor Filter"),
                                                                              "Currency Code" = FIELD(Code),
                                                                              "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter")));
            Caption = 'Vendor Amt. Rcd. Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }

        field(33; "Vendor Balance Due"; Decimal)

        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor No." = FIELD("Vendor Filter"),
                                                                           "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                           "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                           "Initial Entry Due Date" = FIELD("Date Filter"),
                                                                           "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                           "Currency Code" = FIELD(Code)));
            Caption = 'Vendor Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }

        field(34; "Customer Balance (LCY)"; Decimal)

        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("Customer Filter"),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Currency Code" = FIELD(Code)));
            Caption = 'Customer Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }

        field(35; "Vendor Balance (LCY)"; Decimal)

        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("Vendor Filter"),
                                                                                   "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                                   "Currency Code" = FIELD(Code)));
            Caption = 'Vendor Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }

        field(40; "Realized G/L Gains Account"; Code[20])

        {
            Caption = 'Realized G/L Gains Account';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(41; "Realized G/L Losses Account"; Code[20])

        {
            Caption = 'Realized G/L Losses Account';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(44; "Appln. Rounding Precision"; Decimal)

        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            Caption = 'Appln. Rounding Precision';
            MinValue = 0;
            DataClassification = CustomerContent;
        }

        field(45; "EMU Currency"; Boolean)
        {
            Caption = 'EMU Currency';
            DataClassification = CustomerContent;
        }
        field(46; "Currency Factor"; Decimal)

        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(47; "Residual Gains Account"; Code[20])

        {
            Caption = 'Residual Gains Account';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(48; "Residual Losses Account"; Code[20])

        {
            Caption = 'Residual Losses Account';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(50; "Conv. LCY Rndg. Debit Acc."; Code[20])

        {
            Caption = 'Conv. LCY Rndg. Debit Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(51; "Conv. LCY Rndg. Credit Acc."; Code[20])

        {
            Caption = 'Conv. LCY Rndg. Credit Acc.';
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }

        field(52; "Max. VAT Difference Allowed"; Decimal)

        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            Caption = 'Max. VAT Difference Allowed';
            DataClassification = CustomerContent;
        }

        field(53; "VAT Rounding Type"; Enum "DEL VAT Rounding Type")

        {
            Caption = 'VAT Rounding Type';
            DataClassification = CustomerContent;
        }

        field(54; "Payment Tolerance %"; Decimal)

        {
            Caption = 'Payment Tolerance %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }

        field(55; "Max. Payment Tolerance Amount"; Decimal)
        {
            AutoFormatExpression = Code;
            //TODO AuFormatType = 1;
            Caption = 'Max. Payment Tolerance Amount';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        //------ spécifique pays suisse---//

        field(3010541; "ISO Currency Code"; Code[3])

        {
            Caption = 'ISO Currency Code';
            CharAllowed = 'AZ';
            DataClassification = CustomerContent;
        }

        field(4006497; Kennzeichen; Text[10])
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

