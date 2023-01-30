table 50069 "DEL DocMatrix Setup"
{
    Caption = 'DocMatrix Setup';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(10; "Sales File Folder"; Text[250])
        {
            Caption = 'Sales File Folder';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //TODO GeneralMgt.CheckFolderName("Sales File Folder");
            end;
        }
        field(11; "Purchase File Folder"; Text[250])
        {
            Caption = 'Purchase File Folder';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //TODO GeneralMgt.CheckFolderName("Purchase File Folder");
            end;
        }
        field(20; "Default E-Mail From"; Text[80])
        {
            Caption = 'Default E-Mail From';
            DataClassification = CustomerContent;
        }
        field(30; "Show Notifications"; Boolean)
        {
            Caption = 'Show Notifications';
            DataClassification = CustomerContent;
        }
        field(40; "Statement Test Date"; Date)
        {
            Caption = 'Statement Test Date';
            DataClassification = CustomerContent;
        }
        field(41; "Test Active"; Boolean)
        {
            Caption = 'Test Active';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        GeneralMgt: Codeunit "GeneralMgt";

    procedure GetStorageLocation(Type: Enum "Credit Transfer Account Type"): Text[250] //enum 50103
    begin
        CASE Type OF
            Type::Customer:
                BEGIN
                    TESTFIELD("Sales File Folder");
                    EXIT("Sales File Folder");
                END;
            Type::Vendor:
                BEGIN
                    TESTFIELD("Purchase File Folder");
                    EXIT("Purchase File Folder");
                END;
        END;
    end;
}

