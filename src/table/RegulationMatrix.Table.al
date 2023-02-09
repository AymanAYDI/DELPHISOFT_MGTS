
table 50050 "DEL Regulation Matrix"
{

    Caption = 'Regulation Matrix';
    DataClassification = CustomerContent;
    LookupPageID = "DEL Regulation Matrix";
    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Category".Code;
            trigger OnValidate()
            begin
                CALCFIELDS("Item Category Label");
            end;
        }
        field(2; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            DataClassification = CustomerContent;

            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            trigger OnValidate()
            begin
                CALCFIELDS("Product Group Label");
            end;
        }

        field(3; "Item Category Label"; Text[100])
        {
            CalcFormula = Lookup("Item Category".Description WHERE(Code = FIELD("Item Category Code")));
            Caption = 'Item Category Description';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category".Description WHERE(Code = FIELD("Item Category Code"));
        }
        field(4; "Product Group Label"; Text[100])
        {
            CalcFormula = Lookup("Product Group".Description WHERE(Code = FIELD("Product Group Code"),
                                                                   "Item Category Code" = FIELD("Item Category Code")));
            Caption = 'Product Group Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Risque Quality"; Enum "DEL Risque Quality")
        {
            Caption = 'Risk Quality';
            DataClassification = CustomerContent;
        }
        field(7; "NGTS Quality Expert"; Enum "DEL NGTS Quality Expert")
        {
            Caption = 'NGTS Quality Expert';
            DataClassification = CustomerContent;
        }
        field(8; "Regl. Generale"; Boolean)
        {
            Caption = 'General Product Regulation';
            DataClassification = CustomerContent;
        }
        field(9; "Regl. Matiere"; Boolean)
        {
            Caption = 'Substance Regulation';
            DataClassification = CustomerContent;
        }
        field(10; "Plan of control"; Boolean)
        {
            Caption = 'Plan of control';
            DataClassification = CustomerContent;
        }
        field(12; "Product Description"; Text[100])
        {
            Caption = 'Description produit';
            DataClassification = CustomerContent;
        }

        field(13; Mark; Enum "DEL Mark")
        {
            Caption = 'Mark';
            DataClassification = CustomerContent;
        }
        field(14; "Instruction manual + Warning"; Text[100])
        {
            Caption = 'Instruction manual (Yes/No) + Warning';
            DataClassification = CustomerContent;
        }
        field(15; "Marking in the product FR"; Boolean)
        {
            CalcFormula = Exist("DEL Regulation Matrix Text" WHERE("Item Category Code" = FIELD("Item Category Code"),
                                                                "Product Group Code" = FIELD("Product Group Code"),
                                                               "Product Description" = FIELD("Product Description"),
                                                                Mark = FIELD(Mark),
                                                                Type = FILTER("Marking in the product FR")));

            Caption = 'Marking in the product (warning) + Pictogram type in French';
            Editable = false;
            FieldClass = FlowField;
        }

        field(16; "Marking in the pack FR"; Boolean)
        {
            CalcFormula = Exist("DEL Regulation Matrix Text" WHERE("Item Category Code" = FIELD("Item Category Code"),
                                                                "Product Group Code" = FIELD("Product Group Code"),
                                                                "Product Description" = FIELD("Product Description"),
                                                                Mark = FIELD(Mark),
                                                                Type = FILTER("Marking in the pack FR")));

            Caption = 'Marking in the pack (warning + Pictogram) in French';
            Editable = false;
            FieldClass = FlowField;
        }

        field(17; Subgroup; Code[20])
        {
            Caption = 'Subgroup';
            DataClassification = CustomerContent;
        }
        field(18; "Marking in the product ENU"; Boolean)
        {
            CalcFormula = Exist("DEL Regulation Matrix Text" WHERE("Item Category Code" = FIELD("Item Category Code"),
                                                                "Product Group Code" = FIELD("Product Group Code"),
                                                                "Product Description" = FIELD("Product Description"),
                                                                Mark = FIELD(Mark),
                                                                Type = FILTER("Marking in the product ENU")));

            Caption = 'Marking in the product (warning) + Pictogram type in English';
            Editable = false;
            FieldClass = FlowField;
        }

        field(19; "Marking in the pack ENU"; Boolean)
        {
            CalcFormula = Exist("DEL Regulation Matrix Text" WHERE("Item Category Code" = FIELD("Item Category Code"),
                                                                "Product Group Code" = FIELD("Product Group Code"),
                                                                "Product Description" = FIELD("Product Description"),
                                                                Mark = FIELD(Mark),
                                                                Type = FILTER("Marking in the pack ENU")));

            Caption = 'Marking in the pack (warning + Pictogram) in English';
            Editable = false;
            FieldClass = FlowField;
        }

        field(20; "Line No."; Integer)

        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(21; "Manuel instruction"; Enum "DEL Manuel instruction")
        {
            DataClassification = CustomerContent;
        }
        field(22; "Warning instruction in French"; Boolean)
        {
            CalcFormula = Exist("DEL Regulation Matrix Text" WHERE("Item Category Code" = FIELD("Item Category Code"),
                                                                "Product Group Code" = FIELD("Product Group Code"),
                                                                "Product Description" = FIELD("Product Description"),
                                                                Mark = FIELD(Mark),
                                                                Type = FILTER("Warning in French")));

            Caption = 'Warning instruction in French';
            Editable = false;
            FieldClass = FlowField;
        }

        field(23; "Warning instruction in English"; Boolean)
        {
            CalcFormula = Exist("DEL Regulation Matrix Text" WHERE("Item Category Code" = FIELD("Item Category Code"),
                                                                "Product Group Code" = FIELD("Product Group Code"),
                                                                "Product Description" = FIELD("Product Description"),
                                                                Mark = FIELD(Mark),
                                                                Type = FILTER("Warning in English")));

            Caption = 'Warning instruction in English';
            Editable = false;
            FieldClass = FlowField;
        }

        field(24; "List Items Associated"; Integer)
        {
            CalcFormula = Count(Item WHERE("Item Category Code" = FIELD("Item Category Code"),
            //TODO      //         "Product Group Code" = FIELD("Product Group Code"),
             "DEL Product Description" = FIELD("Product Description"),
              "DEL Marque Produit" = FIELD(Mark)));

            Caption = 'List Items Associated';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {

        key(Key1; "Item Category Code", "Product Group Code", Mark, "Product Description")

        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

