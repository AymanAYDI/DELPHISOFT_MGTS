page 50111 "Matrix General regulation List"
{


    Caption = 'General product regulation';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "DEL Regulation Matrix Line";
    SourceTableView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("General product"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Visible = false;
                    Caption = 'Item Category Code';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Visible = false;
                    Caption = 'Product Group Code';
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    Visible = false;
                    Caption = 'Item category description';
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    Visible = false;
                    Caption = 'Product group description';
                }
                field(Type; Rec.Type)
                {
                    Visible = false;
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
                field("Publication date"; Rec."Publication date")
                {
                    Caption = 'Publication date';
                }
                field("Date limit of the application"; Rec."Date limit of the application")
                {
                    Caption = 'Date limit of the application';
                }
                field("Starting date"; Rec."Starting date")
                {
                    Caption = 'Starting date';
                }
                field("Date Fin"; Rec."Date Fin")
                {
                    Caption = 'End date';
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
        area(processing)
        {
            action(Card)
            {
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Matrix General Reg. Card";
                RunPageLink = "Item Category Code" = FIELD("Item Category Code"), "Product Group Code" = FIELD("Product Group Code"), "No." = FIELD("No."), Type = FIELD(Type), Mark = FIELD(Mark), "Product Description" = FIELD("Product Description");
            }
        }
    }
}

