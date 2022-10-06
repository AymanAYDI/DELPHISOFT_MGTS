table 50030 "DEL Deal Shipment"
{
    Caption = 'DEL Deal Shipment';


    LookupPageID = "DEL Deal Ship. Sele.";

    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
        }
        field(2; Status; Enum "DEL Status")
        {
            Caption = 'Status';

        }
        field(3; Fournisseur; Code[20])
        {
            TableRelation = Vendor."No.";
            Caption = 'Fournisseur';
        }
        field(10; Deal_ID; Code[20])
        {
            TableRelation = "DEL Deal".ID;
            Caption = 'Deal_ID';
        }

        field(20; "Date"; Date)

        {
            Caption = 'Date';
        }
        field(30; "BR No."; Code[20])
        {
            TableRelation = "Purch. Rcpt. Header"."No.";
            Caption = 'BR No.';
        }
        field(40; "Purchase Invoice No."; Code[20])
        {
            Caption = 'Purchase Invoice No.';
        }
        field(50; "Sales Invoice No."; Code[20])
        {
            Caption = 'Sales Invoice No.';
        }
        field(100; PI; Enum "DEL PI")
        {
            Editable = false;

            Caption = 'PI';
        }
        field(101; "A facturer"; Enum "DEL afacturer")
        {
            Editable = false;

            Caption = 'A facturer';
        }
        field(102; "Depart shipment"; Boolean)
        {
            Editable = false;
            Caption = 'Depart shipment';
        }
        field(103; "Arrival ship"; Boolean)
        {
            Caption = 'Arrival ship';
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
    var
        deal_Re_Loc: Record "DEL Deal";
    begin
    end;

    var
        Setup: Record "DEL General Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
}

