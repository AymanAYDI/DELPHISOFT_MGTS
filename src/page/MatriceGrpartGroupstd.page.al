page 50118 "DEL Matrice Grp art./Group std"
{
    ApplicationArea = all;
    Caption = 'Product Group / Standard Item Group Matrix';
    PageType = List;
    SourceTable = "DEL Matrise Group Art./Grp Std";
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Product Group Code';
                }
                field("Product Group Description"; Rec."Product Group Description")
                {
                    ApplicationArea = All;
                    Caption = 'Product Group Description';
                }
                field("Standard Item Group Code"; Rec."Standard Item Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Standard Item Group Code';
                }
                field("Std Item Group Description"; Rec."Std Item Group Description")
                {
                    ApplicationArea = All;
                    Caption = 'Standard Item Group Description';
                }
            }
        }
    }
}
