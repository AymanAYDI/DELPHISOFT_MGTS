page 50066 "Liste Notation contact"
{
    Caption = 'Rating contracts List';
    CardPageID = "Contact Notation Card";
    Editable = false;
    PageType = List;
    SourceTable = Table5050;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field(Name; Name)
                {
                }
                field(Type; Type)
                {
                }
                field("Note Quality"; "Note Quality")
                {
                }
                field("Realisation Date Quality"; "Realisation Date Quality")
                {
                }
                field("Revision Date quality"; "Revision Date quality")
                {
                }
                field("Note Soc"; "Note Soc")
                {
                }
                field("Realisation Date Soc"; "Realisation Date Soc")
                {
                }
                field("Revision Date Soc"; "Revision Date Soc")
                {
                }
                field("Note Env"; "Note Env")
                {
                }
                field("Realisation Date Env"; "Realisation Date Env")
                {
                }
                field("Revision Date env"; "Revision Date env")
                {
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
                        RunObject = Page 5061;
                        RunPageLink = Contact No.=FIELD(Company No.);
                    }
                    action("Industry Groups")
                    {
                        Caption = 'Industry Groups';
                        Image = IndustryGroups;
                        RunObject = Page 5067;
                                        RunPageLink = Contact No.=FIELD(Company No.);
                    }
                    action("Web Sources")
                    {
                        Caption = 'Web Sources';
                        Image = Web;
                        RunObject = Page 5070;
                                        RunPageLink = Contact No.=FIELD(Company No.);
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
                            ContJobResp: Record "5067";
                        begin
                            TESTFIELD(Type,Type::Person);
                            ContJobResp.SETRANGE("Contact No.","No.");
                            PAGE.RUNMODAL(PAGE::"Contact Job Responsibilities",ContJobResp);
                        end;
                    }
                }
                action("Pro&files")
                {
                    Caption = 'Pro&files';
                    Image = Answers;

                    trigger OnAction()
                    var
                        ProfileManagement: Codeunit "5059";
                    begin
                        ProfileManagement.ShowContactQuestionnaireCard(Rec,'',0);
                    end;
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page 5104;
                                    RunPageLink = No.=FIELD(No.);
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5072;
                                    RunPageLink = Table Name=CONST(Contact),
                                  No.=FIELD(No.),
                                  Sub No.=CONST(0);
                }
                group("Alternati&ve Address")
                {
                    Caption = 'Alternati&ve Address';
                    Image = Addresses;
                    action(Card)
                    {
                        Caption = 'Card';
                        Image = EditLines;
                        RunObject = Page 5057;
                                        RunPageLink = Contact No.=FIELD(No.);
                    }
                    action("Date Ranges")
                    {
                        Caption = 'Date Ranges';
                        Image = DateRange;
                        RunObject = Page 5059;
                                        RunPageLink = Contact No.=FIELD(No.);
                    }
                }
                separator()
                {
                    Caption = '';
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
                    RunObject = Page 5052;
                                    RunPageLink = Company No.=FIELD(Company No.);
                }
                action("Segmen&ts")
                {
                    Caption = 'Segmen&ts';
                    Image = Segment;
                    RunObject = Page 5150;
                                    RunPageLink = Contact Company No.=FIELD(Company No.),
                                  Contact No.=FILTER(<>''),
                                  Contact No.=FIELD(FILTER(Lookup Contact No.));
                    RunPageView = SORTING(Contact No.,Segment No.);
                }
                action("Mailing &Groups")
                {
                    Caption = 'Mailing &Groups';
                    Image = DistributionGroup;
                    RunObject = Page 5064;
                                    RunPageLink = Contact No.=FIELD(No.);
                }
                action("C&ustomer/Vendor/Bank Acc.")
                {
                    Caption = 'C&ustomer/Vendor/Bank Acc.';
                    Image = ContactReference;

                    trigger OnAction()
                    begin
                        ShowCustVendBank;
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
                    RunObject = Page 5096;
                                    RunPageLink = Contact Company No.=FIELD(Company No.),
                                  Contact No.=FIELD(FILTER(Lookup Contact No.)),
                                  System To-do Type=FILTER(Contact Attendee);
                    RunPageView = SORTING(Contact Company No.,Contact No.);
                }
                action("Oppo&rtunities")
                {
                    Caption = 'Oppo&rtunities';
                    Image = OpportunityList;
                    RunObject = Page 5123;
                                    RunPageLink = Contact Company No.=FIELD(Company No.),
                                  Contact No.=FILTER(<>''),
                                  Contact No.=FIELD(FILTER(Lookup Contact No.));
                    RunPageView = SORTING(Contact Company No.,Contact No.);
                }
                separator()
                {
                    Caption = '';
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
                    RunObject = Page 9300;
                                    RunPageLink = Sell-to Contact No.=FIELD(No.);
                    RunPageView = SORTING(Document Type,Sell-to Contact No.);
                }
                separator()
                {
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
                    RunObject = Page 5082;
                                    RunPageLink = Contact Company No.=FIELD(Company No.),
                                  Contact No.=FILTER(<>''),
                                  Contact No.=FIELD(FILTER(Lookup Contact No.));
                    RunPageView = SORTING(Contact Company No.,Contact No.);
                }
                action("Interaction Log E&ntries")
                {
                    Caption = 'Interaction Log E&ntries';
                    Image = InteractionLog;
                    RunObject = Page 5076;
                                    RunPageLink = Contact Company No.=FIELD(Company No.),
                                  Contact No.=FILTER(<>''),
                                  Contact No.=FIELD(FILTER(Lookup Contact No.));
                    RunPageView = SORTING(Contact Company No.,Contact No.);
                    ShortCutKey = 'Ctrl+F7';
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5053;
                                    RunPageLink = No.=FIELD(No.);
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
                        TAPIManagement: Codeunit "5053";
                    begin
                        TAPIManagement.DialContCustVendBank(DATABASE::Contact,"No.","Phone No.",'');
                    end;
                }
                action("Launch &Web Source")
                {
                    Caption = 'Launch &Web Source';
                    Image = LaunchWeb;

                    trigger OnAction()
                    var
                        ContactWebSource: Record "5060";
                    begin
                        ContactWebSource.SETRANGE("Contact No.","Company No.");
                        IF PAGE.RUNMODAL(PAGE::"Web Source Launch",ContactWebSource) = ACTION::LookupOK THEN
                          ContactWebSource.Launch;
                    end;
                }
                action("Print Cover &Sheet")
                {
                    Caption = 'Print Cover &Sheet';
                    Image = PrintCover;

                    trigger OnAction()
                    var
                        Cont: Record "5050";
                    begin
                        Cont := Rec;
                        Cont.SETRECFILTER;
                        REPORT.RUN(REPORT::"Contact - Cover Sheet",TRUE,FALSE,Cont);
                    end;
                }
                group("Create as")
                {
                    Caption = 'Create as';
                    Image = CustomerContact;
                    action(Customer)
                    {
                        Caption = 'Customer';
                        Image = Customer;

                        trigger OnAction()
                        begin
                            CreateCustomer(ChooseCustomerTemplate);
                        end;
                    }
                    action(Vendor)
                    {
                        Caption = 'Vendor';
                        Image = Vendor;

                        trigger OnAction()
                        begin
                            CreateVendor;
                        end;
                    }
                    action(Bank)
                    {
                        Caption = 'Bank';
                        Image = Bank;

                        trigger OnAction()
                        begin
                            CreateBankAccount;
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
                            CreateCustomerLink;
                        end;
                    }
                    action(Vendor)
                    {
                        Caption = 'Vendor';
                        Image = Vendor;

                        trigger OnAction()
                        begin
                            CreateVendorLink;
                        end;
                    }
                    action(Bank)
                    {
                        Caption = 'Bank';
                        Image = Bank;

                        trigger OnAction()
                        begin
                            CreateBankAccountLink;
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
                    CreateInteraction;
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
                RunObject = Page 41;
                                RunPageLink = Sell-to Contact No.=FIELD(No.);
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
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Cont := Rec;
                    Cont.SETRECFILTER;
                    REPORT.RUN(REPORT::"Contact - Cover Sheet",TRUE,FALSE,Cont);
                end;
            }
            action("Contact Company Summary")
            {
                Caption = 'Contact Company Summary';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5051;
            }
            action("Contact Labels")
            {
                Caption = 'Contact Labels';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 5056;
            }
            action("Questionnaire Handout")
            {
                Caption = 'Questionnaire Handout';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 5066;
            }
            action("Sales Cycle Analysis")
            {
                Caption = 'Sales Cycle Analysis';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5062;
            }
        }
    }

    var
        Cont: Record "5050";
        [InDataSet]
        StyleIsStrong: Boolean;
        [InDataSet]
        NameIndent: Integer;
        CompanyGroupEnabled: Boolean;
        PersonGroupEnabled: Boolean;

    local procedure EnableFields()
    begin
        CompanyGroupEnabled := Type = Type::Company;
        PersonGroupEnabled := Type = Type::Person;
    end;
}

