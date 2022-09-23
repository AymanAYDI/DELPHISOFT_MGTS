table 50020 "DEL Deal"
{
    Caption = 'DEL Deal';
    //  TODO DrillDownPageID = 50020;
    //     LookupPageID = 50020;

    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
        }
        field(2; Status; Enum "DEL Status")
        {

            Caption = 'Status';
        }


        field(3; "Date"; Date)

        {
            Caption = 'Date';
        }
        field(10; "Next Shipment No."; Integer)
        {
            Caption = 'Next Shipment No.';
        }
        field(20; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(14),
                                                      "No." = FIELD(ID)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";

        }
        field(40; "Last Update"; DateTime)
        {
            Caption = 'Last Update';
        }
        field(50; "ACO Document Date"; Date)
        {
            Caption = 'ACO Document Date';
        }
        field(60; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
        }
        field(61; "Vendor No."; Code[20])
        {
            CalcFormula = Lookup("DEL Element"."Subject No." WHERE(Deal_ID = FIELD(ID),
                                                              Type = FILTER(ACO),
                                                              Instance = FILTER(planned)));
            Caption = 'Vendor No.';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Vendor;
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }


}

