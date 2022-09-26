page 50043 "Position Detail"
{
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table50033;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(ID; ID)
                {
                    Visible = false;
                }
                field(Type; Type)
                {
                }
                field("Type No."; "Type No.")
                {
                    Visible = "Type No.Visible";
                }
                field(Fee_ID; Fee_ID)
                {
                    Caption = 'Fee ID';
                    Visible = Fee_IDVisible;
                }
                field("Deal Item"; "Deal Item")
                {
                    Caption = 'Item No';
                }
                field(Quantity; Quantity)
                {
                    Caption = 'Quantité';
                }
                field(Amount; Amount)
                {
                    Caption = 'Amount';
                    DecimalPlaces = 2 : 3;
                }
                field(Currency; Currency)
                {
                    Caption = 'Currency';
                }
                field("Line Amount"; "Line Amount")
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
        IF Type = Type::Fee THEN BEGIN
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

