page 50103 "DEL Subs. regulation Card"
{


    Caption = 'Substance regulation Card';
    PageType = Card;
    SourceTable = "DEL Regulation";
    SourceTableView = SORTING("No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Materials));

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
                        IF Rec.Pays = '' THEN
                            Rec."Description pays" := '';
                    end;
                }
                field("Type of material"; Rec."Type of material")
                {
                    Caption = 'Type of material';
                }
                field(Usage; Rec.Usage)
                {
                    Caption = 'Usage';
                }
                field("Description Usage in French"; Rec."Description Usage in French")
                {
                    Caption = 'Description Usage in French';
                }
                field("Description Usage in English"; Rec."Description Usage in English")
                {
                    Caption = 'Description Usage in English';
                }
                field("Substance - CAS / EINECS"; Rec."Substance - CAS / EINECS")
                {
                    Caption = 'Substance ID';
                }
                field("Substance - nom"; Rec."Substance - nom")
                {
                    MultiLine = true;
                    Caption = 'Substance name';
                }
                field(Source; Rec.Source)
                {
                    Caption = 'Origine';
                }
                field("Starting date"; Rec."Starting date")
                {
                    Caption = 'Starting date';
                }
                field("Date Fin"; Rec."Date Fin")
                {
                    Caption = 'End date';
                }
                field("Norm of testing"; Rec."Norm of testing")
                {
                    MultiLine = true;
                    Caption = 'Norm of testing';
                }
                field(Statut; Rec.Statut)
                {
                    Caption = 'Status';
                }
                field("Texte de remplacement"; Rec."Texte de remplacement")
                {
                    Caption = 'Text of substitution';
                }
            }
        }
    }


    var
        Pays_Rec: Record "DEL Pays";
        Pays_Page: Page "DEL Pays";
}

