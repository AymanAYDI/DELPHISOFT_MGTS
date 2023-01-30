page 50107 "DEL Plan of Control Card"
{
    Caption = 'Plan of Control Card';
    PageType = Card;
    SourceTable = "DEL Regulation";
    SourceTableView = SORTING("No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("Plan of control"));
    UsageCategory = None;
    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Record details';
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    Editable = false;
                }
                field("Test Type"; Rec."Test Type")
                {
                    ApplicationArea = All;
                    Caption = 'Test Type';
                }
                field("Description Plan of control"; Rec."Description Plan of control")
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field(Descriptive; Rec.Descriptive)
                {
                    ApplicationArea = All;
                    Caption = 'Descriptive';
                    MultiLine = true;
                }
                field("Support Text"; Rec."Support Text")
                {
                    ApplicationArea = All;
                    Caption = 'Support Text';
                }
                field("Control Type"; Rec."Control Type")
                {
                    ApplicationArea = All;
                    Caption = 'Type de contrôle';
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                    Caption = 'Frequency';
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                    ApplicationArea = All;
                    Caption = 'Referent Laboratory';
                }
                field("Livrables 1"; Rec."Livrables 1")
                {
                    ApplicationArea = All;
                    Caption = 'Deliverables 1';
                    MultiLine = true;
                }
            }
        }
    }
}
