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
                    Caption = 'No.';
                    Editable = false;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    Editable = false;
                    Visible = false;
                }
                field(Champs; Rec.Champs)
                {
                    Caption = 'Champs';
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Caption = 'Line No.';
                    Editable = false;
                    Visible = false;
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
        TextEdit: Codeunit "Export Mail Prod Nouv Et Suiv";
        RecRef: RecordRef;
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

