report 50026 "DEL Export achat"
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

                //Facture Achat
                PurchInvLine.RESET();
                PurchInvLine.SETRANGE(PurchInvLine."Posting Date", DateDebut, DateFin);
                PurchInvLine.SETRANGE(PurchInvLine.Type, PurchInvLine.Type::Item);
                IF FiltreFourn <> '' THEN
                    PurchInvLine.SETFILTER(PurchInvLine."Buy-from Vendor No.", FiltreFourn);
                IF FiltreArticle <> '' THEN
                    PurchInvLine.SETFILTER(PurchInvLine."No.", FiltreArticle);
                PurchInvLine.SETFILTER(PurchInvLine.Quantity, '<>0');
                IF PurchInvLine.FINDSET() THEN
                    REPEAT
                        IF NOT ExportAchat.GET(PurchInvLine."No.", '+') THEN
                            AddInfoArticle(PurchInvLine."No.", '+');
                        TauxChange1 := 0;
                        TauxChange2 := 0;
                        PurchInvHeader.GET(PurchInvLine."Document No.");
                        IF PurchInvHeader."Currency Code" <> 'EUR' THEN BEGIN
                            TauxChange1 := PurchInvHeader."Currency Factor";
                            TauxChange2 := CurrExchRate.ExchangeRate(PurchInvHeader."Posting Date", 'EUR');
                        END;

                        ExportAchat."Code Fournisseur" := CorLengthTxt(PurchInvLine."Buy-from Vendor No.", 10);
                        ExportAchat."Quantity Fact." := ExportAchat."Quantity Fact." + PurchInvLine.Quantity;
                        IF (TauxChange1 <> 0) AND (TauxChange2 <> 0) THEN
                            ExportAchat."CA HT Fact." := ExportAchat."CA HT Fact." + ROUND(((PurchInvLine.Amount / TauxChange1) * TauxChange2) * 100, 1, '=')
                        ELSE
                            ExportAchat."CA HT Fact." := ExportAchat."CA HT Fact." + ROUND(PurchInvLine.Amount * 100, 1, '=');

                        ExportAchat."Quantity Fact. Txt" := CorLengthDec(ExportAchat."Quantity Fact.", 12, '+');
                        ExportAchat."CA HT Fact. Txt" := CorLengthDec(ExportAchat."CA HT Fact.", 12, '+');
                        ExportAchat.MODIFY();

                    UNTIL PurchInvLine.NEXT() = 0;


                //Avoir Achat
                PurchCrMemoLine.RESET();
                PurchCrMemoLine.SETRANGE(PurchCrMemoLine."Posting Date", DateDebut, DateFin);
                PurchCrMemoLine.SETRANGE(PurchCrMemoLine.Type, PurchCrMemoLine.Type::Item);
                IF FiltreArticle <> '' THEN
                    PurchCrMemoLine.SETFILTER(PurchCrMemoLine."No.", FiltreArticle);
                IF FiltreFourn <> '' THEN
                    PurchCrMemoLine.SETFILTER(PurchCrMemoLine."Buy-from Vendor No.", FiltreFourn);
                PurchCrMemoLine.SETFILTER(PurchCrMemoLine.Quantity, '<>0');
                IF PurchCrMemoLine.FINDSET() THEN
                    REPEAT
                        IF NOT ExportAchat.GET(PurchCrMemoLine."No.", '-') THEN
                            AddInfoArticle(PurchCrMemoLine."No.", '-');
                        TauxChange1 := 0;
                        TauxChange2 := 0;
                        PurchCrMemoHdr.GET(PurchCrMemoLine."Document No.");
                        IF PurchCrMemoHdr."Currency Code" <> 'EUR' THEN BEGIN
                            TauxChange1 := PurchCrMemoHdr."Currency Factor";
                            TauxChange2 := CurrExchRate.ExchangeRate(PurchCrMemoHdr."Posting Date", 'EUR');
                        END;

                        ExportAchat."Code Fournisseur" := CorLengthTxt(PurchCrMemoLine."Buy-from Vendor No.", 10);
                        ExportAchat."Quantity Fact." := ExportAchat."Quantity Fact." + PurchCrMemoLine.Quantity;
                        IF (TauxChange1 <> 0) AND (TauxChange2 <> 0) THEN
                            ExportAchat."CA HT Fact." := ExportAchat."CA HT Fact." + ROUND(((PurchCrMemoLine.Amount / TauxChange1) * TauxChange2) * 100, 1, '=')
                        ELSE
                            ExportAchat."CA HT Fact." := ExportAchat."CA HT Fact." + ROUND(PurchCrMemoLine.Amount * 100, 1, '=');

                        ExportAchat."Quantity Fact. Txt" := CorLengthDec(ExportAchat."Quantity Fact.", 12, '-');
                        ExportAchat."CA HT Fact. Txt" := CorLengthDec(ExportAchat."CA HT Fact.", 12, '-');
                        ExportAchat.MODIFY();

                    UNTIL PurchCrMemoLine.NEXT() = 0;

                // Commande achat
                PurchaseLine.RESET();
                PurchaseLine.SETRANGE(PurchaseLine."Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SETRANGE(PurchaseLine.Type, PurchaseLine.Type::Item);
                PurchaseLine.SETRANGE(PurchaseLine."Order Date", DateDebut, DateFin);
                IF FiltreArticle <> '' THEN
                    PurchaseLine.SETFILTER(PurchaseLine."No.", FiltreArticle);
                IF FiltreFourn <> '' THEN
                    PurchaseLine.SETFILTER(PurchaseLine."Buy-from Vendor No.", FiltreFourn);
                PurchaseLine.SETFILTER(PurchaseLine.Quantity, '<>0');
                IF PurchaseLine.FINDSET() THEN
                    REPEAT
                        IF NOT ExportAchat.GET(PurchaseLine."No.", '+') THEN
                            AddInfoArticle(PurchaseLine."No.", '+');
                        TauxChange1 := 0;
                        TauxChange2 := 0;
                        PurchaseHeader.GET(PurchaseLine."Document Type", PurchaseLine."Document No.");
                        IF PurchaseHeader."Currency Code" <> 'EUR' THEN BEGIN
                            TauxChange1 := PurchaseHeader."Currency Factor";
                            TauxChange2 := CurrExchRate.ExchangeRate(PurchaseHeader."Posting Date", 'EUR');
                        END;

                        ExportAchat."Code Fournisseur" := CorLengthTxt(PurchaseLine."Buy-from Vendor No.", 10);
                        ExportAchat."Quantity Com." := ExportAchat."Quantity Com." + PurchaseLine.Quantity;
                        IF (TauxChange1 <> 0) AND (TauxChange2 <> 0) THEN
                            ExportAchat."CA HT Com." := ExportAchat."CA HT Com." + ROUND(((PurchaseLine.Amount / TauxChange1) * TauxChange2) * 100, 1, '=')
                        ELSE
                            ExportAchat."CA HT Com." := ExportAchat."CA HT Com." + ROUND(PurchaseLine.Amount * 100, 1, '=');
                        ExportAchat."CA HT Com. Txt" := CorLengthDec(ExportAchat."CA HT Com.", 12, '+');
                        ExportAchat."Quantity Com.Txt" := CorLengthDec(ExportAchat."Quantity Com.", 12, '+');
                        ExportAchat.MODIFY();
                    UNTIL PurchaseLine.NEXT() = 0;


                // reception achat
                PurchRcptLine.RESET();
                PurchRcptLine.SETRANGE(PurchRcptLine."Posting Date", DateDebut, DateFin);
                PurchRcptLine.SETRANGE(PurchRcptLine.Type, PurchRcptLine.Type::Item);
                IF FiltreArticle <> '' THEN
                    PurchRcptLine.SETFILTER(PurchRcptLine."No.", FiltreArticle);
                IF FiltreFourn <> '' THEN
                    PurchRcptLine.SETFILTER(PurchRcptLine."Buy-from Vendor No.", FiltreFourn);
                PurchRcptLine.SETFILTER(PurchRcptLine.Quantity, '<>0');
                IF PurchRcptLine.FINDSET() THEN
                    REPEAT
                        IF NOT ExportAchat.GET(PurchRcptLine."No.", '+') THEN
                            AddInfoArticle(PurchRcptLine."No.", '+');
                        TauxChange1 := 0;
                        TauxChange2 := 0;
                        PurchRcptHeader.GET(PurchRcptLine."Document No.");
                        IF PurchRcptHeader."Currency Code" <> 'EUR' THEN BEGIN
                            TauxChange1 := PurchRcptHeader."Currency Factor";
                            TauxChange2 := CurrExchRate.ExchangeRate(PurchRcptHeader."Posting Date", 'EUR');
                        END;

                        ExportAchat."Code Fournisseur" := CorLengthTxt(PurchRcptLine."Buy-from Vendor No.", 10);
                        ExportAchat."Quantity Liv." := ExportAchat."Quantity Liv." + PurchRcptLine.Quantity;
                        ExportAchat."Quantity Liv. Txt" := CorLengthDec(ExportAchat."Quantity Liv.", 12, '+');
                        IF (TauxChange1 <> 0) AND (TauxChange2 <> 0) THEN
                            ExportAchat."CA HT Liv." := ExportAchat."CA HT Liv." + ROUND(((PurchRcptLine."Item Charge Base Amount" / TauxChange1) * TauxChange2) * 100, 1, '=')
                        ELSE
                            ExportAchat."CA HT Liv." := ExportAchat."CA HT Liv." + ROUND(PurchRcptLine."Item Charge Base Amount" * 100, 1, '=');
                        ExportAchat."CA HT Liv. Txt" := CorLengthDec(ExportAchat."CA HT Liv.", 12, '+');
                        ExportAchat.MODIFY();


                    UNTIL PurchRcptLine.NEXT() = 0;
            end;

            trigger OnPreDataItem()
            begin
                IF DateDebut = 0D THEN
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
                field(DateDebut; DateDebut)
                {
                    Caption = 'Beging Date';

                    trigger OnValidate()
                    begin
                        IF DateDebut <> 0D THEN BEGIN
                            Mois := DATE2DMY(DateDebut, 2);
                            Year := DATE2DMY(DateDebut, 3);
                            DateDebut := DMY2DATE(1, Mois, Year);
                            DateFin := CALCDATE('+FM', DateDebut);
                        END
                        ELSE BEGIN
                            DateFin := 0D;
                        END;
                    end;
                }
                field(DateFin; DateFin)
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
        FileName := 'CONSO_ACHATS_MG_S2_CH_NGT_' + DateNow_Te + '_' + TimeNow_Te + '_fv1.CSV';
        ExportAchat.RESET();
        ExportAchat.SETFILTER(ExportAchat."Item No.", '<>%1', '');
        IF ExportAchat.FINDFIRST() THEN BEGIN
            TempBlob.CreateOutStream(VarOut);
            REPEAT
                Line := ExportAchat.Mois +
                      ExportAchat."Code Fournisseur" +
                      ExportAchat."Type flux" +
                      ExportAchat.Activité +
                      ExportAchat.Pays +
                      ExportAchat.Enseigne +
                      ExportAchat."Type d'identifiant" +
                      ExportAchat."Identifiant produit" +
                      ExportAchat."Identifiant fabricant" +
                      ExportAchat.Sens +
                      ExportAchat."Quantity Com.Txt" +
                      ExportAchat."Quantity Liv. Txt" +
                      ExportAchat."Quantity Fact. Txt" +
                      ExportAchat."CA HT Com. Txt" +
                      ExportAchat."CA HT Liv. Txt" +
                      ExportAchat."CA HT Fact. Txt" +
                      ExportAchat.Ean +
                      ExportAchat."Code Marque" +
                      ExportAchat.Fournisseur +
                      ExportAchat."Référence fournisseur" +
                      ExportAchat.Fabricant +
                      ExportAchat."Référence fabricant" +
                      ExportAchat."Fournisseur principal" +
                      ExportAchat."Référence fournisseur Prin." +
                      ExportAchat."Code article B.U" +
                      ExportAchat."Groupe marchandise B.U" +
                      ExportAchat."Libellé produit" +
                      ExportAchat."CA HT Liv. Txt";

                VarOut.WRITETEXT(Line);
                VarOut.WRITETEXT();
            UNTIL ExportAchat.NEXT() = 0;
            MESSAGE(Text0002);
            FileManagement.BLOBExport(TempBlob, FileName, true);
        END;
    end;

    trigger OnPreReport()
    begin
        ExportAchat.DELETEALL();
    end;

    var
        CurrExchRate: Record "Currency Exchange Rate";
        ExportAchat: Record "DEL Export Achat";
        Item_Rec: Record Item;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        Vendor_Rec: Record Vendor;
        ItemList: Page "Item List";
        VendorList: Page "Vendor List";
        DateDebut: Date;
        DateFin: Date;
        TauxChange1: Decimal;
        TauxChange2: Decimal;
        Mois: Integer;
        Year: Integer;
        Text0001: Label 'Invalid date';
        Text0002: Label 'Generated file';
        VarOut: OutStream;
        DateNow_Te: Text;
        FileName: Text;
        FiltreArticle: Text;
        FiltreFourn: Text;
        TimeNow_Te: Text;
        Line: Text[383];


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
        IF VarSens = '+' THEN
            VarDecTxt := '0' + VarDecTxt
        ELSE
            VarDecTxt := '-' + VarDecTxt;
        EXIT(VarDecTxt);
    end;


    procedure AddInfoLiv(var ItemCode: Code[20])
    begin
    end;


    procedure AddInfocomm(var ItemCode: Code[20])
    begin
    end;


    procedure AddInfoArticle(CodeArticle: Code[20]; SensLine: Text[1])
    begin
        IF NOT ExportAchat.GET(CodeArticle, SensLine) THEN BEGIN
            ExportAchat.INIT();
            Item_Rec.GET(CodeArticle);
            ExportAchat."Item No." := CodeArticle;
            IF Mois < 10 THEN
                ExportAchat.Mois := FORMAT(Year) + '0' + FORMAT(Mois)
            ELSE
                ExportAchat.Mois := FORMAT(Year) + FORMAT(Mois);
            ExportAchat."Type flux" := '1';
            ExportAchat.Activité := 'S2';
            ExportAchat.Pays := 'CH';
            ExportAchat.Enseigne := 'NGT';
            ExportAchat."Type d'identifiant" := '9';
            ExportAchat."Identifiant produit" := CorLengthTxt(Item_Rec."No.", 30);
            ExportAchat."Identifiant fabricant" := CorLengthTxt('', 10);
            ExportAchat.Sens := SensLine;
            ExportAchat."Quantity Fact." := 0;
            ExportAchat."CA HT Fact." := 0;
            ExportAchat."Quantity Fact. Txt" := CorLengthDec(ExportAchat."Quantity Fact.", 12, SensLine);
            ExportAchat."CA HT Fact. Txt" := CorLengthDec(0, 12, SensLine);
            ExportAchat."Quantity Com.Txt" := CorLengthDec(0, 12, SensLine);
            ExportAchat."CA HT Com. Txt" := CorLengthDec(0, 12, SensLine);
            ExportAchat."Quantity Liv. Txt" := CorLengthDec(0, 12, SensLine);
            ExportAchat."CA HT Liv. Txt" := CorLengthDec(0, 12, SensLine);
            ExportAchat.Ean := CorLengthTxt(Item_Rec."DEL Code EAN 13", 13);
            ExportAchat."Code Marque" := CorLengthTxt(Item_Rec."DEL Marque", 10);
            ExportAchat.Fournisseur := CorLengthTxt(Item_Rec."Vendor No.", 10);
            ExportAchat."Référence fournisseur" := CorLengthTxt(Item_Rec."Vendor Item No.", 30);
            ExportAchat.Fabricant := CorLengthTxt('', 10);
            ExportAchat."Référence fabricant" := CorLengthTxt('', 30);
            ExportAchat."Fournisseur principal" := CorLengthTxt(Item_Rec."Vendor No.", 10);
            ;
            ExportAchat."Référence fournisseur Prin." := CorLengthTxt(Item_Rec."Vendor Item No.", 30);
            ExportAchat."Code article B.U" := CorLengthTxt(Item_Rec."No.", 10);
            //TODO   // ExportAchat."Groupe marchandise B.U" := CorLengthTxt(Item_Rec."DEL Product Group Code", 30);
            ExportAchat."Libellé produit" := CorLengthTxt(Item_Rec.Description, 50);
            ExportAchat.INSERT();
        END;
    end;
}

