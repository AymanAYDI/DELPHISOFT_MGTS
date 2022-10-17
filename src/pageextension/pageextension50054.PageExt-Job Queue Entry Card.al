pageextension 50054 pageextension50054 extends "Job Queue Entry Card"
{
    layout
    {
        addafter("Control 1900576001")
        {
            group(Notification)
            {
                Caption = 'Notification';
                field("Notification Recipient Email"; "Notification Recipient Email")
                {
                }
                group("On error")
                {
                    Caption = 'On error';
                    field("Notify By Email On Error"; "Notify By Email On Error")
                    {
                    }
                    field("Mail Template On Error"; "Mail Template On Error")
                    {
                        LookupPageID = "D365FM Mail Template Notif.";
                    }
                }
                group("On hold")
                {
                    Caption = 'On hold';
                    field("Notify By Email On Hold"; "Notify By Email On Hold")
                    {
                    }
                    field("Mail Template On Hold"; "Mail Template On Hold")
                    {
                        LookupPageID = "D365FM Mail Template Notif.";
                    }
                }
                group(Inactive)
                {
                    Caption = 'Inactive';
                    field("Notify By Email Inactive"; "Notify By Email Inactive")
                    {
                    }
                    field("Mail Template Inactive"; "Mail Template Inactive")
                    {
                        LookupPageID = "D365FM Mail Template Notif.";
                    }
                }
            }
        }
    }
}

