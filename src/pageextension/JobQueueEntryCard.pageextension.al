pageextension 50054 "DEL JobQueueEntryCard" extends "Job Queue Entry Card" //673
{
    layout
    {
        addafter(Recurrence)
        {
            group("DEL Notification")
            {
                Caption = 'Notification';
                field("DEL Notification Recipient Email"; Rec."DEL Notif. Recipient Email")
                {
                }
                group("DEL On error")
                {
                    Caption = 'On error';
                    field("DEL Notify By Email On Error"; Rec."DEL Notify By Email On Error")
                    {
                    }
                    field("DEL Mail Template On Error"; Rec."DEL Mail Template On Error")
                    {
                        LookupPageID = "D365FM Mail Template Notif.";
                    }
                }
                group("DEL On hold")
                {
                    Caption = 'On hold';
                    field("DEL Notify By Email On Hold"; Rec."DEL Notify By Email On Hold")
                    {
                    }
                    field("DEL Mail Template On Hold"; Rec."DEL Mail Template On Hold")
                    {
                        LookupPageID = "D365FM Mail Template Notif.";
                    }
                }
                group("DEL Inactive")
                {
                    Caption = 'Inactive';
                    field("DEL Notify By Email Inactive"; Rec."DEL Notify By Email Inactive")
                    {
                    }
                    field("DEL Mail Template Inactive"; Rec."DEL Mail Template Inactive")
                    {
                        LookupPageID = "D365FM Mail Template Notif.";
                    }
                }
            }
        }
    }
}

