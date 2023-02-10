page 50048 "DEL Update Request Manager"
{
    ApplicationArea = all;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "DEL Update Request Manager";
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            repeater(Controle)
            {
                field(ID; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(Requested_By_User; Rec.Requested_By_User)
                {
                    Caption = 'Requested_By_User';
                }
                field(Request_For_Deal_ID; Rec.Request_For_Deal_ID)
                {
                    Caption = 'Affaire';
                }
                field(Requested_By_Type; Rec.Requested_By_Type)
                {
                    Caption = 'Type';
                }
                field("Requested_By_Type No."; Rec."Requested_By_Type No.")
                {
                    Caption = 'No.';
                }
                field(Requested_At; Rec.Requested_At)
                {
                    Caption = 'Date';
                }
                field(Request_Status; Rec.Request_Status)
                {
                    Caption = 'Statut';
                }
                field("To be ignored"; Rec."To be ignored")
                {
                    Caption = 'Ignorer';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Actions")
            {
                Caption = 'Actions';
                action("Compléter Deal Item")
                {
                    Caption = 'Compléter Deal Item';
                    Image = CompleteLine;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        DealItemCompleter_Cu.CompleteDeal_FNC(Rec.Request_For_Deal_ID);

                        MESSAGE('Done !');
                    end;
                }
            }
            group(Import)
            {
                Caption = 'Import';
                action("Blank Invoices")
                {
                    Caption = 'Blank Invoices';
                    Image = Replan;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        UpdateRequestManager_Cu.FNC_Import_BlankInvoices();
                    end;
                }
                action(All)
                {
                    Caption = 'All';
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        UpdateRequestManager_Cu.FNC_Import_All();
                    end;
                }
            }
            group("Traiter la liste")
            {
                Caption = 'Traiter la liste';
                action("Mise à jour")
                {
                    Caption = 'Mise à jour';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        UpdateRequestManager_Cu.FNC_Process_Requests(Rec, FALSE, FALSE, TRUE);
                    end;
                }
                action("Mise à jour (y compris le prévu)")
                {
                    Caption = 'Mise à jour (y compris le prévu)';
                    Image = PaymentForecast;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        UpdateRequestManager_Cu.FNC_Process_Requests(Rec, FALSE, TRUE, TRUE);
                    end;
                }
                action("Update")
                {
                    Caption = 'Update';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "DEL Update Request Manager";
                }
            }
        }
    }

    var

        DealItemCompleter_Cu: Codeunit "DEL Deal Item Completer";
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";
}

