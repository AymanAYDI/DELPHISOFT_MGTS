page 50001 "Regulation Text"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00783      THM     27.04.16           Create Object

    Caption = 'Matrix Text';
    PageType = Worksheet;
    SourceTable = Table50001;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Type; Type)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Champs; Champs)
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

    [Scope('Internal')]
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

