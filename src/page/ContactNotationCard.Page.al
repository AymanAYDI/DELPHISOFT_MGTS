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
                field("No."; Rec."No.")
                {

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field(Type; Rec.Type)
                {

                    trigger OnValidate()
                    begin
                        TypeOnAfterValidate();
                    end;
                }
                field("Company No."; Rec."Company No.")
                {
                    Enabled = "Company No.Enable";
                }
                field("Company Name"; Rec."Company Name")
                {
                    AssistEdit = true;
                    Enabled = "Company NameEnable";

                    trigger OnAssistEdit()
                    begin
                        Cont.SETRANGE("No.", Rec."Company No.");
                        CLEAR(CompanyDetails);
                        CompanyDetails.SETTABLEVIEW(Cont);
                        CompanyDetails.SETRECORD(Cont);
                        IF Rec.Type = Rec.Type::Person THEN
                            CompanyDetails.EDITABLE := FALSE;
                        CompanyDetails.RUNMODAL();
                    end;
                }
                field(IntegrationCustomerNo; IntegrationCustomerNo)
                {
                    Caption = 'Integration Customer No.';
                    Visible = false;

                    trigger OnValidate()
                    var
                        ContactBusinessRelation: Record "Contact Business Relation";
                        Customer: Record Customer;
                    begin
                        IF NOT (IntegrationCustomerNo = '') THEN BEGIN
                            Customer.GET(IntegrationCustomerNo);
                            ContactBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                            ContactBusinessRelation.SETRANGE("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                            ContactBusinessRelation.SETRANGE("No.", Customer."No.");
                            IF ContactBusinessRelation.FINDFIRST() THEN
                                Rec.VALIDATE("Company No.", ContactBusinessRelation."Contact No.");
                        END ELSE
                            Rec.VALIDATE("Company No.", '');
                    end;
                }
                field(Name; Rec.Name)
                {
                    AssistEdit = true;

                    trigger OnAssistEdit()
                    begin
                        Rec.MODIFY();
                        COMMIT();
                        Cont.SETRANGE("No.", Rec."No.");
                        IF Rec.Type = Rec.Type::Person THEN BEGIN
                            CLEAR(NameDetails);
                            NameDetails.SETTABLEVIEW(Cont);
                            NameDetails.SETRECORD(Cont);
                            NameDetails.RUNMODAL();
                        END ELSE BEGIN
                            CLEAR(CompanyDetails);
                            CompanyDetails.SETTABLEVIEW(Cont);
                            CompanyDetails.SETRECORD(Cont);
                            CompanyDetails.RUNMODAL();
                        END;
                        Rec.GET(Rec."No.");
                        CurrPage.UPDATE();
                    end;
                }
                field(Address; Rec.Address)
                {
                }
                field("Address 2"; Rec."Address 2")
                {
                }
                field("Post Code"; Rec."Post Code")
                {
                }
                field(City; Rec.City)
                {
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                }
            }
            group("Audit Quality")
            {
                Caption = 'Audit Quality';
                field("URL Quality"; Rec."DEL URL Quality")
                {
                }
                field("Note Quality"; Rec."DEL Note Quality")
                {
                    Importance = Promoted;
                }
                field("Realisation Date Quality"; Rec."DEL Realisation Date Quality")
                {
                }
                field("Revision Date quality"; Rec."DEL Revision Date quality")
                {
                }
            }
            group("Audit  Social")
            {
                Caption = 'Audit  Social';
                field("URL social"; Rec."DEL URL social")
                {
                }
                field("Note Soc"; Rec."DEL Note Soc")
                {
                    Importance = Promoted;
                }
                field("Realisation Date Soc"; Rec."DEL Realisation Date Soc")
                {
                }
                field("Revision Date Soc"; Rec."DEL Revision Date Soc")
                {
                }
                part("Detail Social Audit Contact"; "DEL Detail Soc. Audit Contact")
                {

                    SubPageLink = "Vendor/Contact No." = FIELD("No."),
                                  Type = FILTER("Contact");
                }
            }
            group("Environmental Audit")
            {
                Caption = 'Environmental Audit';
                field("URL Environmental"; Rec."DEL URL Environmental")
                {
                }
                field("Note Env"; Rec."DEL Note Env")
                {
                    Importance = Promoted;
                }
                field("Realisation Date Env"; Rec."DEL Realisation Date Env")
                {
                }
                field("Revision Date env"; Rec."DEL Revision Date env")
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
                        Rec.DisplayMap();
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
                            Rec.TESTFIELD(Type, Rec.Type::Company);
                            ContactBusinessRelationRec.SETRANGE("Contact No.", Rec."Company No.");
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
                            Rec.TESTFIELD(Type, Rec.Type::Company);
                            ContactIndustryGroupRec.SETRANGE("Contact No.", Rec."Company No.");
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
                            Rec.TESTFIELD(Type, Rec.Type::Company);
                            ContactWebSourceRec.SETRANGE("Contact No.", Rec."Company No.");
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
                action("MgtsCo&mments")
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
                action("MgtsOnline Map")
                {
                    Caption = 'Online Map';
                    Image = Map;

                    trigger OnAction()
                    begin
                        Rec.DisplayMap();
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
                    RunPageLink = "Contact Company No." = FIELD(FILTER("Company No.")),
                                  "Contact No." = FIELD(FILTER("No.")),
                                  "System To-do Type" = FILTER("Contact Attendee");
                    RunPageView = SORTING("Contact Company No.", Date, "Contact No.", Closed);
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
                    Promoted = true;
                    PromotedCategory = Process;
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
                    RunPageView = SORTING("Contact Company No.", Date, "Contact No.", Canceled, "Initiated By", "Attempt Failed");
                }
                action("Interaction Log E&ntries")
                {
                    Caption = 'Interaction Log E&ntries';
                    Image = InteractionLog;
                    RunObject = Page "Interaction Log Entries";
                    RunPageLink = "Contact Company No." = FIELD("Company No."),
                                  "Contact No." = FILTER(<> ''),
                                  "Contact No." = FIELD(FILTER("Lookup Contact No."));
                    RunPageView = SORTING("Contact Company No.", Date, "Contact No.", Canceled, "Initiated By", "Attempt Failed");
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

                action("Apply Template")
                {
                    Caption = 'Apply Template';
                    Ellipsis = true;
                    Image = ApplyTemplate;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ConfigTemplateMgt: Codeunit "Config. Template Management";
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
                    Rec.CreateInteraction();
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
                    Cont.SETRECFILTER();
                    REPORT.RUN(REPORT::"Contact - Cover Sheet", TRUE, FALSE, Cont);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        EnableFields();

        IF Rec.Type = Rec.Type::Person THEN
            IntegrationFindCustomerNo()
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
        MapMgt: Codeunit "Online Map Management";
    begin
        IF NOT MapMgt.TestSetup() THEN
            MapPointVisible := FALSE;
    end;

    var
        Cont: Record Contact;
        CompanyDetails: Page "Company Details";
        NameDetails: Page "Name Details";
        CompanyGroupEnabled: Boolean;
        [InDataSet]
        "Company NameEnable": Boolean;
        [InDataSet]
        "Company No.Enable": Boolean;
        [InDataSet]
        "Currency CodeEnable": Boolean;
        [InDataSet]

        MapPointVisible: Boolean;
        [InDataSet]
        NoofJobResponsibilitiesEnable: Boolean;
        [InDataSet]
        OrganizationalLevelCodeEnable: Boolean;
        PersonGroupEnabled: Boolean;
        [InDataSet]
        "VAT Registration No.Enable": Boolean;
        IntegrationCustomerNo: Code[20];

    local procedure EnableFields()
    begin
        CompanyGroupEnabled := Rec.Type = Rec.Type::Company;
        PersonGroupEnabled := Rec.Type = Rec.Type::Person;
        "Currency CodeEnable" := Rec.Type = Rec.Type::Company;
        "VAT Registration No.Enable" := Rec.Type = Rec.Type::Company;
        "Company No.Enable" := Rec.Type = Rec.Type::Person;
        "Company NameEnable" := Rec.Type = Rec.Type::Person;
        OrganizationalLevelCodeEnable := Rec.Type = Rec.Type::Person;
        NoofJobResponsibilitiesEnable := Rec.Type = Rec.Type::Person;
    end;


    procedure IntegrationFindCustomerNo()
    var
        ContactBusinessRelation: Record "Contact Business Relation";
    begin
        ContactBusinessRelation.SETCURRENTKEY("Link to Table", "Contact No.");
        ContactBusinessRelation.SETRANGE("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
        ContactBusinessRelation.SETRANGE("Contact No.", Rec."Company No.");
        IF ContactBusinessRelation.FINDFIRST() THEN
            IntegrationCustomerNo := ContactBusinessRelation."No."
        ELSE
            IntegrationCustomerNo := '';
    end;

    local procedure TypeOnAfterValidate()
    begin
        EnableFields();
    end;
}

