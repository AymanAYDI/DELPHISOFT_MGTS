pageextension 50001 "DEL CompanyInformation" extends "Company Information" //1 
{
    layout
    {
        addafter("SWIFT Code") //("Control 74")
        {
            field("DEL IBAN USD"; Rec."DEL IBAN USD")
            {
            }
            field("Info pénalités"; Rec."Info pénalités")
            {
            }
            field("DEL Info fiscales 1"; Rec."DEL Info fiscales 1")
            {
            }
            field("DEL Info fiscales 2"; Rec."DEL Info fiscales 2")
            {
            }
            field("DEL Swiss QRBill IBAN"; Rec."DEL Swiss QRBill IBAN")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the QR-IBAN value of your primary bank account.';
            }
        }
        addafter("Experience") //("Control 38")
        {
            group("DEL FTP")
            {
                Caption = 'FTP';
                field("DEL FTP Server"; Rec."DEL FTP Server")
                {
                }
                field("DEL FTP UserName"; Rec."DEL FTP UserName")
                {
                }
                field("DEL FTP Password"; Rec."DEL FTP Password")
                {
                }
                field("DEL Purchase E-Mail"; Rec."DEL Purchase E-Mail")
                {
                }
            }
            group("DEL FTP Server 2")
            {
                Caption = 'FTP Server 2';
                field("DEL FTP2 Server"; Rec."DEL FTP2 Server")
                {
                    Caption = '<FTP2 Server>';
                }
                field("DEL FTP2 UserName"; Rec."DEL FTP2 UserName")
                {
                    Caption = '<FTP2 UserName>';
                }
                field("DEL FTP2 Password"; Rec."DEL FTP2 Password")
                {
                    Caption = '<FTP2 Password>';
                }
            }
        }
    }
    actions
    {
        addafter("No. Series") //action 26 
        {
            action("DEL Document Matrix")
            {
                Caption = 'Document Matrix';
                Image = TaxSetup;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    lpgDocumentMatrix: Page "DEL Document Matrix";
                begin
                    lpgDocumentMatrix.RUN();
                end;
            }
        }
    }
}

