page 50066 "DEL Liste Notation contact"
{
    Caption = 'Rating contracts List';
    CardPageID = "DEL Contact Notation Card";
    Editable = false;
    PageType = List;
    SourceTable = Contact;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field("Note Quality"; Rec."DEL Note Quality")
                {
                    Caption = 'Quality rating';
                }
                field("Realisation Date Quality"; Rec."DEL Realisation Date Quality")
                {
                    Caption = 'Creation Date';
                }
                field("Revision Date quality"; Rec."DEL Revision Date quality")
                {
                    Caption = 'Expired Date';
                }
                field("Note Soc"; Rec."DEL Note Soc")
                {
                    Caption = 'Social rating';
                }
                field("Realisation Date Soc"; Rec."DEL Realisation Date Soc")
                {
                    Caption = 'Creation Date Soc';
                }
                field("Revision Date Soc"; Rec."DEL Revision Date Soc")
                {
                    Caption = 'Expired Date Soc';
                }
                field("Note Env"; Rec."DEL Note Env")
                {
                    Caption = 'Environmental rating';
                }
                field("Realisation Date Env"; Rec."DEL Realisation Date Env")
                {
                    Caption = 'Creation Date Env';
                }
                field("Revision Date env"; Rec."DEL Revision Date env")
                {
                    Caption = 'Expired Date Env';
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
                    }
                    action("Industry Groups")
                    {
                        Caption = 'Industry Groups';
                        Image = IndustryGroups;
                        RunObject = Page "Contact Industry Groups";
                        RunPageLink = "Contact No." = FIELD("Company No.");
                    }
                    action("Web Sources")
                    {
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
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Contact Picture";

                    RunPageLink = "No." = FIELD("No.");
                }
                action("Co&mments")
                {
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
                        Caption = 'Card';
                        Image = EditLines;
                        RunObject = Page "Contact Alt. Address List";
                        RunPageLink = "Contact No." = FIELD("No.");
                    }
                    action("Date Ranges")
                    {
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
                    Caption = 'Relate&d Contacts';
                    Image = Users;
                    RunObject = Page "Contact List";
                    RunPageLink = "Company No." = FIELD("Company No.");
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
                }
                action("Mailing &Groups")
                {
                    Caption = 'Mailing &Groups';
                    Image = DistributionGroup;
                    RunObject = Page "Contact Mailing Groups";
                    RunPageLink = "Contact No." = FIELD("No.");
                }
                action("C&ustomer/Vendor/Bank Acc.")
                {
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
                        Caption = 'Customer';
                        Image = Customer;

                        trigger OnAction()
                        begin
                            Rec.CreateCustomer(Rec.ChooseCustomerTemplate());
                        end;
                    }
                    action(MgtsVendor)
                    {
                        Caption = 'Vendor';
                        Image = Vendor;

                        trigger OnAction()
                        begin
                            Rec.CreateVendor();
                        end;
                    }
                    action(MgtsBank)
                    {
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
                        Caption = 'Customer';
                        Image = Customer;

                        trigger OnAction()
                        begin
                            Rec.CreateCustomerLink();
                        end;
                    }
                    action(Vendor)
                    {
                        Caption = 'Vendor';
                        Image = Vendor;

                        trigger OnAction()
                        begin
                            Rec.CreateVendorLink();
                        end;
                    }
                    action(Bank)
                    {
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
                Caption = 'Create &Interact';
                Image = CreateInteraction;
                Promoted = true;
                PromotedCategory = Process;

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
            }
        }
        area(reporting)
        {
            action("Contact Cover Sheet")
            {
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
                Caption = 'Contact Company Summary';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Contact - Company Summary";
            }
            action("Contact Labels")
            {
                Caption = 'Contact Labels';
                Image = "Report";
                Promoted = false;
                ;
                RunObject = Report "Contact - Labels";
            }
            action("Questionnaire Handout")
            {
                Caption = 'Questionnaire Handout';
                Image = "Report";
                Promoted = false;

                RunObject = Report "Questionnaire - Handouts";
            }
            action("Sales Cycle Analysis")
            {
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

    local procedure EnableFields()
    begin
        CompanyGroupEnabled := Rec.Type = Rec.Type::Company;
        PersonGroupEnabled := Rec.Type = Rec.Type::Person;
    end;
}

