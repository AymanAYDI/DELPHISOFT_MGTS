table 50039 "Update Request Manager"
{
    Caption = 'Update Request Manager';
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 06.04.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            06.04.09   created object
    // CHG02                            20.04.09   renamed field 50
    // 
    // 
    // Cette table contient toutes les mises à jours des affaires. Si le status est NOK,
    // cela veut dire que pour une raison ou une autre, la mise à jour n'a pas pu s'effectuer !
    // 
    // Mgts10.00.06.01 : 03.02.21 --> field USER_ID  20 >>50


    fields
    {
        field(1; ID; Code[20])
        {
        }
        field(10; Request_For_Deal_ID; Code[20])
        {
            TableRelation = Deal.ID;
        }
        field(15; Requested_By_User; Code[50])
        {
            Description = 'Mgts10.00.06.01';
        }
        field(20; Requested_By_Type; Option)
        {
            OptionCaption = 'Invoice,Purchase Header,Sales Header,Sales Cr. Memo,Purch. Cr. Memo,Payment,Provision,CUSTOM,Deal Item';
            OptionMembers = Invoice,"Purchase Header","Sales Header","Sales Cr. Memo","Purch. Cr. Memo",Payment,Provision,CUSTOM,"Deal Item";
        }
        field(30; "Requested_By_Type No."; Code[20])
        {
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(40; Requested_At; DateTime)
        {
        }
        field(50; Request_Status; Option)
        {
            InitValue = NOK;
            OptionMembers = NOK,OK;
        }
        field(60; "To be ignored"; Boolean)
        {
        }
        field(70; Description; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
        key(Key2; Request_For_Deal_ID, Requested_By_Type, "Requested_By_Type No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        VALIDATE(Requested_By_User, USERID);
    end;

    trigger OnModify()
    begin
        VALIDATE(Requested_By_User, USERID);
    end;
}

