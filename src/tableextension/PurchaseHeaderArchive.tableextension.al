tableextension 50050 "DEL PurchaseHeaderArchive" extends "Purchase Header Archive" //5109
{
    fields
    {
        field(50000; "DEL Ship Per"; Option)
        {
            OptionMembers = "Air Flight","Sea Vessel","Sea/Air",Truck,Train;
        }
        field(50002; "DEL Forwarding Agent Code"; Code[20])
        {
            Caption = 'Forwarding Agent Code';
            TableRelation = "DEL Forwarding agent 2";
        }
        field(50003; "DEL Port de départ"; Text[30])
        {
            TableRelation = Location.Code;
        }
        field(50004; "DEL Code événement"; Option)
        {
            OptionCaption = 'NORM,TYRE,SPARE,SMOOVE,ISP,CANCELLED';
            OptionMembers = NORM,TYRE,SPARE,SMOOVE,ISP,CANCELLED;
        }
        field(50005; "DEL Récépissé transitaire"; Text[30])
        {
        }
        field(50006; "DEL Port d'arrivée"; Text[30])
        {
            TableRelation = Location.Code;
        }
        field(50007; "DEL DealNeedsUpdate"; Boolean)
        {
        }
        field(50008; "DEL DELCreate By"; Text[50])
        {
            Caption = 'Create By';
            Editable = false;
        }
        field(50009; "DEL Create Date"; Date)
        {
            Caption = 'Create Date';
            Editable = false;
        }
        field(50010; "DEL Create Time"; Time)
        {
            Caption = 'Create Time';
            Editable = false;
        }
        field(50011; "DEL Requested Delivery Date"; Date)
        {
            AccessByPermission = TableData 99000880 = R;
            Caption = 'Requested Delivery Date';
        }
        field(50012; "DEL Rel. Exch. Rate Amount"; Decimal)
        {
            Caption = 'Relational Exch. Rate Amount';
            DecimalPlaces = 1 : 6;
        }
        field(50013; "DEL Vendor Shipment Date"; Date)
        {
            Caption = 'Vendor Shipment Date';
        }
        field(50014; "DEL Type Order EDI"; Code[20])
        {
            Caption = 'Type Order EDI';
            TableRelation = "DEL Type Order EDI";
        }
        field(50015; "DEL GLN"; Text[30])
        {
            Caption = 'GLN';
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
        }
        field(50052; "DEL Container No."; Code[30])
        {
            Caption = 'Container Number';
        }
        field(50053; "DEL Dispute Reason"; Code[20])
        {
            Caption = 'Dispute Reason';
            TableRelation = "DEL Dispute Reason";
        }
        field(50054; "DEL Dispute Date"; Date)
        {
            Caption = 'Dispute Date';
        }
    }
}

