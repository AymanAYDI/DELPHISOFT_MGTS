page 50048 "Update Request Manager"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 06.04.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            06.04.09   created Form
    // CHG02                            20.04.09   added "Import Button" on form
    // CHG03                            04.05.09   modified and added function to the Import Button
    // CHG04                            26.09.11   adapted deal update function with "updatePlanned" parameter
    // T-00759                          13.01.16   Modify PageActions

    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = Table50039;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(ID; ID)
                {
                }
                field(Requested_By_User; Requested_By_User)
                {
                }
                field(Request_For_Deal_ID; Request_For_Deal_ID)
                {
                    Caption = 'Affaire';
                }
                field(Requested_By_Type; Requested_By_Type)
                {
                    Caption = 'Type';
                }
                field("Requested_By_Type No."; "Requested_By_Type No.")
                {
                    Caption = 'No.';
                }
                field(Requested_At; Requested_At)
                {
                    Caption = 'Date';
                }
                field(Request_Status; Request_Status)
                {
                    Caption = 'Statut';
                }
                field("To be ignored"; "To be ignored")
                {
                    Caption = 'Ignorer';
                }
                field(Description; Description)
                {
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
                        DealItemCompleter_Cu.CompleteDeal_FNC(Request_For_Deal_ID);

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
                action(Update)
                {
                    Caption = 'Update';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report 50003;
                }
            }
        }
    }

    var
        UpdateRequestManager_Cu: Codeunit "50032";
        DealItemCompleter_Cu: Codeunit "50038";
        Text19018791: Label 'U P D A T E   R E Q U E S T   M A N A G E R';
}

