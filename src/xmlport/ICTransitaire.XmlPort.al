xmlport 50000 "DEL IC Transitaire"
{

    Encoding = UTF8;

    schema
    {
        textelement(transitaire)
        {
            tableelement(38; 38)
            {
                XmlName = 'entete';
                textelement(adresseiptransitaire)
                {
                    XmlName = 'AdresseIPTransitaire';

                    trigger OnBeforePassVariable()
                    begin
                        Transitaires.SETRANGE("Forwarding Agent Code", "Purchase Header"."Forwarding Agent Code");
                        IF Transitaires.FIND('-') THEN BEGIN
                            AdresseIPTransitaire := Transitaires."URL Address";
                            CodeTransitaire := Transitaires."Forwarding Agent Code";
                            NomTransitaire := Transitaires.Description;
                        END;
                    end;
                }
                textelement(nomemetteur)
                {
                    XmlName = 'NomEmetteur';
                }
                fieldelement(NoCommandeNav; "Purchase Header"."No.")
                {
                }
                fieldelement(RefcomClient; "Purchase Header"."Your Reference")
                {
                }
                textelement(codetransitaire)
                {
                    XmlName = 'CodeTransitaire';
                }
                textelement(nomtransitaire)
                {
                    XmlName = 'NomTransitaire';
                }
                fieldelement(DateCommande; "Purchase Header"."Order Date")
                {
                }
                fieldelement(NomFournisseur; "Purchase Header"."Pay-to Name")
                {
                }
                fieldelement(AdressFournisseur1; "Purchase Header"."Buy-from Address")
                {
                }
                fieldelement(AdressFournisseur2; "Purchase Header"."Buy-from Address 2")
                {
                }
                fieldelement(CodePostalFournisseur; "Purchase Header"."Pay-to Post Code")
                {
                }
                fieldelement(VilleFournisseur; "Purchase Header"."Buy-from City")
                {
                }
                fieldelement(CodePaysFournisseur; "Purchase Header"."Pay-to Country/Region Code")
                {
                }
                fieldelement(CodeDonneurOrdre; "Purchase Header"."Sell-to Customer No.")
                {
                }
                fieldelement(NomDestinataire; "Purchase Header"."Ship-to Name")
                {
                }
                fieldelement(AdressDestinataire1; "Purchase Header"."Ship-to Address")
                {
                }
                fieldelement(AdressDestinataire2; "Purchase Header"."Ship-to Address 2")
                {
                }
                fieldelement(CodePostalDestinataire; "Purchase Header"."Ship-to Post Code")
                {
                }
                fieldelement(VilleDestinataire; "Purchase Header"."Ship-to City")
                {
                }
                fieldelement(CodePaysDestinataire; "Purchase Header"."Ship-to Country/Region Code")
                {
                }
                fieldelement(PortArriveeMagasin; "Purchase Header"."Port d'arrivée")
                {
                }
                fieldelement(ShipPer; "Purchase Header"."Ship Per")
                {
                }
                fieldelement(PortDepart; "Purchase Header"."Port de départ")
                {
                }
                fieldelement(CodeEvenement; "Purchase Header"."Code événement")
                {
                }
                textelement(lignes)
                {
                    tableelement(39; 39)
                    {
                        LinkFields = Field3 = FIELD(Field3);
                        LinkTable = "Purchase Header";
                        XmlName = 'position';
                        SourceTableView = SORTING(Field1, Field3, Field6)
                                          ORDER(Ascending)
                                          WHERE(Field5 = CONST(2));
                        fieldelement(CodeArticleNav; "Purchase Line"."No.")
                        {
                        }
                        fieldelement(Designation1; "Purchase Line".Description)
                        {
                        }
                        fieldelement(ReferenceFournisseur; "Purchase Line"."Vendor Item No.")
                        {
                        }
                        fieldelement(Codeartclient; "Purchase Line"."External reference NGTS")
                        {
                        }
                        textelement(HSCODE)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                Item.SETRANGE("No.", "Purchase Line"."No.");
                                IF Item.FIND('-') THEN BEGIN
                                    HSCODE := Item."Code nomenclature douaniere";
                                END;
                            end;
                        }
                        textelement(Marque)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                Item.SETRANGE("No.", "Purchase Line"."No.");
                                IF Item.FIND('-') THEN BEGIN
                                    //START THM01
                                    IF Manufacturer.GET(Item.Marque) THEN BEGIN
                                        Marque := Manufacturer.Name;
                                        //Marque := Item.Marque; OLD
                                    END;
                                    //STOP THM01
                                END;
                            end;
                        }
                        textelement(Quantite)
                        {

                            trigger OnBeforePassVariable()
                            var
                                longueur: Integer;
                                quantite1: Text[30];
                                quantite2: Text[30];
                                quantite3: Text[30];
                            begin
                                longueur := STRLEN(FORMAT("Purchase Line".Quantity));

                                IF (longueur < 4) THEN BEGIN
                                    Quantite := FORMAT("Purchase Line".Quantity)
                                END;


                                IF (longueur < 8) AND (longueur > 3) THEN BEGIN
                                    quantite1 := COPYSTR(FORMAT("Purchase Line".Quantity), 1, longueur - 4);
                                    quantite2 := COPYSTR(FORMAT("Purchase Line".Quantity), longueur - 2, 4);
                                    Quantite := quantite1 + ' ' + quantite2;
                                END;

                                IF (longueur < 12) AND (longueur > 7) THEN BEGIN
                                    quantite1 := COPYSTR(FORMAT("Purchase Line".Quantity), 1, longueur - 8);
                                    quantite2 := COPYSTR(FORMAT("Purchase Line".Quantity), longueur - 6, 4);
                                    quantite3 := COPYSTR(FORMAT("Purchase Line".Quantity), longueur - 2, 4);
                                    Quantite := quantite1 + ' ' + quantite2 + ' ' + quantite3;
                                END;
                            end;
                        }
                        fieldelement(CodeUnite; "Purchase Line"."Unit of Measure Code")
                        {
                        }
                        fieldelement(DateEmbarquement; "Purchase Header"."Requested Delivery Date")
                        {
                        }
                        fieldelement(DateReceptionPrevue; "Purchase Header"."Expected Receipt Date")
                        {
                        }
                        fieldelement(VolumeTotal; "Purchase Line"."Total volume")
                        {
                        }
                    }
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort()
    var
        longueur: Integer;
        quantite1: Text[30];
        quantite2: Text[30];
    begin
        // Holt allgemeine Daten zu Flux 5
        NGTSSetup.GET;

        NomEmetteur := NGTSSetup."Nom emetteur";
    end;

    var
        NGTSSetup: Record "50000";
        Transitaires: Record "50009";
        Item: Record "27";
        Manufacturer: Record "5720";
}

