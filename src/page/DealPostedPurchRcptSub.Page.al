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
                    Caption = 'Type';
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                    Caption = 'Document No.';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                    Caption = 'Variant Code';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Visible = true;
                    Caption = 'Cross-Reference No.';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Visible = false;
                    Caption = 'Return Reason Code';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                    Caption = 'Location Code';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Visible = false;
                    Caption = 'Bin Code';
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Visible = true;
                    Caption = 'Quantity';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Visible = false;
                    Caption = 'Unit of Measure Code';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Visible = false;
                    Caption = 'Unit of Measure';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    BlankZero = true;
                    Visible = false;
                    Caption = 'Quantity Invoiced';
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Qty. Rcd. Not Invoiced';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Visible = false;
                    Caption = 'Requested Receipt Date';
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Visible = false;
                    Caption = 'Promised Receipt Date';
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    Visible = false;
                    Caption = 'Planned Receipt Date';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Visible = false;
                    Caption = 'Expected Receipt Date';
                }
                field("Order Date"; Rec."Order Date")
                {
                    Visible = false;
                    Caption = 'Order Date';
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Visible = false;
                    Caption = 'Lead Time Calculation';
                }
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    Caption = 'Job No.';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Visible = false;
                    Caption = 'Prod. Order No.';
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Visible = false;
                    Caption = 'Inbound Whse. Handling Time';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Visible = false;
                    Caption = 'Appl.-to Item Entry';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field(Correction; Rec.Correction)
                {
                    Visible = false;
                    Caption = 'Correction';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
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

                Rec.SETFILTER(Quantity, '<>%1', 0);

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

