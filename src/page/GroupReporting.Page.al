page 50018 "DEL Group Reporting"
{
    Caption = 'Group Reporting';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "G/L Account";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Reporting Dimension 1 Code"; "Reporting Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Reporting Dimension 2 Code"; "Reporting Dimension 2 Code")
                {
                    Editable = false;
                }
                field("No. 2"; Rec."No. 2")
                {
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                field("Income/Balance"; Rec."Income/Balance")
                {
                    Editable = false;
                }
                field("Net Change"; Rec."Net Change")
                {
                    Editable = false;
                    Visible = false;
                }
                field(CalcBalance; CalcBalance)
                {
                    Caption = 'Balance';
                    Editable = false;
                }
            }
            field(DateFilterBalance; DateFilterBalance)
            {
                Caption = 'Date Filter (Balance Sheet) : Ex.   ..31.12.2010';

                trigger OnValidate()
                var
                    ApplicationManagement: Codeunit 1;
                begin
                    Rec.SETFILTER("Date Filter", DateFilterBalance);
                    UpdateAmount;
                end;
            }
            field(DateFilterIncome; DateFilterIncome)
            {
                Caption = 'Date Filter (Income Statement) :  Ex.   01.12.2010..31.12.2010';

                trigger OnValidate()
                var
                    ApplicationManagement: Codeunit 1;
                begin
                    Rec.SETFILTER("Date Filter", DateFilterIncome);
                    UpdateAmount;
                end;
            }
            field(TotalAmount; TotalAmount)
            {
                Caption = 'Total';
                Editable = false;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        GLAccount: Record 5;
    begin
        Rec.SETRANGE("Account Type", Rec."Account Type"::Posting);
        Rec.SETFILTER("Reporting Dimension 1 Code", '<>%1', '');
        Rec.SETFILTER("Reporting Dimension 2 Code", '<>%1', '');
        UpdateAmount;
    end;

    var
        DateFilterBalance: Text[250];
        DateFilterIncome: Text[250];
        BalanceAmount: Decimal;
        TotalAmount: Decimal;
        Filename: File;
        Text000: Label 'File %1 Written.';


    procedure CalcBalance(): Decimal
    begin
        Rec.SETRANGE("Date Filter");

        IF Rec."Income/Balance" = Rec."Income/Balance"::"Income Statement" THEN BEGIN
            IF DateFilterIncome <> '' THEN
                Rec.SETFILTER("Date Filter", DateFilterIncome)
        END ELSE BEGIN
            IF DateFilterBalance <> '' THEN
                Rec.SETFILTER("Date Filter", DateFilterBalance)
        END;

        Rec.CALCFIELDS("Net Change");
        EXIT(Rec."Net Change");
    end;


    procedure UpdateAmount()
    var
        GLAccount: Record 15;
    begin
        TotalAmount := 0;

        GLAccount.SETRANGE("Account Type", Rec."Account Type"::Posting);
        GLAccount.SETFILTER("Reporting Dimension 1 Code", '<>%1', '');
        GLAccount.SETFILTER("Reporting Dimension 2 Code", '<>%1', '');
        IF GLAccount.FINDFIRST THEN
            REPEAT
                GLAccount.SETRANGE("Date Filter");
                IF GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Income Statement" THEN BEGIN
                    IF DateFilterIncome <> '' THEN
                        GLAccount.SETFILTER("Date Filter", DateFilterIncome)
                END ELSE BEGIN
                    IF DateFilterBalance <> '' THEN
                        GLAccount.SETFILTER("Date Filter", DateFilterBalance)
                END;
                GLAccount.CALCFIELDS("Net Change");
                TotalAmount := TotalAmount + GLAccount."Net Change";
            UNTIL GLAccount.NEXT = 0;
    end;


    procedure PrepareFile()
    var
        GeneralSetup: Record 50000;
    begin
        GeneralSetup.GET;

        Filename.TEXTMODE := TRUE;
        Filename.WRITEMODE := TRUE;
        Filename.QUERYREPLACE := TRUE;
        Filename.CREATE(GeneralSetup."Reporting File");
        WriteData;
        Filename.CLOSE();

        MESSAGE(Text000, GeneralSetup."Reporting File");
    end;


    procedure WriteData()
    var
        GLAccount: Record 15;
        ExportData: Text[250];
    begin
        GLAccount.SETRANGE("Account Type", Rec."Account Type"::Posting);
        GLAccount.SETFILTER("Reporting Dimension 1 Code", '<>%1', '');
        GLAccount.SETFILTER("Reporting Dimension 2 Code", '<>%1', '');
        IF GLAccount.FINDFIRST THEN
            REPEAT
                GLAccount.SETRANGE("Date Filter");
                IF GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Income Statement" THEN BEGIN
                    IF DateFilterIncome <> '' THEN
                        GLAccount.SETFILTER("Date Filter", DateFilterIncome)
                END ELSE BEGIN
                    IF DateFilterBalance <> '' THEN
                        GLAccount.SETFILTER("Date Filter", DateFilterBalance)
                END;
                GLAccount.CALCFIELDS("Net Change");
                ExportData := GLAccount."Reporting Dimension 1 Code" + '$' + GLAccount."Reporting Dimension 2 Code" + '$' + GLAccount."No." + '$' +
                              GLAccount."No. 2" + '$' + GLAccount.Name + '$' + FORMAT(GLAccount."Income/Balance") + '$' + FORMAT(GLAccount."Net Change");
                Filename.WRITE(ExportData);
            UNTIL GLAccount.NEXT = 0;
    end;
}

