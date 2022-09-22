table 99210 "DEL Ex_Campaign"
{
    Caption = 'Campaign';
    DataCaptionFields = "No.", Description;
    LookupPageID = "Campaign List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(4; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(5; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = Salesperson/Purchaser;
        }
        field(6; Comment; Boolean)
        {
            CalcFormula = Exist("Rlshp. Mgt. Comment Line" WHERE (Table Name    Caption = 'Name';
=CONST(Campaign),
                                                                  No.=FIELD(No.)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(8; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(1));
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE (Global Dimension No.=CONST(2));
        }
        field(11; "Status Code"; Code[10])
        {
            Caption = 'Status Code';
            TableRelation = "Campaign Status";
        }
        field(12; "Target Contacts Contacted"; Integer)
        {
            CalcFormula = Count("Interaction Log Entry" WHERE (Campaign No.=FIELD(No.),
                                                               Campaign Target=CONST(Yes),
                                                               Canceled=CONST(No),
                                                               Date=FIELD(Date Filter),
                                                               Postponed=CONST(No)));
            Caption = 'Target Contacts Contacted';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Contacts Responded"; Integer)
        {
            CalcFormula = Count("Interaction Log Entry" WHERE (Campaign No.=FIELD(No.),
                                                               Campaign Response=CONST(Yes),
                                                               Canceled=CONST(No),
                                                               Date=FIELD(Date Filter),
                                                               Postponed=CONST(No)));
            Caption = 'Contacts Responded';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Duration (Min.)"; Decimal)
        {
            CalcFormula = Sum("Interaction Log Entry"."Duration (Min.)" WHERE (Campaign No.=FIELD(No.),
                                                                               Canceled=CONST(No),
                                                                               Date=FIELD(Date Filter),
                                                                               Postponed=CONST(No)));
            Caption = 'Duration (Min.)';
            DecimalPlaces = 0:0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Cost (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Interaction Log Entry"."Cost (LCY)" WHERE (Campaign No.=FIELD(No.),
                                                                          Canceled=CONST(No),
                                                                          Date=FIELD(Date Filter),
                                                                          Postponed=CONST(No)));
            Caption = 'Cost (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "No. of Opportunities"; Integer)
        {
            CalcFormula = Count("Opportunity Entry" WHERE (Campaign No.=FIELD(No.),
                                                           Active=CONST(Yes)));
            Caption = 'No. of Opportunities';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Estimated Value (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Opportunity Entry"."Estimated Value (LCY)" WHERE (Campaign No.=FIELD(No.),
                                                                                 Active=CONST(Yes)));
            Caption = 'Estimated Value (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Calcd. Current Value (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Opportunity Entry"."Calcd. Current Value (LCY)" WHERE (Campaign No.=FIELD(No.),
                                                                                      Active=CONST(Yes)));
            Caption = 'Calcd. Current Value (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(23; "Action Taken Filter"; Option)
        {
            Caption = 'Action Taken Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,Next,Previous,Updated,Jumped,Won,Lost';
            OptionMembers = " ",Next,Previous,Updated,Jumped,Won,Lost;
        }
        field(24; "Sales Cycle Filter"; Code[10])
        {
            Caption = 'Sales Cycle Filter';
            FieldClass = FlowFilter;
            TableRelation = "Sales Cycle";
        }
        field(25; "Sales Cycle Stage Filter"; Integer)
        {
            Caption = 'Sales Cycle Stage Filter';
            FieldClass = FlowFilter;
            TableRelation = "Sales Cycle Stage".Stage WHERE (Sales Cycle Code=FIELD(Sales Cycle Filter));
        }
        field(26; "Probability % Filter"; Decimal)
        {
            Caption = 'Probability % Filter';
            DecimalPlaces = 1:1;
            FieldClass = FlowFilter;
            MaxValue = 100;
            MinValue = 0;
        }
        field(27; "Completed % Filter"; Decimal)
        {
            Caption = 'Completed % Filter';
            DecimalPlaces = 1:1;
            FieldClass = FlowFilter;
            MaxValue = 100;
            MinValue = 0;
        }
        field(28; "Contact Filter"; Code[20])
        {
            Caption = 'Contact Filter';
            FieldClass = FlowFilter;
            TableRelation = Contact;
        }
        field(29; "Contact Company Filter"; Code[20])
        {
            Caption = 'Contact Company Filter';
            FieldClass = FlowFilter;
            TableRelation = Contact WHERE (Type=CONST(Company));
        }
        field(30; "Estimated Value Filter"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Estimated Value Filter';
            FieldClass = FlowFilter;
        }
        field(31; "Calcd. Current Value Filter"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Calcd. Current Value Filter';
            FieldClass = FlowFilter;
        }
        field(32; "Chances of Success % Filter"; Decimal)
        {
            Caption = 'Chances of Success % Filter';
            DecimalPlaces = 0:0;
            FieldClass = FlowFilter;
            MaxValue = 100;
            MinValue = 0;
        }
        field(33; "To-do Status Filter"; Option)
        {
            Caption = 'To-do Status Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Not Started,In Progress,Completed,Waiting,Postponed';
            OptionMembers = "Not Started","In Progress",Completed,Waiting,Postponed;
        }
        field(34; "To-do Closed Filter"; Boolean)
        {
            Caption = 'To-do Closed Filter';
            FieldClass = FlowFilter;
        }
        field(35; "Priority Filter"; Option)
        {
            Caption = 'Priority Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Low,Normal,High';
            OptionMembers = Low,Normal,High;
        }
        field(36; "Team Filter"; Code[10])
        {
            Caption = 'Team Filter';
            FieldClass = FlowFilter;
            TableRelation = Team;
        }
        field(37; "Salesperson Filter"; Code[10])
        {
            Caption = 'Salesperson Filter';
            FieldClass = FlowFilter;
            TableRelation = Salesperson/Purchaser;
        }
        field(38; "Opportunity Entry Exists"; Boolean)
        {
            CalcFormula = Exist("Opportunity Entry" WHERE (Campaign No.=FIELD(No.),
                                                           Active=CONST(Yes),
                                                           Salesperson Code=FIELD(Salesperson Filter),
                                                           Contact No.=FIELD(Contact Filter),
                                                           Contact Company No.=FIELD(Contact Company Filter),
                                                           Sales Cycle Code=FIELD(Sales Cycle Filter),
                                                           Sales Cycle Stage=FIELD(Sales Cycle Stage Filter),
                                                           Action Taken=FIELD(Action Taken Filter),
                                                           Estimated Value (LCY)=FIELD(Estimated Value Filter),
                                                           Calcd. Current Value (LCY)=FIELD(Calcd. Current Value Filter),
                                                           Completed %=FIELD(Completed % Filter),
                                                           Chances of Success %=FIELD(Chances of Success % Filter),
                                                           Probability %=FIELD(Probability % Filter),
                                                           Estimated Close Date=FIELD(Date Filter),
                                                           Close Opportunity Code=FIELD(Close Opportunity Filter)));
            Caption = 'Opportunity Entry Exists';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "To-do Entry Exists"; Boolean)
        {
            CalcFormula = Exist(To-do WHERE (Campaign No.=FIELD(No.),
                                             Contact No.=FIELD(Contact Filter),
                                             Contact Company No.=FIELD(Contact Company Filter),
                                             Salesperson Code=FIELD(Salesperson Filter),
                                             Team Code=FIELD(Team Filter),
                                             Status=FIELD(To-do Status Filter),
                                             Closed=FIELD(To-do Closed Filter),
                                             Priority=FIELD(Priority Filter),
                                             Date=FIELD(Date Filter)));
            Caption = 'To-do Entry Exists';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Close Opportunity Filter"; Code[10])
        {
            Caption = 'Close Opportunity Filter';
            FieldClass = FlowFilter;
            TableRelation = "Close Opportunity Code";
        }
        field(41; Activated; Boolean)
        {
            CalcFormula = Exist("Campaign Target Group" WHERE (Campaign No.=FIELD(No.)));
            Caption = 'Activated';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006496; Hauptkampagne; Boolean)
        {
            Caption = 'Main Campaign';
            Description = 'AL.KVK4.5';
        }
        field(4006497; eCommerce; Boolean)
        {
            Caption = 'eCommerce';
            Description = 'AL.KVK4.5';
        }
        field(4006498; Mediacode; Code[5])
        {
            Caption = 'Mediacore';
            Description = 'AL.KVK4.5';
        }
        field(4006499; "eCommerce Mandant"; Text[30])
        {
            Caption = 'eCommerce Company';
            Description = 'AL.KVK4.5';
            TableRelation = Company;
        }
        field(4006500; Kurztext; Text[150])
        {
            Caption = 'Short Text';
            Description = 'AL.KVK4.5';
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
        key(Key2;"Salesperson Code")
        {
        }
        key(Key3;Hauptkampagne)
        {
        }
        key(Key4;eCommerce)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown;"No.",Description,"Starting Date","Ending Date","Status Code")
        {
        }
    }

    trigger OnDelete()
    var
        SalesPrice: Record "7002";
        SalesLineDisc: Record "7004";
    begin
    end;

    var
        Text000: Label '%1 must be before %2.';
        Text001: Label '%1 must be after %2.';
        RMSetup: Record "5079";
        Campaign: Record "5071";
        RMCommentLine: Record "5061";
        CampaignEntry: Record "5072";
        NoSeriesMgt: Codeunit "396";
        DimMgt: Codeunit "408";
        CampaignMgmt: Codeunit "7030";
}

