table 50025 "DEL Fee Connection"
{
    Caption = 'Fee Connection';
    DataClassification = CustomerContent;
    LookupPageID = "DEL Fee Connection";

    fields
    {
        field(1; Type; Enum "Credit Transfer Account Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;

        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST(Customer)) Customer."No."
            ELSE
            IF (Type = CONST(Vendor)) Vendor."No.";
        }
        field(3; "Deal ID"; Code[20])
        {
            Caption = 'Deal ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal".ID;
        }
        field(4; "Fee ID"; Code[20])
        {
            Caption = 'Fee ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Fee".ID;
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
            CalcFormula = Lookup("DEL Fee"."No compte" WHERE(ID = FIELD("Fee ID")));
            Caption = 'Related Account No.';
            Editable = false;
            FieldClass = FlowField;
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
        Setup: Record "DEL General Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";

}

