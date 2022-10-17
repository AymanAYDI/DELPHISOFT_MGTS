pageextension 50011 pageextension50011 extends "Posted Sales Shipments"
{

    //Unsupported feature: Property Modification (SourceTableView) on ""Posted Sales Shipments"(Page 142)".

    layout
    {
        addafter("Control 2")
        {
            field("Order No."; "Order No.")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 33".


        //Unsupported feature: Property Modification (RunPageLink) on "CertificateOfSupplyDetails(Action 3)".

        addafter("Action 21")
        {
            action("Print XML")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print XML';
                Ellipsis = true;
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesShptHeader: Record "110";
                begin
                    CLEAR(ExportBL2);
                    CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                    //SalesShptHeader.PrintRecords(TRUE);
                    //DESADV_YYYYMMDDJJHHMMSS.
                    IF DATE2DMY(TODAY, 2) < 10 THEN
                        MM := '0' + FORMAT(DATE2DMY(TODAY, 2))
                    ELSE
                        MM := FORMAT(DATE2DMY(TODAY, 2));
                    IF DATE2DMY(TODAY, 1) < 10 THEN
                        DD := '0' + FORMAT(DATE2DMY(TODAY, 1))
                    ELSE
                        DD := FORMAT(DATE2DMY(TODAY, 1));

                    NMfichier := 'DESADV_' + FORMAT(DATE2DMY(TODAY, 3)) + MM + DD + DELCHR(FORMAT(TIME), '=', ':') + '.xml';
                    //MESSAGE(NMfichier);
                    ExportBL2.FILENAME(NMfichier);

                    ExportBL2.SETTABLEVIEW(SalesShptHeader);
                    ExportBL2.RUN;
                end;
            }
        }
    }

    var
        ExportBL2: XMLport "50014";
        NMfichier: Text;
        MM: Text;
        DD: Text;
}

