tableextension 50004 "DEL SalesInvoiceLine" extends "Sales Invoice Line"
{

    fields
    {
        //TODO  // modification  au niveau du longeur du champs Customer Price Group ( code[10] --> 20 )) 
        // modify("Customer Price Group")
        // {

        // }
        field(50000; "DEL Customer line reference2"; Text[30])
        {
            Caption = 'Kundenreferenz';

        }
        field(50001; "DEL Qty. Init. Client"; Decimal)
        {

        }
        field(50008; "DEL Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';

            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));

        }
        field(50009; "DEL Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
        }
    }
    keys
    {
        key(Key10; "Shortcut Dimension 1 Code", Type, "Order No.")
        {
        }
        key(Key11; "Shortcut Dimension 1 Code", Type, "Document No.")
        {
        }
    }
}

