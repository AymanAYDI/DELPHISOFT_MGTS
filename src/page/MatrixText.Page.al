page 50114 "Matrix Text"
{
    Caption = 'Matrix Text';
    PageType = Worksheet;
    SourceTable = Table50053;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; "Item Category Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Product Group Code"; "Product Group Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Product Description"; "Product Description")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Mark; Mark)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Type; Type)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; "Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Text; Text)
                {
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
        TextEdit: Codeunit "50010";
        Text00001: Label 'Edit Document Text';
    begin
        /*
        IF NOT(GET("Attached to Line No.",Type,"Line No.")) THEN BEGIN
          INIT;
          INSERT;
          COMMIT;
        END;
        
        */
        RecRef.GETTABLE(Rec);
        TextEdit.EditTextLines(RecRef,
                               'Text',
                               '',
                               '',
                               'Attached to Line No.',
                               'Line No.',
                               FALSE,
                               '',
                               'Edit Text');

    end;
}

