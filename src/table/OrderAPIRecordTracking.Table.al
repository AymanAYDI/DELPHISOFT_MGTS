
table 50074 "DEL Order API Record Tracking"
{
    Caption = 'Order API Record Tracking';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Deal ID"; Code[20])
        {
            Caption = 'Deal ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal".ID;
        }
        field(2; "ACO No."; Code[20])
        {
            Caption = 'ACO No.';
            DataClassification = CustomerContent;

            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(3; "ACO Date"; Date)
        {
            Caption = 'ACO Date';
            DataClassification = CustomerContent;
        }
        field(4; "ACO Product"; Code[10])
        {
            Caption = 'ACO Product';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(5; "ACO Supplier ERP Code"; Code[20])
        {
            Caption = 'ACO Supplier ERP Code';
            DataClassification = CustomerContent;
            TableRelation = Vendor."No.";
        }
        field(6; "ACO Supplier ERP Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("ACO Supplier ERP Code")));
            Caption = 'ACO Supplier ERP Name';
            Editable = false;
            FieldClass = FlowField;
        }

        field(7; "ACO Supplier base code"; Text[10])
        {
            Caption = 'ACO Supplier Base Code';
            DataClassification = CustomerContent;
        }
        field(8; "ACO Transport Mode"; Enum "DEL Ship Per")

        {
            Caption = 'ACO Transport Mode';
            DataClassification = CustomerContent;
        }

        field(9; "ACO Departure Port"; Text[30])
        {
            Caption = 'ACO Departure Port';
            DataClassification = CustomerContent;
        }
        field(10; "ACO Arrival Port"; Text[30])
        {
            Caption = 'ACO Arrival Port';
            DataClassification = CustomerContent;
        }
        field(11; "ACO Warehouse"; Text[50])
        {
            Caption = 'ACO Warehouse';
            DataClassification = CustomerContent;
        }
        field(12; "ACO Event"; Text[30])
        {
            Caption = 'ACO Event';
            DataClassification = CustomerContent;
        }
        field(13; "ACO ETD"; Date)
        {
            Caption = 'ACO ETD';
            DataClassification = CustomerContent;
        }
        field(14; "ACO Incoterm"; Code[10])

        {
            Caption = 'ACO Incoterm';
            DataClassification = CustomerContent;
            TableRelation = "Shipment Method";
        }

        field(15; "ACO Amount"; Decimal)
        {
            Caption = 'ACO Amount';
            DataClassification = CustomerContent;
        }
        field(16; "ACO Currency Code"; Code[10])

        {
            Caption = 'ACO Currency Code';
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(17; "VCO No."; Code[20])
        {
            Caption = 'VCO No.';
            DataClassification = CustomerContent;
        }
        field(18; "VCO Customer Ref"; Code[35])
        {
            Caption = 'VCO Customer Ref';
            DataClassification = CustomerContent;
        }
        field(19; "VCO Delivery date"; Date)
        {
            Caption = 'VCO Delivery date';
            DataClassification = CustomerContent;
        }
        field(20; "VCO Customer Name"; Code[20])
        {
            Caption = 'VCO Customer Name';
            DataClassification = CustomerContent;
            TableRelation = Customer."No.";
        }
        field(21; "ACO Payment Deadline"; Date)
        {
            Caption = 'ACO payment Deadline';
            DataClassification = CustomerContent;
        }
        field(22; "Sent Deal"; Boolean)
        {
            Caption = 'Sent Deal';
            DataClassification = CustomerContent;
        }
        field(23; Completed; Boolean)

        {
            Caption = 'Completed';
            DataClassification = CustomerContent;
        }
    }

    keys
    {

        key(Key1; "Deal ID")
        {
            Clustered = true;
        }
        key(Key2; "Sent Deal")

        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var

        ACOLinesAPIRecordTracking: Record "DEL ACO Lines API Rec. Track.";
    begin
        ACOLinesAPIRecordTracking.SETRANGE("Deal ID", "Deal ID");
        ACOLinesAPIRecordTracking.DELETEALL();

    end;
}

