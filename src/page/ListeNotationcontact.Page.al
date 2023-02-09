page 50066 "DEL Liste Notation contact"
{
    ApplicationArea = all;
    Caption = 'Rating contracts List';
    CardPageID = "DEL Contact Notation Card";
    Editable = false;
    PageType = List;
    SourceTable = Contact;
    UsageCategory = Lists;
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
                        ApplicationArea = All;
                        Caption = 'Business Relations';
                        Image = BusinessRelation;
                        RunObject = Page "Contact Business Relations";
                        RunPageLink = "Contact No." = FIELD("Company No.");
                    }
                    action("Industry Groups")
                    {
                        ApplicationArea = All;
                        Caption = 'Industry Groups';
                        Image = IndustryGroups;
                        RunObject = Page "Contact Industry Groups";
                        RunPageLink = "Contact No." = FIELD("Company No.");
                    }
                    action("Web Sources")
                    {
                        ApplicationArea = All;
                        Caption = 'Web Sources';
                        Image = Web;
                        RunObject = Page "Contact Web Sources";
                        RunPageLink = "Contact No." = FIELD("Company No.");
                    }
                }
                group("P&erson")
                {
                    Caption = 'P&erson';
                    Enabled = PersonGroupEnabled;
                    Image = User;
                    action("Job Responsibilities")
                    {
                        ApplicationArea = All;
                        Caption = 'Job Responsibilities';
                        Image = Job;

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
                    ApplicationArea = All;
                    Caption = 'Pro&files';
                    Image = Answers;

                    trigger OnAction()
                    var
                        ProfileManagement: Codeunit ProfileManagement;
                    begin
                        ProfileManagement.ShowContactQuestionnaireCard(Rec, '', 0);
                    end;
                }
                action("&Picture")
                {
                    ApplicationArea = All;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Contact Picture";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Rlshp. Mgt. Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Contact),
                                  "No." = FIELD("No."),
                                  "Sub No." = CONST(0);
                }
                group("Alternati&ve Address")
                {
                    Caption = 'Alternati&ve Address';
                    Image = Addresses;
                    action(Card)
                    {
                        ApplicationArea = All;
                        Caption = 'Card';
                        Image = EditLines;
                        RunObject = Page "Contact Alt. Address List";
                        RunPageLink = "Contact No." = FIELD("No.");
                    }
                    action("Date Ranges")
                    {
                        ApplicationArea = All;
                        Caption = 'Date Ranges';
                        Image = DateRange;
                        RunObject = Page "Contact Alt. Addr. Date Ranges";
                        RunPageLink = "Contact No." = FIELD("No.");
                    }
                }
            }
            group("Related Information")
            {
                Caption = 'Related Information';
                Image = Users;
                action("Relate&d Contacts")
                {
                    ApplicationArea = All;
                    Caption = 'Relate&d Contacts';
                    Image = Users;
                    RunObject = Page "Contact List";
                    RunPageLink = "Company No." = FIELD("Company No.");
                }
                action("Segmen&ts")
                {
                    ApplicationArea = All;
                    Caption = 'Segmen&ts';
                    Image = Segment;
                    RunObject = Page "Contact Segment List";
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FILTER(<> ''),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact No.", "Segment No.");
                }
                action("Mailing &Groups")
                {
                    ApplicationArea = All;
                    Caption = 'Mailing &Groups';
                    Image = DistributionGroup;
                    RunObject = Page "Contact Mailing Groups";
                    RunPageLink = "Contact No." = FIELD("No.");
                }
                action("C&ustomer/Vendor/Bank Acc.")
                {
                    ApplicationArea = All;
                    Caption = 'C&ustomer/Vendor/Bank Acc.';
                    Image = ContactReference;

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
                    ApplicationArea = All;
                    Caption = 'T&o-dos';
                    Image = TaskList;
                    RunObject = Page "Task List";
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No.")),
                                  "System To-do Type" = FILTER("Contact Attendee");
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                }
                action("Oppo&rtunities")
                {
                    ApplicationArea = All;
                    Caption = 'Oppo&rtunities';
                    Image = OpportunityList;
                    RunObject = Page "Opportunity List";
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FILTER(<> ''),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action("Sales &Quotes")
                {
                    ApplicationArea = All;
                    Caption = 'Sales &Quotes';
                    Image = Quote;
                    RunObject = Page "Sales Quotes";
                    RunPageLink = "Sell-to Contact No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Contact No.");
                }
            }
            group(History)
            {
                Caption = 'History';
                Image = History;
                action("Postponed &Interactions")
                {
                    ApplicationArea = All;
                    Caption = 'Postponed &Interactions';
                    Image = PostponedInteractions;
                    RunObject = Page "Postponed Interactions";
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FILTER(<> ''),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                }
                action("Interaction Log E&ntries")
                {
                    ApplicationArea = All;
                    Caption = 'Interaction Log E&ntries';
                    Image = InteractionLog;
                    RunObject = Page "Interaction Log Entries";
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FILTER(<> ''),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", "Contact No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Contact Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
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
                    ApplicationArea = All;
                    Caption = 'Make &Phone Call';
                    Image = Calls;

                    trigger OnAction()
                    var
                        TAPIManagement: Codeunit "TAPIManagement";
                    begin
                        TAPIManagement.DialContCustVendBank(DATABASE::Contact, Rec."No.", Rec."Phone No.", '');
                    end;
                }
                action("Launch &Web Source")
                {
                    ApplicationArea = All;
                    Caption = 'Launch &Web Source';
                    Image = LaunchWeb;

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
                    ApplicationArea = All;
                    Caption = 'Print Cover &Sheet';
                    Image = PrintCover;

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
                        ApplicationArea = All;
                        Caption = 'Customer';
                        Image = Customer;

                        trigger OnAction()
                        begin
                            Rec.CreateCustomer(Rec.ChooseCustomerTemplate());
                        end;
                    }
                    action(MgtsVendor)
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor';
                        Image = Vendor;

                        trigger OnAction()
                        begin
                            Rec.CreateVendor();
                        end;
                    }
                    action(MgtsBank)
                    {
                        ApplicationArea = All;
                        Caption = 'Bank';
                        Image = Bank;

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
                        ApplicationArea = All;
                        Caption = 'Customer';
                        Image = Customer;

                        trigger OnAction()
                        begin
                            Rec.CreateCustomerLink();
                        end;
                    }
                    action(Vendor)
                    {
                        ApplicationArea = All;
                        Caption = 'Vendor';
                        Image = Vendor;

                        trigger OnAction()
                        begin
                            Rec.CreateVendorLink();
                        end;
                    }
                    action(Bank)
                    {
                        ApplicationArea = All;
                        Caption = 'Bank';
                        Image = Bank;

                        trigger OnAction()
                        begin
                            Rec.CreateBankAccountLink();
                        end;
                    }
                }
            }
            action("Create &Interact")
            {
                ApplicationArea = All;
                Caption = 'Create &Interact';
                Image = CreateInteraction;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

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
                ApplicationArea = All;
                Caption = 'New Sales Quote';
                Image = Quote;
                Promoted = true;
                PromotedCategory = New;
                RunObject = Page "Sales Quote";
                RunPageLink = "Sell-to Contact No." = FIELD("No.");
                RunPageMode = Create;
            }
        }
        area(reporting)
        {
            action("Contact Cover Sheet")
            {
                ApplicationArea = All;
                Caption = 'Contact Cover Sheet';
                Image = "Report";
                Promoted = false;

                trigger OnAction()
                begin
                    Cont := Rec;
                    Cont.SETRECFILTER();
                    REPORT.RUN(REPORT::"Contact - Cover Sheet", TRUE, FALSE, Cont);
                end;
            }
            action("Contact Company Summary")
            {
                ApplicationArea = All;
                Caption = 'Contact Company Summary';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Contact - Company Summary";
            }
            action("Contact Labels")
            {
                ApplicationArea = All;
                Caption = 'Contact Labels';
                Image = "Report";
                Promoted = false;
                RunObject = Report "Contact - Labels";
                ;
            }
            action("Questionnaire Handout")
            {
                ApplicationArea = All;
                Caption = 'Questionnaire Handout';
                Image = "Report";
                Promoted = false;
                RunObject = Report "Questionnaire - Handouts";
            }
            action("Sales Cycle Analysis")
            {
                ApplicationArea = All;
                Caption = 'Sales Cycle Analysis';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Sales Cycle - Analysis";
            }
        }
    }

    var
        Cont: Record "Contact";

        CompanyGroupEnabled: Boolean;
        PersonGroupEnabled: Boolean;
}
