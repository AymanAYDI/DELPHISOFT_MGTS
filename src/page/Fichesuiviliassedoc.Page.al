page 50071 "DEL Fiche suivi liasse doc"
{

    Caption = 'General contract doc case Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    Editable = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    Editable = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    Editable = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Editable = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Editable = false;
                }
                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    Editable = false;
                }
                field(Contact; Rec.Contact)
                {
                    Editable = false;
                }
            }
            group("CG d'achats NGTS")
            {
                Caption = 'General purchasing term';
                field("Statut CG"; Rec."DEL Statut CG")
                {
                }
                field("Date de maj statut CG"; Rec."DEL Date de maj statut CG")
                {
                }
                field("URL document CG"; Rec."DEL URL document CG")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(DocumentLine);
                        DocumentLine.RESET();
                        DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Vendor);
                        DocumentLine.SETRANGE(DocumentLine."No.", Rec."No.");
                        DocumentLine.SETRANGE(DocumentLine."Type liasse", 1);
                        Documentliasse.SETTABLEVIEW(DocumentLine);
                        Documentliasse.RUN();
                    end;
                }
            }
            group("Charte ethique")
            {
                Caption = 'Ethical Charter';
                field("Statut CE"; Rec."DEL Statut CE")
                {
                }
                field("Date de maj statut CE"; Rec."DEL Date de maj statut CE")
                {
                }
                field("URL document CE"; Rec."DEL URL document CE")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CLEAR(DocumentLine);
                        DocumentLine.RESET();
                        DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Vendor);
                        DocumentLine.SETRANGE(DocumentLine."No.", Rec."No.");
                        DocumentLine.SETRANGE(DocumentLine."Type liasse", 2);
                        Documentliasse.SETTABLEVIEW(DocumentLine);
                        Documentliasse.RUN();
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
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Doc&uments")
                {
                    Caption = 'Audit Report';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "DEL Document Sheet liasse";
                    RunPageLink = "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Comment Entry No.", "Line No.")
                                  WHERE("Table Name" = CONST(Vendor),
                                        "Notation Type" = FILTER(' '));
                }
            }
        }
    }

    var
        DocumentLine: Record "DEL Document Line";
        Documentliasse: Page "DEL Document Sheet liasse";
}

