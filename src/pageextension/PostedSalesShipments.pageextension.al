pageextension 50011 "DEL PostedSalesShipments" extends "Posted Sales Shipments" //142
{


    layout
    {
        addafter("No.") //2
        {
            field("DEL Order No."; REC."Order No.")
            {
            }
        }
    }
    actions
    {

        addafter("&Print") //21 
        {
            action("DEL Print XML")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print XML';
                Ellipsis = true;
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SalesShptHeader: Record "Sales Shipment Header";
                begin
                    CLEAR(ExportBL2);
                    CurrPage.SETSELECTIONFILTER(SalesShptHeader);
                    IF DATE2DMY(TODAY, 2) < 10 THEN
                        MM := '0' + FORMAT(DATE2DMY(TODAY, 2))
                    ELSE
                        MM := FORMAT(DATE2DMY(TODAY, 2));
                    IF DATE2DMY(TODAY, 1) < 10 THEN
                        DD := '0' + FORMAT(DATE2DMY(TODAY, 1))
                    ELSE
                        DD := FORMAT(DATE2DMY(TODAY, 1));

                    NMfichier := 'DESADV_' + FORMAT(DATE2DMY(TODAY, 3)) + MM + DD + DELCHR(FORMAT(TIME), '=', ':') + '.xml';
                    ExportBL2.FILENAME(NMfichier);
                    ExportBL2.SETTABLEVIEW(SalesShptHeader);
                    ExportBL2.RUN();
                end;
            }
        }
    }

    var
        ExportBL2: XMLport "DEL Hyperion Export";
        DD: Text;
        MM: Text;
        NMfichier: Text;
}

