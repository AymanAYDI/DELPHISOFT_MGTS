table 50038 "Purchase Price Worksheet"
{
    // NGTS/LOCO/GRC 13.03.09 create table

    Caption = 'Purchase Price';
    LookupPageID = 7012;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;

            trigger OnValidate()
            begin
                IF "Item No." <> xRec."Item No." THEN BEGIN
                    "Unit of Measure Code" := '';
                    "Variant Code" := '';
                END;
            end;
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            NotBlank = true;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                IF Vend.GET("Vendor No.") THEN
                    "Currency Code" := Vend."Currency Code";
            end;
        }
        field(3; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(4; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
                IF ("Starting Date" > "Ending Date") AND ("Ending Date" <> 0D) THEN
                    ERROR(Text000, FIELDCAPTION("Starting Date"), FIELDCAPTION("Ending Date"));
            end;
        }
        field(5; "Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Direct Unit Cost';
            MinValue = 0;
        }
        field(14; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            MinValue = 0;
        }
        field(15; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
                VALIDATE("Starting Date");
            end;
        }
        field(5400; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE(Item No.=FIELD(Item No.));
        }
        field(5700;"Variant Code";Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE (Item No.=FIELD(Item No.));
        }
        field(50092;"Qty. optimale";Decimal)
        {
        }
        field(50093;"New Unit Price";Decimal)
        {
        }
    }

    keys
    {
        key(Key1;"Item No.","Vendor No.","Starting Date","Currency Code","Variant Code","Unit of Measure Code","Minimum Quantity","Qty. optimale")
        {
            Clustered = true;
        }
        key(Key2;"Vendor No.","Item No.","Starting Date","Currency Code","Variant Code","Unit of Measure Code","Minimum Quantity")
        {
        }
        key(Key3;"Item No.","Starting Date","Ending Date")
        {
            SumIndexFields = "Qty. optimale";
        }
    }

    fieldgroups
    {
    }

    var
        Vend: Record "23";
        Text000: Label '%1 cannot be after %2';


    procedure CalcCurrentPrice(var PriceAlreadyExists: Boolean)
    var
        PurchPrice: Record "7012";
    begin
        PurchPrice.SETRANGE("Item No.","Item No.");
        //PurchPrice.SETRANGE("Sales Type","Sales Type");
        PurchPrice.SETRANGE("Vendor No.","Vendor No.");
        PurchPrice.SETRANGE("Currency Code","Currency Code");
        PurchPrice.SETRANGE("Unit of Measure Code","Unit of Measure Code");
        PurchPrice.SETRANGE("Starting Date",0D,"Starting Date");
        PurchPrice.SETRANGE("Minimum Quantity",0,"Minimum Quantity");
        PurchPrice.SETRANGE("Variant Code","Variant Code");
        IF PurchPrice.FIND('+') THEN BEGIN
          "Direct Unit Cost" := PurchPrice."Direct Unit Cost";
          //"Price Includes VAT" := PurchPrice."Price Includes VAT";
          //"Allow Line Disc." := PurchPrice."Allow Line Disc.";
          //"Allow Invoice Disc." := PurchPrice."Allow Invoice Disc.";
          //"VAT Bus. Posting Gr. (Price)" := PurchPrice."VAT Bus. Posting Gr. (Price)";
          PriceAlreadyExists := PurchPrice."Starting Date" = "Starting Date";
        END ELSE BEGIN
          "Direct Unit Cost" := 0;
          PriceAlreadyExists := FALSE;
        END;
    end;
}

