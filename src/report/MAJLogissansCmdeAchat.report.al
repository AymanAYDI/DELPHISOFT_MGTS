report 50020 "DEL MAJ Logis sans Cmde Achat"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MAJLogisticsansCmdeAchat.rdlc';

    dataset
    {
        dataitem("DEL Element"; "DEL Element")
        {
            DataItemTableView = SORTING(ID)
                                ORDER(Ascending)
                                WHERE(Type = FILTER(ACO));
            PrintOnlyIfDetail = true;
            RequestFilterFields = ID;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column("USERID"; USERID)
            {
            }
            column(Element_Deal_ID; Deal_ID)
            {
            }
            //TODO column(Element_Type; "Customer/Vendor")
            // {
            // }
            column(Element__Type_No__; "Type No.")
            {
            }
            column(ElementCaption; ElementCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Element_Deal_IDCaption; FIELDCAPTION(Deal_ID))
            {
            }
            //TODO column(Element_TypeCaption; FIELDCAPTION("Customer/Vendor"))
            // {
            // }
            column(Element__Type_No__Caption; FIELDCAPTION("Type No."))
            {
            }
            column(Logistic_Deal_IDCaption; "DEL Logistic".FIELDCAPTION(Deal_ID))
            {
            }
            column(Logistic_Deal_ID_Control1000000010Caption; "DEL Logistic".FIELDCAPTION(Deal_ID))
            {
            }
            column(Logistic__ACO_No__Caption; "DEL Logistic".FIELDCAPTION("ACO No."))
            {
            }
            column(Element_ID; ID)
            {
            }
            dataitem("DEL Logistic"; "DEL Logistic")
            {
                DataItemLink = Deal_ID = FIELD(Deal_ID);
                DataItemTableView = SORTING(ID, Deal_ID)
                                    ORDER(Ascending)
                                    WHERE("ACO No." = FILTER(''));
                column(Logistic_Deal_ID; Deal_ID)
                {
                }
                column(Logistic_Deal_ID_Control1000000010; Deal_ID)
                {
                }
                column(Logistic__ACO_No__; "ACO No.")
                {
                }
                column(Logistic_ID; ID)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    "DEL Logistic"."ACO No." := "DEL Element"."Type No.";
                    "DEL Logistic".MODIFY();
                end;
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(ID);
            end;
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

    labels
    {
    }

    var
        LastFieldNo: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ElementCaptionLbl: Label 'Element';
}

