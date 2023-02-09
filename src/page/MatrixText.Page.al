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
                    ApplicationArea = All;
                    Caption = 'Item Category Code';
                    Editable = false;
                    Visible = false;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Product Group Code';
                    Editable = false;
                    Visible = false;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = All;
                    Caption = 'Description produit';
                    Editable = false;
                    Visible = false;
                }
                field(Mark; Rec.Mark)
                {
                    ApplicationArea = All;
                    Caption = 'Mark';
                    Editable = false;
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                    Editable = false;
                    Visible = false;
                }
                field("Text"; Rec.Text)
                {
                    ApplicationArea = All;
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
                ApplicationArea = All;
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

