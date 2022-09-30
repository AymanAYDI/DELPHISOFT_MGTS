page 50107 "DEL Plan of Control Card"
{


    Caption = 'Plan of Control Card';
    PageType = Card;
    SourceTable = "DEL Regulation";
    SourceTableView = SORTING("No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("Plan of control"));

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Record details';
                field(Type; Rec.Type)
                {
                    Editable = false;
                    Caption = 'Type';
                }
                field("Test Type"; Rec."Test Type")
                {
                    Caption = 'Test Type';
                }
                field("Description Plan of control"; Rec."Description Plan of control")
                {
                    Caption = 'Description';
                }
                field(Descriptive; Rec.Descriptive)
                {
                    MultiLine = true;
                    Caption = 'Descriptive';
                }
                field("Support Text"; Rec."Support Text")
                {
                    Caption = 'Support Text';
                }
                field("Control Type"; Rec."Control Type")
                {
                    Caption = 'Type de contrôle';
                }
                field(Frequency; Rec.Frequency)
                {
                    Caption = 'Frequency';
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                    Caption = 'Referent Laboratory';
                }
                field("Livrables 1"; Rec."Livrables 1")
                {
                    MultiLine = true;
                    Caption = 'Deliverables 1';
                }
            }
        }
    }


    var
        TestType: Record "DEL Test Type";
        TestType_Page: Page "DEL Test Type";
}

