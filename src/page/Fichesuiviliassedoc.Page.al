page 50071 "Fiche suivi liasse doc"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00678     THM      12.09.14          Create object
    // T-00705     THM      19.06.15          Modify CaptionML

    Caption = 'General contract doc case Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Table23;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Name; Name)
                {
                    Editable = false;
                }
                field(Address; Address)
                {
                    Editable = false;
                }
                field("Address 2"; "Address 2")
                {
                    Editable = false;
                }
                field("Post Code"; "Post Code")
                {
                    Editable = false;
                }
                field(City; City)
                {
                    Editable = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    Editable = false;
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                    Editable = false;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    Editable = false;
                }
                field("Primary Contact No."; "Primary Contact No.")
                {
                    Editable = false;
                }
                field(Contact; Contact)
                {
                    Editable = false;
                }
            }
            group("CG d'achats NGTS")
            {
                Caption = 'General purchasing term';
                field("Statut CG"; "Statut CG")
                {
                }
                field("Date de maj statut CG"; "Date de maj statut CG")
                {
                }
                field("URL document CG"; "URL document CG")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(DocumentLine);
                        DocumentLine.RESET;
                        DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Vendor);
                        DocumentLine.SETRANGE(DocumentLine."No.", "No.");
                        DocumentLine.SETRANGE(DocumentLine."Type liasse", 1);
                        Documentliasse.SETTABLEVIEW(DocumentLine);
                        Documentliasse.RUN;
                    end;
                }
            }
            group("Charte ethique")
            {
                Caption = 'Ethical Charter';
                field("Statut CE"; "Statut CE")
                {
                }
                field("Date de maj statut CE"; "Date de maj statut CE")
                {
                }
                field("URL document CE"; "URL document CE")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(DocumentLine);
                        DocumentLine.RESET;
                        DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Vendor);
                        DocumentLine.SETRANGE(DocumentLine."No.", "No.");
                        DocumentLine.SETRANGE(DocumentLine."Type liasse", 2);
                        Documentliasse.SETTABLEVIEW(DocumentLine);
                        Documentliasse.RUN;
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ven&dor")
            {
                Caption = 'Ven&dor';
                Image = Vendor;
                action(Card)
                {
                    Caption = 'Card';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 26;
                    RunPageLink = No.=FIELD(No.);
                }
                action("Doc&uments")
                {
                    Caption = 'Audit Report';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page 50072;
                                    RunPageLink = No.=FIELD(No.);
                    RunPageView = SORTING(Table Name,No.,Comment Entry No.,Line No.)
                                  WHERE(Table Name=CONST(Vendor),
                                        Notation Type=FILTER(' '));
                }
            }
        }
    }

    var
        DocumentLine: Record "50008";
        Documentliasse: Page "50072";
}

