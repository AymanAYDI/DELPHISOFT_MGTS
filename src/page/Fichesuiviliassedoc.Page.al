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
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("CG d'achats NGTS")
            {
                Caption = 'General purchasing term';
                field("Statut CG"; Rec."DEL Statut CG")
                {
                    ApplicationArea = All;
                }
                field("Date de maj statut CG"; Rec."DEL Date de maj statut CG")
                {
                    ApplicationArea = All;
                }
                field("URL document CG"; Rec."DEL URL document CG")
                {
                    ApplicationArea = All;

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
                    ApplicationArea = All;
                }
                field("Date de maj statut CE"; Rec."DEL Date de maj statut CE")
                {
                    ApplicationArea = All;
                }
                field("URL document CE"; Rec."DEL URL document CE")
                {
                    ApplicationArea = All;

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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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

