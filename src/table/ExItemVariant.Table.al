table 99211 "DEL Ex_Item Variant"
{
    Caption = 'Item Variant';
    DataCaptionFields = "Item No.", "Code", Description;
    LookupPageID = "Item Variants";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(4006496; ZeilenID; Integer)
        {
            Caption = 'Line ID';

        }
        field(4006497; ZeilenIDCode; Code[20])
        {
            Caption = 'Line ID Code';

        }
        field(4006498; "Bilddokument ID"; Code[20])
        {
            Caption = 'Picture Document ID';
            //TODO TableRelation = "Dokument Katalog" WHERE(Art = CONST(Bild));

            //  //TODO trigger OnLookup()
            // begin
            //     CLEAR(gpagDoklisteB);

            //     // --- Filter setzen --- //
            //     gpagDoklisteB.FilterSetzen(goptQuellenart::Variante, ZeilenIDCode, 0);

            //     gpagDoklisteB.LOOKUPMODE(TRUE);
            //     IF gpagDoklisteB.RUNMODAL = ACTION::LookupOK THEN BEGIN
            //         gpagDoklisteB.GETRECORD(grecKatDok);
            //         IF grecKatDok.Nummer <> "Bilddokument ID" THEN
            //             VALIDATE("Bilddokument ID", grecKatDok.Nummer);
            //     END;
            // end;

            // //TODO  trigger OnValidate()
            // begin
            //     IF Rec."Bilddokument ID" <> '' THEN BEGIN
            //         // --- Katalogdokument --- //
            //         grecKatDok.RESET;
            //         grecKatDok.SETRANGE(Quelle, grecKatDok.Quelle::Variante);
            //         grecKatDok.SETRANGE(Art, grecKatDok.Art::Bild);
            //         grecKatDok.SETRANGE(Code, ZeilenIDCode);
            //         grecKatDok.SETRANGE(Nummer, "Bilddokument ID");
            //         IF NOT grecKatDok.FIND('-') THEN
            //             ERROR(AL0001);
            //     END;
            // end;
        }
        field(4006499; "Vererbung Beschreibungen"; Boolean)
        {
            Caption = 'Inherit Descriptions';
        }
        field(4006500; "Vererbung Merkmale"; Boolean)
        {
            Caption = 'Inherit Features';
        }
        field(4006501; "Vererbung Schlagworte"; Boolean)
        {
            Caption = 'Inherit Keywords';
        }
        field(4006502; "Vererbung Bilder"; Boolean)
        {
            Caption = 'Inherit Pictures';
        }
        field(4006503; "Vererbung Dokumente"; Boolean)
        {
            Caption = 'Inherit Documents';
        }
        field(4006504; "Vererbung Grafik"; Boolean)
        {
            Caption = 'Inherit Graphic';
        }
        field(4006505; "Vererbung Referenzen"; Boolean)
        {
            Caption = 'Inherit References';
        }
        field(4006506; "Vererbung Merkmalwerte"; Boolean)
        {
            Caption = 'Inherit Feature Values';
        }
        field(4006507; Sprache_01; Code[10])
        {
            //TODO   CalcFormula = Lookup("Katalog Einrichtung"."Sprache 01" WHERE(Primaerschluessel = CONST()));
            Caption = 'Language 1';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006508; Sprache_02; Code[10])
        {
            //TODO    CalcFormula = Lookup("Katalog Einrichtung"."Sprache 02" WHERE(Primaerschluessel = CONST()));
            Caption = 'Language 1';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006509; Sprache_03; Code[10])
        {
            //TODO   CalcFormula = Lookup("Katalog Einrichtung"."Sprache 03" WHERE(Primaerschluessel = CONST()));
            Caption = 'Language 3';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006510; Sprache_04; Code[10])
        {
            //TODO   CalcFormula = Lookup("Katalog Einrichtung"."Sprache 04" WHERE(Primaerschluessel = CONST()));
            Caption = 'Language 4';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006511; Sprache_05; Code[10])
        {
            //TODO    CalcFormula = Lookup("Katalog Einrichtung"."Sprache 05" WHERE(Primaerschluessel = CONST()));
            Caption = 'Language 5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006512; Sprache_06; Code[10])
        {
            //TODO   CalcFormula = Lookup("Katalog Einrichtung"."Sprache 06" WHERE(Primaerschluessel = CONST()));
            Caption = 'Language 6';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006513; Sprache_07; Code[10])
        {
            //TODO   CalcFormula = Lookup("Katalog Einrichtung"."Sprache 07" WHERE(Primaerschluessel = CONST()));
            Caption = 'Language 7';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006514; Sprache_08; Code[10])
        {
            //TODO   CalcFormula = Lookup("Katalog Einrichtung"."Sprache 08" WHERE(Primaerschluessel = CONST()));
            Caption = 'Language 8';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006515; Sprache_09; Code[10])
        {
            //TODO   CalcFormula = Lookup("Katalog Einrichtung"."Sprache 09" WHERE(Primaerschluessel = CONST()));
            Caption = 'Language 9';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006516; Sprache_10; Code[10])
        {
            //TODO  CalcFormula = Lookup("Katalog Einrichtung"."Sprache 10" WHERE(Primaerschluessel = CONST()));
            Caption = 'Language 10';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006517; Systemstatus; Option)
        {
            Caption = 'System Status';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006518; "Checklistennr."; Code[20])
        {
            Caption = 'Checklist Number';
            //TODO TableRelation = Checklistkopf WHERE(Klasse = CONST(Artikelgruppe));

            trigger OnValidate()
            begin
                IF xRec."Checklistennr." <> Rec."Checklistennr." THEN
                    Systemstatus := Systemstatus::"In Entwicklung";
            end;
        }
        field(4006519; "Systemstatus pruefen"; Boolean)
        {
            //TODO CalcFormula = Lookup(Checklistkopf."Systemstatus pruefen" WHERE(Code = FIELD("Checklistennr.")));
            Caption = 'Check System Status';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006520; Publikationsgruppe; Code[20])
        {
            Caption = 'Publication Group';
            //TODO TableRelation = Publikationsgruppe;
        }
        field(4006521; ZertifizierungID; BigInteger)
        {
            Caption = 'Certification ID';
        }
        field(4006522; Vorlagencode; Code[20])
        {
            Caption = 'Template Code';
            //TODO  TableRelation = Vorlage.Code WHERE(Dokumententyp = CONST(InDesign));
        }
        field(4006523; Uebersetzung; Boolean)
        {
            Caption = 'Translation';
        }
    }

    keys
    {
        key(Key1; "Item No.", "Code")
        {
            Clustered = true;
        }
        key(Key2; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ItemTranslation: Record "Item Translation";
        SKU: Record "Stockkeeping Unit";
        ItemIdent: Record "Item Identifier";
#pragma warning disable AL0432
        ItemCrossReference: Record "Item Cross Reference";
#pragma warning restore AL0432
#pragma warning disable AL0432
        SalesPrice: Record "Sales Price";
#pragma warning restore AL0432
        SalesLineDiscount: Record "Sales Line Discount";
        PurchasePrice: Record "Purchase Price";
        PurchaseLineDiscount: Record "Purchase Line Discount";
        BOMComp: Record "BOM Component";
        ItemJnlLine: Record "Item Journal Line";
        RequisitionLine: Record "Requisition Line";
        PurchOrderLine: Record "Purchase Line";
        SalesOrderLine: Record "Sales Line";
        ProdOrderComp: Record "Prod. Order Component";
        TransLine: Record "Transfer Line";
        ServiceLine: Record "Service Line";
        ProdBOMLine: Record "Production BOM Line";
        ServiceContractLine: Record "Service Contract Line";
        ServiceItem: Record "Service Item";
        AssemblyHeader: Record "Assembly Header";
        ItemSubstitution: Record "Item Substitution";
        ItemVend: Record "Item Vendor";
        PlanningAssignment: Record "Planning Assignment";
        ServiceItemComponent: Record "Service Item Component";
        BinContent: Record "Bin Content";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        AssemblyLine: Record "Assembly Line";
    begin
        BOMComp.RESET();
        BOMComp.SETCURRENTKEY(Type, "No.");
        BOMComp.SETRANGE(Type, BOMComp.Type::Item);
        BOMComp.SETRANGE("No.", "Item No.");
        BOMComp.SETRANGE("Variant Code", Code);
        IF NOT BOMComp.ISEMPTY THEN
            ERROR(Text001, Code, BOMComp.TABLECAPTION);

        ProdBOMLine.RESET();
        ProdBOMLine.SETCURRENTKEY(Type, "No.");
        ProdBOMLine.SETRANGE(Type, ProdBOMLine.Type::Item);
        ProdBOMLine.SETRANGE("No.", "Item No.");
        ProdBOMLine.SETRANGE("Variant Code", Code);
        IF NOT ProdBOMLine.ISEMPTY THEN
            ERROR(Text001, Code, ProdBOMLine.TABLECAPTION);

        ProdOrderComp.RESET();
        ProdOrderComp.SETCURRENTKEY(Status, "Item No.");
        ProdOrderComp.SETRANGE("Item No.", "Item No.");
        ProdOrderComp.SETRANGE("Variant Code", Code);
        IF NOT ProdOrderComp.ISEMPTY THEN
            ERROR(Text001, Code, ProdOrderComp.TABLECAPTION);

        IF ProdOrderExist() THEN
            ERROR(Text002, "Item No.");

        AssemblyHeader.RESET();
        AssemblyHeader.SETCURRENTKEY("Document Type", "Item No.");
        AssemblyHeader.SETRANGE("Item No.", "Item No.");
        AssemblyHeader.SETRANGE("Variant Code", Code);
        IF NOT AssemblyHeader.ISEMPTY THEN
            ERROR(Text001, Code, AssemblyHeader.TABLECAPTION);

        AssemblyLine.RESET();
        AssemblyLine.SETCURRENTKEY("Document Type", Type, "No.");
        AssemblyLine.SETRANGE("No.", "Item No.");
        AssemblyLine.SETRANGE("Variant Code", Code);
        IF NOT AssemblyLine.ISEMPTY THEN
            ERROR(Text001, Code, AssemblyLine.TABLECAPTION);

        BinContent.RESET();
        BinContent.SETCURRENTKEY("Item No.");
        BinContent.SETRANGE("Item No.", "Item No.");
        BinContent.SETRANGE("Variant Code", Code);
        IF NOT BinContent.ISEMPTY THEN
            ERROR(Text001, Code, BinContent.TABLECAPTION);

        TransLine.RESET();
        TransLine.SETCURRENTKEY("Item No.");
        TransLine.SETRANGE("Item No.", "Item No.");
        TransLine.SETRANGE("Variant Code", Code);
        IF NOT TransLine.ISEMPTY THEN
            ERROR(Text001, Code, TransLine.TABLECAPTION);

        RequisitionLine.RESET();
        RequisitionLine.SETCURRENTKEY(Type, "No.");
        RequisitionLine.SETRANGE(Type, RequisitionLine.Type::Item);
        RequisitionLine.SETRANGE("No.", "Item No.");
        RequisitionLine.SETRANGE("Variant Code", Code);
        IF NOT RequisitionLine.ISEMPTY THEN
            ERROR(Text001, Code, RequisitionLine.TABLECAPTION);

        PurchOrderLine.RESET();
        PurchOrderLine.SETCURRENTKEY(Type, "No.");
        PurchOrderLine.SETRANGE(Type, PurchOrderLine.Type::Item);
        PurchOrderLine.SETRANGE("No.", "Item No.");
        PurchOrderLine.SETRANGE("Variant Code", Code);
        IF NOT PurchOrderLine.ISEMPTY THEN
            ERROR(Text001, Code, PurchOrderLine.TABLECAPTION);

        SalesOrderLine.RESET();
        SalesOrderLine.SETCURRENTKEY(Type, "No.");
        SalesOrderLine.SETRANGE(Type, SalesOrderLine.Type::Item);
        SalesOrderLine.SETRANGE("No.", "Item No.");
        SalesOrderLine.SETRANGE("Variant Code", Code);
        IF NOT SalesOrderLine.ISEMPTY THEN
            ERROR(Text001, Code, SalesOrderLine.TABLECAPTION);

        ServiceItem.RESET();
        ServiceItem.SETCURRENTKEY("Item No.", "Serial No.");
        ServiceItem.SETRANGE("Item No.", "Item No.");
        ServiceItem.SETRANGE("Variant Code", Code);
        IF NOT ServiceItem.ISEMPTY THEN
            ERROR(Text001, Code, ServiceItem.TABLECAPTION);

        ServiceLine.RESET();
        ServiceLine.SETCURRENTKEY(Type, "No.");
        ServiceLine.SETRANGE(Type, ServiceLine.Type::Item);
        ServiceLine.SETRANGE("No.", "Item No.");
        ServiceLine.SETRANGE("Variant Code", Code);
        IF NOT ServiceLine.ISEMPTY THEN
            ERROR(Text001, Code, ServiceLine.TABLECAPTION);

        ServiceContractLine.RESET();
        ServiceContractLine.SETRANGE("Item No.", "Item No.");
        ServiceContractLine.SETRANGE("Variant Code", Code);
        IF NOT ServiceContractLine.ISEMPTY THEN
            ERROR(Text001, Code, ServiceContractLine.TABLECAPTION);

        ServiceItemComponent.RESET();
        ServiceItemComponent.SETRANGE(Type, ServiceItemComponent.Type::Item);
        ServiceItemComponent.SETRANGE("No.", "Item No.");
        ServiceItemComponent.SETRANGE("Variant Code", Code);
        ServiceItemComponent.MODIFYALL("Variant Code", '');

        ItemJnlLine.RESET();
        ItemJnlLine.SETCURRENTKEY("Item No.");
        ItemJnlLine.SETRANGE("Item No.", "Item No.");
        ItemJnlLine.SETRANGE("Variant Code", Code);
        IF NOT ItemJnlLine.ISEMPTY THEN
            ERROR(Text001, Code, ItemJnlLine.TABLECAPTION);

        ItemLedgerEntry.RESET();
        ItemLedgerEntry.SETCURRENTKEY("Item No.");
        ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
        ItemLedgerEntry.SETRANGE("Variant Code", Code);
        IF NOT ItemLedgerEntry.ISEMPTY THEN
            ERROR(Text001, Code, ItemLedgerEntry.TABLECAPTION);

        ValueEntry.RESET();
        ValueEntry.SETCURRENTKEY("Item No.");
        ValueEntry.SETRANGE("Item No.", "Item No.");
        ValueEntry.SETRANGE("Variant Code", Code);
        IF NOT ValueEntry.ISEMPTY THEN
            ERROR(Text001, Code, ValueEntry.TABLECAPTION);

        ItemTranslation.SETRANGE("Item No.", "Item No.");
        ItemTranslation.SETRANGE("Variant Code", Code);
        ItemTranslation.DELETEALL();

        ItemIdent.RESET();
        ItemIdent.SETCURRENTKEY("Item No.");
        ItemIdent.SETRANGE("Item No.", "Item No.");
        ItemIdent.SETRANGE("Variant Code", Code);
        ItemIdent.DELETEALL();

        ItemCrossReference.SETRANGE("Item No.", "Item No.");
        ItemCrossReference.SETRANGE("Variant Code", Code);
        ItemCrossReference.DELETEALL();

        ItemSubstitution.RESET();
        ItemSubstitution.SETRANGE(Type, ItemSubstitution.Type::Item);
        ItemSubstitution.SETRANGE("No.", "Item No.");
        ItemSubstitution.SETRANGE("Substitute Type", ItemSubstitution."Substitute Type"::Item);
        ItemSubstitution.SETRANGE("Variant Code", Code);
        ItemSubstitution.DELETEALL();

        ItemVend.RESET();
        ItemVend.SETCURRENTKEY("Item No.");
        ItemVend.SETRANGE("Item No.", "Item No.");
        ItemVend.SETRANGE("Variant Code", Code);
        ItemVend.DELETEALL();

        SalesPrice.RESET();
        SalesPrice.SETRANGE("Item No.", "Item No.");
        SalesPrice.SETRANGE("Variant Code", Code);
        SalesPrice.DELETEALL();

        SalesLineDiscount.RESET();
        SalesLineDiscount.SETRANGE(Code, "Item No.");
        SalesLineDiscount.SETRANGE("Variant Code", Code);
        SalesLineDiscount.DELETEALL();

        PurchasePrice.RESET();
        PurchasePrice.SETRANGE("Item No.", "Item No.");
        PurchasePrice.SETRANGE("Variant Code", Code);
        PurchasePrice.DELETEALL();

        PurchaseLineDiscount.RESET();
        PurchaseLineDiscount.SETRANGE("Item No.", "Item No.");
        PurchaseLineDiscount.SETRANGE("Variant Code", Code);
        PurchaseLineDiscount.DELETEALL();

        SKU.SETRANGE("Item No.", "Item No.");
        SKU.SETRANGE("Variant Code", Code);
        SKU.DELETEALL(TRUE);

        PlanningAssignment.RESET();
        PlanningAssignment.SETRANGE("Item No.", "Item No.");
        PlanningAssignment.SETRANGE("Variant Code", Code);
        PlanningAssignment.DELETEALL();
    end;

    trigger OnInsert()
    begin
        // --- AL.KVK4.5, Katalog Einr. --- //
        //TODO grecKatEinr.GET;

        // // --- ZeilenID --- //
        // grecArtikelVar.RESET;
        // grecArtikelVar.SETCURRENTKEY(ZeilenID);
        // IF grecArtikelVar.FIND('+') THEN
        //     ZeilenID := grecArtikelVar.ZeilenID + 1
        // ELSE
        //     ZeilenID := 1;
        // ZeilenIDCode := FORMAT(ZeilenID);

        // TODO--- Defaultwerte --- //
        // Vorlagencode := grecKatEinr."Standardvorlage Artikel";
        // "Checklistennr." := grecKatEinr."Checkliste Variante";
        // Publikationsgruppe := grecKatEinr."Publikationsgrp. Artikel";

        // TODO--- Vererbungen --- //
        // "Vererbung Beschreibungen" := grecKatEinr."Vererbung Beschreibungen";
        // "Vererbung Merkmale" := grecKatEinr."Vererbung Merkmale";
        // "Vererbung Referenzen" := grecKatEinr."Vererbung Merkmale";
        // "Vererbung Schlagworte" := grecKatEinr."Vererbung Schlagworte";
        // "Vererbung Bilder" := grecKatEinr."Vererbung Bilder";
        // "Vererbung Dokumente" := grecKatEinr."Vererbung Dokumente";
        // "Vererbung Grafik" := grecKatEinr."Vererbung Grafik";
        Uebersetzung := TRUE;
        // --- AL.KVK4.5, END --- //
    end;

    var
        Text001: Label 'You cannot delete item variant %1 because there is at least one %2 that includes this Variant Code.';
        Text002: Label 'You cannot delete item variant %1 because there are one or more outstanding production orders that include this item.';

    local procedure ProdOrderExist(): Boolean
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProdOrderLine.SETCURRENTKEY(Status, "Item No.");
        ProdOrderLine.SETRANGE("Item No.", "Item No.");
        ProdOrderLine.SETRANGE("Variant Code", Code);
        IF NOT ProdOrderLine.ISEMPTY THEN
            EXIT(TRUE);

        EXIT(FALSE);
    end;
}

