
table 99206 "DEL Ex_Unit of Measure"
{
    Caption = 'Unit of Measure';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "Units of Measure";
    LookupPageID = "Units of Measure";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[10])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(4006496; "ISO Code"; Code[3])  //---------Spécifique pays Suisse

        {
            Caption = 'ISO Code';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        UnitOfMeasureTranslation.SETRANGE(Code, Code);
        UnitOfMeasureTranslation.DELETEALL();
    end;

    trigger OnRename()
    begin
        UpdateItemBaseUnitOfMeasure();
    end;

    var
        UnitOfMeasureTranslation: Record "Unit of Measure Translation";

    local procedure UpdateItemBaseUnitOfMeasure()
    var
        Item: Record Item;
    begin
        Item.SETCURRENTKEY("Base Unit of Measure");
        Item.SETRANGE("Base Unit of Measure", xRec.Code);
        IF NOT Item.ISEMPTY THEN
            Item.MODIFYALL("Base Unit of Measure", Code, TRUE);
    end;
}

