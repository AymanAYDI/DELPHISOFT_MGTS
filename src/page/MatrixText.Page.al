page 50114 "DEL Matrix Text"
{
    Caption = 'Matrix Text';
    PageType = Worksheet;
    SourceTable = "DEL Regulation Matrix Text";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Item Category Code';
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Product Group Code';
                    ApplicationArea = All;
                }
                field("Product Description"; Rec."Product Description")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Description produit';
                    ApplicationArea = All;
                }
                field(Mark; Rec.Mark)
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Mark';
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Type';
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Line No.';
                    ApplicationArea = All;
                }
                field("Text"; Rec.Text)
                {
                    Caption = 'Text';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TextEdit)
            {
                Caption = '&Edit text';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Ctrl+D';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    EditText();
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.GetNextLineNo(Rec, FALSE);
    end;


    procedure EditText()
    var
        TextEdit: Codeunit "Export Mail Prod Nouv Et Suiv";
        RecRef: RecordRef;

    begin

        RecRef.GETTABLE(Rec);
        //TODO: EditTextLines n'existe pas dans le code ancien

        // TextEdit.EditTextLines(RecRef,
        //                       'Text',
        //                       '',
        //                       '',
        //                       'Attached to Line No.',
        //                       'Line No.',
        //                       FALSE,
        //                       '',
        //                       'Edit Text');




    end;
}

