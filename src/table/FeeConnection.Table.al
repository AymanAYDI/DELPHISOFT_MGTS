table 50025 "DEL Fee Connection"
{
    Caption = 'Fee Connection';
    DataClassification = CustomerContent;
    //TODO LookupPageID = 50025;

    fields
    {
        field(1; Type; Enum "DEL Type Fee Connection")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;

        }
        field(2; "No."; Code[20])
        {
            TableRelation = IF (Type = CONST(Customer)) Customer."No."
            ELSE
            IF (Type = CONST(Vendor)) Vendor."No.";
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(3; "Deal ID"; Code[20])
        {
            TableRelation = "DEL Deal".ID;
            Caption = 'Deal ID';
            DataClassification = CustomerContent;
        }
        field(4; "Fee ID"; Code[20])
        {
            TableRelation = Fee.ID;
            Caption = 'Fee ID';
            DataClassification = CustomerContent;
        }
        field(5; "Default Amount"; Decimal)
        {
            Caption = 'Default Amount';
            DataClassification = CustomerContent;
        }
        field(6; "Default Factor"; Decimal)
        {
            Caption = 'Default Factor';
            DataClassification = CustomerContent;
        }
        field(7; ID; Code[20])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(10; "Fee Description"; Text[50])
        {
            Caption = 'Fee Description';
            DataClassification = CustomerContent;
        }
        field(20; "Related Account No."; Text[20])
        {
            CalcFormula = Lookup(Fee."No compte" WHERE(ID = FIELD("Fee ID")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Related Account No.';
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Setup.GET();

        IF ID = '' THEN
            ID := NoSeriesMgt.GetNextNo(Setup."Fee Connection Nos.", TODAY, TRUE);
    end;

    var
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Setup: Record "DEL General Setup";
}

