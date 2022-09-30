page 50114 "DEL Matrix Text"
{
    Caption = 'Matrix Text';
    PageType = Worksheet;
    SourceTable = "DEL Regulation Matrix Text";

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
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Product Group Code';
                }
                field("Product Description"; Rec."Product Description")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Description produit';
                }
                field(Mark; Rec.Mark)
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Mark';
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Type';
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Line No.';
                }
                field("Text"; Rec.Text)
                {
                    Caption = 'Text';
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

                trigger OnAction()
                begin
                    EditText;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetNextLineNo(Rec, FALSE);
    end;


    procedure EditText()
    var
        RecRef: RecordRef;
        //TODO: codeunit is still not imported yet  TextEdit: Codeunit "50010";
        Text00001: Label 'Edit Document Text';
    begin

        RecRef.GETTABLE(Rec);
        //TODO TextEdit.EditTextLines(RecRef,
        //                        'Text',
        //                        '',
        //                        '',
        //                        'Attached to Line No.',
        //                        'Line No.',
        //                        FALSE,
        //                        '',
        //                        'Edit Text');

    end;
}

