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
                                Rec.Pays := format(Rec.Pays + ',' + Pays_Rec.Code);
                        END;
                    end;
                }
                field("Type of material"; Rec."Type of material")
                {
                    Caption = 'Type of material';
                    ApplicationArea = All;
                }
                field(Usage; Rec.Usage)
                {
                    Caption = 'Usage';
                    ApplicationArea = All;
                }
                field("Description Usage in French"; Rec."Description Usage in French")
                {
                    Caption = 'Description Usage in French';
                    ApplicationArea = All;
                }
                field("Description Usage in English"; Rec."Description Usage in English")
                {
                    Caption = 'Description Usage in English';
                    ApplicationArea = All;
                }
                field("Substance - CAS / EINECS"; Rec."Substance - CAS / EINECS")
                {
                    Caption = 'Substance ID';
                    ApplicationArea = All;
                }
                field("Substance - nom"; Rec."Substance - nom")
                {
                    Caption = 'Substance name';
                    ApplicationArea = All;
                }
                field(Source; Rec.Source)
                {
                    Caption = 'Origine';
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
                field("Norm of testing"; Rec."Norm of testing")
                {
                    MultiLine = true;
                    Caption = 'Norm of testing';
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
            }
        }
    }

    var
        Pays_Rec: Record "DEL Pays";
        Pays_Page: Page "DEL Pays";
}
