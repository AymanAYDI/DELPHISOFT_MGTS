tableextension 50048 "DEL CommentLine" extends "Comment Line" //97
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
            //TODO: //  à vérifier // dans le standard 20 this method is not supported
            // trigger OnLookup()
            // var
            //     UserMgt: Codeunit "User Management";
            // begin
            //     UserMgt.LookupUserID("DEL User ID");
            // end;

            trigger onvalidate()
            var
                UserSelection: Codeunit "User Selection";
            begin
                UserSelection.ValidateUserName("DEL User ID");
            end;
        }
    }
    keys
    {
        key(Key2; "Date")
        {

        }
    }

}
