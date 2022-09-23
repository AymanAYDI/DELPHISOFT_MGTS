
table 99200 "DEL Ex_Currency"
{
    Caption = 'Currency';
    LookupPageID = Currencies;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(3; "Last Date Adjusted"; Date)
        {
            Caption = 'Last Date Adjusted';
            Editable = false;
        }
        field(6; "Unrealized Gains Acc."; Code[20])
        {
            Caption = 'Unrealized Gains Acc.';
            TableRelation = "G/L Account";
        }
        field(7; "Realized Gains Acc."; Code[20])
        {
            Caption = 'Realized Gains Acc.';
            TableRelation = "G/L Account";
        }
        field(8; "Unrealized Losses Acc."; Code[20])
        {
            Caption = 'Unrealized Losses Acc.';
            TableRelation = "G/L Account";
        }
        field(9; "Realized Losses Acc."; Code[20])
        {
            Caption = 'Realized Losses Acc.';
            TableRelation = "G/L Account";
        }
        field(10; "Invoice Rounding Precision"; Decimal)
        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            Caption = 'Invoice Rounding Precision';
            InitValue = 1;
        }
        field(12; "Invoice Rounding Type"; Option)
        {
            Caption = 'Invoice Rounding Type';
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
        }
        field(13; "Amount Rounding Precision"; Decimal)
        {
            Caption = 'Amount Rounding Precision';
            DecimalPlaces = 2 : 5;
            InitValue = 0.01;
            MinValue = 0;
        }
        field(14; "Unit-Amount Rounding Precision"; Decimal)
        {
            Caption = 'Unit-Amount Rounding Precision';
            DecimalPlaces = 0 : 9;
            InitValue = 0.00001;
            MinValue = 0;
        }
        field(15; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(17; "Amount Decimal Places"; Text[5])
        {
            Caption = 'Amount Decimal Places';
            InitValue = '2:2';
            NotBlank = true;
        }
        field(18; "Unit-Amount Decimal Places"; Text[5])
        {
            Caption = 'Unit-Amount Decimal Places';
            InitValue = '2:5';
            NotBlank = true;
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
            TableRelation = "Dimension Value".Code WHERE(Global Dimension No.=CONST(1));
        }
        field(22; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE(Global Dimension No.=CONST(2));
        }
        field(23; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(24; "Cust. Ledg. Entries in Filter"; Boolean)
        {

            CalcFormula = Exist("Cust. Ledger Entry" WHERE(Customer No.=FIELD(Customer Filter),

                                                            Currency Code=FIELD(Code)));
            Caption = 'Cust. Ledg. Entries in Filter';
            Editable = false;
            FieldClass = FlowField;
        }

        field(25; "Customer Balance"; Decimal)
>
        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE (Customer No.=FIELD(Customer Filter),
                                                                         Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                         Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                         Posting Date=FIELD(Date Filter),
                                                                         Currency Code=FIELD(Code)));
            Caption = 'Customer Balance';
            Editable = false;
            FieldClass = FlowField;
        }

        field(26; "Customer Outstanding Orders"; Decimal)

        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Outstanding Amount" WHERE (Document Type=CONST(Order),
                                                                       Bill-to Customer No.=FIELD(Customer Filter),
                                                                       Currency Code=FIELD(Code),
                                                                       Shortcut Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                       Shortcut Dimension 2 Code=FIELD(Global Dimension 2 Filter)));
            Caption = 'Customer Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }

        field(27; "Customer Shipped Not Invoiced"; Decimal)

        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Shipped Not Invoiced" WHERE (Document Type=CONST(Order),
                                                                         Bill-to Customer No.=FIELD(Customer Filter),
                                                                         Currency Code=FIELD(Code),
                                                                         Shortcut Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                         Shortcut Dimension 2 Code=FIELD(Global Dimension 2 Filter)));
            Caption = 'Customer Shipped Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }

        field(28; "Customer Balance Due"; Decimal)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE (Customer No.=FIELD(Customer Filter),
                                                                         Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                         Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                         Initial Entry Due Date=FIELD(Date Filter),
                                                                         Posting Date=FIELD(UPPERLIMIT(Date Filter)),
                                                                         Currency Code=FIELD(Code)));
            Caption = 'Customer Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
<<<<<<< HEAD
        field(29; "Vendor Ledg. Entries in Filter"; Boolean)
=======
        field(29; "Vendor Ledg. Entries in Filter"; Boolean)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            CalcFormula = Exist("Vendor Ledger Entry" WHERE (Vendor No.=FIELD(Vendor Filter),
                                                             Currency Code=FIELD(Code)));
            Caption = 'Vendor Ledg. Entries in Filter';
            Editable = false;
            FieldClass = FlowField;
        }
<<<<<<< HEAD
        field(30; "Vendor Balance"; Decimal)
=======
        field(30; "Vendor Balance"; Decimal)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry".Amount WHERE (Vendor No.=FIELD(Vendor Filter),
                                                                           Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                           Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                           Posting Date=FIELD(Date Filter),
                                                                           Currency Code=FIELD(Code)));
            Caption = 'Vendor Balance';
            Editable = false;
            FieldClass = FlowField;
        }
<<<<<<< HEAD
        field(31; "Vendor Outstanding Orders"; Decimal)
=======
        field(31; "Vendor Outstanding Orders"; Decimal)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Outstanding Amount" WHERE (Document Type=CONST(Order),
                                                                          Pay-to Vendor No.=FIELD(Vendor Filter),
                                                                          Currency Code=FIELD(Code),
                                                                          Shortcut Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                          Shortcut Dimension 2 Code=FIELD(Global Dimension 2 Filter)));
            Caption = 'Vendor Outstanding Orders';
            Editable = false;
            FieldClass = FlowField;
        }
<<<<<<< HEAD
        field(32; "Vendor Amt. Rcd. Not Invoiced"; Decimal)
=======
        field(32; "Vendor Amt. Rcd. Not Invoiced"; Decimal)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Amt. Rcd. Not Invoiced" WHERE (Document Type=CONST(Order),
                                                                              Pay-to Vendor No.=FIELD(Vendor Filter),
                                                                              Currency Code=FIELD(Code),
                                                                              Shortcut Dimension 1 Code=FIELD(Global Dimension 1 Filter),
                                                                              Shortcut Dimension 2 Code=FIELD(Global Dimension 2 Filter)));
            Caption = 'Vendor Amt. Rcd. Not Invoiced';
            Editable = false;
            FieldClass = FlowField;
        }
<<<<<<< HEAD
        field(33; "Vendor Balance Due"; Decimal)
=======
        field(33; "Vendor Balance Due"; Decimal)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry".Amount WHERE (Vendor No.=FIELD(Vendor Filter),
                                                                           Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                           Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                           Initial Entry Due Date=FIELD(Date Filter),
                                                                           Posting Date=FIELD(UPPERLIMIT(Date Filter)),
                                                                           Currency Code=FIELD(Code)));
            Caption = 'Vendor Balance Due';
            Editable = false;
            FieldClass = FlowField;
        }
<<<<<<< HEAD
        field(34; "Customer Balance (LCY)"; Decimal)
=======
        field(34; "Customer Balance (LCY)"; Decimal)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE (Customer No.=FIELD(Customer Filter),
                                                                                 Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                 Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                 Posting Date=FIELD(Date Filter),
                                                                                 Currency Code=FIELD(Code)));
            Caption = 'Customer Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
<<<<<<< HEAD
        field(35; "Vendor Balance (LCY)"; Decimal)
=======
        field(35; "Vendor Balance (LCY)"; Decimal)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE (Vendor No.=FIELD(Vendor Filter),
                                                                                   Initial Entry Global Dim. 1=FIELD(Global Dimension 1 Filter),
                                                                                   Initial Entry Global Dim. 2=FIELD(Global Dimension 2 Filter),
                                                                                   Posting Date=FIELD(Date Filter),
                                                                                   Currency Code=FIELD(Code)));
            Caption = 'Vendor Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
<<<<<<< HEAD
        field(40; "Realized G/L Gains Account"; Code[20])
=======
        field(40; "Realized G/L Gains Account"; Code[20])
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            Caption = 'Realized G/L Gains Account';
            TableRelation = "G/L Account";
        }
<<<<<<< HEAD
        field(41; "Realized G/L Losses Account"; Code[20])
=======
        field(41; "Realized G/L Losses Account"; Code[20])
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            Caption = 'Realized G/L Losses Account';
            TableRelation = "G/L Account";
        }
<<<<<<< HEAD
        field(44; "Appln. Rounding Precision"; Decimal)
=======
        field(44; "Appln. Rounding Precision"; Decimal)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            Caption = 'Appln. Rounding Precision';
            MinValue = 0;
        }
<<<<<<< HEAD
        field(45; "EMU Currency"; Boolean)
        {
            Caption = 'EMU Currency';
        }
        field(46; "Currency Factor"; Decimal)
=======
        field(45; "EMU Currency"; Boolean)
        {
            Caption = 'EMU Currency';
        }
        field(46; "Currency Factor"; Decimal)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0:5;
            Editable = false;
        }
<<<<<<< HEAD
        field(47; "Residual Gains Account"; Code[20])
=======
        field(47; "Residual Gains Account"; Code[20])
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            Caption = 'Residual Gains Account';
            TableRelation = "G/L Account";
        }
<<<<<<< HEAD
        field(48; "Residual Losses Account"; Code[20])
=======
        field(48; "Residual Losses Account"; Code[20])
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            Caption = 'Residual Losses Account';
            TableRelation = "G/L Account";
        }
<<<<<<< HEAD
        field(50; "Conv. LCY Rndg. Debit Acc."; Code[20])
=======
        field(50; "Conv. LCY Rndg. Debit Acc."; Code[20])
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            Caption = 'Conv. LCY Rndg. Debit Acc.';
            TableRelation = "G/L Account";
        }
<<<<<<< HEAD
        field(51; "Conv. LCY Rndg. Credit Acc."; Code[20])
=======
        field(51; "Conv. LCY Rndg. Credit Acc."; Code[20])
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            Caption = 'Conv. LCY Rndg. Credit Acc.';
            TableRelation = "G/L Account";
        }
<<<<<<< HEAD
        field(52; "Max. VAT Difference Allowed"; Decimal)
=======
        field(52; "Max. VAT Difference Allowed"; Decimal)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            Caption = 'Max. VAT Difference Allowed';
        }
<<<<<<< HEAD
        field(53; "VAT Rounding Type"; Option)
=======
        field(53; "VAT Rounding Type"; Option)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            Caption = 'VAT Rounding Type';
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
        }
<<<<<<< HEAD
        field(54; "Payment Tolerance %"; Decimal)
=======
        field(54; "Payment Tolerance %"; Decimal)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            Caption = 'Payment Tolerance %';
            DecimalPlaces = 0:5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
<<<<<<< HEAD
        field(55; "Max. Payment Tolerance Amount"; Decimal)
=======
        field(55; "Max. Payment Tolerance Amount"; Decimal)
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            AutoFormatExpression = Code;
            AutoFormatType = 1;
            Caption = 'Max. Payment Tolerance Amount';
            Editable = false;
            MinValue = 0;
        }
<<<<<<< HEAD
        field(3010541; "ISO Currency Code"; Code[3])
=======
        field(3010541; "ISO Currency Code"; Code[3])
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            Caption = 'ISO Currency Code';
            CharAllowed = 'AZ';
        }
<<<<<<< HEAD
        field(4006497; Kennzeichen; Text[10])
=======
        field(4006497; Kennzeichen; Text[10])
>>>>>>> 4bb440cd5e9a735e45eff15bec7001464a5622ca
        {
            Description = 'AL.KVK5.0';
        }
    }

    keys
    {
        key(Key1;"Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        CustLedgEntry: Record "21";
        VendLedgEntry: Record "25";
    begin
    end;

    var
        Text000: Label 'must be rounded to the nearest %1';
        Text001: Label '%1 must be rounded to the nearest %2.';
        Text002: Label 'There is one or more opened entries in the %1 table using %2 %3.', Comment='1 either customer or vendor ledger entry table 2 name co currency table 3 currencency code';
}

