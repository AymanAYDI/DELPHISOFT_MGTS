page 50094 "Matrix General regulation Card"
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
    // T-00783      THM     04.04.16           Delete fields
    //              THM     26.08.16           modify captionML

    Caption = 'General product regulation Card';
    Editable = false;
    PageType = Card;
    SourceTable = Table50051;
    SourceTableView = SORTING(Item Category Code, Product Group Code, Mark, Product Description, No., Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER(General product));

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Record details';
                field("Item Category Code"; "Item Category Code")
                {
                }
                field("Product Group Code"; "Product Group Code")
                {
                }
                field("Item Category Label"; "Item Category Label")
                {
                }
                field("Product Group Label"; "Product Group Label")
                {
                }
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
                            IF Pays = '' THEN
                                Pays := Pays_Rec.Code
                            ELSE
                                Pays := Pays + ',' + Pays_Rec.Code;
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
                }
                field("Publication date"; "Publication date")
                {
                }
                field("Date limit of the application"; "Date limit of the application")
                {
                }
                field("Starting date"; "Starting date")
                {
                }
                field("Date Fin"; "Date Fin")
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

