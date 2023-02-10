tableextension 50044 "DEL GenJournalLine" extends "Gen. Journal Line" //81
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
            CalcFormula = Count("DEL Deal Shipment Selection" WHERE(Checked = FILTER('Yes'),
                                                                 "Document No." = FIELD(FILTER("Document No.")),
                                                                 "Journal Template Name" = FIELD(FILTER("Journal Template Name")),
                                                                 "Journal Batch Name" = FIELD(FILTER("Journal Batch Name")),
                                                                 "Line No." = FIELD("Line No."),
                                                                 USER_ID = FIELD("DEL User ID Filter")));
            Editable = false;
            FieldClass = FlowField;

        }
        field(50002; "DEL User ID Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';
            CaptionClass = '1,3,1';
            FieldClass = FlowFilter;
            TableRelation = User;
        }
        field(50003; "DEL Customer Provision"; Code[20])
        {
            Caption = 'Customer Provision';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }
        field(50010; "DEL Shortcut Dim 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "DEL Shortcut Dim 3 Code");
            end;
        }
        field(50011; "DEL Shortcut Dim 4 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code';
            CaptionClass = '1,2,4';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "DEL Shortcut Dim 4 Code");
            end;
        }
        field(50012; "DEL Shortcut Dim 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "DEL Shortcut Dim 5 Code");
            end;
        }
        field(50013; "DEL Shortcut Dim 6 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code';
            CaptionClass = '1,2,6';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "DEL Shortcut Dim 6 Code");
            end;
        }
        field(50014; "DEL Shortcut Dim 7 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code';
            CaptionClass = '1,2,7';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "DEL Shortcut Dim 7 Code");
            end;
        }
        field(50015; "DEL Shortcut Dim 8 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code';
            CaptionClass = '1,2,8';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "DEL Shortcut Dim 8 Code");
            end;
        }
    }


}

