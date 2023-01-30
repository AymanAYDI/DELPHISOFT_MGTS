table 50030 "DEL Deal Shipment"
{
    Caption = 'DEL Deal Shipment';


    LookupPageID = "DEL Deal Ship. Sele.";
    DataClassification = CustomerContent;
    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; Status; Enum "DEL Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(3; Fournisseur; Code[20])
        {
            TableRelation = Vendor."No.";
            Caption = 'Fournisseur';
            DataClassification = CustomerContent;
        }
        field(10; Deal_ID; Code[20])
        {
            TableRelation = "DEL Deal".ID;
            Caption = 'Deal_ID';
            DataClassification = CustomerContent;
        }

        field(20; "Date"; Date)

        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(30; "BR No."; Code[20])
        {
            TableRelation = "Purch. Rcpt. Header"."No.";
            Caption = 'BR No.';
            DataClassification = CustomerContent;
        }
        field(40; "Purchase Invoice No."; Code[20])
        {
            Caption = 'Purchase Invoice No.';
            DataClassification = CustomerContent;
        }
        field(50; "Sales Invoice No."; Code[20])
        {
            Caption = 'Sales Invoice No.';
            DataClassification = CustomerContent;
        }
        field(100; PI; Enum "DEL PI")
        {
            Editable = false;

            Caption = 'PI';
            DataClassification = CustomerContent;
        }
        field(101; "A facturer"; Enum "DEL afacturer")
        {
            Editable = false;

            Caption = 'A facturer';
            DataClassification = CustomerContent;
        }
        field(102; "Depart shipment"; Boolean)
        {
            Editable = false;
            Caption = 'Depart shipment';
            DataClassification = CustomerContent;
        }
        field(103; "Arrival ship"; Boolean)
        {
            Caption = 'Arrival ship';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
        key(Key2; Deal_ID)
        {
        }
        key(Key3; Status)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
    begin
        dealShipmentConnection_Re_Loc.RESET();
        dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, ID);
        IF dealShipmentConnection_Re_Loc.FIND('-') THEN
            ERROR('Des éléments sont liés à cette livraison ! Suppression impossible');
    end;

    trigger OnInsert()
    begin
    end;
}

