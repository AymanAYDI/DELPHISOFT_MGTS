page 50150 "DEL DESADV Export Shipment"
{

    Caption = 'DESADV Export Shipment';
    DataCaptionExpression = Rec."Delivery No.";
    DataCaptionFields = "Delivery No.";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPlus;
    SourceTable = "DEL DESADV Export Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Delivery No."; Rec."Delivery No.")
                {
                }
                field("Order No."; Rec."Order No.")
                {
                }
                field("Your Reference"; Rec."Your Reference")
                {
                }
                field("Container No."; Rec."Container No.")
                {
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                }
                field("Delivery Date"; Rec."Delivery Date")
                {
                }
                field(Exported; Rec.Exported)
                {
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Export Date"; Rec."Export Date")
                {
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
            }
            part("DESADV Export Shipment Line"; "DEL DESADV ExportShipment Line")
            {
                SubPageLink = "Document Enty No." = FIELD("Entry No.");
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = true;
            }
            systempart(Notes; Notes)
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
                    SalesHeader: Record "Sales Header";
                    PageManagement: Codeunit "Page Management";
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
                    SalesShipmentHeader: Record "Sales Shipment Header";
                    PageManagement: Codeunit "Page Management";
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
                    DESADEVMgt: Codeunit "DEL ESADEV Mgt";
                begin
                    DESADEVMgt.ResendDocument(Rec);
                    CurrPage.UPDATE();
                end;
            }
        }
    }
}

