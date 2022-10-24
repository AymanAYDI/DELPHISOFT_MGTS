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
                field("Reporting Dimension 1 Code"; Rec."DEL Reporting Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Reporting Dimension 2 Code"; Rec."DEL Reporting Dimension 2 Code")
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
                field("Calc Balance"; CalcBalance())
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

                begin
                    Rec.SETFILTER("Date Filter", DateFilterBalance);
                    UpdateAmount();
                end;
            }
            field(DateFilterIncome; DateFilterIncome)
            {
                Caption = 'Date Filter (Income Statement) :  Ex.   01.12.2010..31.12.2010';

                trigger OnValidate()
                var

                begin
                    Rec.SETFILTER("Date Filter", DateFilterIncome);
                    UpdateAmount();
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

    begin
        Rec.SETRANGE("Account Type", Rec."Account Type"::Posting);
        Rec.SETFILTER("DEL Reporting Dimension 1 Code", '<>%1', '');
        Rec.SETFILTER("DEL Reporting Dimension 2 Code", '<>%1', '');
        UpdateAmount();
    end;

    var
        TotalAmount: Decimal;
        Text000: Label 'File %1 Written.';
        DateFilterBalance: Text[250];
        DateFilterIncome: Text[250];
        Filename: File;


    procedure CalcBalance(): Decimal
    begin
        Rec.SETRANGE("Date Filter");

        IF Rec."Income/Balance" = Rec."Income/Balance"::"Income Statement" THEN BEGIN
            IF DateFilterIncome <> '' THEN
                Rec.SETFILTER("Date Filter", DateFilterIncome)
        END ELSE
            IF DateFilterBalance <> '' THEN
                Rec.SETFILTER("Date Filter", DateFilterBalance);

        Rec.CALCFIELDS("Net Change");
        EXIT(Rec."Net Change");
    end;


    procedure UpdateAmount()
    var
        GLAccount: Record "G/L Account";
    begin
        TotalAmount := 0;

        GLAccount.SETRANGE("Account Type", Rec."Account Type"::Posting);
        GLAccount.SETFILTER("DEL Reporting Dimension 1 Code", '<>%1', '');
        GLAccount.SETFILTER("DEL Reporting Dimension 2 Code", '<>%1', '');
        IF GLAccount.FINDFIRST() THEN
            REPEAT
                GLAccount.SETRANGE("Date Filter");
                IF GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Income Statement" THEN BEGIN
                    IF DateFilterIncome <> '' THEN
                        GLAccount.SETFILTER("Date Filter", DateFilterIncome)
                END ELSE
                    IF DateFilterBalance <> '' THEN
                        GLAccount.SETFILTER("Date Filter", DateFilterBalance);
                GLAccount.CALCFIELDS("Net Change");
                TotalAmount := TotalAmount + GLAccount."Net Change";
            UNTIL GLAccount.NEXT() = 0;
    end;


    procedure PrepareFile()
    var
        GeneralSetup: Record "DEL General Setup";
    begin
        GeneralSetup.GET();
        //TODO: methods are not used for cloud dev---------------

        // Filename.TEXTMODE := TRUE;
        // Filename.WRITEMODE := TRUE;
        // Filename.QUERYREPLACE := TRUE;
        // Filename.CREATE(GeneralSetup."Reporting File");
        // WriteData();
        // Filename.CLOSE();





        MESSAGE(Text000, GeneralSetup."Reporting File");
    end;


    procedure WriteData()
    var
        GLAccount: Record "G/L Account";
        ExportData: Text[250];
    begin
        GLAccount.SETRANGE("Account Type", Rec."Account Type"::Posting);
        GLAccount.SETFILTER("DEL Reporting Dimension 1 Code", '<>%1', '');
        GLAccount.SETFILTER("DEL Reporting Dimension 2 Code", '<>%1', '');
        IF GLAccount.FINDFIRST() THEN
            REPEAT
                GLAccount.SETRANGE("Date Filter");
                IF GLAccount."Income/Balance" = GLAccount."Income/Balance"::"Income Statement" THEN BEGIN
                    IF DateFilterIncome <> '' THEN
                        GLAccount.SETFILTER("Date Filter", DateFilterIncome)
                END ELSE
                    IF DateFilterBalance <> '' THEN
                        GLAccount.SETFILTER("Date Filter", DateFilterBalance);
                GLAccount.CALCFIELDS("Net Change");
                ExportData := GLAccount."DEL Reporting Dimension 1 Code" + '$' + GLAccount."DEL Reporting Dimension 2 Code" + '$' + GLAccount."No." + '$' +
                              GLAccount."No. 2" + '$' + GLAccount.Name + '$' + FORMAT(GLAccount."Income/Balance") + '$' + FORMAT(GLAccount."Net Change");
            //TODO Filename.WRITE(ExportData);
            UNTIL GLAccount.NEXT() = 0;
    end;
}

