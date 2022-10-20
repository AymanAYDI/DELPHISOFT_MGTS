xmlport 50011 "DEL Export Hyperion File"
{
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
            tableelement("DEL Export Hyperion Datas"; "DEL Export Hyperion Datas")
            {
                RequestFilterFields = "No.";
                XmlName = 'ExportHyperionDatas_Ta';
                fieldelement(CompanyCode_Fl; "DEL Export Hyperion Datas"."Company Code")
                {
                }
                fieldelement(No_Fl; "DEL Export Hyperion Datas"."No.")
                {
                }
                fieldelement(No2_Fl; "DEL Export Hyperion Datas"."No. 2")
                {
                }
                fieldelement(RepDim1Code_Fl; "DEL Export Hyperion Datas"."Reporting Dimension 1 Code")
                {
                }
                fieldelement(RepDim2Code_Fl; "DEL Export Hyperion Datas"."Reporting Dimension 2 Code")
                {
                }
                fieldelement(Name_Fl; "DEL Export Hyperion Datas".Name)
                {
                }
                fieldelement(DimENSEIGNE_Fl; "DEL Export Hyperion Datas"."Dimension ENSEIGNE")
                {
                }
                textelement(amount_te)
                {
                    XmlName = 'Amount_Fl_text';

                    trigger OnBeforePassVariable()
                    begin
                        IF ("DEL Export Hyperion Datas"."Line No." = 0) THEN
                            Amount_Te := ''
                        ELSE
                            Amount_Te := FORMAT("DEL Export Hyperion Datas".Amount);
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

    end;

    var
        ExportHyperionDatas_Re: Record "DEL Export Hyperion Datas";
        GeneralSetup_Re: Record "DEL General Setup";
        FileMgt_Cu: Codeunit "File Management";
        StartDate_Loc_Te: Text;
        EndDate_Loc_Te: Text;
        TimeNow_Te: Text;
        DateNow_Te: Text;
}

