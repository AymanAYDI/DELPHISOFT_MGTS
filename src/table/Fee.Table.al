table 50024 "DEL Fee"
{


    //TODOLookupPageID = 50024;
    Caption = 'Fee';

    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';

            trigger OnValidate()
            begin

                IF IsInUse_FNC(xRec.ID, ErrorMsg_Te) THEN
                    ERROR(ErrorMsg_Te);

            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Amount Type"; Enum "DEL Amount Type")
        {
            Caption = 'Amount Type';

        }
        field(4; "Ventilation Element"; Enum "DEL Ventilation Element")
        {

            Caption = 'Ventilation Element';
        }
        field(5; "Ventilation Position"; Enum "DEL Ventilation Position")
        {

            Caption = 'Ventilation Position';
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; Currency; Code[10])
        {
            TableRelation = Currency.Code;
            Caption = 'Currency';
        }
        field(8; "Field"; Enum "DEL Field")
        {
            Caption = 'Field';
        }
        field(9; Factor; Decimal)
        {
            Caption = 'Factor';
        }
        field(10; Destination; Code[10])
        {
            TableRelation = Location.Code;
            Caption = 'Destination';
        }
        field(11; Axe; Code[10])
        {
            Caption = 'Axe';
        }
        field(12; "No compte"; Text[20])
        {
            Caption = 'Account No';
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin

                IF IsAccountNoExisting_FNC("No compte", "Used For Import", ErrorMsg_Te) THEN
                    ERROR(ErrorMsg_Te);

            end;
        }
        field(13; "Used For Import"; Boolean)
        {

            trigger OnValidate()
            begin

                IF IsAccountNoExisting_FNC("No compte", "Used For Import", ErrorMsg_Te) THEN
                    ERROR(ErrorMsg_Te);

            end;
        }
        field(14; "Factor by date"; Decimal)
        {
            BlankZero = true;
            Caption = 'factor by period';
            FieldClass = Normal;
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        IF IsInUse_FNC(ID, ErrorMsg_Te) THEN
            ERROR(ErrorMsg_Te);

    end;

    trigger OnInsert()
    begin
        Setup.GET();


        IF IsAccountNoExisting_FNC("No compte", "Used For Import", ErrorMsg_Te) THEN
            ERROR('Account No. already existing');


        IF ID = '' THEN
            ID := NoSeriesMgt.GetNextNo(Setup."Fee Nos.", TODAY, TRUE);
    end;

    var
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Setup: Record "DEL General Setup";
        FeeFactor: Record "DEL Fee Factor";
        ErrorMsg_Te: Text[250];
        IsAccountExistingErr: Label 'The account no. %1 is alrealdy attributed with fee id %2';
        IsNotUsedErr: Label 'The fee %1 is still in use in deal %2 !';

    // [Scope('Internal')]
    procedure UpdateFactor()
    begin

        IF Rec.FIND('-') THEN BEGIN
            REPEAT
                FeeFactor.SETFILTER(Fee_ID, ID);
                FeeFactor.SETFILTER("Allow From", '<=%1', WORKDATE);
                FeeFactor.SETFILTER("Allow To", '>=%1', WORKDATE);
                IF FeeFactor.FIND('-') THEN BEGIN
                    "Factor by date" := FeeFactor.Factor;
                    Rec.MODIFY();
                END ELSE BEGIN
                    "Factor by date" := 0;
                    Rec.MODIFY();


                END;
            UNTIL Rec.NEXT = 0;
        END;

    end;

    //[Scope('Internal')]
    procedure IsAccountNoExisting_FNC(AccountNo_Co_Par: Code[20]; UsedForImport_Bo_Par: Boolean; var ErrorMsg_Te_Par: Text[250]): Boolean
    var
        Fee_Re_Loc: Record "DEL Fee";
    begin

        Fee_Re_Loc.RESET();
        Fee_Re_Loc.SETRANGE("No compte", AccountNo_Co_Par);
        Fee_Re_Loc.SETRANGE("Used For Import", UsedForImport_Bo_Par);
        IF Fee_Re_Loc.FIND('-') THEN BEGIN
            ErrorMsg_Te_Par := STRSUBSTNO(IsAccountExistingErr, AccountNo_Co_Par, Fee_Re_Loc.ID);
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    end;

    //  [Scope('Internal')]
    procedure IsInUse_FNC(FeeID_Co_Par: Code[20]; var ErrorMsg_Te_Par: Text[250]): Boolean
    var
        Element_Re_Loc: Record "DEL Element";
    begin



        IF FeeID_Co_Par = '' THEN
            EXIT(FALSE);


        Element_Re_Loc.RESET();
        Element_Re_Loc.SETRANGE(Fee_ID, FeeID_Co_Par);
        IF Element_Re_Loc.FIND('-') THEN BEGIN
            ErrorMsg_Te_Par := STRSUBSTNO(IsNotUsedErr, FeeID_Co_Par, Element_Re_Loc.Deal_ID);
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    end;
}

