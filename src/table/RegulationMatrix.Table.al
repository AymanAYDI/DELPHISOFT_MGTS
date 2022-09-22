table 50050 "Regulation Matrix"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00716      THM     27.08.15           Create Object
    // T-00747      THM     17.11.15           change name in fields
    // T-00755      THM     07.01.16           Delete field, add new field  and modify Key
    // T-00783      THM     04.04.16           add field "Marking in the pack ENU","Marking in the product ENU"
    // T-00783      THM     19.04.16           modify field "Product Description" 20 ->50
    // T-00783      THM     29.04.16           add Fields
    //              THM     27.06.16           add OptionString field Mark and  Risque Quality
    //              THM     27.06.16           "Product Description" 50 -->100
    //              THM     27.06.16           "NGTS Quality Expert" ED-->EV
    //              THM     26.08.16           add option all Marks

    Caption = 'Regulation Matrix';
    LookupPageID = 50085;

    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category".Code;

            trigger OnValidate()
            begin
                CALCFIELDS("Item Category Label");
            end;
        }
        field(2; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE(Item Category Code=FIELD(Item Category Code));

            trigger OnValidate()
            begin
                CALCFIELDS("Product Group Label");
            end;
        }
        field(3; "Item Category Label"; Text[50])
        {
            CalcFormula = Lookup("Item Category".Description WHERE(Code = FIELD(Item Category Code)));
            Caption = 'Item Category Description';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category".Description WHERE(Code = FIELD(Item Category Code));
        }
        field(4; "Product Group Label"; Text[50])
        {
            CalcFormula = Lookup("Product Group".Description WHERE(Code = FIELD(Product Group Code),
                                                                    Item Category Code=FIELD(Item Category Code)));
                                                                                           Caption = 'Product Group Description';
                                                                                           Editable = false;
                                                                                           FieldClass = FlowField;
        }
        field(5; "Risque Quality"; Option)
        {
            Caption = 'Risk Quality';
            OptionMembers = " ","0","1","2","3",NC,NA,"?";
        }
        field(7; "NGTS Quality Expert"; Option)
        {
            Caption = 'NGTS Quality Expert';
            OptionMembers = " ",JPD,FC,SM,EV,"à definir ";
        }
        field(8; "Regl. Generale"; Boolean)
        {
            Caption = 'General Product Regulation';
        }
        field(9; "Regl. Matiere"; Boolean)
        {
            Caption = 'Substance Regulation';
        }
        field(10; "Plan of control"; Boolean)
        {
            Caption = 'Plan of control';
        }
        field(12; "Product Description"; Text[100])
        {
            Caption = 'Description produit';
        }
        field(13; Mark; Option)
        {
            Caption = 'Mark';
            OptionCaption = ' ,Own brand,Supplier brand,Licence,No Name,Premium Brand,NC,NA,?,All Marks';
            OptionMembers = " ","Own brand","Supplier brand",Licence,"No Name","Premium Brand",NC,NA,"?","All Marks";
        }
        field(14; "Instruction manual + Warning"; Text[100])
        {
            Caption = 'Instruction manual (Yes/No) + Warning';
        }
        field(15; "Marking in the product FR"; Boolean)
        {
            CalcFormula = Exist("Regulation Matrix Text" WHERE(Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Product Description=FIELD(Product Description),
                                                                Mark=FIELD(Mark),
                                                                Type=FILTER(Marking in the product FR)));
            Caption = 'Marking in the product (warning) + Pictogram type in French';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16;"Marking in the pack FR";Boolean)
        {
            CalcFormula = Exist("Regulation Matrix Text" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Product Description=FIELD(Product Description),
                                                                Mark=FIELD(Mark),
                                                                Type=FILTER(Marking in the pack FR)));
            Caption = 'Marking in the pack (warning + Pictogram) in French';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17;Subgroup;Code[20])
        {
            Caption = 'Subgroup';
        }
        field(18;"Marking in the product ENU";Boolean)
        {
            CalcFormula = Exist("Regulation Matrix Text" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Product Description=FIELD(Product Description),
                                                                Mark=FIELD(Mark),
                                                                Type=FILTER(Marking in the product ENU)));
            Caption = 'Marking in the product (warning) + Pictogram type in English';
            Editable = false;
            FieldClass = FlowField;
        }
        field(19;"Marking in the pack ENU";Boolean)
        {
            CalcFormula = Exist("Regulation Matrix Text" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Product Description=FIELD(Product Description),
                                                                Mark=FIELD(Mark),
                                                                Type=FILTER(Marking in the pack ENU)));
            Caption = 'Marking in the pack (warning + Pictogram) in English';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20;"Line No.";Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            NotBlank = true;
        }
        field(21;"Manuel instruction";Option)
        {
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(22;"Warning instruction in French";Boolean)
        {
            CalcFormula = Exist("Regulation Matrix Text" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Product Description=FIELD(Product Description),
                                                                Mark=FIELD(Mark),
                                                                Type=FILTER(Warning in French)));
            Caption = 'Warning instruction in French';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23;"Warning instruction in English";Boolean)
        {
            CalcFormula = Exist("Regulation Matrix Text" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Product Description=FIELD(Product Description),
                                                                Mark=FIELD(Mark),
                                                                Type=FILTER(Warning in English)));
            Caption = 'Warning instruction in English';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24;"List Items Associated";Integer)
        {
            CalcFormula = Count(Item WHERE (Item Category Code=FIELD(Item Category Code),
                                            Product Group Code=FIELD(Product Group Code),
                                            Product Description=FIELD(Product Description),
                                            Marque Produit=FIELD(Mark)));
            Caption = 'List Items Associated';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Item Category Code","Product Group Code",Mark,"Product Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

