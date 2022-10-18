xmlport 50011 "Export Hyperion File"
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
    // THS             THS     12.12.13    -                                       Finition
    // THS130114       THS     13.01.14    -                                       Correction (Sauving without confirm. message)

    Direction = Export;
    FieldSeparator = ';';
    Format = VariableText;
    FormatEvaluate = Xml;
    TextEncoding = UTF8;
    UseRequestPage = false;

    schema
    {
        textelement(Debut)
        {
            tableelement(Table50049; Table50049)
            {
                RequestFilterFields = Field2;
                XmlName = 'ExportHyperionDatas_Ta';
                fieldelement(CompanyCode_Fl; "Export Hyperion Datas"."Company Code")
                {
                }
                fieldelement(No_Fl; "Export Hyperion Datas"."No.")
                {
                }
                fieldelement(No2_Fl; "Export Hyperion Datas"."No. 2")
                {
                }
                fieldelement(RepDim1Code_Fl; "Export Hyperion Datas"."Reporting Dimension 1 Code")
                {
                }
                fieldelement(RepDim2Code_Fl; "Export Hyperion Datas"."Reporting Dimension 2 Code")
                {
                }
                fieldelement(Name_Fl; "Export Hyperion Datas".Name)
                {
                }
                fieldelement(DimENSEIGNE_Fl; "Export Hyperion Datas"."Dimension ENSEIGNE")
                {
                }
                textelement(amount_te)
                {
                    XmlName = 'Amount_Fl_text';

                    trigger OnBeforePassVariable()
                    begin
                        IF ("Export Hyperion Datas"."Line No." = 0) THEN
                            Amount_Te := ''
                        ELSE
                            Amount_Te := FORMAT("Export Hyperion Datas".Amount);
                    end;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        StartDate_Loc_Te := '';
        EndDate_Loc_Te := '';

        //THS130114 START
        //OLD//
        //  GeneralSetup_Re.GET;
        //  ExportHyperionDatas_Re.RESET;
        //  ExportHyperionDatas_Re.SETRANGE("Line No.",0);
        //  IF(ExportHyperionDatas_Re.FINDFIRST)THEN BEGIN
        //    StartDate_Loc_Te := DELCHR(ExportHyperionDatas_Re."Company Code",'=', ':/.');
        //    EndDate_Loc_Te := DELCHR(ExportHyperionDatas_Re."No.",'=', ':/.');
        //    DateNow_Te := DELCHR(FORMAT(TODAY),'=', ':/.');
        //    TimeNow_Te := DELCHR(FORMAT(TIME),'=', ':/.');
        //  END;
        //  currXMLport.FILENAME(GeneralSetup_Re."Hyperion File" + '\HFM_' + GeneralSetup_Re."Hyperion Company Code" + '_' + StartDate_Loc_Te + '_' + EndDate_Loc_Te + '_' + DateNow_Te + '_' + TimeNow_Te + '.csv');
        //
        //THS130114 STOP
    end;

    var
        ExportHyperionDatas_Re: Record "50049";
        GeneralSetup_Re: Record "50000";
        FileMgt_Cu: Codeunit "419";
        StartDate_Loc_Te: Text;
        EndDate_Loc_Te: Text;
        TimeNow_Te: Text;
        DateNow_Te: Text;
}

