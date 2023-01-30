page 50066 "DEL Liste Notation contact"
{
    Caption = 'Rating contracts List';
    CardPageID = "DEL Contact Notation Card";
    Editable = false;
    PageType = List;
    SourceTable = Contact;
    UsageCategory = Lists;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Note Quality"; Rec."DEL Note Quality")
                {
                    ApplicationArea = All;
                }
                field("Realisation Date Quality"; Rec."DEL Realisation Date Quality")
                {
                    ApplicationArea = All;
                }
                field("Revision Date quality"; Rec."DEL Revision Date quality")
                {
                    ApplicationArea = All;
                }
                field("Note Soc"; Rec."DEL Note Soc")
                {
                    ApplicationArea = All;
                }
                field("Realisation Date Soc"; Rec."DEL Realisation Date Soc")
                {
                    ApplicationArea = All;
                }
                field("Revision Date Soc"; Rec."DEL Revision Date Soc")
                {
                    ApplicationArea = All;
                }
                field("Note Env"; Rec."DEL Note Env")
                {
                    ApplicationArea = All;
                }
                field("Realisation Date Env"; Rec."DEL Realisation Date Env")
                {
                    ApplicationArea = All;
                }
                field("Revision Date env"; Rec."DEL Revision Date env")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("C&ontact")
            {
                Caption = 'C&ontact';
                Image = ContactPerson;
                group("Comp&any")
                {
                    Caption = 'Comp&any';
                    Enabled = CompanyGroupEnabled;
                    Image = Company;
                    action("Business Relations")
                    {
                        Caption = 'Business Relations';
                        Image = BusinessRelation;
                        RunObject = Page "Contact Business Relations";
                        RunPageLink = "Contact No." = FIELD("Company No.");
                        ApplicationArea = All;
                    }
                    action("Industry Groups")
                    {
                        Caption = 'Industry Groups';
                        Image = IndustryGroups;
                        RunObject = Page "Contact Industry Groups";
                        RunPageLink = "Contact No." = FIELD("Company No.");
                        ApplicationArea = All;
                    }
                    action("Web Sources")
                    {
                        Caption = 'Web Sources';
                        Image = Web;
                        RunObject = Page "Contact Web Sources";
                        RunPageLink = "Contact No." = FIELD("Company No.");
                        ApplicationArea = All;
                    }
                }
                group("P&erson")
                {
                    Caption = 'P&erson';
                    Enabled = PersonGroupEnabled;
                    Image = User;
                    action("Job Responsibilities")
                    {
                        Caption = 'Job Responsibilities';
                        Image = Job;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ContJobResp: Record "Contact Job Responsibility";
                        begin
                            Rec.TESTFIELD(Type, Rec.Type::Person);
                            ContJobResp.SETRANGE("Contact No.", Rec."No.");
                            PAGE.RUNMODAL(PAGE::"Contact Job Responsibilities", ContJobResp);
                        end;
                    }
                }
                action("Pro&files")
                {
                    Caption = 'Pro&files';
                    Image = Answers;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ProfileManagement: Codeunit ProfileManagement;
                    begin
                        ProfileManagement.ShowContactQuestionnaireCard(Rec, '', 0);
                    end;
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Contact Picture";
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Rlshp. Mgt. Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Contact),
                                  "No." = FIELD("No."),
                                  "Sub No." = CONST(0);
                    ApplicationArea = All;
                }
                group("Alternati&ve Address")
                {
                    Caption = 'Alternati&ve Address';
                    Image = Addresses;
                    action(Card)
                    {
                        Caption = 'Card';
                        Image = EditLines;
                        RunObject = Page "Contact Alt. Address List";
                        RunPageLink = "Contact No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Date Ranges")
                    {
                        Caption = 'Date Ranges';
                        Image = DateRange;
                        RunObject = Page "Contact Alt. Addr. Date Ranges";
                        RunPageLink = "Contact No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                }
            }
            group("Related Information")
            {
                Caption = 'Related Information';
                Image = Users;
                action("Relate&d Contacts")
                {
                    Caption = 'Relate&d Contacts';
                    Image = Users;
                    RunObject = Page "Contact List";
                    RunPageLink = "Company No." = FIELD("Company No.");
                    ApplicationArea = All;
                }
                action("Segmen&ts")
                {
                    Caption = 'Segmen&ts';
                    Image = Segment;
                    RunObject = Page "Contact Segment List";
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FILTER(<> ''),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact No.", "Segment No.");
                    ApplicationArea = All;
                }
                action("Mailing &Groups")
                {
                    Caption = 'Mailing &Groups';
                    Image = DistributionGroup;
                    RunObject = Page "Contact Mailing Groups";
                    RunPageLink = "Contact No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("C&ustomer/Vendor/Bank Acc.")
                {
                    Caption = 'C&ustomer/Vendor/Bank Acc.';
                    Image = ContactReference;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowCustVendBank();
                    end;
                }
            }
            group(Tasks)
            {
                Caption = 'Tasks';
                Image = Task;
                action("T&o-dos")
                {
                    Caption = 'T&o-dos';
                    Image = TaskList;
                    RunObject = Page "Task List";
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No.")),
                                  "System To-do Type" = FILTER("Contact Attendee");
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                    ApplicationArea = All;
                }
                action("Oppo&rtunities")
                {
                    Caption = 'Oppo&rtunities';
                    Image = OpportunityList;
                    RunObject = Page "Opportunity List";
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FILTER(<> ''),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                    ApplicationArea = All;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("Sales &Quotes")
                {
                    Caption = 'Sales &Quotes';
                    Image = Quote;
                    RunObject = Page "Sales Quotes";
                    RunPageLink = "Sell-to Contact No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Contact No.");
                    ApplicationArea = All;
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Postponed &Interactions")
                {
                    Caption = 'Postponed &Interactions';
                    Image = PostponedInteractions;
                    RunObject = Page "Postponed Interactions";
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FILTER(<> ''),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                    ApplicationArea = All;
                }
                action("Interaction Log E&ntries")
                {
                    Caption = 'Interaction Log E&ntries';
                    Image = InteractionLog;
                    RunObject = Page "Interaction Log Entries";
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FILTER(<> ''),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Contact Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Make &Phone Call")
                {
                    Caption = 'Make &Phone Call';
                    Image = Calls;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        TAPIManagement: Codeunit "TAPIManagement";
                    begin
                        TAPIManagement.DialContCustVendBank(DATABASE::Contact, Rec."No.", Rec."Phone No.", '');
                    end;
                }
                action("Launch &Web Source")
                {
                    Caption = 'Launch &Web Source';
                    Image = LaunchWeb;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ContactWebSource: Record "Contact Web Source";
                    begin
                        ContactWebSource.SETRANGE("Contact No.", Rec."Company No.");
                        IF PAGE.RUNMODAL(PAGE::"Web Source Launch", ContactWebSource) = ACTION::LookupOK THEN
                            ContactWebSource.Launch();
                    end;
                }
                action("Print Cover &Sheet")
                {
                    Caption = 'Print Cover &Sheet';
                    Image = PrintCover;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Cont: Record "Contact";
                    begin
                        Cont := Rec;
                        Cont.SETRECFILTER();
                        REPORT.RUN(REPORT::"Contact - Cover Sheet", TRUE, FALSE, Cont);
                    end;
                }
                group("Create as")
                {
                    Caption = 'Create as';
                    Image = CustomerContact;
                    action(MgtsCustomer)
                    {
                        Caption = 'Customer';
                        Image = Customer;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Rec.CreateCustomer(Rec.ChooseCustomerTemplate());
                        end;
                    }
                    action(MgtsVendor)
                    {
                        Caption = 'Vendor';
                        Image = Vendor;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Rec.CreateVendor();
                        end;
                    }
                    action(MgtsBank)
                    {
                        Caption = 'Bank';
                        Image = Bank;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Rec.CreateBankAccount();
                        end;
                    }
                }
                group("Link with existing")
                {
                    Caption = 'Link with existing';
                    Image = Links;
                    action(Customer)
                    {
                        Caption = 'Customer';
                        Image = Customer;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Rec.CreateCustomerLink();
                        end;
                    }
                    action(Vendor)
                    {
                        Caption = 'Vendor';
                        Image = Vendor;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Rec.CreateVendorLink();
                        end;
                    }
                    action(Bank)
                    {
                        Caption = 'Bank';
                        Image = Bank;
                        ApplicationArea = All;

                        trigger OnAction()
                        begin
                            Rec.CreateBankAccountLink();
                        end;
                    }
                }
            }
            action("Create &Interact")
            {
                Caption = 'Create &Interact';
                Image = CreateInteraction;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.CreateInteraction();
                end;
            }
        }
        area(creation)
        {
            action("New Sales Quote")
            {
                Caption = 'New Sales Quote';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Sales Quote";
                RunPageLink = "Sell-to Contact No." = FIELD("No.");
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            action("Contact Cover Sheet")
            {
                Caption = 'Contact Cover Sheet';
                Image = "Report";
                Promoted = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Cont := Rec;
                    Cont.SETRECFILTER();
                    REPORT.RUN(REPORT::"Contact - Cover Sheet", TRUE, FALSE, Cont);
                end;
            }
            action("Contact Company Summary")
            {
                Caption = 'Contact Company Summary';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Contact - Company Summary";
                ApplicationArea = All;
            }
            action("Contact Labels")
            {
                Caption = 'Contact Labels';
                Image = "Report";
                Promoted = false;
                ;
                RunObject = Report "Contact - Labels";
                ApplicationArea = All;
            }
            action("Questionnaire Handout")
            {
                Caption = 'Questionnaire Handout';
                Image = "Report";
                Promoted = false;
                RunObject = Report "Questionnaire - Handouts";
                ApplicationArea = All;
            }
            action("Sales Cycle Analysis")
            {
                Caption = 'Sales Cycle Analysis';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Sales Cycle - Analysis";
                ApplicationArea = All;
            }
        }
    }

    var
        Cont: Record "Contact";

        CompanyGroupEnabled: Boolean;
        PersonGroupEnabled: Boolean;
}
