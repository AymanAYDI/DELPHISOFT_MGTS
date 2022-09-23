table 50002 "DEL Import Commande vente"
{
    Caption = 'DEL Import Commande vente';
    //TODO DrillDownPageID = 50002;
    // LookupPageID = 50002;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(3; Position; Text[100])
        {
            Caption = 'Position';
        }
        field(4; "No."; Text[100])
        {
            Caption = 'No.';

            trigger OnValidate()
            var
                TempSalesLine: Record "Sales Line" temporary;
                StandardText: Record "Standard Text";
                FixedAsset: Record "Fixed Asset";
                PrepaymentMgt: Codeunit "Prepayment Mgt.";
                TypeHelper: Codeunit "Type Helper";
            begin
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';

            trigger OnValidate()
            var
                Item: Record "Item";
                TypeHelper: Codeunit "Type Helper";
                ReturnValue: Text[50];
                ItemDescriptionIsNo: Boolean;
                DefaultCreate: Boolean;
            begin
            end;
        }
        field(6; Quantity; Text[100])
        {
            Caption = 'Quantity';

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
            begin
            end;
        }
        field(7; "Unit Price"; Text[100])
        {
            Caption = 'Unit Price';

            trigger OnValidate()
            var

                ACOConnection_Re_Loc: Record "DEL ACO Connection";
            // DealItem_Cu: Codeunit "50024";
            // Deal_Cu: Codeunit "50020";
            begin
            end;
        }
        field(8; Amount; Text[100])
        {
            Caption = 'Amount';
        }
        field(9; "Cross-Reference No."; Text[100])
        {
            Caption = 'Cross-Reference No.';
        }

        field(10; "Error"; Text[250])

        {
            Caption = 'Error';
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

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ErrorImportvente.SETRANGE(ErrorImportvente."Document No.", "Document No.");
        ErrorImportvente.SETRANGE(ErrorImportvente."Line No.", "Line No.");
        ErrorImportvente.SETRANGE(ErrorImportvente.Position, Position);
        IF ErrorImportvente.FINDFIRST THEN
            ErrorImportvente.DELETE;
    end;

    var
        ErrorImportvente: Record "DEL Error Import vente";
}
