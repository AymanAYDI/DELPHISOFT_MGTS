table 50068 "DEL DocMatrix Log"
{



    // LookupPageID = 50138;

    Caption = 'DocMatrix Log';

    fields
    {


        field(1; Type; Option)

        {
          
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;

        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            Editable = false;

            TableRelation = IF (Type = CONST(Customer)) Customer."No."
            ELSE
            IF (Type = CONST(Vendor)) Vendor."No.";

        }
        field(3; "Process Type"; Option)
        {
            Caption = 'Process Type';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Manual,Automatic';
            OptionMembers = Manual,Automatic;
        }
        field(4; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            Editable = false;

            TableRelation = AllObjWithCaption."Object ID" WHERE(Object Type=CONST(Report    Caption = '';

        }
        field(5; "Report Caption"; Text[250])
        {

            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE (Object Type=CONST(Report    Caption = '';

),
                                                                           Object ID=FIELD(Report ID    Caption = 'ID';
)));
            Caption = 'Report Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Usage; Option)
        {
            Caption = 'Usage';
            Editable = false;
            OptionCaption = ',S.Order,S.Invoice,S.Cr.Memo,,,P.Order,P.Invoice,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,C.Statement';
            OptionMembers = ,"S.Order","S.Invoice","S.Cr.Memo",,,"P.Order","P.Invoice",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"C.Statement";
        }
        field(7; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "UserId"; Code[50])
        {
            Caption = 'UserId';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Send to FTP 1"; Boolean)
        {
            Caption = 'Send to FTP 1';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Send to FTP 2"; Boolean)
        {
            Caption = 'Send to FTP 2';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "E-Mail To 1"; Text[80])
        {
            Caption = 'E-Mail To 1';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "E-Mail To 2"; Text[80])
        {
            Caption = 'E-Mail To 2';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(22; "E-Mail To 3"; Text[80])
        {
            Caption = 'E-Mail To 3';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "E-Mail From"; Text[80])
        {
            Caption = 'E-Mail From';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(30; "Save PDF"; Boolean)
        {
            Caption = 'Save PDF';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(40; "Print PDF"; Boolean)
        {
            Caption = 'Print PDF';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; "Mail Text Code"; Code[20])
        {
            Caption = 'Mail Text Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "DocMatrix Email Codes";
        }
        field(51; "Mail Text Langauge Code"; Code[10])
        {
            Caption = 'Mail Text Language Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Language;
        }
        field(70; Post; Option)
        {
            Caption = 'Post';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Ship,Invoice,Ship and Invoice,Yes';
            OptionMembers = " ",Ship,Invoice,"Ship and Invoice",Yes;
        }
        field(75; "E-Mail from Sales Order"; Boolean)
        {
            Caption = 'E-Mail from Sales Order';
            Description = 'CR100';

            trigger OnValidate()
            begin
                //20200915/DEL/PD/CR100.begin
                TESTFIELD(Type,Type::Customer);
                //20200915/DEL/PD/CR100.end
            end;
        }
        field(100; "Action"; Option)
        {
            Caption = 'Action';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Print,Save,Mail,FTP1,FTP2,,,,,,JobQueueEntry';
            OptionMembers = Print,Save,Mail,FTP1,FTP2,,,,,,JobQueueEntry;
        }
        field(101; "Date Time Stamp"; DateTime)
        {
            Caption = 'Date Time Stamp';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(102; "Error"; Boolean)
        {
            Caption = 'Error';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(103; "Document No."; Code[10])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(104; "Process Result Description"; Text[250])
        {
            Caption = 'Process Result Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(105; "Error Solved"; Boolean)
        {
            Caption = 'Error Solved';
            DataClassification = ToBeClassified;
        }
        field(106; "Solving Description"; Text[250])
        {
            Caption = 'Solving Description';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Type,"No.","Process Type",Usage,"Line No.")
        {
            Clustered = true;
        }
        key(Key2;"Date Time Stamp")
        {
        }
        key(Key3;"Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DocumentMatrixMgt: Codeunit "50015";
        DocumentMatrixSetup: Record "50069";
        Err001: Label 'Please enter the Document Matrix Setup first.';
        Err002: Label 'You can not desactivate "Save PDF" if EMail or FTP is active, or if "Process Type" is "Automatic".';
        Err003: Label 'You can not delete the "E-Mail From" Address, if a E-Mail Address is entered. First you have to delete all the E-Mail Addresses.';
        Err004: Label 'You can not activate "Print" if the "Process Type" is set to "Automatic"!';
        Text001: Label 'The field "Save PDF" was set to TRUE to fit the Business Logic.';
        Text002: Label 'The field "Process Type" might have changed to fit the Business Logic.';
        Text003: Label 'Please check if you have to change the field "Usage".';
        boNotificationAlreadySent: Boolean;
}

