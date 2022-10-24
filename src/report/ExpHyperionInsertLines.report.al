report 50021 "DEL Exp. Hyperion Insert Lines"
{

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
        DefaultDimension_Re_Lo: Record "Default Dimension";
        Dialog_Di: Dialog;

    begin
        Dialog_Di.OPEN(LOGITEXT0001);

        ExportHyperionDatas_Re.RESET();
        ExportHyperionDatas_Re.DELETEALL();

        AccountingPeriod_Re.RESET();
        AccountingPeriod_Re.SETFILTER("Starting Date", '<=' + FORMAT(StartDate_Da));
        AccountingPeriod_Re.SETRANGE("New Fiscal Year", TRUE);
        IF (AccountingPeriod_Re.FINDLAST()) THEN
            StartPeriodeDate_Da := AccountingPeriod_Re."Starting Date";

        ExportHyperionDatas_Re.INIT();
        ExportHyperionDatas_Re."Line No." := 0;
        ExportHyperionDatas_Re."Company Code" := FORMAT(StartDate_Da);
        ExportHyperionDatas_Re."No." := FORMAT(EndDate_Da);

        GeneralSetup_Re.GET();
        ExportHyperionDatas_Re."No. 2" := GeneralSetup_Re."Hyperion Company Code";

        ExportHyperionDatas_Re.INSERT();


        GLAccount_Re.RESET();
        GLAccount_Re.SETRANGE("Account Type", GLAccount_Re."Account Type"::Posting);
        IF (GLAccount_Re.FINDSET()) THEN
            REPEAT
                GLEntry_Re.RESET();
                GLEntry_Re.SETRANGE("G/L Account No.", GLAccount_Re."No.");

                IF (GLAccount_Re."Income/Balance" = GLAccount_Re."Income/Balance"::"Balance Sheet") THEN
                    GLEntry_Re.SETRANGE("Posting Date", 0D, EndDate_Da)
                ELSE
                    GLEntry_Re.SETRANGE("Posting Date", StartDate_Da, EndDate_Da);

                IF (GLEntry_Re.FINDSET()) THEN
                    REPEAT
                        IF (GLEntry_Re."Source Type" = GLEntry_Re."Source Type"::Customer) THEN BEGIN
                            DefaultDimension_Re_Lo.RESET();
                            DefaultDimension_Re_Lo.SETRANGE("Table ID", 18);
                            DefaultDimension_Re_Lo.SETRANGE("Dimension Code", 'ENSEIGNE');
                            DefaultDimension_Re_Lo.SETRANGE("No.", GLEntry_Re."Source No.");
                            IF (DefaultDimension_Re_Lo.FINDFIRST()) THEN
                                CODEENSEIGNE_TE := DefaultDimension_Re_Lo."Dimension Value Code"
                            ELSE
                                CODEENSEIGNE_TE := '';
                        END ELSE
                            IF (GLEntry_Re."Source Type" = GLEntry_Re."Source Type"::Vendor) THEN BEGIN
                                DefaultDimension_Re_Lo.SETRANGE("Table ID", 23);
                                DefaultDimension_Re_Lo.SETRANGE("Dimension Code", 'ENSEIGNE');
                                DefaultDimension_Re_Lo.SETRANGE("No.", GLEntry_Re."Source No.");
                                IF (DefaultDimension_Re_Lo.FINDFIRST()) THEN
                                    CODEENSEIGNE_TE := DefaultDimension_Re_Lo."Dimension Value Code"
                                ELSE
                                    CODEENSEIGNE_TE := '';
                            END ELSE BEGIN
                                DimensionSetEntry_Re.RESET();
                                DimensionSetEntry_Re.SETRANGE("Dimension Set ID", GLEntry_Re."Dimension Set ID");
                                DimensionSetEntry_Re.SETRANGE("Dimension Code", 'ENSEIGNE');
                                IF (DimensionSetEntry_Re.FINDFIRST()) THEN
                                    CODEENSEIGNE_TE := DimensionSetEntry_Re."Dimension Value Code"
                                ELSE
                                    CODEENSEIGNE_TE := '';
                            END;
                        ExportHyperionDatas_Re.RESET();
                        ExportHyperionDatas_Re.SETRANGE("Company Code", GLAccount_Re."DEL Company Code");
                        ExportHyperionDatas_Re.SETRANGE("No.", GLAccount_Re."No.");
                        ExportHyperionDatas_Re.SETRANGE("No. 2", GLAccount_Re."No. 2");
                        ExportHyperionDatas_Re.SETRANGE("Reporting Dimension 1 Code", GLAccount_Re."DEL Reporting Dimension 1 Code");
                        ExportHyperionDatas_Re.SETRANGE("Reporting Dimension 2 Code", GLAccount_Re."DEL Reporting Dimension 2 Code");
                        ExportHyperionDatas_Re.SETRANGE("Dimension ENSEIGNE", CODEENSEIGNE_TE);
                        ExportHyperionDatas_Re.SETRANGE(Name, GLAccount_Re.Name);
                        IF (ExportHyperionDatas_Re.FINDFIRST()) THEN BEGIN
                            ExportHyperionDatas_Re.Amount := ExportHyperionDatas_Re.Amount + GLEntry_Re.Amount;
                            ExportHyperionDatas_Re.MODIFY();
                        END ELSE BEGIN
                            ExportHyperionDatas_Re.INIT();
                            ExportHyperionDatas_Re."Company Code" := GLAccount_Re."DEL Company Code";
                            ExportHyperionDatas_Re."No." := GLAccount_Re."No.";
                            ExportHyperionDatas_Re."No. 2" := GLAccount_Re."No. 2";
                            ExportHyperionDatas_Re."Reporting Dimension 1 Code" := GLAccount_Re."DEL Reporting Dimension 1 Code";
                            ExportHyperionDatas_Re."Reporting Dimension 2 Code" := GLAccount_Re."DEL Reporting Dimension 2 Code";
                            ExportHyperionDatas_Re."Dimension ENSEIGNE" := CODEENSEIGNE_TE;
                            ExportHyperionDatas_Re.Name := GLAccount_Re.Name;
                            ExportHyperionDatas_Re.Amount := GLEntry_Re.Amount;
                            ExportHyperionDatas_Re."Line No." := 1;
                            ExportHyperionDatas_Re.INSERT();
                        END;
                    UNTIL GLEntry_Re.NEXT() = 0;
            UNTIL GLAccount_Re.NEXT() = 0;
        COMMIT();
        Dialog_Di.CLOSE();

        GeneralSetup_Re.GET();
        ExportHyperionDatas_Re.RESET();
        ExportHyperionDatas_Re.SETRANGE("Line No.", 0);
        IF (ExportHyperionDatas_Re.FINDFIRST()) THEN BEGIN
            StartDate_Loc_Te := DELCHR(ExportHyperionDatas_Re."Company Code", '=', ':/.');
            EndDate_Loc_Te := DELCHR(ExportHyperionDatas_Re."No.", '=', ':/.');
            DateNow_Te := DELCHR(FORMAT(TODAY), '=', ':/.');
            TimeNow_Te := DELCHR(FORMAT(TIME), '=', ':/.');
        END;
        //TODO: cloud mode ! 

        // CustXmlFile_Fi.CREATE(GeneralSetup_Re."Hyperion File" + '\HFM_' +
        // GeneralSetup_Re."Hyperion Company Code" + '_' + StartDate_Loc_Te + '_' + EndDate_Loc_Te +
        //  '_' + DateNow_Te + '_' + TimeNow_Te + '.csv');

        // CustXmlFile_Fi.CREATEOUTSTREAM(XmlStream_Os);
        // XMLPORT.EXPORT(50011, XmlStream_Os);
        // CustXmlFile_Fi.CLOSE;

        ///////// à corriger ! 
        CustXmlFile_Fi := GeneralSetup_Re."Hyperion File" + '\HFM_' +
        GeneralSetup_Re."Hyperion Company Code" + '_' + StartDate_Loc_Te + '_' + EndDate_Loc_Te +
         '_' + DateNow_Te + '_' + TimeNow_Te + '.csv';
        TempBlob.CreateOutStream(XmlStream_Os, TEXTENCODING::UTF8);
        XMLPORT.EXPORT(XMLPORT::"DEL Export Hyperion File", XmlStream_Os);
        MESSAGE('Export Xml File!');


    end;

    var
        AccountingPeriod_Re: Record "Accounting Period";
        ExportHyperionDatas_Re: Record "DEL Export Hyperion Datas";
        GeneralSetup_Re: Record "DEL General Setup";
        DimensionSetEntry_Re: Record "Dimension Set Entry";
        GLAccount_Re: Record "G/L Account";
        GLEntry_Re: Record "G/L Entry";
        tempblob: Codeunit "Temp Blob";

        EndDate_Da: Date;
        StartDate_Da: Date;
        StartPeriodeDate_Da: Date;
        LOGITEXT0001: Label 'The batch is runing...';
        CODEENSEIGNE_TE: Text;
        DateNow_Te: Text;
        EndDate_Loc_Te: Text;
        StartDate_Loc_Te: Text;
        TimeNow_Te: Text;
        CustXmlFile_Fi: Text;
        XmlStream_Os: OutStream;
}

