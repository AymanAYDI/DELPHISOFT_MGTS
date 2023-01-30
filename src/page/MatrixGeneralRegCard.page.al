page 50094 "DEL Matrix General Reg. Card"
{
    Caption = 'General product regulation Card';
    Editable = false;
    PageType = Card;
    SourceTable = "DEL Regulation Matrix Line";
    SourceTableView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("General product"));
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Record details';
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Caption = 'Product Group Code';
                    ApplicationArea = All;
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    Caption = 'Item category description';
                    ApplicationArea = All;
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    Caption = 'Product group description';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    Caption = 'Type';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                field("Description pays"; Rec."Description pays")
                {
                    Caption = 'Country';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Pays_Rec.RESET();
                        CLEAR(Pays_Page);
                        Pays_Page.SETTABLEVIEW(Pays_Rec);
                        Pays_Page.LOOKUPMODE := TRUE;
                        IF Pays_Page.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                            Pays_Page.GETRECORD(Pays_Rec);
                            IF Rec.Pays = '' THEN
                                Rec.Pays := Pays_Rec.Code
                            ELSE
                                Rec.Pays := Rec.Pays + ',' + Pays_Rec.Code;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        IF Rec."Description pays" = '' THEN
                            Rec.Pays := '';
                    end;
                }
                field(Nature; Rec.Nature)
                {
                    Caption = 'Type of regulation';
                    ApplicationArea = All;
                }
                field("Title in French"; Rec."Title in French")
                {
                    MultiLine = true;
                    Caption = 'Title in French';
                    ApplicationArea = All;
                }
                field("Title in English"; Rec."Title in English")
                {
                    MultiLine = true;
                    Caption = 'Title in English';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field("Publication date"; Rec."Publication date")
                {
                    Caption = 'Publication date';
                    ApplicationArea = All;
                }
                field("Date limit of the application"; Rec."Date limit of the application")
                {
                    Caption = 'Date limit of the application';
                    ApplicationArea = All;
                }
                field("Starting date"; Rec."Starting date")
                {
                    Caption = 'Starting date';
                    ApplicationArea = All;
                }
                field("Date Fin"; Rec."Date Fin")
                {
                    Caption = 'End date';
                    ApplicationArea = All;
                }
                field("Texte rattachement"; Rec."Texte rattachement")
                {
                    Caption = 'Text of connection';
                    ApplicationArea = All;
                }
                field(Statut; Rec.Statut)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                }
                field("Texte de remplacement"; Rec."Texte de remplacement")
                {
                    Caption = 'Text of substitution';
                    ApplicationArea = All;
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                    Caption = 'ICS';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        Pays_Rec: Record "DEL Pays";
        Pays_Page: Page "DEL Pays";
}
