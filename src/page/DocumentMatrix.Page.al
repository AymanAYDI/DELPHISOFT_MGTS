page 50130 "Document Matrix"
{
    // DEL/PD/20190227/LOP003 : object created
    // DEL/PD/20190305/LOP003 : changed action button "Show Request Page Parameters": make sure that the correct record is showed
    // DEL/PD/20190306/LOP003 : new action button "Customer FTP Settings"
    // DEL/PD/20190307/LOP003 : new action button "Show Error Log"
    // 20200915/DEL/PD/CR100  : new field "E-Mail from Sales Order"
    // 20201007/DEL/PD/CR100  : published to PROD

    DelayedInsert = true;
    PageType = List;
    SourceTable = Table50067;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field(Name; Name)
                {
                }
                field("Process Type"; "Process Type")
                {
                }
                field(Usage; Usage)
                {
                }
                field("Report ID"; "Report ID")
                {
                }
                field("Report Caption"; "Report Caption")
                {
                }
                field(Post; Post)
                {
                }
                field("Send to FTP 1"; "Send to FTP 1")
                {
                }
                field("Send to FTP 2"; "Send to FTP 2")
                {
                }
                field("E-Mail from Sales Order"; "E-Mail from Sales Order")
                {
                }
                field("E-Mail To 1"; "E-Mail To 1")
                {
                }
                field("E-Mail To 2"; "E-Mail To 2")
                {
                }
                field("E-Mail To 3"; "E-Mail To 3")
                {
                }
                field("E-Mail From"; "E-Mail From")
                {
                }
                field("Save PDF"; "Save PDF")
                {
                }
                field("Print PDF"; "Print PDF")
                {
                }
                field("Mail Text Code"; "Mail Text Code")
                {
                    AssistEdit = false;
                    DrillDown = false;
                    DrillDownPageID = 50132;
                    Lookup = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        lrecDocMatrixEmailCodes: Record "50070";
                        lpgDocMatrixMailCodes: Page "50134";
                    begin
                        lrecDocMatrixEmailCodes.RESET;
                        IF "Mail Text Langauge Code" <> '' THEN
                            lrecDocMatrixEmailCodes.SETFILTER("Language Code", '%1|%2', "Mail Text Langauge Code", '');
                        IF lrecDocMatrixEmailCodes.FINDSET THEN;
                        lpgDocMatrixMailCodes.SETTABLEVIEW(lrecDocMatrixEmailCodes);
                        lpgDocMatrixMailCodes.LOOKUPMODE := TRUE;
                        IF lpgDocMatrixMailCodes.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            lpgDocMatrixMailCodes.GETRECORD(lrecDocMatrixEmailCodes);
                            "Mail Text Code" := lrecDocMatrixEmailCodes.Code;
                            MODIFY;
                        END;
                    end;
                }
                field("Mail Text Langauge Code"; "Mail Text Langauge Code")
                {
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
                        pgDocMatrixMailCodes: Page "50134";
                    begin
                        pgDocMatrixMailCodes.RUN;
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
                    RunObject = Page 50131;
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
                    RunObject = Page 50139;
                    RunPageLink = Customer No.=FIELD(No.);
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
                        SaveRequestPageParameters(Rec);
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
                        lpgDocMatrixRequestPagePar: Page "50136";
                    begin
                        lpgDocMatrixRequestPagePar.LOOKUPMODE(TRUE);
                        lpgDocMatrixRequestPagePar.SETRECORD(Rec);
                        lpgDocMatrixRequestPagePar.RUNMODAL;
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
                    RunObject = Page 50138;
                                    RunPageLink = Type=FIELD(Type),
                                  No.=FIELD(No.),
                                  Process Type=FIELD(Process Type),
                                  Usage=FIELD(Usage);
                    RunPageView = SORTING(Date Time Stamp)
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
                    RunObject = Page 50138;
                                    RunPageView = SORTING(Date Time Stamp)
                                  ORDER(Descending)
                                  WHERE(Error=CONST(Yes),
                                        Error Solved=CONST(No));
                }
            }
        }
    }


    procedure SetCustomerFilter(lCustNo: Code[20])
    begin
        SETRANGE("No.", lCustNo);
        SETRANGE(Type, Type::Customer);
    end;


    procedure SetVendorFilter(lVendNo: Code[20])
    begin
        SETRANGE("No.", lVendNo);
        SETRANGE(Type, Type::Vendor);
    end;
}

