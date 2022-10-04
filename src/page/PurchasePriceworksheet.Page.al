page 50047 "DEL Purchase Price worksheet"
{
    // NGTS/LOCO/GRC 13.03.09 create form

    Caption = 'Purchase Price worksheet';
    PageType = List;
    SourceTable = "DEL Purchase Price Worksheet";

    layout
    {
        area(content)
        {
            repeater(Controle1)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Editable = false;
                }
                field("New Unit Price"; Rec."New Unit Price")
                {
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                }
                field("Ending Date"; Rec."Ending Date")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Variant Code"; Rec."Variant Code")
                {
                }
                field("Qty. optimale"; Rec."Qty. optimale")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Update")
            {
                Caption = 'Update';
                action("Export excel")
                {
                    Caption = 'Export excel';
                    //TODO //Report
                    // RunObject = Report 50012;
                }
                action("Import excel")
                {
                    Caption = 'Import excel';

                    trigger OnAction()
                    begin

                        IF CONFIRM('L''import va supprimer les lignes de la feuille prix d''achat. Voulez-vous continuer ?', TRUE) THEN BEGIN
                            Rec.DELETEALL();
                            //TODO Report
                            // ReportImport.RUN;
                            CurrPage.UPDATE();
                        END;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Suggest Purchase Price on Wksh.")
                {
                    Caption = 'Suggest Purchase Price on Wksh.';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(50010, TRUE, TRUE);
                    end;
                }
                action("I&mplement Price Change")
                {
                    Caption = 'I&mplement Price Change';
                    Ellipsis = true;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(50011, TRUE, TRUE, Rec);
                    end;
                }
            }
        }
    }

    var
    //TODO // Report    
    // ReportImport: Report "50013";
}

