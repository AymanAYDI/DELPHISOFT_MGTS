xmlport 50002 "DEL IC Transitaire with hscode"
{
    Encoding = UTF8;

    schema
    {
        textelement(transitaire)
        {
            tableelement("Purchase Header"; "Purchase Header")
            {
                XmlName = 'entete';
                textelement(adresseiptransitaire)
                {
                    XmlName = 'AdresseIPTransitaire';

                    trigger OnBeforePassVariable()
                    begin
                        Transitaires.SETRANGE("Forwarding Agent Code", "Purchase Header"."DEL Forwarding Agent Code");
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
                fieldelement(PortArriveeMagasin; "Purchase Header"."DEL Port d'arrivée")
                {
                }
                fieldelement(ShipPer; "Purchase Header"."DEL Ship Per")
                {
                }
                fieldelement(PortDepart; "Purchase Header"."DEL Port de départ")
                {
                }
                fieldelement(CodeEvenement; "Purchase Header"."DEL Code événement")
                {
                }
                textelement(lignes)
                {
                    tableelement("Purchase Line"; "Purchase Line")
                    {
                        LinkFields = "Document No." = FIELD("No.");
                        LinkTable = "Purchase Header";
                        SourceTableView = SORTING("Document Type", "Document No.", "No.")
                                          ORDER(Ascending)
                                          WHERE(Type = CONST(2));
                        XmlName = 'position';
                        fieldelement(CodeArticleNav; "Purchase Line"."No.")
                        {
                        }
                        fieldelement(Designation1; "Purchase Line".Description)
                        {
                        }
                        fieldelement(ReferenceFournisseur; "Purchase Line"."Item Reference No.")
                        {
                        }
                        textelement(HSCODE)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                Item.SETRANGE("No.", "Purchase Line"."No.");
                                IF Item.FIND('-') THEN
                                    HSCODE := Item."DEL Code nomenc. douaniere";
                            end;
                        }
                        textelement(Quantite)
                        {

                            trigger OnBeforePassVariable()
                            var
                                longueur: Integer;
                                quantite1: Text;
                                quantite2: Text;
                                quantite3: Text;
                            begin
                                longueur := STRLEN(FORMAT("Purchase Line".Quantity));

                                IF (longueur < 4) THEN
                                    Quantite := FORMAT("Purchase Line".Quantity);


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
                        fieldelement(DateEmbarquement; "Purchase Header"."DEL Requested Delivery Date")
                        {
                        }
                        fieldelement(DateReceptionPrevue; "Purchase Line"."Expected Receipt Date")
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
    begin
        NGTSSetup.GET();

        NomEmetteur := NGTSSetup."Nom emetteur";
    end;

    var
        Transitaires: Record "DEL Forwarding agent 2";
        NGTSSetup: Record "DEL General Setup";
        Item: Record Item;
}

