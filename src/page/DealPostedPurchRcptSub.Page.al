page 50041 "Deal Posted Purch. Rcpt. Sub."
{
    // <changelog>
    //   <add id="dach0001"
    //        dev="mnommens"
    //        date="2004-08-01"
    //        area="ENHARCHDOC"
    //        releaseversion="DACH4.00"
    //        request="DACH-START-40">
    //        Enhanced Arch. Doc Mgmt.
    //   </add>
    // </changelog>
    // 
    // Documentation()
    // +------------------------------------------------------------------------------------------------------------+
    // | Logico SA                                                                                                  |
    // | Status: 17.06.2011                                                                                         |
    // | Customer: NGTS SA                                                                                          |
    // +------------------------------------------------------------------------------------------------------------+
    // 
    // Requirement   UserID  Date        Where                      Description
    // --------------------------------------------------------------------------------------------------------------
    // AFF1          STG     17.06.11    Function FNC_UpdateForm    Shows all entries (greater and smaller than 0)

    AutoSplitKey = true;
    Caption = 'Deal Posted Purch. Rcpt. Sub.';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Table121;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Type; Type)
                {
                    Visible = false;
                }
                field("Document No."; "Document No.")
                {
                    Visible = false;
                }
                field("No."; "No.")
                {
                }
                field("Variant Code"; "Variant Code")
                {
                    Visible = false;
                }
                field(Description; Description)
                {
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    Visible = true;
                }
                field("Return Reason Code"; "Return Reason Code")
                {
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    Visible = false;
                }
                field("Bin Code"; "Bin Code")
                {
                    Visible = false;
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                    Visible = true;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Visible = false;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Visible = false;
                }
                field("Quantity Invoiced"; "Quantity Invoiced")
                {
                    BlankZero = true;
                    Visible = false;
                }
                field("Qty. Rcd. Not Invoiced"; "Qty. Rcd. Not Invoiced")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Requested Receipt Date"; "Requested Receipt Date")
                {
                    Visible = false;
                }
                field("Promised Receipt Date"; "Promised Receipt Date")
                {
                    Visible = false;
                }
                field("Planned Receipt Date"; "Planned Receipt Date")
                {
                    Visible = false;
                }
                field("Expected Receipt Date"; "Expected Receipt Date")
                {
                    Visible = false;
                }
                field("Order Date"; "Order Date")
                {
                    Visible = false;
                }
                field("Lead Time Calculation"; "Lead Time Calculation")
                {
                    Visible = false;
                }
                field("Job No."; "Job No.")
                {
                    Visible = false;
                }
                field("Prod. Order No."; "Prod. Order No.")
                {
                    Visible = false;
                }
                field("Inbound Whse. Handling Time"; "Inbound Whse. Handling Time")
                {
                    Visible = false;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field(Correction; Correction)
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        ACOConnection_Re_Loc: Record "50026";
    begin
        FNC_SetFilters('', '');
    end;

    var
        Deal_ID_Co: Code[20];
        DocumentNo_Co: Code[20];

    [Scope('Internal')]
    procedure FNC_UpdateForm()
    var
        ACOConnection_Re_Loc: Record "50026";
    begin
        RESET();

        IF Deal_ID_Co <> '' THEN BEGIN

            ACOConnection_Re_Loc.RESET();
            ACOConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co);
            IF ACOConnection_Re_Loc.FINDFIRST THEN BEGIN

                //MESSAGE(ACOConnection_Re_Loc."ACO No.");

                // START AFF1
                SETFILTER(Quantity, '<>%1', 0);
                // STOP AFF1
                SETRANGE("Shortcut Dimension 1 Code", ACOConnection_Re_Loc."ACO No.");

                IF DocumentNo_Co <> '' THEN
                    SETRANGE("Document No.", DocumentNo_Co);

                CurrPage.UPDATE;

            END;

        END
    end;

    [Scope('Internal')]
    procedure FNC_SetFilters(Deal_ID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    begin
        Deal_ID_Co := Deal_ID_Co_Par;
        DocumentNo_Co := DocumentNo_Co_Par;
        FNC_UpdateForm();
    end;
}

