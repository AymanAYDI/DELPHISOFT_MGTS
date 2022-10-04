page 50097 "DEL General regulation Card"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00716      THM     27.08.15           Create Object
    // T-00757      THM     07.01.16           add and modify Field
    // T-00758      THM     12.01.16           add new field
    // T-00783      THM     04.04.16           delete Field
    //              THM     26.08.16           modify captionML

    Caption = 'General product regulation Card';
    PageType = Card;
    SourceTable = "DEL Regulation";
    SourceTableView = SORTING("No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("General product"));

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
                }
                field("No."; Rec."No.")
                {
                }
                field("Description pays"; Rec."Description pays")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        Pays_Rec.RESET();
                        CLEAR(Pays_Page);
                        Pays_Page.SETTABLEVIEW(Pays_Rec);
                        Pays_Page.LOOKUPMODE := TRUE;
                        IF Pays_Page.RUNMODAL = ACTION::LookupOK THEN BEGIN
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
                }
                field("Title in French"; Rec."Title in French")
                {
                    MultiLine = true;
                }
                field("Title in English"; Rec."Title in English")
                {
                    MultiLine = true;
                }
                field(Description; Rec.Description)
                {
                    MultiLine = true;
                }
                field("Starting date"; Rec."Starting date")
                {
                }
                field("Date Fin"; Rec."Date Fin")
                {
                }
                field("Publication date"; Rec."Publication date")
                {
                }
                field("Date limit of the application"; Rec."Date limit of the application")
                {
                }
                field("Texte rattachement"; Rec."Texte rattachement")
                {
                }
                field(Statut; Rec.Statut)
                {
                }
                field("Texte de remplacement"; Rec."Texte de remplacement")
                {
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
        Pays_Page: Page Pays;
        Pays_Rec: Record "DEL Pays";
}

