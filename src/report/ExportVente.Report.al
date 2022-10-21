report 50025 "DEL Export Vente"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = FILTER(1));

            trigger OnAfterGetRecord()
            begin

                SalesInvoiceLine.RESET();
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Posting Date", DateBegin, DateEnd);
                SalesInvoiceLine.SETRANGE(SalesInvoiceLine.Type, SalesInvoiceLine.Type::Item);
                IF FiltreArticle <> '' THEN
                    SalesInvoiceLine.SETFILTER(SalesInvoiceLine."No.", FiltreArticle);
                SalesInvoiceLine.SETFILTER(SalesInvoiceLine.Quantity, '<>0');
                IF SalesInvoiceLine.FINDSET() THEN
                    REPEAT
                        i := 0;
                        Item.RESET();
                        Item.SETRANGE(Item."No.", SalesInvoiceLine."No.");
                        IF FiltreFourn <> '' THEN
                            Item.SETFILTER(Item."Vendor No.", FiltreFourn);
                        IF Item.FINDFIRST() THEN BEGIN
                            IF NOT ExportVente.GET(SalesInvoiceLine."No.", '+') THEN BEGIN
                                ExportVente.INIT();
                                ExportVente."Item No." := SalesInvoiceLine."No.";
                                ExportVente.Sens := '+';
                                ExportVente.INSERT();
                                COMMIT();
                                AddInfo('+');
                            END
                            ELSE
                                AddInfo('+');
                        END;


                    UNTIL SalesInvoiceLine.NEXT() = 0;



                SalesCrMemoLine.RESET();
                SalesCrMemoLine.SETRANGE(SalesCrMemoLine."Posting Date", DateBegin, DateEnd);
                SalesCrMemoLine.SETRANGE(SalesCrMemoLine.Type, SalesCrMemoLine.Type::Item);

                IF FiltreArticle <> '' THEN
                    SalesCrMemoLine.SETFILTER(SalesCrMemoLine."No.", FiltreArticle);

                SalesCrMemoLine.SETFILTER(SalesCrMemoLine.Quantity, '<>0');
                IF SalesCrMemoLine.FINDSET() THEN
                    REPEAT
                        Item.RESET();
                        Item.SETRANGE(Item."No.", SalesCrMemoLine."No.");
                        IF FiltreFourn <> '' THEN
                            Item.SETFILTER(Item."Vendor No.", FiltreFourn);

                        IF Item.FINDFIRST() THEN BEGIN
                            IF NOT ExportVente.GET(SalesCrMemoLine."No.", '-') THEN BEGIN
                                ExportVente.INIT();
                                ExportVente."Item No." := SalesCrMemoLine."No.";
                                ExportVente.Sens := '-';
                                ExportVente.INSERT();
                                COMMIT();
                                AddInfo('-');
                            END
                            ELSE
                                AddInfo('-');

                        END;
                    UNTIL SalesCrMemoLine.NEXT() = 0;
            end;

            trigger OnPreDataItem()
            begin
                IF DateBegin = 0D THEN
                    ERROR(Text0001);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DateDebut; DateBegin)
                {
                    Caption = 'Beging Date';

                    trigger OnValidate()
                    begin
                        IF DateBegin <> 0D THEN BEGIN
                            Mois := DATE2DMY(DateBegin, 2);
                            Year := DATE2DMY(DateBegin, 3);
                            DateBegin := DMY2DATE(1, Mois, Year);
                            DateEnd := CALCDATE('+FM', DateBegin);
                        END
                        ELSE BEGIN
                            DateEnd := 0D;
                        END;
                    end;
                }
                field(DateFin; DateEnd)
                {
                    Caption = 'End Date';
                    Editable = false;
                }
                field(FiltreArticle; FiltreArticle)
                {
                    Caption = 'Item Filter';

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ItemList);
                        Item_Rec.RESET();
                        ItemList.LOOKUPMODE(TRUE);
                        ItemList.SETTABLEVIEW(Item_Rec);
                        ItemList.SETRECORD(Item_Rec);
                        IF ItemList.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                            ItemList.GETRECORD(Item_Rec);
                            FiltreArticle := FiltreArticle + Item_Rec."No.";
                            COMMIT();
                        END;
                    end;
                }
                field(FiltreFourn; FiltreFourn)
                {
                    Caption = 'Vendor Filter';

                    trigger OnAssistEdit()
                    begin
                        CLEAR(VendorList);
                        Vendor_Rec.RESET();
                        VendorList.LOOKUPMODE(TRUE);
                        VendorList.SETTABLEVIEW(Vendor_Rec);
                        VendorList.SETRECORD(Vendor_Rec);
                        IF VendorList.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                            VendorList.GETRECORD(Vendor_Rec);
                            FiltreFourn := FiltreFourn + Vendor_Rec."No.";
                            COMMIT();
                        END;
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
    begin
        IF Mois < 10 THEN
            DateNow_Te := FORMAT(Year) + '_0' + FORMAT(Mois)
        ELSE
            DateNow_Te := FORMAT(Year) + '_' + FORMAT(Mois);
        TimeNow_Te := DELCHR(FORMAT(TIME), '=', ':/.');
        FileName := 'CONSO_VENTES_MG_S2_CH_NGT_' + DateNow_Te + '_' + TimeNow_Te + '_fv1.CSV';
        IF ExportVente.FINDFIRST() THEN
            TempBlob.CreateOutStream(VarOut);
        REPEAT
            Line := ExportVente.Mois + ExportVente.Activité + ExportVente.Pays + ExportVente.Enseigne + ExportVente."Type d'identifiant" + ExportVente."Identifiant produit" + ExportVente."Identifiant fabricant" +
                  ExportVente.Sens + ExportVente.Quantité + ExportVente."C.A. H.T." + ExportVente.Ean + ExportVente."Code Marque" + ExportVente.Fournisseur + ExportVente."Référence fournisseur" + ExportVente.Fabricant +
                  ExportVente."Référence fabricant" + ExportVente."Fournisseur principal" + ExportVente."Référence fournisseur Prin." + ExportVente."Code article B.U" + ExportVente."Groupe marchandise B.U" +
                  ExportVente."Libellé produit";
            VarOut.WRITETEXT(Line);
            VarOut.WRITETEXT();
        UNTIL ExportVente.NEXT() = 0;
        MESSAGE('Fichier créer');
        FileManagement.BLOBExport(TempBlob, FileName, True);
    end;

    trigger OnPreReport()
    begin
        ExportVente.DELETEALL();
    end;

    var
        CurrExchRate: Record "Currency Exchange Rate";
        ExportVente: Record "DEL Export vente";
        Item: Record Item;
        Item_Rec: Record Item;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        Vendor_Rec: Record Vendor;
        ItemList: Page "Item List";
        VendorList: Page "Vendor List";
        DateBegin: Date;
        DateEnd: Date;
        TauxChange1: Decimal;
        TauxChange2: Decimal;
        i: Integer;
        Mois: Integer;
        Year: Integer;
        Text0001: Label 'Invalid date';
        VarOut: OutStream;
        DateNow_Te: Text;
        FileName: Text;
        FiltreArticle: Text;
        FiltreFourn: Text;
        TimeNow_Te: Text;
        Line: Text[312];


    procedure AddInfo(SensLine: Text[1])
    begin
        IF SensLine = '+' THEN BEGIN
            Item_Rec.GET(SalesInvoiceLine."No.");
            TauxChange1 := 0;
            TauxChange2 := 0;
            SalesInvoiceHeader.GET(SalesInvoiceLine."Document No.");
            IF SalesInvoiceHeader."Currency Code" <> 'EUR' THEN BEGIN
                TauxChange1 := SalesInvoiceHeader."Currency Factor";
                TauxChange2 := CurrExchRate.ExchangeRate(SalesInvoiceHeader."Posting Date", 'EUR');
            END;

            ExportVente.GET(SalesInvoiceLine."No.", '+');
            IF Mois < 10 THEN
                ExportVente.Mois := FORMAT(Year) + '0' + FORMAT(Mois)
            ELSE
                ExportVente.Mois := FORMAT(Year) + FORMAT(Mois);
            ExportVente.Activité := 'S2';
            ExportVente.Pays := 'CH';
            ExportVente.Enseigne := 'NGT';
            ExportVente."Type d'identifiant" := '9';
            ExportVente."Identifiant produit" := CorLengthTxt(SalesInvoiceLine."No.", 30);
            ExportVente."Identifiant fabricant" := CorLengthTxt('', 10);

            ExportVente.QuantityDec := ExportVente.QuantityDec + SalesInvoiceLine.Quantity;
            IF (TauxChange1 <> 0) AND (TauxChange2 <> 0) THEN
                ExportVente."CA HT" := ExportVente."CA HT" + ROUND(((SalesInvoiceLine.Amount / TauxChange1) * TauxChange2) * 100, 1, '=')
            ELSE
                ExportVente."CA HT" := ExportVente."CA HT" + ROUND(SalesInvoiceLine.Amount * 100, 1, '=');
            ExportVente.Quantité := CorLengthDec(ExportVente.QuantityDec, 12, '0');
            ExportVente."C.A. H.T." := CorLengthDec(ExportVente."CA HT", 12, '0');
            ExportVente.Ean := CorLengthTxt(Item_Rec."DEL Code EAN 13", 13);
            ExportVente."Code Marque" := CorLengthTxt(Item_Rec."DEL Marque", 10);
            ExportVente.Fournisseur := CorLengthTxt(Item_Rec."Vendor No.", 10);
            ExportVente."Référence fournisseur" := CorLengthTxt(Item_Rec."Vendor Item No.", 30);
            ExportVente.Fabricant := CorLengthTxt('', 10);
            ExportVente."Référence fabricant" := CorLengthTxt('', 30);
            ExportVente."Fournisseur principal" := CorLengthTxt(Item_Rec."Vendor No.", 10);

            ExportVente."Référence fournisseur Prin." := CorLengthTxt(Item_Rec."Vendor Item No.", 30);
            ExportVente."Code article B.U" := CorLengthTxt(Item_Rec."No.", 10);
            //TODO : check product Group  //ExportVente."Groupe marchandise B.U" := CorLengthTxt(Item_Rec."DEL Product Group Code", 30);           //21
            ExportVente."Libellé produit" := CorLengthTxt(Item_Rec.Description, 50);
            ExportVente.MODIFY();
        END;

        IF SensLine = '-' THEN BEGIN
            Item_Rec.GET(SalesCrMemoLine."No.");
            SalesCrMemoHeader.GET(SalesCrMemoLine."Document No.");
            TauxChange1 := 0;
            TauxChange2 := 0;
            IF SalesCrMemoHeader."Currency Code" <> 'EUR' THEN BEGIN
                TauxChange1 := SalesCrMemoHeader."Currency Factor";
                TauxChange2 := CurrExchRate.ExchangeRate(SalesCrMemoHeader."Posting Date", 'EUR');
            END;

            ExportVente.GET(SalesCrMemoLine."No.", '-');
            IF Mois < 10 THEN
                ExportVente.Mois := FORMAT(Year) + '0' + FORMAT(Mois)
            ELSE
                ExportVente.Mois := FORMAT(Year) + FORMAT(Mois);
            ExportVente.Activité := 'S2';
            ExportVente.Pays := 'CH';
            ExportVente.Enseigne := 'NGT';
            ExportVente."Type d'identifiant" := '9';
            ExportVente."Identifiant produit" := CorLengthTxt(SalesCrMemoLine."No.", 30);
            ExportVente."Identifiant fabricant" := CorLengthTxt('', 10);
            ExportVente.Ean := CorLengthTxt(Item_Rec."DEL Code EAN 13", 13);
            ExportVente."Code Marque" := CorLengthTxt(Item_Rec."DEL Marque", 10);
            ExportVente.Fournisseur := CorLengthTxt(Item_Rec."Vendor No.", 10);
            ExportVente."Référence fournisseur" := CorLengthTxt(Item_Rec."Vendor Item No.", 30);
            ExportVente.Fabricant := CorLengthTxt('', 10);
            ExportVente."Référence fabricant" := CorLengthTxt('', 30);
            ExportVente."Fournisseur principal" := CorLengthTxt(Item_Rec."Vendor No.", 10);
            ;
            ExportVente."Référence fournisseur Prin." := CorLengthTxt(Item_Rec."Vendor Item No.", 30);
            ExportVente."Code article B.U" := CorLengthTxt(Item_Rec."No.", 10);
            //TODO : check product Group   // ExportVente."Groupe marchandise B.U" := CorLengthTxt(Item_Rec."Product Group Code", 30);
            ExportVente."Libellé produit" := CorLengthTxt(Item_Rec.Description, 50);
            ExportVente.QuantityDec := ExportVente.QuantityDec + SalesCrMemoLine.Quantity;
            IF (TauxChange1 <> 0) AND (TauxChange2 <> 0) THEN
                ExportVente."CA HT" := ExportVente."CA HT" + ROUND(((SalesCrMemoLine.Amount / TauxChange1) * TauxChange2) * 100, 1, '=')
            ELSE
                ExportVente."CA HT" := ExportVente."CA HT" + ROUND(SalesCrMemoLine.Amount * 100, 1, '=');
            ExportVente.Quantité := CorLengthDec(ExportVente.QuantityDec, 12, '-');
            ExportVente."C.A. H.T." := CorLengthDec(ExportVente."CA HT", 12, '-');
            ExportVente.MODIFY();
        END;
    end;


    procedure CorLengthTxt(VarTxt: Text; Taille: Integer): Text
    var
        NbreCarac: Integer;
    begin
        NbreCarac := 0;
        NbreCarac := STRLEN(VarTxt);
        IF NbreCarac < Taille THEN
            REPEAT
                VarTxt := ' ' + VarTxt;
                NbreCarac := NbreCarac + 1;
            UNTIL NbreCarac = Taille;


        IF NbreCarac > Taille THEN
            VarTxt := COPYSTR(VarTxt, 1, Taille);
        EXIT(VarTxt);
    end;


    procedure CorLengthDec(VarDec: Decimal; Taille: Integer; VarSens: Text): Text
    var
        NbreCarac: Integer;
        VarDecTxt: Text;
    begin
        NbreCarac := 0;
        VarDecTxt := FORMAT(VarDec, 0, 2);
        NbreCarac := STRLEN(VarDecTxt);
        IF NbreCarac < Taille THEN
            REPEAT
                VarDecTxt := '0' + VarDecTxt;
                NbreCarac := NbreCarac + 1;
            UNTIL NbreCarac = Taille - 1;
        VarDecTxt := VarSens + VarDecTxt;
        EXIT(VarDecTxt);
    end;
}

