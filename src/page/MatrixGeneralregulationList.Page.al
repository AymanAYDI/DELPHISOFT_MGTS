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
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Caption = 'Item Category Code';
                    Visible = false;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Product Group Code';
                    Visible = false;
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    ApplicationArea = All;
                    Caption = 'Item category description';
                    Visible = false;
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    ApplicationArea = All;
                    Caption = 'Product group description';
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    Visible = false;
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
                field(Nature; Rec.Nature)
                {
                    ApplicationArea = All;
                    Caption = 'Type of regulation';
                }
                field("Title in French"; Rec."Title in French")
                {
                    ApplicationArea = All;
                    Caption = 'Title in French';
                }
                field("Title in English"; Rec."Title in English")
                {
                    ApplicationArea = All;
                    Caption = 'Title in English';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field("Publication date"; Rec."Publication date")
                {
                    ApplicationArea = All;
                    Caption = 'Publication date';
                }
                field("Date limit of the application"; Rec."Date limit of the application")
                {
                    ApplicationArea = All;
                    Caption = 'Date limit of the application';
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
                field("Texte rattachement"; Rec."Texte rattachement")
                {
                    ApplicationArea = All;
                    Caption = 'Text of connection';
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
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                    ApplicationArea = All;
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
                ApplicationArea = All;
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
