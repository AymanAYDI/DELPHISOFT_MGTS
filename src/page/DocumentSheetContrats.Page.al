page 50075 "DEL Document Sheet Contrats"
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
                            "Type liasse" = FILTER(' '));
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Insert Date"; Rec."Insert Date")
                {
                    ApplicationArea = All;
                }
                field("Insert Time"; Rec."Insert Time")
                {
                    ApplicationArea = All;
                }
                field(Path; Rec.Path)
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("Type contrat"; Rec."Type contrat")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
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
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Add();
                end;
            }
            action(MgtsOpen)
            {
                Caption = 'Open';
                Image = View;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Return';
                ApplicationArea = All;

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
        InStr: InStream;
        LastLineNo: Integer;
        OutStr: OutStream;
        ImportFileName: Text;
        ServerFileName: Text;
        TempBlob: Codeunit "Temp Blob";

    begin
        IF NOT Document_CU.OpenFile(ImportFileName, ServerFileName) THEN
            EXIT;

        IF ServerFileName = '' THEN
            EXIT;
        DocumentLine.SETRANGE("Table Name", Rec."Table Name");
        DocumentLine.SETRANGE("No.", Rec."No.");
        IF DocumentLine.FINDLAST() THEN
            LastLineNo := DocumentLine."Line No.";
        Rec.INIT();
        Rec."Line No." := LastLineNo + 10000;

        //TODO oFile.OPEN(ServerFileName);
        // oFile.CREATEINSTREAM(InStr);
        // Rec.Document.CREATEOUTSTREAM(OutStr);
        // COPYSTREAM(OutStr, InStr);
        // oFile.CLOSE;

        TempBlob.CREATEINSTREAM(InStr, TEXTENCODING::UTF8);
        Rec.Document.CREATEOUTSTREAM(OutStr);
        COPYSTREAM(OutStr, InStr);

        Rec."Insert Date" := TODAY;
        Rec."Insert Time" := TIME;
        Rec.Path := Document_CU.GetDirectoryName(ImportFileName);
        Rec."File Name" := Document_CU.GetFileName(ImportFileName);
        Rec.INSERT(TRUE);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure Open()
    var
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;
        Directory: Text;

    begin
        Directory := Document_CU.TempDirectory();

        // oFile.CREATE(Directory + "File Name");
        // oFile.CREATEOUTSTREAM(OutStr);
        // Document.CREATEINSTREAM(InStr); ==> code initiale
        // COPYSTREAM(OutStr, InStr);
        // oFile.CLOSE;

        TempBlob.CREATEINSTREAM(InStr, TEXTENCODING::UTF8);
        Rec.Document.CREATEOUTSTREAM(OutStr);
        COPYSTREAM(OutStr, InStr);
        HYPERLINK(Directory + Rec."File Name");
    end;
}