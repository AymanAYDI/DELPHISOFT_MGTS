page 50001 "DEL Regulation Text"
{
    Caption = 'Matrix Text';
    PageType = Worksheet;
    SourceTable = "DEL Texte Regulation";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'No.';
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Type';
                }
                field(Champs; Rec.Champs)
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Champs';
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
        RecRef: RecordRef;
        TextEdit: Codeunit "Export Mail Prod Nouv Et Suiv";
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

