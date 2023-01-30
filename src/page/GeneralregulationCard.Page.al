page 50097 "DEL General regulation Card"
{


    Caption = 'General product regulation Card';
    PageType = Card;
    SourceTable = "DEL Regulation";
    SourceTableView = SORTING("No.", Type)
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
                field(Type; Rec.Type)
                {
                    Editable = false;
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field("Description pays"; Rec."Description pays")
                {
                    Caption = 'Country';

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        Pays_Rec.RESET();
                        CLEAR(Pays_Page);
                        Pays_Page.SETTABLEVIEW(Pays_Rec);
                        Pays_Page.LOOKUPMODE := TRUE;
                        IF Pays_Page.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                            Pays_Page.GETRECORD(Pays_Rec);
                            IF Rec.Pays = '' THEN BEGIN
                                Rec.Pays := Pays_Rec.Code;
                                Rec."Description pays" := Pays_Rec.Description;
                            END
                            ELSE BEGIN
                                Rec.Pays := Rec.Pays + ',' + Pays_Rec.Code;
                                Rec."Description pays" := Rec."Description pays" + ',' + Pays_Rec.Description;
                            END;
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
                }
                field("Title in French"; Rec."Title in French")
                {
                    MultiLine = true;
                    Caption = 'Title in French';
                }
                field("Title in English"; Rec."Title in English")
                {
                    MultiLine = true;
                    Caption = 'Title in English';
                }
                field(Description; Rec.Description)
                {
                    MultiLine = true;
                    Caption = 'Description';
                }
                field("Starting date"; Rec."Starting date")
                {
                    Caption = 'Starting date';
                }
                field("Date Fin"; Rec."Date Fin")
                {
                    Caption = 'End date';
                }
                field("Publication date"; Rec."Publication date")
                {
                    Caption = 'Publication date';
                }
                field("Date limit of the application"; Rec."Date limit of the application")
                {
                    Caption = 'Date limit of the application';
                }
                field("Texte rattachement"; Rec."Texte rattachement")
                {
                    Caption = 'Text of connection';
                }
                field(Statut; Rec.Statut)
                {
                    Caption = 'Status';
                }
                field("Texte de remplacement"; Rec."Texte de remplacement")
                {
                    Caption = 'Text of substitution';
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                    Caption = 'ICS';
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

