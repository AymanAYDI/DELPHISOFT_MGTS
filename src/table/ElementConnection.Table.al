table 50027 "DEL Element Connection"
{
    //TODO LookupPageID = 50026;
    Caption = 'Element Connection';

    fields
    {
        field(1; Deal_ID; Code[20])
        {

            TableRelation = "DEL Deal".ID;
        }
        field(2; Element_ID; Code[20])
        {
            TableRelation = "DEL Element".ID;
        }
        field(3; "Apply To"; Code[20])
        {
            TableRelation = "DEL Element".ID;

        }
        field(4; Instance; Option)
        {
            OptionCaption = 'Planned,Real';
            OptionMembers = planned,real;

        }
        field(10; "Split Index"; Integer)
        {

        }
    }

    keys
    {
        key(Key1; Deal_ID, Element_ID, "Apply To")
        {
            Clustered = true;
        }
        key(Key2; Element_ID)
        {
        }
        key(Key3; Element_ID, "Split Index")
        {
        }
    }

    fieldgroups
    {
    }
}

