page 50096 "DEL General regulation"
{


    Caption = 'General product regulation';
    CardPageID = "DEL General regulation Card";
    Editable = false;
    PageType = List;
    SourceTable = "DEL Regulation";
    SourceTableView = SORTING("No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("General product"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field("Description pays"; Rec."Description pays")
                {
                    Caption = 'Country';
                }
                field(Nature; Rec.Nature)
                {
                    Caption = 'Type of regulation';
                }
                field("Title in French"; Rec."Title in French")
                {
                    Caption = 'Title in French';
                }
                field("Title in English"; Rec."Title in English")
                {
                    Caption = 'Title in English';
                }
                field(Description; Rec.Description)
                {
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
}

