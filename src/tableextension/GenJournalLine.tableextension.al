tableextension 50044 "DEL GenJournalLine" extends "Gen. Journal Line"
{
    fields
    {
        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
            begin
                dealShipmentSelection_Re_Loc.RESET();
                dealShipmentSelection_Re_Loc.SETFILTER("Journal Template Name", "Journal Template Name");
                dealShipmentSelection_Re_Loc.SETFILTER("Journal Batch Name", "Journal Batch Name");
                dealShipmentSelection_Re_Loc.SETRANGE("Line No.", "Line No.");
                dealShipmentSelection_Re_Loc.DELETEALL();
            end;

        }

        modify("Payment Reference")
        {
            trigger OnAfterValidate()
            var
            begin
                IF "Payment Reference" <> '' THEN
                    TESTFIELD("Creditor No.");
            end;
        }



        modify("Dimension Set ID")
        {
            trigger OnAfterValidate()
            var
                DimMgt: Codeunit "DEL MGTS_FctMgt";
            begin
                DimMgt.UpdateAllShortDimFromDimSetID("Dimension Set ID", "DEL Shortcut Dim 3 Code", "DEL Shortcut Dim 4 Code", "DEL Shortcut Dim 5 Code",
                                                        "DEL Shortcut Dim 6 Code", "DEL Shortcut Dim 7 Code", "DEL Shortcut Dim 8 Code");
            end;
        }

        field(50001; "DEL Shipment Selection"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("DEL Deal Shipment Selection" WHERE(Checked = FILTER('Yes'),
                                                                 "Document No." = FIELD(FILTER("Document No.")),
                                                                 "Journal Template Name" = FIELD(FILTER("Journal Template Name")),
                                                                 "Journal Batch Name" = FIELD(FILTER("Journal Batch Name")),
                                                                 "Line No." = FIELD("Line No."),
                                                                 USER_ID = FIELD("DEL User ID Filter")));
            Editable = false;

        }
        field(50002; "DEL User ID Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = User;
        }
        field(50003; "DEL Customer Provision"; Code[20])
        {
            Caption = 'Customer Provision';
            TableRelation = Customer."No.";
        }
        field(50010; "DEL Shortcut Dim 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "DEL Shortcut Dim 3 Code");
            end;
        }
        field(50011; "DEL Shortcut Dim 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "DEL Shortcut Dim 4 Code");
            end;
        }
        field(50012; "DEL Shortcut Dim 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "DEL Shortcut Dim 5 Code");
            end;
        }
        field(50013; "DEL Shortcut Dim 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "DEL Shortcut Dim 6 Code");
            end;
        }
        field(50014; "DEL Shortcut Dim 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "DEL Shortcut Dim 7 Code");
            end;
        }
        field(50015; "DEL Shortcut Dim 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "DEL Shortcut Dim 8 Code");
            end;
        }
    }

    var
        dealShipmentSelection_Re_Loc: Record "IC Outbox Purchase Header";


}

