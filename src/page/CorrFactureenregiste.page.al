page 50015 "DEL Corr. Facture enregistée"
{

    Caption = 'Posted Sales Invoice';
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Sales Invoice Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    Editable = false;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Editable = false;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    Editable = false;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    Editable = false;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code/City';
                    Editable = false;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    Editable = false;
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                }
                field("Order No."; Rec."Order No.")
                {
                    Editable = false;
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    Editable = false;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Editable = false;
                }
                //TODO
                // field("Fiscal Repr."; "Fiscal Repr.")
                // {
                //     Editable = false;
                // }
                field("No. Printed"; Rec."No. Printed")
                {
                    Editable = false;
                }
            }
            part(SalesInvLines; 50014)
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Editable = false;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    Editable = false;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Editable = false;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    Editable = false;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    Editable = false;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code/City';
                    Editable = false;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    Editable = false;
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Editable = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    Editable = false;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Editable = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Editable = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Editable = false;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Editable = false;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Editable = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    Editable = false;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    Editable = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Editable = false;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Editable = false;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {

                    trigger OnAssistEdit()
                    begin
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        ChangeExchangeRate.EDITABLE(FALSE);
                        IF ChangeExchangeRate.RUNMODAL() = ACTION::OK THEN BEGIN
                            Rec."Currency Factor" := ChangeExchangeRate.GetParameter();
                            Rec.MODIFY();
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        SalesInvHeader: Record "Sales Invoice Header";
        Text19027897: Label 'N''oubliez pas de recalculer l''affaire une fois les valeurs modifiées';
        ChangeExchangeRate: Page 511;
}

