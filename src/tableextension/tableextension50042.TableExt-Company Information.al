tableextension 50042 tableextension50042 extends "Company Information"
{
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // MGTS:EDD001.01 :TU 24/05/2018 : Minimisation des clics :
    //   #Added new field 50003FTP Server[Text30]
    //   #Added new field 50004FTP UserName[Text20]
    //   #Added new field 50005FTP Password[Text20]
    // 
    // MGTS:EDD001.02 :TU 06/06/2018 : Minimisation des clics :
    //                   - Add new field (ID 50007) "FTP2 Server" [Text 30]
    //                   - Add new field (ID 50008) "FTP2 UserName" [Text 20]
    //                   - Add new field (ID 50009) "FTP2 Password" [Text 20]
    // +----------------------------------------------------------------------------------------------------------------+
    // 
    // DEL/PD/20190304/LOP003 : changed fields "FTP Server" and "FTP2 Server": field lenght from 30 to 50
    // DEL|QR : Add field 11510
    // 
    // Mgts10.00.04.00      07.12.2021 : Add field(50011)
    // ------------------------------------------------------------------------------------------
    fields
    {
        field(11510; "Swiss QRBill IBAN"; Code[50])
        {
            Caption = 'IBAN/QR-IBAN';
            Description = 'DEL|QR';

            trigger OnValidate()
            begin
                CheckIBAN("Swiss QRBill IBAN");
            end;
        }
        field(50000; "Info pénalités"; Text[100])
        {
        }
        field(50001; "Info fiscales 1"; Text[100])
        {
        }
        field(50002; "Info fiscales 2"; Text[100])
        {
        }
        field(50003; "FTP Server"; Text[50])
        {
            Caption = 'FTP Server';
            Description = 'MGTS:EDD001.01,DEL1.00';
        }
        field(50004; "FTP UserName"; Text[20])
        {
            Caption = 'FTP UserName';
            Description = 'MGTS:EDD001.01';
        }
        field(50005; "FTP Password"; Text[20])
        {
            Caption = 'FTP Password';
            Description = 'MGTS:EDD001.01';
            ExtendedDatatype = Masked;
        }
        field(50006; "Purchase E-Mail"; Text[80])
        {
            Caption = 'Purchase E-Mail';
            ExtendedDatatype = EMail;
        }
        field(50007; "FTP2 Server"; Text[50])
        {
            Caption = 'FTP Server 2';
            Description = 'MGTS:EDD001.02,DEL1.00';
        }
        field(50008; "FTP2 UserName"; Text[20])
        {
            Caption = 'FTP UserName 2';
            Description = 'MGTS:EDD001.02';
        }
        field(50009; "FTP2 Password"; Text[20])
        {
            Caption = 'FTP Password';
            Description = 'MGTS:EDD001.02';
            ExtendedDatatype = Masked;
        }
        field(50010; "IBAN USD"; Code[50])
        {
            Caption = 'IBAN USD';

            trigger OnValidate()
            begin

                CheckIBAN("IBAN USD");
            end;
        }
        field(50011; "Enable WS Interface"; Boolean)
        {
            Caption = 'Enable WS Interface';
            Description = 'Mgts10.00.04.00';
        }
    }
}

