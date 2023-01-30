table 50006 "DEL ItemCategory_Translation"
{
    DataCaptionFields = CategoryCode;
    Caption = 'DEL ItemCategory_Translation';
    LookupPageID = "DEL Item Category Translation";
    DataClassification = CustomerContent;
    fields
    {
        field(10; CategoryCode; Code[10])
        {
            TableRelation = "Item Category";

            Caption = 'CategoryCode';
            DataClassification = CustomerContent;
        }
        field(20; Language_Code; Code[10])
        {
            Caption = 'Language Code';
            NotBlank = true;
            TableRelation = Language;
            DataClassification = CustomerContent;
        }
        field(30; Translation; Text[50])
        {

            Caption = 'Translation';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; CategoryCode, Language_Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

