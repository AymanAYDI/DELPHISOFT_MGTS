page 50072 "DEL Document Sheet liasse"
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
                      WHERE("Notation Type" = FILTER(' '),
                            "Type contrat" = FILTER(' '));

    layout
    {
        area(content)
        {
            repeater(Controle1)
            {
                field("Insert Date"; "Insert Date")
                {
                }
                field("Insert Time"; "Insert Time")
                {
                }
                field(Path; Path)
                {
                }
                field("File Name"; "File Name")
                {
                }
                field("Type liasse"; "Type liasse")
                {
                }
                field("User ID"; "User ID")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("MGTS Add")
            {
                Caption = 'Add';
                Ellipsis = true;
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Add();
                end;
            }
            action("MGTS Open")
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
        SetUpNewLine(BelowxRec);
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
        //TODO
        // IF NOT Document_CU.OpenFile(ImportFileName, ServerFileName) THEN
        //   EXIT;

        // IF ServerFileName = '' THEN
        //   EXIT;

        // DocumentLine.SETRANGE("Table Name", "Table Name");
        // DocumentLine.SETRANGE("No.", "No.");
        // IF DocumentLine.FINDLAST THEN
        //   LastLineNo := DocumentLine."Line No.";

        // INIT;
        // "Line No." := LastLineNo + 10000;

        // oFile.OPEN(ServerFileName);
        // oFile.CREATEINSTREAM(InStr);
        // Document.CREATEOUTSTREAM(OutStr);
        // COPYSTREAM(OutStr, InStr);
        // oFile.CLOSE;

        // "Insert Date" := TODAY;
        // "Insert Time" := TIME;

        // Path := Document_CU.GetDirectoryName(ImportFileName);
        // "File Name" := Document_CU.GetFileName(ImportFileName);

        // INSERT(TRUE);
        // CurrPage.UPDATE(FALSE);
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
        //CALCFIELDS(Document);
        //IF NOT Document.HASVALUE THEN
        // ERROR(cNoDocument);

        //TODO
        //   Directory := Document_CU.TempDirectory;

        //   oFile.CREATE(Directory + "File Name");
        //   oFile.CREATEOUTSTREAM(OutStr);

        //   Document.CREATEINSTREAM(InStr);
        //   COPYSTREAM(OutStr, InStr);

        //   oFile.CLOSE;

        //   HYPERLINK(Directory + "File Name");
    end;
}

