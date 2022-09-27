page 50041 "Deal Posted Purch. Rcpt. Sub."
{
    AutoSplitKey = true;
    Caption = 'Deal Posted Purch. Rcpt. Sub.';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Purch. Rcpt. Line";

    layout
    {
        area(content)
        {
            repeater(Controle1)
            {
                field(Type; Rec.Type)
                {
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Visible = true;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Visible = true;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Visible = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    BlankZero = true;
                    Visible = false;
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Visible = false;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Visible = false;
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    Visible = false;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Visible = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Visible = false;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Visible = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field(Correction; Rec.Correction)
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
        ACOConnection_Re_Loc: Record "DEL ACO Connection";
    begin
        FNC_SetFilters('', '');
    end;

    var
        Deal_ID_Co: Code[20];
        DocumentNo_Co: Code[20];


    procedure FNC_UpdateForm()
    var
        ACOConnection_Re_Loc: Record "DEL ACO Connection";
    begin
        Rec.RESET();

        IF Deal_ID_Co <> '' THEN BEGIN

            ACOConnection_Re_Loc.RESET();
            ACOConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co);
            IF ACOConnection_Re_Loc.FINDFIRST() THEN BEGIN

                //MESSAGE(ACOConnection_Re_Loc."ACO No.");

                // START AFF1
                Rec.SETFILTER(Quantity, '<>%1', 0);
                // STOP AFF1
                Rec.SETRANGE("Shortcut Dimension 1 Code", ACOConnection_Re_Loc."ACO No.");

                IF DocumentNo_Co <> '' THEN
                    Rec.SETRANGE("Document No.", DocumentNo_Co);

                CurrPage.UPDATE();

            END;

        END
    end;


    procedure FNC_SetFilters(Deal_ID_Co_Par: Code[20]; DocumentNo_Co_Par: Code[20])
    begin
        Deal_ID_Co := Deal_ID_Co_Par;
        DocumentNo_Co := DocumentNo_Co_Par;
        FNC_UpdateForm();
    end;
}

