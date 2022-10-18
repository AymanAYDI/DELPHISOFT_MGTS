report 50023 "DEL Hyperion V3"
{
    Caption = 'Hyperion V3';
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Account Type" = FILTER(Posting),
                                      "DEL Customer Posting Group" = FILTER(false),
                                      "DEL Vendor Posting Group" = FILTER(false));

            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.")
                                    ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    DimensionSetEntry_Re.RESET();
                    DimensionSetEntry_Re.SETRANGE("Dimension Set ID", "Dimension Set ID");
                    DimensionSetEntry_Re.SETRANGE("Dimension Code", 'ENSEIGNE');
                    IF (DimensionSetEntry_Re.FINDFIRST()) THEN
                        CODEENSEIGNE_TE := DimensionSetEntry_Re."Dimension Value Code"
                    ELSE
                        CODEENSEIGNE_TE := '';


                    ExportHyperionDatas_Re.RESET();
                    ExportHyperionDatas_Re.SETRANGE("Company Code", "G/L Account"."DEL Company Code");
                    ExportHyperionDatas_Re.SETRANGE("No.", "G/L Account"."No.");
                    ExportHyperionDatas_Re.SETRANGE("No. 2", "G/L Account"."No. 2");
                    ExportHyperionDatas_Re.SETRANGE("Reporting Dimension 1 Code", "G/L Account"."DEL Reporting Dimension 1 Code");
                    ExportHyperionDatas_Re.SETRANGE("Reporting Dimension 2 Code", "G/L Account"."DEL Reporting Dimension 2 Code");
                    ExportHyperionDatas_Re.SETRANGE("Dimension ENSEIGNE", CODEENSEIGNE_TE);
                    ExportHyperionDatas_Re.SETRANGE(Name, "G/L Account".Name);
                    IF (ExportHyperionDatas_Re.FINDFIRST()) THEN BEGIN
                        ExportHyperionDatas_Re.Amount := ExportHyperionDatas_Re.Amount + "G/L Entry".Amount;
                        ExportHyperionDatas_Re.MODIFY();
                    END ELSE BEGIN
                        ExportHyperionDatas_Re.INIT();
                        ExportHyperionDatas_Re."Company Code" := "G/L Account"."DEL Company Code";
                        ExportHyperionDatas_Re."No." := "G/L Account"."No.";
                        ExportHyperionDatas_Re."No. 2" := "G/L Account"."No. 2";
                        ExportHyperionDatas_Re."Reporting Dimension 1 Code" := "G/L Account"."DEL Reporting Dimension 1 Code";
                        ExportHyperionDatas_Re."Reporting Dimension 2 Code" := "G/L Account"."DEL Reporting Dimension 2 Code";
                        ExportHyperionDatas_Re."Dimension ENSEIGNE" := CODEENSEIGNE_TE;
                        ExportHyperionDatas_Re.Name := "G/L Account".Name;
                        ExportHyperionDatas_Re.Amount := "G/L Entry".Amount;
                        ExportHyperionDatas_Re."Line No." := 1;
                        ExportHyperionDatas_Re.INSERT();
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF "G/L Account"."Income/Balance" = "G/L Account"."Income/Balance"::"Balance Sheet" THEN
                        "G/L Entry".SETRANGE("G/L Entry"."Posting Date", 0D, EndDate)
                    ELSE
                        "G/L Entry".SETRANGE("G/L Entry"."Posting Date", StartDate, EndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Dialog_Di.UPDATE(1, "G/L Account"."No.");
            end;
        }
        dataitem(AccountCustomer; "G/L Account")
        {
            DataItemTableView = SORTING("Gen. Bus. Posting Group")
                                ORDER(Ascending)
                                WHERE("DEL Customer Posting Group" = FILTER(true));
            dataitem("Customer Posting Group"; "Customer Posting Group")
            {
                DataItemLink = "Receivables Account" = FIELD("No.");
                DataItemTableView = SORTING(Code)
                                    ORDER(Ascending);
                dataitem(Customer; Customer)
                {
                    DataItemLink = "Customer Posting Group" = FIELD(Code);
                    DataItemTableView = SORTING("Customer Posting Group")
                                        ORDER(Ascending);

                    trigger OnAfterGetRecord()
                    begin
                        Customer.CALCFIELDS(Customer."Net Change (LCY)");
                        DefaultDimension_Re_Lo.RESET();
                        DefaultDimension_Re_Lo.SETRANGE("Table ID", 18);
                        DefaultDimension_Re_Lo.SETRANGE("Dimension Code", 'ENSEIGNE');
                        DefaultDimension_Re_Lo.SETRANGE("No.", Customer."No.");
                        IF (DefaultDimension_Re_Lo.FINDFIRST()) THEN
                            CODEENSEIGNE_TE := DefaultDimension_Re_Lo."Dimension Value Code"
                        ELSE
                            CODEENSEIGNE_TE := '';

                        ExportHyperionDatas_Re.RESET();
                        ExportHyperionDatas_Re.SETRANGE("Company Code", AccountCustomer."DEL Company Code");
                        ExportHyperionDatas_Re.SETRANGE("No.", AccountCustomer."No.");
                        ExportHyperionDatas_Re.SETRANGE("No. 2", AccountCustomer."No. 2");
                        ExportHyperionDatas_Re.SETRANGE("Reporting Dimension 1 Code", AccountCustomer."DEL Reporting Dimension 1 Code");
                        ExportHyperionDatas_Re.SETRANGE("Reporting Dimension 2 Code", AccountCustomer."DEL Reporting Dimension 2 Code");
                        ExportHyperionDatas_Re.SETRANGE("Dimension ENSEIGNE", CODEENSEIGNE_TE);
                        ExportHyperionDatas_Re.SETRANGE(Name, AccountCustomer.Name);
                        IF (ExportHyperionDatas_Re.FINDFIRST()) THEN BEGIN
                            ExportHyperionDatas_Re.Amount := ExportHyperionDatas_Re.Amount + Customer."Net Change (LCY)";
                            ExportHyperionDatas_Re.MODIFY();
                        END ELSE BEGIN
                            ExportHyperionDatas_Re.INIT();
                            ExportHyperionDatas_Re."Company Code" := AccountCustomer."DEL Company Code";
                            ExportHyperionDatas_Re."No." := AccountCustomer."No.";
                            ExportHyperionDatas_Re."No. 2" := AccountCustomer."No. 2";
                            ExportHyperionDatas_Re."Reporting Dimension 1 Code" := AccountCustomer."DEL Reporting Dimension 1 Code";
                            ExportHyperionDatas_Re."Reporting Dimension 2 Code" := AccountCustomer."DEL Reporting Dimension 2 Code";
                            ExportHyperionDatas_Re."Dimension ENSEIGNE" := CODEENSEIGNE_TE;
                            ExportHyperionDatas_Re.Name := AccountCustomer.Name;
                            ExportHyperionDatas_Re.Amount := Customer."Net Change (LCY)";
                            ExportHyperionDatas_Re."Line No." := 1;
                            ExportHyperionDatas_Re.INSERT();
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        Customer.SETFILTER(Customer."Date Filter", '..%1', EndDate);
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                Dialog_Di.UPDATE(1, AccountCustomer."No.");
            end;
        }
        dataitem(AccountVendor; "G/L Account")
        {
            DataItemTableView = SORTING("No.")
                                WHERE("DEL Vendor Posting Group" = FILTER(true));
            dataitem("Vendor Posting Group"; "Vendor Posting Group")
            {
                DataItemLink = "Payables Account" = FIELD("No.");
                DataItemTableView = SORTING(Code)
                                    ORDER(Ascending);
                dataitem(Vendor; Vendor)
                {
                    DataItemLink = "Vendor Posting Group" = FIELD(Code);
                    DataItemTableView = SORTING("Vendor Posting Group")
                                        ORDER(Ascending);

                    trigger OnAfterGetRecord()
                    begin
                        Vendor.CALCFIELDS(Vendor."Net Change (LCY)");

                        DefaultDimension_Re_Lo.RESET();
                        DefaultDimension_Re_Lo.SETRANGE("Table ID", 23);
                        DefaultDimension_Re_Lo.SETRANGE("Dimension Code", 'ENSEIGNE');
                        DefaultDimension_Re_Lo.SETRANGE("No.", Vendor."No.");
                        IF (DefaultDimension_Re_Lo.FINDFIRST()) THEN
                            CODEENSEIGNE_TE := DefaultDimension_Re_Lo."Dimension Value Code"
                        ELSE
                            CODEENSEIGNE_TE := '';

                        ExportHyperionDatas_Re.RESET();
                        ExportHyperionDatas_Re.SETRANGE("Company Code", AccountVendor."DEL Company Code");
                        ExportHyperionDatas_Re.SETRANGE("No.", AccountVendor."No.");
                        ExportHyperionDatas_Re.SETRANGE("No. 2", AccountVendor."No. 2");
                        ExportHyperionDatas_Re.SETRANGE("Reporting Dimension 1 Code", AccountVendor."DEL Reporting Dimension 1 Code");
                        ExportHyperionDatas_Re.SETRANGE("Reporting Dimension 2 Code", AccountVendor."DEL Reporting Dimension 2 Code");
                        ExportHyperionDatas_Re.SETRANGE("Dimension ENSEIGNE", CODEENSEIGNE_TE);
                        ExportHyperionDatas_Re.SETRANGE(Name, AccountVendor.Name);
                        IF (ExportHyperionDatas_Re.FINDFIRST()) THEN BEGIN
                            ExportHyperionDatas_Re.Amount := ExportHyperionDatas_Re.Amount - Vendor."Net Change (LCY)";
                            ExportHyperionDatas_Re.MODIFY();
                        END ELSE BEGIN
                            ExportHyperionDatas_Re.INIT();
                            ExportHyperionDatas_Re."Company Code" := AccountVendor."DEL Company Code";
                            ExportHyperionDatas_Re."No." := AccountVendor."No.";
                            ExportHyperionDatas_Re."No. 2" := AccountVendor."No. 2";
                            ExportHyperionDatas_Re."Reporting Dimension 1 Code" := AccountVendor."DEL Reporting Dimension 1 Code";
                            ExportHyperionDatas_Re."Reporting Dimension 2 Code" := AccountVendor."DEL Reporting Dimension 2 Code";
                            ExportHyperionDatas_Re."Dimension ENSEIGNE" := CODEENSEIGNE_TE;
                            ExportHyperionDatas_Re.Name := AccountVendor.Name;
                            ExportHyperionDatas_Re.Amount := -Vendor."Net Change (LCY)";
                            ExportHyperionDatas_Re."Line No." := 1;
                            ExportHyperionDatas_Re.INSERT();
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        Vendor.SETFILTER(Vendor."Date Filter", '..%1', EndDate);
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                Dialog_Di.UPDATE(1, AccountVendor."No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate_Da; StartDate)
                {
                    Caption = 'From';
                }
                field(EndDate_Da; EndDate)
                {
                    Caption = 'To';
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

    trigger OnPostReport()
    var

        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";

        RecRef: RecordRef;

        OStream: OutStream;
    begin
        GeneralSetup_Re.GET();
        ExportHyperionDatas_Re.RESET();
        ExportHyperionDatas_Re.SETRANGE("Line No.", 0);
        IF (ExportHyperionDatas_Re.FINDFIRST()) THEN BEGIN
            StartDate_Loc_Te := DELCHR(ExportHyperionDatas_Re."Company Code", '=', ':/.');
            EndDate_Loc_Te := DELCHR(ExportHyperionDatas_Re."No.", '=', ':/.');
            DateNow_Te := DELCHR(FORMAT(TODAY), '=', ':/.');
            TimeNow_Te := DELCHR(FORMAT(TIME), '=', ':/.');
        END;
        // TODO //FILE 

        TempBlob.CreateOutStream(OStream);
        XMLPORT.Export(50011, OStream);
        FileManagement.BLOBExport(TempBlob, 'HFM_' + GeneralSetup_Re."Hyperion Company Code" + '_' + StartDate_Loc_Te + '_' + EndDate_Loc_Te + '_' + DateNow_Te + '_' + TimeNow_Te + '.csv', true);
        Dialog_Di.CLOSE();

        /*    CustXmlFile_Fi.CREATE(GeneralSetup_Re."Hyperion File" + '\HFM_' + GeneralSetup_Re."Hyperion Company Code" + '_' + StartDate_Loc_Te + '_' + EndDate_Loc_Te + '_' + DateNow_Te + '_' + TimeNow_Te + '.csv');
           CustXmlFile_Fi.CREATEOUTSTREAM(XmlStream_Os);
           XMLPORT.EXPORT(50011, XmlStream_Os);
           CustXmlFile_Fi.CLOSE; */


    end;

    trigger OnPreReport()
    begin
        ExportHyperionDatas_Re.DELETEALL();

        ExportHyperionDatas_Re.INIT();
        ExportHyperionDatas_Re."Line No." := 0;
        ExportHyperionDatas_Re."Company Code" := FORMAT(StartDate);
        ExportHyperionDatas_Re."No." := FORMAT(EndDate);
        GeneralSetup_Re.GET();
        ExportHyperionDatas_Re."No. 2" := GeneralSetup_Re."Hyperion Company Code";
        ExportHyperionDatas_Re.INSERT();
        TextDialog := LOGITEXT0001 + LOGITEXT0002;
        Dialog_Di.OPEN(TextDialog);
    end;

    var
        DefaultDimension_Re_Lo: Record "Default Dimension";
        ExportHyperionDatas_Re: Record "DEL Export Hyperion Datas";
        GeneralSetup_Re: Record "DEL General Setup";
        DimensionSetEntry_Re: Record "Dimension Set Entry";
        CODEENSEIGNE_TE: Code[20];
        EndDate: Date;
        StartDate: Date;
        Dialog_Di: Dialog;
        LOGITEXT0001: Label 'The batch is runing...';
        LOGITEXT0002: Label 'Account no.:  #1########';
        DateNow_Te: Text;
        EndDate_Loc_Te: Text;
        StartDate_Loc_Te: Text;
        TextDialog: Text;
        TimeNow_Te: Text;
}

