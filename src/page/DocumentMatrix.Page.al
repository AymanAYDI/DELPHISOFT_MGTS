page 50130 "DEL Document Matrix"
{

    DelayedInsert = true;
    PageType = List;
    SourceTable = "DEL Document Matrix";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field("Process Type"; Rec."Process Type")
                {
                    Caption = 'Process Type';
                }
                field(Usage; Rec.Usage)
                {
                    Caption = 'Usage';
                }
                field("Report ID"; Rec."Report ID")
                {
                    Caption = 'Report ID';
                }
                field("Report Caption"; Rec."Report Caption")
                {
                    Caption = 'Report Caption';
                }
                field(Post; Rec.Post)
                {
                    Caption = 'Post';
                }
                field("Send to FTP 1"; Rec."Send to FTP 1")
                {
                    Caption = 'Send to FTP 1';
                }
                field("Send to FTP 2"; Rec."Send to FTP 2")
                {
                    Caption = 'Send to FTP 2';
                }
                field("E-Mail from Sales Order"; Rec."E-Mail from Sales Order")
                {
                    Caption = 'E-Mail from Sales Order';
                }
                field("E-Mail To 1"; Rec."E-Mail To 1")
                {
                    Caption = 'E-Mail To 1';
                }
                field("E-Mail To 2"; Rec."E-Mail To 2")
                {
                    Caption = 'E-Mail To 2';
                }
                field("E-Mail To 3"; Rec."E-Mail To 3")
                {
                    Caption = 'E-Mail To 3';
                }
                field("E-Mail From"; Rec."E-Mail From")
                {
                    Caption = 'E-Mail From';
                }
                field("Save PDF"; Rec."Save PDF")
                {
                    Caption = 'Save PDF';
                }
                field("Print PDF"; Rec."Print PDF")
                {
                    Caption = 'Print PDF';
                }
                field("Mail Text Code"; Rec."Mail Text Code")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    //TODO DrillDownPageID = 50132;  //50132 n'existe pas 
                    Lookup = true;
                    Caption = 'Mail Text Code';

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

