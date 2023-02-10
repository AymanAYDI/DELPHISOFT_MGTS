page 50105 "DEL Substance regulation 2"
{
    Caption = 'Substance regulation';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "DEL Regulation";
    SourceTableView = SORTING("No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Materials));
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Checked; Rec.Checked)
                {
                    ApplicationArea = All;
                    Caption = 'Checked';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
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

    actions
    {
        area(processing)
        {
            action(Card)
            {
                ApplicationArea = All;
                Caption = 'Card';
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Subs. regulation Card";
                RunPageLink = "No." = FIELD("No."),
                              Type = FIELD(Type);
                RunPageMode = View;
            }
        }
    }
}
