page 50067 "DEL Contact Notation Card"
{


    Caption = 'Contact Card';
    PageType = Card;
    SourceTable = Contact;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Type; Type)
                {

                    trigger OnValidate()
                    begin
                        TypeOnAfterValidate;
                    end;
                }
                field("Company No."; "Company No.")
                {
                    Enabled = "Company No.Enable";
                }
                field("Company Name"; "Company Name")
                {
                    AssistEdit = true;
                    Enabled = "Company NameEnable";

                    trigger OnAssistEdit()
                    begin
                        Cont.SETRANGE("No.", "Company No.");
                        CLEAR(CompanyDetails);
                        CompanyDetails.SETTABLEVIEW(Cont);
                        CompanyDetails.SETRECORD(Cont);
                        IF Type = Type::Person THEN
                            CompanyDetails.EDITABLE := FALSE;
                        CompanyDetails.RUNMODAL;
                    end;
                }
                field(IntegrationCustomerNo; IntegrationCustomerNo)
                {
                    Caption = 'Integration Customer No.';
                    Visible = false;

                    trigger OnValidate()
                    var
                        Customer: Record "18";
                        ContactBusinessRelation: Record "5054";
                    begin
                        IF NOT (IntegrationCustomerNo = '') THEN BEGIN
                            Customer.GET(IntegrationCustomerNo);
                            ContactBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                            ContactBusinessRelation.SETRANGE("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                            ContactBusinessRelation.SETRANGE("No.", Customer."No.");
                            IF ContactBusinessRelation.FINDFIRST THEN
                                VALIDATE("Company No.", ContactBusinessRelation."Contact No.");
                        END ELSE
                            VALIDATE("Company No.", '');
                    end;
                }
                field(Name; Name)
                {
                    AssistEdit = true;

                    trigger OnAssistEdit()
                    begin
                        MODIFY;
                        COMMIT;
                        Cont.SETRANGE("No.", "No.");
                        IF Type = Type::Person THEN BEGIN
                            CLEAR(NameDetails);
                            NameDetails.SETTABLEVIEW(Cont);
                            NameDetails.SETRECORD(Cont);
                            NameDetails.RUNMODAL;
                        END ELSE BEGIN
                            CLEAR(CompanyDetails);
                            CompanyDetails.SETTABLEVIEW(Cont);
                            CompanyDetails.SETRECORD(Cont);
                            CompanyDetails.RUNMODAL;
                        END;
                        GET("No.");
                        CurrPage.UPDATE;
                    end;
                }
                field(Address; Address)
                {
                }
                field("Address 2"; "Address 2")
                {
                }
                field("Post Code"; "Post Code")
                {
                }
                field(City; City)
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
            }
            group("Audit Quality")
            {
                Caption = 'Audit Quality';
                field("URL Quality"; "URL Quality")
                {
                }
                field("Note Quality"; "Note Quality")
                {
                    Importance = Promoted;
                }
                field("Realisation Date Quality"; "Realisation Date Quality")
                {
                }
                field("Revision Date quality"; "Revision Date quality")
                {
                }
            }
            group("Audit  Social")
            {
                Caption = 'Audit  Social';
                field("URL social"; "URL social")
                {
                }
                field("Note Soc"; "Note Soc")
                {
                    Importance = Promoted;
                }
                field("Realisation Date Soc"; "Realisation Date Soc")
                {
                }
                field("Revision Date Soc"; "Revision Date Soc")
                {
                }
                part("Detail Social Audit Contact"; "DEL Detail Social Audit Contact")
                {
                    SubPageLink = "Vendor/Contact No." = FIELD("No."),
                                  Type = FILTER(Contact);
                }
            }
            group("Environmental Audit")
            {
                Caption = 'Environmental Audit';
                field("URL Environmental"; "URL Environmental")
                {
                }
                field("Note Env"; "Note Env")
                {
                    Importance = Promoted;
                }
                field("Realisation Date Env"; "Realisation Date Env")
                {
                }
                field("Revision Date env"; "Revision Date env")
                {
                }
            }
            part("Rlshp. Mgt. Comment Sheet"; "Rlshp. Mgt. Comment Sheet")
            {
                SubPageLink = "Table Name" = FILTER(Contact),
                              "No." = FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
            }
            systempart(Notes; Notes)
            {
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
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Rlshp. Mgt. Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Contact),
                                  "No." = FIELD("No."),
                                  "Sub No." = CONST(0);
                }
                action("Online Map")
                {
                    Caption = 'Online Map';
                    Image = Map;

                    trigger OnAction()
                    begin
                        DisplayMap;
                    end;
                }
                action("Doc&uments")
                {
                    Caption = 'Audit Report';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Document Sheet";
                    RunPageLink = "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Comment Entry No.", "Line No.")
                                  WHERE("Table Name" = CONST(Contact));
                }
                group("Comp&any")
                {
                    Caption = 'Comp&any';
                    Enabled = CompanyGroupEnabled;
                    Image = Company;
                    action("Business Relations")
                    {
                        Caption = 'Business Relations';
                        Image = BusinessRelation;

                        trigger OnAction()
                        var
                            ContactBusinessRelationRec: Record "Contact Business Relation";
                        begin
                            TESTFIELD(Type, Type::Company);
                            ContactBusinessRelationRec.SETRANGE("Contact No.", "Company No.");
                            PAGE.RUN(PAGE::"Contact Business Relations", ContactBusinessRelationRec);
                        end;
                    }
                    action("Industry Groups")
                    {
                        Caption = 'Industry Groups';
                        Image = IndustryGroups;

                        trigger OnAction()
                        var
                            ContactIndustryGroupRec: Record "Contact Industry Group";
                        begin
                            TESTFIELD(Type, Type::Company);
                            ContactIndustryGroupRec.SETRANGE("Contact No.", "Company No.");
                            PAGE.RUN(PAGE::"Contact Industry Groups", ContactIndustryGroupRec);
                        end;
                    }
                    action("Web Sources")
                    {
                        Caption = 'Web Sources';
                        Image = Web;

                        trigger OnAction()
                        var
                            ContactWebSourceRec: Record "Contact Web Source";
                        begin
                            TESTFIELD(Type, Type::Company);
                            ContactWebSourceRec.SETRANGE("Contact No.", "Company No.");
                            PAGE.RUN(PAGE::"Contact Web Sources", ContactWebSourceRec);
                        end;
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
                            TESTFIELD(Type, Type::Person);
                            ContJobResp.SETRANGE("Contact No.", "No.");
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
                action("Online Map")
                {
                    Caption = 'Online Map';
                    Image = Map;

                    trigger OnAction()
                    begin
                        DisplayMap;
                    end;
                }
                separator()
                {
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
                                    RunPageLink = Contact Company No.=FIELD(FILTER(Company No.)),
                                  Contact No.=FIELD(FILTER(No.)),
                                  System To-do Type=FILTER(Contact Attendee);
                    RunPageView = SORTING(Contact Company No.,Date,Contact No.,Closed);
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
                    Promoted = true;
                    PromotedCategory = Process;
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
                    RunPageView = SORTING(Contact Company No.,Date,Contact No.,Canceled,Initiated By,Attempt Failed);
                }
                action("Interaction Log E&ntries")
                {
                    Caption = 'Interaction Log E&ntries';
                    Image = InteractionLog;
                    RunObject = Page 5076;
                                    RunPageLink = Contact Company No.=FIELD(Company No.),
                                  Contact No.=FILTER(<>''),
                                  Contact No.=FIELD(FILTER(Lookup Contact No.));
                    RunPageView = SORTING(Contact Company No.,Date,Contact No.,Canceled,Initiated By,Attempt Failed);
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
                separator()
                {
                }
                action("Apply Template")
                {
                    Caption = 'Apply Template';
                    Ellipsis = true;
                    Image = ApplyTemplate;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ConfigTemplateMgt: Codeunit "8612";
                        RecRef: RecordRef;
                    begin
                        RecRef.GETTABLE(Rec);
                        ConfigTemplateMgt.UpdateFromTemplateSelection(RecRef);
                    end;
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
        area(reporting)
        {
            action("Contact Cover Sheet")
            {
                Caption = 'Contact Cover Sheet';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    Cont := Rec;
                    Cont.SETRECFILTER;
                    REPORT.RUN(REPORT::"Contact - Cover Sheet",TRUE,FALSE,Cont);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        EnableFields;

        IF Type = Type::Person THEN
          IntegrationFindCustomerNo
        ELSE
          IntegrationCustomerNo := '';
    end;

    trigger OnInit()
    begin
        NoofJobResponsibilitiesEnable := TRUE;
        OrganizationalLevelCodeEnable := TRUE;
        "Company NameEnable" := TRUE;
        "Company No.Enable" := TRUE;
        "VAT Registration No.Enable" := TRUE;
        "Currency CodeEnable" := TRUE;
        MapPointVisible := TRUE;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "802";
    begin
        IF NOT MapMgt.TestSetup THEN
          MapPointVisible := FALSE;
    end;

    var
        Cont: Record "5050";
        CompanyDetails: Page "5054";
                            NameDetails: Page "5055";
                            IntegrationCustomerNo: Code[20];
    [InDataSet]

    MapPointVisible: Boolean;
        [InDataSet]
        "Currency CodeEnable": Boolean;
        [InDataSet]
        "VAT Registration No.Enable": Boolean;
        [InDataSet]
        "Company No.Enable": Boolean;
        [InDataSet]
        "Company NameEnable": Boolean;
        [InDataSet]
        OrganizationalLevelCodeEnable: Boolean;
        [InDataSet]
        NoofJobResponsibilitiesEnable: Boolean;
        CompanyGroupEnabled: Boolean;
        PersonGroupEnabled: Boolean;

    local procedure EnableFields()
    begin
        CompanyGroupEnabled := Type = Type::Company;
        PersonGroupEnabled := Type = Type::Person;
        "Currency CodeEnable" := Type = Type::Company;
        "VAT Registration No.Enable" := Type = Type::Company;
        "Company No.Enable" := Type = Type::Person;
        "Company NameEnable" := Type = Type::Person;
        OrganizationalLevelCodeEnable := Type = Type::Person;
        NoofJobResponsibilitiesEnable := Type = Type::Person;
    end;

    [Scope('Internal')]
    procedure IntegrationFindCustomerNo()
    var
        ContactBusinessRelation: Record "5054";
    begin
        ContactBusinessRelation.SETCURRENTKEY("Link to Table","Contact No.");
        ContactBusinessRelation.SETRANGE("Link to Table",ContactBusinessRelation."Link to Table"::Customer);
        ContactBusinessRelation.SETRANGE("Contact No.","Company No.");
        IF ContactBusinessRelation.FINDFIRST THEN BEGIN
          IntegrationCustomerNo := ContactBusinessRelation."No.";
        END ELSE
          IntegrationCustomerNo := '';
    end;

    local procedure TypeOnAfterValidate()
    begin
        EnableFields;
    end;
}

