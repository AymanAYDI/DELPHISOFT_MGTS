table 50002 "DEL Import Commande vente"
{
    Caption = 'DEL Import Commande vente';
    DataClassification = CustomerContent;
    DrillDownPageID = "DEL Import Commande vente";
    LookupPageID = "DEL Import Commande vente";
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Position; Text[100])
        {
            Caption = 'Position';
            DataClassification = CustomerContent;
        }
        field(4; "No."; Text[100])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Text[100])
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(7; "Unit Price"; Text[100])
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(8; Amount; Text[100])
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(9; "Cross-Reference No."; Text[100])
        {
            Caption = 'Cross-Reference No.';
            DataClassification = CustomerContent;
        }

        field(10; "Error"; Text[250])

        {
            Caption = 'Error';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", Position)
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    begin
        ErrorImportvente.SETRANGE(ErrorImportvente."Document No.", "Document No.");
        ErrorImportvente.SETRANGE(ErrorImportvente."Line No.", "Line No.");
        ErrorImportvente.SETRANGE(ErrorImportvente.Position, Position);
        IF ErrorImportvente.FINDFIRST() THEN
            ErrorImportvente.DELETE();
    end;

    var
        ErrorImportvente: Record "DEL Error Import vente";
}

