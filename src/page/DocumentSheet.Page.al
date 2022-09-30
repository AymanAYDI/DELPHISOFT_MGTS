page 50065 "DEL Document Sheet"
{


    Caption = 'Document Sheet';
    DataCaptionFields = "No.";
    DelayedInsert = true;
    InsertAllowed = false;
    PageType = Worksheet;
    PopulateAllFields = true;
    SourceTable = "DEL Document Line";
    SourceTableView = SORTING("Table Name", "No.", "Comment Entry No.", "Line No.")
                      ORDER(Ascending)
                      WHERE("Type liasse" = FILTER(' '));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Insert Date"; Rec."Insert Date")
                {
                    Caption = 'Date';
                }
                field("Insert Time"; Rec."Insert Time")
                {
                    Caption = 'Time';
                }
                field(Path; Rec.Path)
                {
                    Caption = 'Path';
                }
                field("File Name"; Rec."File Name")
                {
                    Caption = 'File Name';
                }
                field("Notation Type"; Rec."Notation Type")
                {
                    Caption = 'Rating type';
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'User ID';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(MgtsAdd)
            {
                Caption = 'Add';
                Ellipsis = true;
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Add;
                end;
            }
            action(MgtsOpen)
            {
                Caption = 'Open';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Return';

                trigger OnAction()
                begin
                    Open();
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine(BelowxRec);
    end;

    var
        Document_CU: Codeunit "50007";

    local procedure Add()
    var
        DocumentLine: Record "DEL Document Line";
        oFile: File;
        InStr: InStream;
        OutStr: OutStream;
        ImportFileName: Text;
        ServerFileName: Text;
        LastLineNo: Integer;
    begin
        IF NOT Document_CU.OpenFile(ImportFileName, ServerFileName) THEN
            EXIT;

        IF ServerFileName = '' THEN
            EXIT;

        DocumentLine.SETRANGE(Rec."Table Name", Rec."Table Name");
        DocumentLine.SETRANGE(Rec."No.", Rec."No.");
        IF DocumentLine.FINDLAST THEN
            LastLineNo := DocumentLine."Line No.";

        Rec.INIT();
        Rec."Line No." := LastLineNo + 10000;

        oFile.OPEN(ServerFileName);
        oFile.CREATEINSTREAM(InStr);
        Rec.Document.CREATEOUTSTREAM(OutStr);
        COPYSTREAM(OutStr, InStr);
        oFile.CLOSE;

        Rec."Insert Date" := TODAY;
        Rec."Insert Time" := TIME;

        Rec.Path := Document_CU.GetDirectoryName(ImportFileName);
        Rec."File Name" := Document_CU.GetFileName(ImportFileName);

        Rec.INSERT(TRUE);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure SaveAs()
    var
        oFile: File;
        InStr: InStream;
        OutStr: OutStream;
        ClientFileName: Text;
        ServerFileName: Text;
        cNoDocument: Label 'No document found.';
    begin
    end;

    local procedure Open()
    var
        oFile: File;
        InStr: InStream;
        OutStr: OutStream;
        Directory: Text;
        ExportFileName: Text;
        cNoDocument: Label 'No document found.';
    begin



        Directory := Document_CU.TempDirectory;

        oFile.CREATE(Directory + Rec."File Name");
        oFile.CREATEOUTSTREAM(OutStr);

        Rec.Document.CREATEINSTREAM(InStr);
        COPYSTREAM(OutStr, InStr);

        oFile.CLOSE;

        HYPERLINK(Directory + Rec."File Name");
    end;
}

