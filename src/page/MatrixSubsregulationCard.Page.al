page 50095 "Matrix Subs. regulation Card"
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
    //              THM     03.05.16           add "Description Usage"

    Caption = 'Substance regulation Card';
    Editable = false;
    PageType = Card;
    SourceTable = Table50051;
    SourceTableView = SORTING(Item Category Code, Product Group Code, Mark, Product Description, No., Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Materials));

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
                }
                field("Type of material"; "Type of material")
                {
                }
                field(Usage; Usage)
                {
                }
                field("Description Usage in French"; "Description Usage in French")
                {
                }
                field("Description Usage in English"; "Description Usage in English")
                {
                }
                field("Substance - CAS / EINECS"; "Substance - CAS / EINECS")
                {
                }
                field("Substance - nom"; "Substance - nom")
                {
                }
                field(Source; Source)
                {
                }
                field("Starting date"; "Starting date")
                {
                }
                field("Date Fin"; "Date Fin")
                {
                }
                field("Norm of testing"; "Norm of testing")
                {
                    MultiLine = true;
                }
                field(Statut; Statut)
                {
                }
                field("Texte de remplacement"; "Texte de remplacement")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Pays_Rec: Record "50052";
        Pays_Page: Page "50088";
}

