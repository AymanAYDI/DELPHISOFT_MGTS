pageextension 50001 pageextension50001 extends "Company Information"
{
    // 
    // ngts/loco/grc   17.02.10 add field info société + info fiscale x2
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // MGTS:EDD001.01 :TU 24/05/2018 : Minimisation des clics :
    //  #Added new tab "FTP"
    //  #Added new field "FTP Server" in FTP tab
    //  #Added new field "FTP UserName" in FTP tab
    //  #Added new field "FTP Password" in FTP tab
    // 
    // MGTS:EDD001.02 :TU 06/06/2018 : Minimisation des clics :
    //                     - Add new Tab "FTP2 Server".
    //                     - Add new field "FTP2 Server"
    //                     - Add new field "FTP2 UserName"
    //                     - Add new field "FTP2 Password"
    // +----------------------------------------------------------------------------------------------------------------+
    // DEL/PD/20190228/LOP003 : new action button "Document Matrix"
    // DEL/PD/20190304/LOP003 : changed action button "Document Matrix": changed call from RUNMODAL to RUN
    // DEL_QR/THS/300620 -  Add field Swiss QRBill IBAN on Layout in payment group
    layout
    {
        addafter("Control 74")
        {
            field("IBAN USD"; "IBAN USD")
            {
            }
            field("Info pénalités"; "Info pénalités")
            {
            }
            field("Info fiscales 1"; "Info fiscales 1")
            {
            }
            field("Info fiscales 2"; "Info fiscales 2")
            {
            }
            field("Swiss QRBill IBAN"; "Swiss QRBill IBAN")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the QR-IBAN value of your primary bank account.';
            }
        }
        addafter("Control 38")
        {
            group(FTP)
            {
                Caption = 'FTP';
                field("FTP Server"; "FTP Server")
                {
                }
                field("FTP UserName"; "FTP UserName")
                {
                }
                field("FTP Password"; "FTP Password")
                {
                }
                field("Purchase E-Mail"; "Purchase E-Mail")
                {
                }
            }
            group("FTP Server 2")
            {
                Caption = 'FTP Server 2';
                field("FTP2 Server"; "FTP2 Server")
                {
                    Caption = '<FTP2 Server>';
                }
                field("FTP2 UserName"; "FTP2 UserName")
                {
                    Caption = '<FTP2 UserName>';
                }
                field("FTP2 Password"; "FTP2 Password")
                {
                    Caption = '<FTP2 Password>';
                }
            }
        }
    }
    actions
    {
        addafter("Action 26")
        {
            action("Document Matrix")
            {
                Caption = 'Document Matrix';
                Image = TaxSetup;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    lpgDocumentMatrix: Page "50130";
                begin
                    lpgDocumentMatrix.RUN;
                end;
            }
        }
    }
}

