table 50005 "DEL Contact_ItemCategory"
{
    Caption = 'DEL Contact_ItemCategory';
    //TODO DrillDownPageID = 50005;
    // LookupPageID = 50005;

    fields
    {
        field(10; contactNo; Code[10])
        {
            TableRelation = Contact;
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

