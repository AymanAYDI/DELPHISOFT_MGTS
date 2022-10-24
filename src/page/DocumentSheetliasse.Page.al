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
                field("Type liasse"; Rec."Type liasse")
                {
                    Caption = 'Type of document';
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'User ID';
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
        Rec.SetUpNewLine(BelowxRec);
    end;

    var
        Document_CU: Codeunit "DEL Document Sheet";

    local procedure Add()
    var
        DocumentLine: Record "DEL Document Line";
        TempBlob: Codeunit "Temp Blob";

        InStr: InStream;
        LastLineNo: Integer;
        OutStr: OutStream;
        ImportFileName: Text;
        ServerFileName: Text;
    begin
        //TODO: Document_CU a été commenté car il contient le Dotnet
        // IF NOT Document_CU.OpenFile(ImportFileName, ServerFileName) THEN
        //     EXIT;

        IF ServerFileName = '' THEN
            EXIT;
        DocumentLine.SETRANGE("Table Name", Rec."Table Name");
        DocumentLine.SETRANGE("No.", Rec."No.");
        IF DocumentLine.FINDLAST() THEN
            LastLineNo := DocumentLine."Line No.";

        Rec.INIT();
        Rec."Line No." := LastLineNo + 10000;
        //TODO: OPEN, CLOSE AND CREATEINSTREAM ARE NOT USED FOR CLOUD DEV 
        // oFile.OPEN(ServerFileName);
        // oFile.CREATEINSTREAM(InStr);
        // Document.CREATEOUTSTREAM(OutStr);
        // COPYSTREAM(OutStr, InStr); => code initial
        // oFile.CLOSE;

        TempBlob.CREATEINSTREAM(InStr, TEXTENCODING::UTF8);
        Rec.Document.CREATEOUTSTREAM(OutStr);
        COPYSTREAM(OutStr, InStr);


        Rec."Insert Date" := TODAY;
        Rec."Insert Time" := TIME;

        //TODO: Document_CU a été commenté car il contient le Dotnet
        // Rec.Path := Document_CU.GetDirectoryName(ImportFileName);
        // Rec."File Name" := Document_CU.GetFileName(ImportFileName);

        Rec.INSERT(TRUE);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure SaveAs()
    begin
    end;

    local procedure Open()
    var
        TempBlob: Codeunit "Temp Blob";

        InStr: InStream;
        cNoDocument: Label 'No document found.';
        OutStr: OutStream;
        Directory: Text;
    begin
        Rec.CALCFIELDS(Document);
        IF NOT Document.HASVALUE THEN
            ERROR(cNoDocument);

        //TODO: Document_CU a été commenté car il contient le Dotnet
        // Directory := Document_CU.TempDirectory();

        //TODO: CREATE, AND CREATEOUTSTREAM ARE NOT USED FOR CLOUD DEV 
        //   oFile.CREATE(Directory + "File Name");
        //   oFile.CREATEOUTSTREAM(OutStr);
        // Document.CREATEINSTREAM(InStr);
        // COPYSTREAM(OutStr, InStr);
        //   oFile.CLOSE;

        TempBlob.CREATEINSTREAM(InStr, TEXTENCODING::UTF8);
        Rec.Document.CREATEOUTSTREAM(OutStr);
        COPYSTREAM(OutStr, InStr);

        HYPERLINK(Directory + Rec."File Name");
    end;
}

