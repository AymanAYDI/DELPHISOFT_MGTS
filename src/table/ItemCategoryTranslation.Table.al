table 50006 "DEL ItemCategory_Translation"
{
    DataCaptionFields = CategoryCode;
    Caption = 'DEL ItemCategory_Translation';
    //TODO LookupPageID = 50006;

    fields
    {
        field(10; CategoryCode; Code[10])
        {
            TableRelation = "Item Category";
        }
        field(20; Language_Code; Code[10])
        {
            Caption = 'Language Code';
            NotBlank = true;
            TableRelation = Language;
        }
        field(30; Translation; Text[50])
        {
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

