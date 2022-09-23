
table 99204 "DEL Ex_Item Translation"
{
    Caption = 'Item Translation';
    DataCaptionFields = "Item No.", "Variant Code", "Language Code", Description;
    LookupPageID = "Item Translations";


    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            NotBlank = true;
            TableRelation = Language;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(5400; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';

            TableRelation = "Item Variant".Code WHERE(Item No.=FIELD(Item No.));

        }
    }

    keys
    {
        key(Key1;"Item No.","Variant Code","Language Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // --- AL.KVK4.5 --- //
        //gcouStammVerw.ArtikelUeberStandOnDelete(Rec);
        // --- AL.KVK4.5 END --- //
    end;

    trigger OnInsert()
    begin
        // --- AL.KVK4.5 --- //
        //gcouStammVerw.ArtikelUeberStandOnInsert(Rec);
        // --- AL.KVK4.5 END --- //
    end;

    trigger OnModify()
    begin
        // --- AL.KVK4.5 --- //
        //gcouStammVerw.ArtikelUeberStandOnModify(Rec);
        // --- AL.KVK4.5 END --- //
    end;

    var
        "--- AL.KVK ---": Integer;
        gcouStammVerw: Codeunit "4006496";
}

