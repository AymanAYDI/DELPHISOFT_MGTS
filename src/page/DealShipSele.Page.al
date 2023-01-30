page 50040 "DEL Deal Ship. Sele."
{
    Caption = 'Shipment list';
    Editable = false;
    PageType = List;
    SourceTable = "DEL Deal Shipment";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field(Deal_ID; Rec.Deal_ID)
                {
                }
                field(ID; Rec.ID)
                {
                }
                field("BR No."; Rec."BR No.")
                {
                }
                field(Fournisseur; Rec.Fournisseur)
                {
                }
                field("Date"; Rec.Date)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(PI; Rec.PI)
                {
                }
                field("A facturer"; Rec."A facturer")
                {
                }
                field("Depart shipment"; Rec."Depart shipment")
                {
                }
                field("Arrival ship"; Rec."Arrival ship")
                {
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


    procedure FNC_InitData()
    var
    begin


    end;
}

