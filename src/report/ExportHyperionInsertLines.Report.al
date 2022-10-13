report 50021 "Export Hyperion Insert Lines"
{
    // +-------------------------------------------------------------------------------------------------+
    // | Logico SA                                                                                       |
    // | Status: 10.12.13                                                                                |
    // | Customer: NGTS                                                                                  |
    // +-------------------------------------------------------------------------------------------------+
    // 
    // Requirement     UserID   Date       Where                                   Description
    // -----------------------------------------------------------------------------------------------------
    // THS             THS     10.12.13    -                                       Object Creation
    //                         12.12.13    -                                       Finition
    // THS130114       THS     13.01.14    -                                       Correction (Sauving without confirm. message)
    // THS280114       THS     28.01.14    OnPostReport()                          If balance sheet then take rec since begining
    // T-00640         NOH     30.01.14                                            V2

    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate_Da; StartDate_Da)
                {
                    Caption = 'From';
                }
                field(EndDate_Da; EndDate_Da)
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
        Dialog_Di: Dialog;
        DefaultDimension_Re_Lo: Record "352";
        CustomerAcount_Re_Lo: Record "92";
        VendorAccount_Re_Lo: Record "93";
    begin
        Dialog_Di.OPEN(LOGITEXT0001);

        ExportHyperionDatas_Re.RESET;
        ExportHyperionDatas_Re.DELETEALL;

        AccountingPeriod_Re.RESET;
        AccountingPeriod_Re.SETFILTER("Starting Date", '<=' + FORMAT(StartDate_Da));
        AccountingPeriod_Re.SETRANGE("New Fiscal Year", TRUE);
        IF (AccountingPeriod_Re.FINDLAST) THEN
            StartPeriodeDate_Da := AccountingPeriod_Re."Starting Date";

        ExportHyperionDatas_Re.INIT;
        ExportHyperionDatas_Re."Line No." := 0;
        ExportHyperionDatas_Re."Company Code" := FORMAT(StartDate_Da);
        ExportHyperionDatas_Re."No." := FORMAT(EndDate_Da);

        GeneralSetup_Re.GET;
        ExportHyperionDatas_Re."No. 2" := GeneralSetup_Re."Hyperion Company Code";

        ExportHyperionDatas_Re.INSERT;


        GLAccount_Re.RESET;
        GLAccount_Re.SETRANGE("Account Type", GLAccount_Re."Account Type"::Posting);
        IF (GLAccount_Re.FINDSET) THEN BEGIN
            REPEAT
                GLEntry_Re.RESET;
                GLEntry_Re.SETRANGE("G/L Account No.", GLAccount_Re."No.");

                IF (GLAccount_Re."Income/Balance" = GLAccount_Re."Income/Balance"::"Balance Sheet") THEN BEGIN
                    //START THS280114
                    //OLD// GLEntry_Re.SETRANGE("Posting Date",StartPeriodeDate_Da,EndDate_Da);
                    GLEntry_Re.SETRANGE("Posting Date", 0D, EndDate_Da);
                    //STOP THS280114
                END ELSE BEGIN
                    GLEntry_Re.SETRANGE("Posting Date", StartDate_Da, EndDate_Da);
                END;

                IF (GLEntry_Re.FINDSET) THEN BEGIN
                    REPEAT
                        //T-00640 begin
                        IF (GLEntry_Re."Source Type" = GLEntry_Re."Source Type"::Customer) THEN BEGIN
                            DefaultDimension_Re_Lo.RESET;
                            DefaultDimension_Re_Lo.SETRANGE("Table ID", 18);
                            DefaultDimension_Re_Lo.SETRANGE("Dimension Code", 'ENSEIGNE');
                            DefaultDimension_Re_Lo.SETRANGE("No.", GLEntry_Re."Source No.");
                            IF (DefaultDimension_Re_Lo.FINDFIRST) THEN BEGIN
                                CODEENSEIGNE_TE := DefaultDimension_Re_Lo."Dimension Value Code";
                            END ELSE BEGIN
                                CODEENSEIGNE_TE := '';
                            END;
                        END ELSE
                            IF (GLEntry_Re."Source Type" = GLEntry_Re."Source Type"::Vendor) THEN BEGIN
                                DefaultDimension_Re_Lo.SETRANGE("Table ID", 23);
                                DefaultDimension_Re_Lo.SETRANGE("Dimension Code", 'ENSEIGNE');
                                DefaultDimension_Re_Lo.SETRANGE("No.", GLEntry_Re."Source No.");
                                IF (DefaultDimension_Re_Lo.FINDFIRST) THEN BEGIN
                                    CODEENSEIGNE_TE := DefaultDimension_Re_Lo."Dimension Value Code";
                                END ELSE BEGIN
                                    CODEENSEIGNE_TE := '';
                                END;
                            END ELSE BEGIN
                                //T-00640 end
                                DimensionSetEntry_Re.RESET;
                                DimensionSetEntry_Re.SETRANGE("Dimension Set ID", GLEntry_Re."Dimension Set ID");
                                DimensionSetEntry_Re.SETRANGE("Dimension Code", 'ENSEIGNE');
                                IF (DimensionSetEntry_Re.FINDFIRST) THEN BEGIN
                                    CODEENSEIGNE_TE := DimensionSetEntry_Re."Dimension Value Code";
                                END ELSE BEGIN
                                    CODEENSEIGNE_TE := '';
                                END;
                            END;
                        ExportHyperionDatas_Re.RESET;
                        ExportHyperionDatas_Re.SETRANGE("Company Code", GLAccount_Re."Company Code");
                        ExportHyperionDatas_Re.SETRANGE("No.", GLAccount_Re."No.");
                        ExportHyperionDatas_Re.SETRANGE("No. 2", GLAccount_Re."No. 2");
                        ExportHyperionDatas_Re.SETRANGE("Reporting Dimension 1 Code", GLAccount_Re."Reporting Dimension 1 Code");
                        ExportHyperionDatas_Re.SETRANGE("Reporting Dimension 2 Code", GLAccount_Re."Reporting Dimension 2 Code");
                        ExportHyperionDatas_Re.SETRANGE("Dimension ENSEIGNE", CODEENSEIGNE_TE);
                        ExportHyperionDatas_Re.SETRANGE(Name, GLAccount_Re.Name);
                        IF (ExportHyperionDatas_Re.FINDFIRST) THEN BEGIN
                            ExportHyperionDatas_Re.Amount := ExportHyperionDatas_Re.Amount + GLEntry_Re.Amount;
                            ExportHyperionDatas_Re.MODIFY;
                        END ELSE BEGIN
                            ExportHyperionDatas_Re.INIT;
                            ExportHyperionDatas_Re."Company Code" := GLAccount_Re."Company Code";
                            ExportHyperionDatas_Re."No." := GLAccount_Re."No.";
                            ExportHyperionDatas_Re."No. 2" := GLAccount_Re."No. 2";
                            ExportHyperionDatas_Re."Reporting Dimension 1 Code" := GLAccount_Re."Reporting Dimension 1 Code";
                            ExportHyperionDatas_Re."Reporting Dimension 2 Code" := GLAccount_Re."Reporting Dimension 2 Code";
                            ExportHyperionDatas_Re."Dimension ENSEIGNE" := CODEENSEIGNE_TE;
                            ExportHyperionDatas_Re.Name := GLAccount_Re.Name;
                            ExportHyperionDatas_Re.Amount := GLEntry_Re.Amount;
                            ExportHyperionDatas_Re."Line No." := 1;
                            ExportHyperionDatas_Re.INSERT;
                        END;
                    UNTIL GLEntry_Re.NEXT = 0;
                END;
            UNTIL GLAccount_Re.NEXT = 0;
        END;
        COMMIT;
        Dialog_Di.CLOSE;

        //THS130114 START
        //OLD//ExportHyperionFile_XP.RUN;

        GeneralSetup_Re.GET;
        ExportHyperionDatas_Re.RESET;
        ExportHyperionDatas_Re.SETRANGE("Line No.", 0);
        IF (ExportHyperionDatas_Re.FINDFIRST) THEN BEGIN
            StartDate_Loc_Te := DELCHR(ExportHyperionDatas_Re."Company Code", '=', ':/.');
            EndDate_Loc_Te := DELCHR(ExportHyperionDatas_Re."No.", '=', ':/.');
            DateNow_Te := DELCHR(FORMAT(TODAY), '=', ':/.');
            TimeNow_Te := DELCHR(FORMAT(TIME), '=', ':/.');
        END;

        CustXmlFile_Fi.CREATE(GeneralSetup_Re."Hyperion File" + '\HFM_' + GeneralSetup_Re."Hyperion Company Code" + '_' + StartDate_Loc_Te + '_' + EndDate_Loc_Te + '_' + DateNow_Te + '_' + TimeNow_Te + '.csv');
        CustXmlFile_Fi.CREATEOUTSTREAM(XmlStream_Os);
        XMLPORT.EXPORT(50011, XmlStream_Os);
        CustXmlFile_Fi.CLOSE;
        //THS130114 STOP
    end;

    var
        ExportHyperionDatas_Re: Record "50049";
        StartDate_Da: Date;
        StartPeriodeDate_Da: Date;
        EndDate_Da: Date;
        GLAccount_Re: Record "15";
        GLEntry_Re: Record "17";
        DimensionSetEntry_Re: Record "480";
        CODEENSEIGNE_TE: Text;
        ExportHyperionFile_XP: XMLport "50011";
        CSVFile_Fi: File;
        CSVOutStream_OutS: OutStream;
        AccountingPeriod_Re: Record "50";
        LOGITEXT0001: Label 'The batch is runing...';
        GeneralSetup_Re: Record "50000";
        XmlStream_Os: OutStream;
        CustXmlFile_Fi: File;
        StartDate_Loc_Te: Text;
        EndDate_Loc_Te: Text;
        TimeNow_Te: Text;
        DateNow_Te: Text;
}

