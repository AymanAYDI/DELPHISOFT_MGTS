page 50043 "DEL Position Detail"
{
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "DEL Position Detail";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(ID; Rec.ID)
                {
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                }
                field("Type No."; Rec."Type No.")
                {
                    Visible = "Type No.Visible";
                }
                field(Fee_ID; Rec.Fee_ID)
                {
                    Caption = 'Fee ID';
                    Visible = Fee_IDVisible;
                }
                field("Deal Item"; Rec."Deal Item")
                {
                    Caption = 'Item No';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantité';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    DecimalPlaces = 2 : 3;
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Caption = 'Amount (EUR)';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        Fee_IDVisible := TRUE;
        "Type No.Visible" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        IF Rec.Type = Rec.Type::Fee THEN BEGIN
            "Type No.Visible" := FALSE;
            Fee_IDVisible := TRUE;
        END ELSE BEGIN
            "Type No.Visible" := TRUE;
            Fee_IDVisible := FALSE;
        END;
    end;

    var
        [InDataSet]
        "Type No.Visible": Boolean;
        [InDataSet]
        Fee_IDVisible: Boolean;
}

