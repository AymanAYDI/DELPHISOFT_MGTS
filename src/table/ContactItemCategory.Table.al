table 50005 "DEL Contact_ItemCategory"
{
    Caption = 'DEL Contact_ItemCategory';
    DrillDownPageID = "DEL Contact_ItemCategory";
    LookupPageID = "DEL Contact_ItemCategory";

    fields
    {
        field(10; contactNo; Code[10])
        {
            TableRelation = Contact;
            Caption = 'contactNo';
        }
        field(20; ItemCategory; Code[10])
        {
            Caption = 'Product Group';
            //TODO: TableRelation = "Product Group";
        }
    }

    keys
    {
        key(Key1; contactNo, ItemCategory)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

