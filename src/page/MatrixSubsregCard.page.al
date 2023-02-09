page 50095 "DEL Matrix Subs. reg Card"
{
    Caption = 'Substance regulation Card';
    Editable = false;
    PageType = Card;
    SourceTable = "DEL Regulation Matrix Line";
    SourceTableView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Materials));
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
                    ApplicationArea = All;
                    Caption = 'Item Category Code';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Product Group Code';
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    ApplicationArea = All;
                    Caption = 'Item category description';
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    ApplicationArea = All;
                    Caption = 'Product group description';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field("Description pays"; Rec."Description pays")
                {
                    ApplicationArea = All;
                    Caption = 'Country';

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
                                Rec.Pays := format(Rec.Pays + ',' + Pays_Rec.Code);
                        END;
                    end;
                }
                field("Type of material"; Rec."Type of material")
                {
                    ApplicationArea = All;
                    Caption = 'Type of material';
                }
                field(Usage; Rec.Usage)
                {
                    ApplicationArea = All;
                    Caption = 'Usage';
                }
                field("Description Usage in French"; Rec."Description Usage in French")
                {
                    ApplicationArea = All;
                    Caption = 'Description Usage in French';
                }
                field("Description Usage in English"; Rec."Description Usage in English")
                {
                    ApplicationArea = All;
                    Caption = 'Description Usage in English';
                }
                field("Substance - CAS / EINECS"; Rec."Substance - CAS / EINECS")
                {
                    ApplicationArea = All;
                    Caption = 'Substance ID';
                }
                field("Substance - nom"; Rec."Substance - nom")
                {
                    ApplicationArea = All;
                    Caption = 'Substance name';
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = All;
                    Caption = 'Origine';
                }
                field("Starting date"; Rec."Starting date")
                {
                    ApplicationArea = All;
                    Caption = 'Starting date';
                }
                field("Date Fin"; Rec."Date Fin")
                {
                    ApplicationArea = All;
                    Caption = 'End date';
                }
                field("Norm of testing"; Rec."Norm of testing")
                {
                    ApplicationArea = All;
                    Caption = 'Norm of testing';
                    MultiLine = true;
                }
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field("Texte de remplacement"; Rec."Texte de remplacement")
                {
                    ApplicationArea = All;
                    Caption = 'Text of substitution';
                }
            }
        }
    }

    var
        Pays_Rec: Record "DEL Pays";
        Pays_Page: Page "DEL Pays";
}
