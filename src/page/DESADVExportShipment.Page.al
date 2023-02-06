page 50150 "DESADV Export Shipment"
{
    // MGTS10.042  | 02.01.2022 | Container/DESADV Management

    Caption = 'DESADV Export Shipment';
    DataCaptionExpression = "Delivery No.";
    DataCaptionFields = "Delivery No.";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPlus;
    SourceTable = Table50086;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Delivery No."; "Delivery No.")
                {
                }
                field("Order No."; "Order No.")
                {
                }
                field("Your Reference"; "Your Reference")
                {
                }
                field("Container No."; "Container No.")
                {
                }
                field("Supplier Name"; "Supplier Name")
                {
                }
                field("Delivery Date"; "Delivery Date")
                {
                }
                field(Exported; Exported)
                {
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Export Date"; "Export Date")
                {
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
            }
            part(; 50151)
            {
                SubPageLink = Document Enty No.=FIELD(Entry No.);
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
                Visible = true;
            }
            systempart(; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Sales Order")
            {
                Caption = 'Sales Order';
                Image = Sales;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    SalesHeader: Record "36";
                    PageManagement: Codeunit "700";
                begin
                    SalesHeader.GET(SalesHeader."Document Type"::Order, Rec."Order No.");
                    PageManagement.PageRunModal(SalesHeader);
                end;
            }
            action(Shipment)
            {
                Caption = 'Shipment';
                Image = SalesShipment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    SalesShipmentHeader: Record "110";
                    PageManagement: Codeunit "700";
                begin
                    SalesShipmentHeader.GET(Rec."Delivery No.");
                    PageManagement.PageRunModal(SalesShipmentHeader);
                end;
            }
            action(ResendDocument)
            {
                Caption = 'Resend Document';
                Image = SendElectronicDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    DESADEVMgt: Codeunit "50061";
                begin
                    DESADEVMgt.ResendDocument(Rec);
                    CurrPage.UPDATE;
                end;
            }
        }
    }
}

