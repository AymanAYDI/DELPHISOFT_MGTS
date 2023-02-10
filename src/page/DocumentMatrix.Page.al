page 50130 "DEL Document Matrix"
{

    DelayedInsert = true;
    PageType = List;
    SourceTable = "DEL Document Matrix";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = All;
                    Caption = 'Process Type';
                }
                field(Usage; Rec.Usage)
                {
                    ApplicationArea = All;
                    Caption = 'Usage';
                }
                field("Report ID"; Rec."Report ID")
                {
                    ApplicationArea = All;
                    Caption = 'Report ID';
                }
                field("Report Caption"; Rec."Report Caption")
                {
                    ApplicationArea = All;
                    Caption = 'Report Caption';
                }
                field(Post; Rec.Post)
                {
                    ApplicationArea = All;
                    Caption = 'Post';
                }
                field("Send to FTP 1"; Rec."Send to FTP 1")
                {
                    ApplicationArea = All;
                    Caption = 'Send to FTP 1';
                }
                field("Send to FTP 2"; Rec."Send to FTP 2")
                {
                    ApplicationArea = All;
                    Caption = 'Send to FTP 2';
                }
                field("E-Mail from Sales Order"; Rec."E-Mail from Sales Order")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail from Sales Order';
                }
                field("E-Mail To 1"; Rec."E-Mail To 1")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail To 1';
                }
                field("E-Mail To 2"; Rec."E-Mail To 2")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail To 2';
                }
                field("E-Mail To 3"; Rec."E-Mail To 3")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail To 3';
                }
                field("E-Mail From"; Rec."E-Mail From")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail From';
                }
                field("Save PDF"; Rec."Save PDF")
                {
                    ApplicationArea = All;
                    Caption = 'Save PDF';
                }
                field("Print PDF"; Rec."Print PDF")
                {
                    ApplicationArea = All;
                    Caption = 'Print PDF';
                }
                field("Mail Text Code"; Rec."Mail Text Code")
                {
                    ApplicationArea = All;
                    AssistEdit = false;
                    Caption = 'Mail Text Code';
                    DrillDown = false;
                    Lookup = true;
                    //TODO DrillDownPageID = 50132;  //50132 n'existe pas 

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lrecDocMatrixEmailCodes: Record "DEL DocMatrix Email Codes";
                        lpgDocMatrixMailCodes: Page "DEL DocMatrix Mail Codes";
                    begin
                        lrecDocMatrixEmailCodes.RESET();
                        IF Rec."Mail Text Langauge Code" <> '' THEN
                            lrecDocMatrixEmailCodes.SETFILTER("Language Code", '%1|%2', Rec."Mail Text Langauge Code", '');
                        IF lrecDocMatrixEmailCodes.FINDSET() THEN;
                        lpgDocMatrixMailCodes.SETTABLEVIEW(lrecDocMatrixEmailCodes);
                        lpgDocMatrixMailCodes.LOOKUPMODE := TRUE;
                        IF lpgDocMatrixMailCodes.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                            lpgDocMatrixMailCodes.GETRECORD(lrecDocMatrixEmailCodes);
                            Rec."Mail Text Code" := lrecDocMatrixEmailCodes.Code;
                            Rec.MODIFY();
                        END;
                    end;
                }
                field("Mail Text Langauge Code"; Rec."Mail Text Langauge Code")
                {
                    ApplicationArea = All;
                    Caption = 'Mail Text Language Code';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Te&xt")
            {
                Caption = 'Te&xt';
                Image = Text;
                action("Mail Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Mail Codes';
                    Image = Text;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunPageMode = Create;

                    trigger OnAction()
                    var
                        pgDocMatrixMailCodes: Page "DEL DocMatrix Mail Codes";
                    begin
                        pgDocMatrixMailCodes.RUN();
                    end;
                }
                action(Setup)
                {
                    ApplicationArea = All;
                    Caption = 'Setup';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "DEL DocMatrix Setup";
                    RunPageMode = Edit;
                }
                action("Customer FTP Settings")
                {
                    ApplicationArea = All;
                    Caption = 'Customer FTP Settings';
                    Image = InteractionTemplateSetup;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "DEL DocMatrix FTP Custom. Card";
                    RunPageLink = "Customer No." = FIELD("No.");
                    RunPageMode = Edit;
                }
                action("Create Request Page Parameters")
                {
                    ApplicationArea = All;
                    Caption = 'Create Request Page Parameters';
                    Image = CreateForm;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        lText001: Label 'The parameters were set sucessfully.';
                    begin
                        Rec.SaveRequestPageParameters(Rec);
                        MESSAGE(lText001);
                    end;
                }
                action("Show Request Page Parameters")
                {
                    ApplicationArea = All;
                    Caption = 'Show Request Page Parameters';
                    Image = XMLFile;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        lpgDocMatrixRequestPagePar: Page "DEL DocMatrix Request Page Par";
                    begin
                        lpgDocMatrixRequestPagePar.LOOKUPMODE(TRUE);
                        lpgDocMatrixRequestPagePar.SETRECORD(Rec);
                        lpgDocMatrixRequestPagePar.RUNMODAL();
                    end;
                }
                action("Show Log")
                {
                    ApplicationArea = All;
                    Caption = 'Show Log';
                    Image = Log;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "DEL DocMatrix Log Entries";
                    RunPageLink = Type = FIELD(Type),
                                  "No." = FIELD("No."),
                                  "Process Type" = FIELD("Process Type"),
                                  Usage = FIELD(Usage);
                    RunPageView = SORTING("Date Time Stamp")
                                  ORDER(Descending);
                }
                action("Show Error Log")
                {
                    ApplicationArea = All;
                    Caption = 'Show Error Log';
                    Image = ErrorLog;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "DEL DocMatrix Log Entries";
                    RunPageView = SORTING("Date Time Stamp")
                                  ORDER(Descending)
                                  WHERE(Error = CONST(true),
                                        "Error Solved" = CONST(false));
                }
            }
        }
    }


    procedure SetCustomerFilter(lCustNo: Code[20])
    begin
        Rec.SETRANGE("No.", lCustNo);
        Rec.SETRANGE(Type, Rec.Type::Customer);
    end;


    procedure SetVendorFilter(lVendNo: Code[20])
    begin
        Rec.SETRANGE("No.", lVendNo);
        Rec.SETRANGE(Type, Rec.Type::Vendor);
    end;
}

