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
                    Caption = 'Checked';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
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

    actions
    {
        area(processing)
        {
            action(Card)
            {
                Caption = 'Card';
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Subs. regulation Card";
                RunPageLink = "No." = FIELD("No."),
                              Type = FIELD(Type);
                RunPageMode = View;
                ApplicationArea = All;
            }
        }
    }
}
