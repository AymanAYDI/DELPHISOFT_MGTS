page 50000 "General Setup"
{
    // EDI       22.05.13/LOCO/ChC- Page Created
    // +-------------------------------------------------------------------------------------------------+
    // | Logico SA                                                                                       |
    // | Status: 10.12.13                                                                                |
    // | Customer: NGTS                                                                                  |
    // +-------------------------------------------------------------------------------------------------+
    // 
    // Requirement     UserID   Date       Where                                   Description
    // -----------------------------------------------------------------------------------------------------
    // THS             THS     10.12.13    Layout-Reporting                        Add field "Hyperion File"
    // THS             THS     12.12.13    Layout-Reporting                        Add field "Hyperion Company Code"
    // THM             THM     02,10,14                                            add "Sales File","Purchase File"
    // T-00737         SAZ     01.10.15                                            Add field  ""Dernier num séq maj Dev Init""
    // 
    // Mgts10.00.01.00 | 11.01.2020 | JSON WS Mgt
    //                          Add Fields : "Vendor Template"
    //                                       "API URL"
    //                                       "API KEY"
    // 
    // Mgts10.00.03.00 | 07.04.2020 | JSON WS Mgt
    //                          Add Fields : "Item Template"
    // 
    // MGTSEDI10.00.00.23 | 21.05.2021 | EDI Management : Add fields
    //                                                     Worksheet Template Name,
    //                                                     Journal Batch Name,
    // MGTS10.00.06.00    | 07.01.2022 | Send Payment Advice : List of changes:
    //                                              Added new field: 50013 "Sender Email Payment Advice"
    //                                              Added new field: 50014 "Default Email Template"

    Caption = 'General Setup';
    PageType = Card;
    SourceTable = Table50000;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Dernier num séq maj Dev Init"; "Dernier num séq maj Dev Init")
                {
                }
            }
            group(Axes)
            {
                Caption = 'Axes';
                field("Code Axe Achat"; "Code Axe Achat")
                {
                }
                label()
                {
                    CaptionClass = Text19036189;
                    MultiLine = true;
                }
            }
            group(Transitaire)
            {
                Caption = 'Transitaire';
                field("Nom emetteur"; "Nom emetteur")
                {
                }
                field("Nom achat commande transitaire"; "Nom achat commande transitaire")
                {
                }
                field("IC Forwarding Agent Code"; "IC Forwarding Agent Code")
                {
                }
            }
            group(Deal)
            {
                Caption = 'Deal';
                field("Element Nos."; "Element Nos.")
                {
                }
                field("Position Nos."; "Position Nos.")
                {
                }
                field("Fee Nos."; "Fee Nos.")
                {
                }
                field("Fee Connection Nos."; "Fee Connection Nos.")
                {
                }
                field("Provision Nos."; "Provision Nos.")
                {
                }
            }
            group("Special Order")
            {
                Caption = 'Special Order';
                field("Default Purchasing Code"; "Default Purchasing Code")
                {
                }
            }
            group(Tracking)
            {
                Caption = 'Tracking';
                field("Folder Expeditors"; "Folder Expeditors")
                {
                }
                field("Folder Expeditors Archive"; "Folder Expeditors Archive")
                {
                }
                field("Folder Maersk"; "Folder Maersk")
                {
                }
                field("Folder Maersk Archive"; "Folder Maersk Archive")
                {
                }
            }
            group(Reporting)
            {
                Caption = 'Reporting';
                field("Reporting File"; "Reporting File")
                {
                }
                field("Hyperion Company Code"; "Hyperion Company Code")
                {
                }
                field("Hyperion File"; "Hyperion File")
                {
                }
                field("Sales File"; "Sales File")
                {
                }
                field("Purchase File"; "Purchase File")
                {
                }
            }
            group("Coefficient Of Item Quality")
            {
                Caption = 'Coefficient Of Item Quality';
                field("Risque Securitaire"; "Risque Securitaire")
                {
                }
                field("Risque Reglementaire"; "Risque Reglementaire")
                {
                }
                field("Marque Produit"; "Marque Produit")
                {
                }
                field("Origine Fournisseur"; "Origine Fournisseur")
                {
                }
                field("Coefficient Of Quality Rating"; "Coefficient Of Quality Rating")
                {
                }
            }
            group("JSON Interface")
            {
                Caption = 'JSON Interface';
                field("Vendor Template"; "Vendor Template")
                {
                }
                field("API URL"; "API URL")
                {
                }
                field("API KEY"; "API KEY")
                {
                }
                field("Item Template"; "Item Template")
                {
                }
            }
            group(EDI)
            {
                Caption = 'EDI';
                field("Worksheet Template Name"; "Worksheet Template Name")
                {
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                }
            }
            group("Vendor Payment Advice")
            {
                Caption = 'Vendor Payment Advice';
                field("Sender Email Payment Advice"; "Sender Email Payment Advice")
                {
                }
                field("Default Email Template"; "Default Email Template")
                {
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

