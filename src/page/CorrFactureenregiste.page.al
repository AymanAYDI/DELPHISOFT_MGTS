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
                    Caption = 'No.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                    Caption = 'Sell-to Customer No.';
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    Editable = false;
                    Caption = 'Sell-to Contact No.';
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    Editable = false;
                    Caption = 'Sell-to Customer Name';
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    Editable = false;
                    Caption = 'Sell-to Address';
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    Editable = false;
                    Caption = 'Sell-to Address 2';
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code/City';
                    Editable = false;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    Editable = false;
                    Caption = 'Sell-to City';
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    Editable = false;
                    Caption = 'Sell-to Contact';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    Caption = 'Posting Date';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    Caption = 'Document Date';
                }
                field("Order No."; Rec."Order No.")
                {
                    Editable = false;
                    Caption = 'Order No.';
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    Editable = false;
                    Caption = 'Pre-Assigned No.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                    Caption = 'External Document No.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    Editable = false;
                    Caption = 'Salesperson Code';
                }

                field("Fiscal Repr."; Rec."DEL Fiscal Repr.")
                {
                    Editable = false;
                    Caption = 'Fiscal Repr.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    Editable = false;
                    Caption = 'No. Printed';
                }
            }
            part(SalesInvLines; "DEL Corr. facture vente ligne")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Editable = false;
                    Caption = 'Bill-to Customer No.';
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    Editable = false;
                    Caption = 'Bill-to Contact No.';
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    Editable = false;
                    Caption = 'Bill-to Name';
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    Editable = false;
                    Caption = 'Bill-to Address';
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    Editable = false;
                    Caption = 'Bill-to Address 2';
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code/City';
                    Editable = false;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    Editable = false;
                    Caption = 'Bill-to City';
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    Editable = false;
                    Caption = 'Bill-to Contact';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    Editable = false;
                    Caption = 'Payment Terms Code';
                }
                field("Due Date"; Rec."Due Date")
                {
                    Editable = false;
                    Caption = 'Due Date';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    Editable = false;
                    Caption = 'Payment Discount %';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Editable = false;
                    Caption = 'Pmt. Discount Date';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    Editable = false;
                    Caption = 'Payment Method Code';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                    Caption = 'Responsibility Center';
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    Editable = false;
                    Caption = 'Ship-to Code';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    Editable = false;
                    Caption = 'Ship-to Name';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    Editable = false;
                    Caption = 'Ship-to Address';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    Editable = false;
                    Caption = 'Ship-to Address 2';
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    Editable = false;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    Editable = false;
                    Caption = 'Ship-to City';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    Editable = false;
                    Caption = 'Ship-to Contact';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Caption = 'Location Code';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    Editable = false;
                    Caption = 'Shipment Method Code';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Editable = false;
                    Caption = 'Shipment Date';
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    Caption = 'Currency Code';

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
                    Caption = 'EU 3-Party Trade';
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
        ChangeExchangeRate: Page "Change Exchange Rate";
}

