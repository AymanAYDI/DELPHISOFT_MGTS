tableextension 50008 "DEL PurchInvHeader" extends "Purch. Inv. Header" //122 
{

    fields
    {
        field(50013; "DEL Vendor Shipment Date"; Date)
        {
            Caption = 'Vendor Shipment Date';
            DataClassification = CustomerContent;
        }
        field(50014; "DEL Type Order EDI"; Code[20])
        {
            Caption = 'Type Order EDI';
            DataClassification = CustomerContent;

            TableRelation = "DEL Type Order EDI";
        }
        field(50015; "DEL GLN"; Text[30])
        {
            Caption = 'GLN';
            DataClassification = CustomerContent;
        }
        field(50016; "DEL Type Order EDI Description"; Text[50])
        {
            CalcFormula = Lookup("DEL Type Order EDI".Description WHERE(Code = FIELD("DEL Type Order EDI")));
            Caption = 'Type Order EDI Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "DEL Due Date Calculation"; Date)
        {
            Caption = 'Due Date Calculation';
            DataClassification = CustomerContent;
        }
        field(50052; "DEL Container No."; Code[30])
        {
            Caption = 'Container Number';
            DataClassification = CustomerContent;
        }
        field(50053; "DEL Dispute Reason"; Code[20])
        {
            Caption = 'Dispute Reason';
            DataClassification = CustomerContent;
        }
        field(50054; "DEL Dispute Date"; Date)
        {
            Caption = 'Dispute Date';
            DataClassification = CustomerContent;
        }
    }
}

