
table 99204 "DEL Ex_Item Translation"
{
    Caption = 'Item Translation';
    DataCaptionFields = "Item No.", "Variant Code", "Language Code", Description;
    LookupPageID = "Item Translations";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(2; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            NotBlank = true;
            TableRelation = Language;
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(5400; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';

            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Variant Code", "Language Code")
        {
            Clustered = true;
        }
    }




}

