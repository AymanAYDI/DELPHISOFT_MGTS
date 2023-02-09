table 50006 "DEL ItemCategory_Translation"
{
    Caption = 'DEL ItemCategory_Translation';
    DataCaptionFields = CategoryCode;
    DataClassification = CustomerContent;
    LookupPageID = "DEL Item Category Translation";
    fields
    {
        field(10; CategoryCode; Code[10])
        {

            Caption = 'CategoryCode';
            DataClassification = CustomerContent;
            TableRelation = "Item Category";
        }
        field(20; Language_Code; Code[10])
        {
            Caption = 'Language Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Language;
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

