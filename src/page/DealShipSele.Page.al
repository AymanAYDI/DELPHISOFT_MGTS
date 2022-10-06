page 50040 "DEL Deal Ship. Sele."
{
    Caption = 'Shipment list';
    Editable = false;
    PageType = List;
    SourceTable = "DEL Deal Shipment";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field(Deal_ID; Rec.Deal_ID)
                {
                    Caption = 'Deal ID';
                }
                field(ID; Rec.ID)
                {
                    Caption = 'Shipment ID';
                }
                field("BR No."; Rec."BR No.")
                {
                    Caption = 'BR No.';
                }
                field(Fournisseur; Rec.Fournisseur)
                {
                    Caption = 'Fournisseur';
                }
                field("Date"; Rec.Date)
                {
                    Caption = 'Date';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(PI; Rec.PI)
                {
                    Caption = 'PI';
                }
                field("A facturer"; Rec."A facturer")
                {
                    Caption = 'A facturer';
                }
                field("Depart shipment"; Rec."Depart shipment")
                {
                    Caption = 'Depart shipment';
                }
                field("Arrival ship"; Rec."Arrival ship")
                {
                    Caption = 'Arrival ship';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        FNC_InitData();
    end;

    var
        Deal_Cu: Codeunit "DEL Deal";


    procedure FNC_InitData()
    var
    begin


    end;
}

