page 50103 "DEL Subs. regulation Card"
{


    Caption = 'Substance regulation Card';
    PageType = Card;
    SourceTable = "DEL Regulation";
    SourceTableView = SORTING("No.", Type)
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
                    MultiLine = true;
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

