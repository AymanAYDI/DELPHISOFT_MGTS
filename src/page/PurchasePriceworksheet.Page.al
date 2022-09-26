page 50047 "Purchase Price worksheet"
{
    // NGTS/LOCO/GRC 13.03.09 create form

    Caption = 'Purchase Price worksheet';
    PageType = List;
    SourceTable = Table50038;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Item No."; "Item No.")
                {
                }
                field("Vendor No."; "Vendor No.")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field("Starting Date"; "Starting Date")
                {
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                    Editable = false;
                }
                field("New Unit Price"; "New Unit Price")
                {
                }
                field("Minimum Quantity"; "Minimum Quantity")
                {
                }
                field("Ending Date"; "Ending Date")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field("Variant Code"; "Variant Code")
                {
                }
                field("Qty. optimale"; "Qty. optimale")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Update)
            {
                Caption = 'Update';
                action("Export excel")
                {
                    Caption = 'Export excel';
                    RunObject = Report 50012;
                }
                action("Import excel")
                {
                    Caption = 'Import excel';

                    trigger OnAction()
                    begin

                        IF CONFIRM('L''import va supprimer les lignes de la feuille prix d''achat. Voulez-vous continuer ?', TRUE) THEN BEGIN
                            Rec.DELETEALL;

                            ReportImport.RUN;
                            CurrPage.UPDATE;
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
        ReportImport: Report "50013";
}

