page 50097 "General regulation Card"
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
    SourceTable = Table50057;
    SourceTableView = SORTING(No., Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER(General product));

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Record details';
                field(Type; Type)
                {
                    Editable = false;
                }
                field("No."; "No.")
                {
                }
                field("Description pays"; "Description pays")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin

                        Pays_Rec.RESET;
                        CLEAR(Pays_Page);
                        Pays_Page.SETTABLEVIEW(Pays_Rec);
                        Pays_Page.LOOKUPMODE := TRUE;
                        IF Pays_Page.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            Pays_Page.GETRECORD(Pays_Rec);
                            IF Pays = '' THEN BEGIN
                                Pays := Pays_Rec.Code;
                                "Description pays" := Pays_Rec.Description;
                            END
                            ELSE BEGIN
                                Pays := Pays + ',' + Pays_Rec.Code;
                                "Description pays" := "Description pays" + ',' + Pays_Rec.Description;
                            END;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        IF "Description pays" = '' THEN
                            Pays := '';
                    end;
                }
                field(Nature; Nature)
                {
                }
                field("Title in French"; "Title in French")
                {
                    MultiLine = true;
                }
                field("Title in English"; "Title in English")
                {
                    MultiLine = true;
                }
                field(Description; Description)
                {
                    MultiLine = true;
                }
                field("Starting date"; "Starting date")
                {
                }
                field("Date Fin"; "Date Fin")
                {
                }
                field("Publication date"; "Publication date")
                {
                }
                field("Date limit of the application"; "Date limit of the application")
                {
                }
                field("Texte rattachement"; "Texte rattachement")
                {
                }
                field(Statut; Statut)
                {
                }
                field("Texte de remplacement"; "Texte de remplacement")
                {
                }
                field("Referent Laboratory"; "Referent Laboratory")
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
        Pays_Page: Page "50088";
        Pays_Rec: Record "50052";
}

