tableextension 50042 "DEL CompanyInformation" extends "Company Information" //79
{
    fields
    {
        field(11510; "DEL Swiss QRBill IBAN"; Code[50])
        {
            Caption = 'IBAN/QR-IBAN';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CheckIBAN("DEL Swiss QRBill IBAN");
            end;
        }
        field(50000; "Info pénalités"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50001; "DEL Info fiscales 1"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50002; "DEL Info fiscales 2"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50003; "DEL FTP Server"; Text[50])
        {
            Caption = 'FTP Server';
            DataClassification = CustomerContent;
        }
        field(50004; "DEL FTP UserName"; Text[20])
        {
            Caption = 'FTP UserName';
            DataClassification = CustomerContent;
        }
        field(50005; "DEL FTP Password"; Text[20])
        {
            Caption = 'FTP Password';
            DataClassification = CustomerContent;
            ExtendedDatatype = Masked;
        }
        field(50006; "DEL Purchase E-Mail"; Text[80])
        {
            Caption = 'Purchase E-Mail';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(50007; "DEL FTP2 Server"; Text[50])
        {
            Caption = 'FTP Server 2';
            DataClassification = CustomerContent;
        }
        field(50008; "DEL FTP2 UserName"; Text[20])
        {
            Caption = 'FTP UserName 2';
            DataClassification = CustomerContent;
        }
        field(50009; "DEL FTP2 Password"; Text[20])
        {
            Caption = 'FTP Password';
            DataClassification = CustomerContent;
            ExtendedDatatype = Masked;
        }
        field(50010; "DEL IBAN USD"; Code[50])
        {
            Caption = 'IBAN USD';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                CheckIBAN("DEL IBAN USD");
            end;
        }
        field(50011; "DEL Enable WS Interface"; Boolean)
        {
            Caption = 'Enable WS Interface';
            DataClassification = CustomerContent;
        }
    }
}

