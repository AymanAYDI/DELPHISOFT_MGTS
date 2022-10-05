tableextension 50080 "DEL JobQueueEntry" extends "Job Queue Entry" //472
{
    fields
    {
        field(50000; "DEL Notify By Email On Error"; Boolean)
        {
            Caption = 'Notify By Email On Error';
            DataClassification = ToBeClassified;
        }
        field(50001; "DEL Notify By Email Inactive"; Boolean)
        {
            Caption = 'Notify By Email Inactive';
            DataClassification = ToBeClassified;
        }
        field(50002; "DEL Notify By Email On Hold"; Boolean)
        {
            Caption = 'Notify By Email On Hold';
            DataClassification = ToBeClassified;
        }
        field(50003; "DEL Mail Template On Error"; Text[250])
        {
            Caption = 'Mail Template On Error';
            DataClassification = ToBeClassified;
            TableRelation = "DEL D365FM Mail Template";
        }
        field(50004; "DEL Mail Template Inactive"; Text[250])
        {
            Caption = 'Mail Template Inactive';
            DataClassification = ToBeClassified;
            TableRelation = "DEL D365FM Mail Template";
        }
        field(50005; "DEL Mail Template On Hold"; Text[250])
        {
            Caption = 'Mail Template On Hold';
            DataClassification = ToBeClassified;
            TableRelation = "DEL D365FM Mail Template";
        }
        field(50006; "DEL Notif. Recipient Email"; Text[250])
        {
            Caption = 'Notification Recipient Email';
            DataClassification = ToBeClassified;
        }
    }
}
