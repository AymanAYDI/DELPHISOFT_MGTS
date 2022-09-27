tableextension 50040 tableextension50040 extends "Sales Price"
{
    // THM010218       THM     01.02.18
    // Mgts10.00.04.00      07.12.2021 : Add field(50002)
    fields
    {


        //Unsupported feature: Code Modification on ""Item No."(Field 1).OnValidate".

        //trigger "(Field 1)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Item No." <> xRec."Item No." THEN BEGIN
          Item.GET("Item No.");
          "Unit of Measure Code" := Item."Sales Unit of Measure";
          "Variant Code" := '';
        END;

        IF "Sales Type" = "Sales Type"::"Customer Price Group" THEN
        #8..10
            EXIT;

        UpdateValuesFromItem;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
          //THM010218 START
          "Vendor No.":=Item."Vendor No.";
          //THM010218 END
        #5..13
        */
        //end;
        field(50000; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            Editable = false;
            TableRelation = Vendor;
            ValidateTableRelation = true;
        }
        field(50001; "Vendor Name"; Text[50])
        {
            CalcFormula = Lookup (Vendor.Name WHERE (No.=FIELD(Vendor No.)));
            Caption = 'Vendor Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002;"Entry No.";BigInteger)
        {
            Caption = 'Entry No.';
            Description = 'Mgts10.00.04.00';
        }
    }
    keys
    {
        key(Key1;"Entry No.")
        {
        }
        key(Key2;"Starting Date","Ending Date")
        {
        }
    }
}

