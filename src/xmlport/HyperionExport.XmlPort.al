xmlport 50014 "DEL Hyperion Export"
{
    Caption = 'Hyperion Export';
    Direction = Export;
    FieldSeparator = ';';
    Format = VariableText;
    FormatEvaluate = Xml;
    TableSeparator = '<NewLine>';
    TextEncoding = UTF8;

    schema
    {
        textelement(HyperionExport)
        {
            tableelement(Header; Integer)
            {
                SourceTableView = SORTING(Number)
                                  ORDER(Ascending)
                                  WHERE(Number = CONST(1));
                XmlName = 'Header';
                textelement(YearCpt)
                {
                }
                textelement(PeriodCpt)
                {
                }
                textelement(LocalEntityCpt)
                {
                }
                textelement(LocalAccountCpt)
                {
                }
                textelement(LocalCostCenterCpt)
                {
                }
                textelement(LocalICPCpt)
                {
                }
                textelement(LocalDetailsCpt)
                {
                }
                textelement(LocalAmountCpt)
                {
                }
                textelement(LocalDescrCpt)
                {
                }
                textelement(MobiciaEntityCpt)
                {
                }
                textelement(MobiviaAccountCpt)
                {
                }
                textelement(MobiviaCostCenterCpt)
                {
                }
                textelement(MobiviaICPCpt)
                {
                }
                textelement(MobiviaDetailCpt)
                {
                }
                textelement(MOBIVIADetailOBJCpt)
                {
                }
                textelement(MOBIVIADetailPLANCpt)
                {
                }
                textelement(MobiviaAccountDescCpt)
                {
                }
                textelement(PrevisionnalAccountCpt)
                {
                }
                textelement(MobiviaFlowCpt)
                {
                }
                textelement(AmountCpt)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    YearCpt := Text005;
                    PeriodCpt := Text006;
                    LocalEntityCpt := Text007;
                    LocalAccountCpt := Text008;
                    LocalCostCenterCpt := Text009;
                    LocalICPCpt := Text010;
                    LocalDetailsCpt := Text011;
                    LocalAmountCpt := Text012;
                    LocalDescrCpt := Text013;
                    MobiciaEntityCpt := Text014;
                    MobiviaAccountCpt := Text015;
                    MobiviaCostCenterCpt := Text016;
                    MobiviaICPCpt := Text017;
                    MobiviaDetailCpt := Text018;
                    MOBIVIADetailOBJCpt := Text023;
                    MOBIVIADetailPLANCpt := Text024;
                    MobiviaAccountDescCpt := Text019;
                    PrevisionnalAccountCpt := Text020;
                    MobiviaFlowCpt := Text021;
                    AmountCpt := Text022;
                end;
            }
            tableelement("DEL Export Hyperion Datas"; "DEL Export Hyperion Datas")
            {
                SourceTableView = SORTING("Line No.", "Company Code", "No.", "Dimension ENSEIGNE")
                                  ORDER(Ascending);
                XmlName = 'ExportHyperionDatas';
                textelement(YearValue)
                {
                }
                textelement(PeriodValue)
                {
                }
                textelement(LocalEntityValue)
                {
                }
                fieldelement(LocalAccountValue; "DEL Export Hyperion Datas"."No.")
                {
                }
                textelement(LocalCostCenterValue)
                {
                }
                textelement(LocalICPValue)
                {
                }
                textelement(LocalDetailsValue)
                {
                }
                fieldelement(LocalAmountValue; "DEL Export Hyperion Datas".Amount)
                {
                }
                textelement(LocalDescrValue)
                {
                }
                fieldelement(MobiciaEntityValue; "DEL Export Hyperion Datas"."Company Code")
                {
                }
                fieldelement(MobiviaAccountValue; "DEL Export Hyperion Datas"."No. 2")
                {
                }
                fieldelement(MobiviaCostCenterValue; "DEL Export Hyperion Datas"."Reporting Dimension 1 Code")
                {
                }
                fieldelement(MobiviaICPValue; "DEL Export Hyperion Datas"."Dimension ENSEIGNE")
                {
                }
                textelement(MobiviaDetailValue)
                {
                }
                textelement(MOBIVIADetailOBJValue)
                {
                }
                textelement(MOBIVIADetailPLANValue)
                {
                }
                textelement(MobiviaAccountDescValue)
                {
                }
                textelement(PrevisionnalAccountValue)
                {
                }
                textelement(MobiviaFlowValue)
                {
                }
                fieldelement(AmountValue; "DEL Export Hyperion Datas".Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    IF NOT GLAcc.GET("DEL Export Hyperion Datas"."No.") THEN
                        GLAcc.INIT();

                    YearValue := FORMAT(DATE2DMY(ToDate, 3));
                    PeriodValue := FORMAT(DATE2DMY(ToDate, 2));
                    LocalEntityValue := '';
                    LocalCostCenterValue := '';
                    LocalICPValue := '';
                    LocalDetailsValue := '';
                    LocalDescrValue := '';
                    MobiviaDetailValue := GLAcc."DEL Mobivia Detail";
                    MobiviaAccountDescValue := '';
                    PrevisionnalAccountValue := '';
                    MOBIVIADetailOBJValue := '';
                    MOBIVIADetailPLANValue := '';

                    IF GLAcc."Income/Balance" = GLAcc."Income/Balance"::"Income Statement" THEN
                        MobiviaFlowValue := Text025
                    ELSE
                        MobiviaFlowValue := Text003;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(FromDateF; FromDate)
                    {
                        Caption = 'From date';
                    }
                    field(ToDateF; ToDate)
                    {
                        Caption = 'To date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin

        Window.CLOSE();

        currXMLport.FILENAME := GeneralSetup."Hyperion File" +
                                STRSUBSTNO(Text004, GeneralSetup."Hyperion Company Code", DELCHR(FORMAT(FromDate, 0, '<Day,2>.<Month,2>.<Year>'), '=', '.'),
                                DELCHR(FORMAT(ToDate, 0, '<Day,2>.<Month,2>.<Year>'), '=', '.'), DELCHR(FORMAT(TODAY, 0, '<Day,2>.<Month,2>.<Year>'), '=', '.'),
                                DELCHR(FORMAT(TIME, 0, '<hours24>:<minutes,2>:<seconds,2>'), '=', ':'));

        ExportHyperionDatas.RESET();
        ExportHyperionDatas.DELETEALL();
    end;

    trigger OnPreXmlPort()
    begin

        IF NOT GeneralSetup.GET() THEN
            GeneralSetup.INIT();

        IF NOT GLSetup.GET() THEN
            GLSetup.INIT();

        ExportHyperionDatas.RESET();
        ExportHyperionDatas.DELETEALL();

        Window.OPEN(Text002);

        GLAcc.RESET();
        GLAcc.SETRANGE("DEL Customer Posting Group", FALSE);
        GLAcc.SETRANGE("DEL Vendor Posting Group", FALSE);
        GLAcc.SETRANGE("Account Type", GLAcc."Account Type"::Posting);
        IF GLAcc.FINDSET() THEN
            REPEAT
                Window.UPDATE(1, GLAcc."No.");
                GetGLEntryValues(GLAcc);
            UNTIL GLAcc.NEXT() = 0;

        GLAcc.RESET();
        GLAcc.SETRANGE("DEL Customer Posting Group", TRUE);
        IF GLAcc.FINDSET() THEN
            REPEAT
                Window.UPDATE(1, GLAcc."No.");
                GetCustomerValues(GLAcc);
            UNTIL GLAcc.NEXT() = 0;

        GLAcc.RESET();
        GLAcc.SETRANGE("DEL Vendor Posting Group", TRUE);
        IF GLAcc.FINDSET() THEN
            REPEAT
                Window.UPDATE(1, GLAcc."No.");
                GetVendorValues(GLAcc);
            UNTIL GLAcc.NEXT() = 0;
    end;

    var
        ExportHyperionDatas: Record "DEL Export Hyperion Datas";
        GeneralSetup: Record "DEL General Setup";
        DimSetEntry: Record "Dimension Set Entry";
        GLAcc: Record "G/L Account";
        GLSetup: Record "General Ledger Setup";
        FromDate: Date;
        ToDate: Date;
        Window: Dialog;
        Text001: Label '..%1';
        Text002: Label 'The batch is runing...\\Account no.:  #1########';
        Text003: Label 'CLO';
        Text004: Label 'FDM_%1_%2_%3_%4_%5.csv';
        Text005: Label 'Year';
        Text006: Label 'Period';
        Text007: Label 'Local Entity';
        Text008: Label 'Local Account';
        Text009: Label 'Local Cost Center';
        Text010: Label 'Local ICP';
        Text011: Label 'Local Details';
        Text012: Label 'Local Amount';
        Text013: Label 'Local Description';
        Text014: Label 'Mobicia Entity';
        Text015: Label 'Mobivia Account';
        Text016: Label 'Mobivia Cost Center';
        Text017: Label 'Mobivia ICP';
        Text018: Label 'Mobivia Detail';
        Text019: Label 'Mobivia Account Desription';
        Text020: Label 'Provisional Account';
        Text021: Label 'Mobivia Flow';
        Text022: Label 'Amount';
        Text023: Label 'MOBIVIA Detail OBJ';
        Text024: Label 'MOBIVIA Detail PLAN';
        Text025: Label '[None]';

    local procedure GetGLEntryValues(GLAccRec: Record "G/L Account")
    var
        GLEntry: Record "G/L Entry";
        ShortcutDim3Code: Code[20];
    begin

        GLEntry.RESET();
        GLEntry.SETRANGE("G/L Account No.", GLAccRec."No.");

        IF GLAccRec."Income/Balance" = GLAccRec."Income/Balance"::"Balance Sheet" THEN
            GLEntry.SETRANGE("Posting Date", 0D, ToDate)
        ELSE
            GLEntry.SETRANGE("Posting Date", FromDate, ToDate);

        IF GLEntry.FINDSET() THEN
            REPEAT
                DimSetEntry.RESET();
                DimSetEntry.SETRANGE("Dimension Set ID", GLEntry."Dimension Set ID");
                DimSetEntry.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                IF (DimSetEntry.FINDFIRST()) THEN BEGIN
                    ShortcutDim3Code := DimSetEntry."Dimension Value Code";
                END ELSE BEGIN
                    ShortcutDim3Code := '';
                END;

                ExportHyperionDatas.RESET();
                ExportHyperionDatas.SETRANGE("Company Code", GLAccRec."DEL Company Code");
                ExportHyperionDatas.SETRANGE("No.", GLAccRec."No.");
                ExportHyperionDatas.SETRANGE("No. 2", GLAccRec."No. 2");
                ExportHyperionDatas.SETRANGE("Reporting Dimension 1 Code", GLAccRec."DEL Reporting Dimension 1 Code");
                ExportHyperionDatas.SETRANGE("Reporting Dimension 2 Code", GLAccRec."DEL Reporting Dimension 2 Code");
                ExportHyperionDatas.SETRANGE("Dimension ENSEIGNE", ShortcutDim3Code);
                ExportHyperionDatas.SETRANGE(Name, GLAccRec.Name);
                IF (ExportHyperionDatas.FINDFIRST()) THEN BEGIN
                    ExportHyperionDatas.Amount := ExportHyperionDatas.Amount + GLEntry.Amount * GetSign(GLAccRec);
                    ExportHyperionDatas.MODIFY();
                END ELSE BEGIN
                    ExportHyperionDatas.INIT();
                    ExportHyperionDatas."Company Code" := GeneralSetup."Hyperion Company Code";
                    ExportHyperionDatas."No." := GLAccRec."No.";
                    ExportHyperionDatas."No. 2" := GLAccRec."No. 2";
                    ExportHyperionDatas."Reporting Dimension 1 Code" := GLAccRec."DEL Reporting Dimension 1 Code";
                    ExportHyperionDatas."Reporting Dimension 2 Code" := GLAccRec."DEL Reporting Dimension 2 Code";
                    ExportHyperionDatas."Dimension ENSEIGNE" := ShortcutDim3Code;
                    ExportHyperionDatas.Name := GLAccRec.Name;
                    ExportHyperionDatas.Amount := GLEntry.Amount * GetSign(GLAccRec);
                    ExportHyperionDatas."Line No." := 1;
                    ExportHyperionDatas.INSERT();
                END;
            UNTIL GLEntry.NEXT() = 0;
    end;

    local procedure GetCustomerValues(GLAccRec: Record "G/L Account")
    var
        Customer: Record Customer;
        CustPostGroup: Record "Customer Posting Group";
        DefaultDim: Record "Default Dimension";
        ShortcutDim3Code: Code[20];
    begin

        CustPostGroup.RESET();
        CustPostGroup.SETRANGE("Receivables Account", GLAccRec."No.");
        IF CustPostGroup.FINDSET() THEN
            REPEAT
                Customer.RESET();
                Customer.SETRANGE("Customer Posting Group", CustPostGroup.Code);
                Customer.SETFILTER("Date Filter", STRSUBSTNO(Text001, ToDate));
                IF Customer.FINDSET() THEN
                    REPEAT
                        Customer.CALCFIELDS(Customer."Net Change (LCY)");

                        DefaultDim.RESET();
                        DefaultDim.SETRANGE("Table ID", DATABASE::Customer);
                        DefaultDim.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                        DefaultDim.SETRANGE("No.", Customer."No.");
                        IF (DefaultDim.FINDFIRST()) THEN BEGIN
                            ShortcutDim3Code := DefaultDim."Dimension Value Code";
                        END ELSE
                            ShortcutDim3Code := '';

                        ExportHyperionDatas.RESET();
                        ExportHyperionDatas.SETRANGE("Company Code", GLAccRec."DEL Company Code");
                        ExportHyperionDatas.SETRANGE("No.", GLAccRec."No.");
                        ExportHyperionDatas.SETRANGE("No. 2", GLAccRec."No. 2");
                        ExportHyperionDatas.SETRANGE("Reporting Dimension 1 Code", GLAccRec."DEL Reporting Dimension 1 Code");
                        ExportHyperionDatas.SETRANGE("Reporting Dimension 2 Code", GLAccRec."DEL Reporting Dimension 2 Code");
                        ExportHyperionDatas.SETRANGE("Dimension ENSEIGNE", ShortcutDim3Code);
                        ExportHyperionDatas.SETRANGE(Name, GLAccRec.Name);
                        IF (ExportHyperionDatas.FINDFIRST()) THEN BEGIN
                            ExportHyperionDatas.Amount := ExportHyperionDatas.Amount + Customer."Net Change (LCY)" * GetSign(GLAccRec);
                            ExportHyperionDatas.MODIFY();
                        END ELSE BEGIN
                            ExportHyperionDatas.INIT();
                            ExportHyperionDatas."Company Code" := GeneralSetup."Hyperion Company Code";
                            ExportHyperionDatas."No." := GLAccRec."No.";
                            ExportHyperionDatas."No. 2" := GLAccRec."No. 2";
                            ExportHyperionDatas."Reporting Dimension 1 Code" := GLAccRec."DEL Reporting Dimension 1 Code";
                            ExportHyperionDatas."Reporting Dimension 2 Code" := GLAccRec."DEL Reporting Dimension 2 Code";
                            ExportHyperionDatas."Dimension ENSEIGNE" := ShortcutDim3Code;
                            ExportHyperionDatas.Name := GLAccRec.Name;
                            ExportHyperionDatas.Amount := Customer."Net Change (LCY)" * GetSign(GLAccRec);
                            ExportHyperionDatas."Line No." := 1;
                            ExportHyperionDatas.INSERT();
                        END;
                    UNTIL Customer.NEXT() = 0;
            UNTIL CustPostGroup.NEXT() = 0;
    end;

    local procedure GetVendorValues(GLAccRec: Record "G/L Account")
    var
        DefaultDim: Record "Default Dimension";
        Vendor: Record Vendor;
        VendPostGroup: Record "Vendor Posting Group";
        ShortcutDim3Code: Code[20];
    begin

        VendPostGroup.RESET();
        VendPostGroup.SETRANGE("Payables Account", GLAccRec."No.");
        IF VendPostGroup.FINDSET() THEN
            REPEAT
                Vendor.RESET();
                Vendor.SETRANGE("Vendor Posting Group", VendPostGroup.Code);
                Vendor.SETFILTER("Date Filter", STRSUBSTNO(Text001, ToDate));
                IF Vendor.FINDSET() THEN
                    REPEAT
                        Vendor.CALCFIELDS(Vendor."Net Change (LCY)");

                        DefaultDim.RESET();
                        DefaultDim.SETRANGE("Table ID", DATABASE::Vendor);
                        DefaultDim.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                        DefaultDim.SETRANGE("No.", Vendor."No.");
                        IF (DefaultDim.FINDFIRST()) THEN BEGIN
                            ShortcutDim3Code := DefaultDim."Dimension Value Code";
                        END ELSE
                            ShortcutDim3Code := '';

                        ExportHyperionDatas.RESET();
                        ExportHyperionDatas.SETRANGE("Company Code", GLAccRec."DEL Company Code");
                        ExportHyperionDatas.SETRANGE("No.", GLAccRec."No.");
                        ExportHyperionDatas.SETRANGE("No. 2", GLAccRec."No. 2");
                        ExportHyperionDatas.SETRANGE("Reporting Dimension 1 Code", GLAccRec."DEL Reporting Dimension 1 Code");
                        ExportHyperionDatas.SETRANGE("Reporting Dimension 2 Code", GLAccRec."DEL Reporting Dimension 2 Code");
                        ExportHyperionDatas.SETRANGE("Dimension ENSEIGNE", ShortcutDim3Code);
                        ExportHyperionDatas.SETRANGE(Name, GLAccRec.Name);
                        IF (ExportHyperionDatas.FINDFIRST()) THEN BEGIN
                            ExportHyperionDatas.Amount := ExportHyperionDatas.Amount - Vendor."Net Change (LCY)" * GetSign(GLAccRec);
                            ExportHyperionDatas.MODIFY();
                        END ELSE BEGIN
                            ExportHyperionDatas.INIT();
                            ExportHyperionDatas."Company Code" := GeneralSetup."Hyperion Company Code";
                            ExportHyperionDatas."No." := GLAccRec."No.";
                            ExportHyperionDatas."No. 2" := GLAccRec."No. 2";
                            ExportHyperionDatas."Reporting Dimension 1 Code" := GLAccRec."DEL Reporting Dimension 1 Code";
                            ExportHyperionDatas."Reporting Dimension 2 Code" := GLAccRec."DEL Reporting Dimension 2 Code";
                            ExportHyperionDatas."Dimension ENSEIGNE" := ShortcutDim3Code;
                            ExportHyperionDatas.Name := GLAccRec.Name;
                            ExportHyperionDatas.Amount := -Vendor."Net Change (LCY)" * GetSign(GLAccRec);
                            ExportHyperionDatas."Line No." := 1;
                            ExportHyperionDatas.INSERT();
                        END;
                    UNTIL Vendor.NEXT() = 0;
            UNTIL VendPostGroup.NEXT() = 0;
    end;

    local procedure GetSign(var pGlAccount: Record "G/L Account"): Decimal
    begin

        CASE pGlAccount."DEL Hyperion Export Sign" OF
            pGlAccount."DEL Hyperion Export Sign"::"Positive Sign":
                EXIT(0.001);
            pGlAccount."DEL Hyperion Export Sign"::"Negative Sign":
                EXIT(-0.001);
        END;
    end;
}

