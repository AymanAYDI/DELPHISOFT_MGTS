tableextension 50048 "DEL CommentLine" extends "Comment Line"
{
    fields
    {
        field(50000; "DEL Type contrat"; Enum "DEL Type contrat")
        {
            Caption = 'Type contrat';
            DataClassification = CustomerContent;
        }
        field(50001; "DEL User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                //TODO UserMgt.LookupUserID("User ID");
            end;
        }
    }
    procedure SetUpNewLine()
    var
        CommentLine: Record "Comment Line";
    begin
        CommentLine.SETRANGE("Table Name", "Table Name");
        CommentLine.SETRANGE("No.", "No.");
        CommentLine.SETRANGE(Date, WORKDATE());
        IF NOT CommentLine.FINDFIRST() THEN
            Date := WORKDATE();

        "DEL User ID" := USERID;

    end;
}
