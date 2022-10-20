page 50000 "DEL General Setup"
{


    Caption = 'General Setup';
    PageType = Card;
    SourceTable = "DEL General Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Dernier num séq maj Dev Init"; Rec."Dernier num séq maj Dev Init")
                {
                    Caption = 'Dernier num séq maj Dev Init';
                }
            }
            group(Axes)
            {
                Caption = 'Axes';
                field("Code Axe Achat"; Rec."Code Axe Achat")
                {
                    Caption = 'Code Axe Achat';
                }
                label(LabelAxe)
                {
                    CaptionClass = Text19036189;
                    MultiLine = true;
                }
            }
            group(Transitaire)
            {
                Caption = 'Transitaire';
                field("Nom emetteur"; Rec."Nom emetteur")
                {
                    Caption = 'Nom emetteur';
                }
                field("Nom achat commande transitaire"; Rec."Nom achat commande transitaire")
                {
                    Caption = 'Nom achat commande transitaire';
                }
                field("IC Forwarding Agent Code"; Rec."IC Forwarding Agent Code")
                {
                    Caption = 'IC Forwarding Agent Code';
                }
            }
            group(Deal)
            {
                Caption = 'Deal';
                field("Element Nos."; Rec."Element Nos.")
                {
                    Caption = 'Element Nos.';
                }
                field("Position Nos."; Rec."Position Nos.")
                {
                    Caption = 'Position Nos.';
                }
                field("Fee Nos."; Rec."Fee Nos.")
                {
                    Caption = 'Fee Nos.';
                }
                field("Fee Connection Nos."; Rec."Fee Connection Nos.")
                {
                    Caption = 'Fee Connection Nos.';
                }
                field("Provision Nos."; Rec."Provision Nos.")
                {
                    Caption = 'Provision Nos.';
                }
            }
            group("Special Order")
            {
                Caption = 'Special Order';
                field("Default Purchasing Code"; Rec."Default Purchasing Code")
                {
                    Caption = 'Default Purchasing Code';
                }
            }
            group(Tracking)
            {
                Caption = 'Tracking';
                field("Folder Expeditors"; Rec."Folder Expeditors")
                {
                    Caption = 'Folder Expeditors';
                }
                field("Folder Expeditors Archive"; Rec."Folder Expeditors Archive")
                {
                    Caption = 'Folder Expeditors Archive';
                }
                field("Folder Maersk"; Rec."Folder Maersk")
                {
                    Caption = 'Folder Maersk';
                }
                field("Folder Maersk Archive"; Rec."Folder Maersk Archive")
                {
                    Caption = 'Folder Maersk Archive';
                }
            }
            group(Reporting)
            {
                Caption = 'Reporting';
                field("Reporting File"; Rec."Reporting File")
                {
                    Caption = 'Reporting File';
                }
                field("Hyperion Company Code"; Rec."Hyperion Company Code")
                {
                    Caption = 'Hyperion Company Code';
                }
                field("Hyperion File"; Rec."Hyperion File")
                {
                    Caption = 'Hyperion File';
                }
                field("Sales File"; Rec."Sales File")
                {
                    Caption = 'Sales File';
                }
                field("Purchase File"; Rec."Purchase File")
                {
                    Caption = 'Purchase File';
                }
            }
            group("Coefficient Of Item Quality")
            {
                Caption = 'Coefficient Of Item Quality';
                field("Risque Securitaire"; Rec."Risque Securitaire")
                {
                    Caption = 'Coefficient of Security Level Of Risk %';
                }
                field("Risque Reglementaire"; Rec."Risque Reglementaire")
                {
                    Caption = 'Coefficient Of Regulation Level Of Risk %';
                }
                field("Marque Produit"; Rec."Marque Produit")
                {
                    Caption = 'Coefficient Of Brand Type %';
                }
                field("Origine Fournisseur"; Rec."Origine Fournisseur")
                {
                    Caption = 'Coefficient Of Supplier %';
                }
                field("Coefficient Of Quality Rating"; Rec."Coefficient Of Quality Rating")
                {
                    Caption = 'Coefficient Of Quality Rating Of Product %';
                }
            }
            group("JSON Interface")
            {
                Caption = 'JSON Interface';
                field("Vendor Template"; Rec."Vendor Template")
                {
                    Caption = 'Vendor Template';
                }
                field("API URL"; Rec."API URL")
                {
                    Caption = 'API URL';
                }
                field("API KEY"; Rec."API KEY")
                {
                    Caption = 'API KEY';
                }
                field("Item Template"; Rec."Item Template")
                {
                    Caption = 'Item Template';
                }
            }
            group(EDI)
            {
                Caption = 'EDI';
                field("Worksheet Template Name"; Rec."Worksheet Template Name")
                {
                    Caption = 'Worksheet Template Name';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    Caption = 'Journal Batch Name';
                }
            }
            group("Vendor Payment Advice")
            {
                Caption = 'Vendor Payment Advice';
                field("Sender Email Payment Advice"; Rec."Sender Email Payment Advice")
                {
                    Caption = 'Sender Email Payment Advice';
                }
                field("Default Email Template"; Rec."Default Email Template")
                {
                    Caption = 'Default Email Template';
                }
            }
            group("Email Recipient")
            {
                Caption = 'Email Recipient';
                field(Mail1; Rec.Mail1)
                {
                    Caption = 'Email Recipient 1';
                }
                field(Mail2; Rec.Mail2)
                {
                    Caption = 'Email Recipient 2';
                }
                field(Mail3; Rec.Mail3)
                {
                    Caption = 'Email Recipient 3';
                }
                field(Mail4; Rec.Mail4)
                {
                    Caption = 'Email Recipient 4';
                }
                field(Mail5; Rec.Mail5)
                {
                    Caption = 'Email Recipient 5';
                }
            }
        }
    }

    actions
    {
    }

    var
        Text19036189: Label 'Ce champs définit l''axe analytique qui sera reporté par le chaînage depuis les cdes achat sur les cde ventes liés.';
}

