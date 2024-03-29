table 50024 "DEL Fee"
{

    Caption = 'Fee';
    DataClassification = CustomerContent;

    LookupPageID = "DEL Fee";
    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                IF IsInUse_FNC(xRec.ID, ErrorMsg_Te) THEN
                    ERROR(ErrorMsg_Te);

            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Amount Type"; Enum "DEL Amount Type")
        {
            Caption = 'Amount Type';
            DataClassification = CustomerContent;
        }
        field(4; "Ventilation Element"; Enum "DEL Ventilation Element")
        {

            Caption = 'Ventilation Element';
            DataClassification = CustomerContent;
        }
        field(5; "Ventilation Position"; Enum "DEL Ventilation Position")
        {

            Caption = 'Ventilation Position';
            DataClassification = CustomerContent;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(7; Currency; Code[10])
        {
            Caption = 'Currency';
            DataClassification = CustomerContent;
            TableRelation = Currency.Code;
        }
        field(8; "Field"; Enum "DEL Field")
        {
            Caption = 'Field';
            DataClassification = CustomerContent;
        }
        field(9; Factor; Decimal)
        {
            Caption = 'Factor';
            DataClassification = CustomerContent;
        }
        field(10; Destination; Code[10])
        {
            Caption = 'Destination';
            DataClassification = CustomerContent;
            TableRelation = Location.Code;
        }
        field(11; Axe; Code[10])
        {
            Caption = 'Axe';
            DataClassification = CustomerContent;
        }
        field(12; "No compte"; Text[20])
        {
            Caption = 'Account No';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account"."No.";
            trigger OnValidate()
            begin

                IF IsAccountNoExisting_FNC("No compte", "Used For Import", ErrorMsg_Te) THEN
                    ERROR(ErrorMsg_Te);

            end;
        }
        field(13; "Used For Import"; Boolean)
        {
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
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
        FeeFactor: Record "DEL Fee Factor";
        Setup: Record "DEL General Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        IsAccountExistingErr: Label 'The account no. %1 is alrealdy attributed with fee id %2';
        IsNotUsedErr: Label 'The fee %1 is still in use in deal %2 !';
        ErrorMsg_Te: Text[250];


    procedure UpdateFactor()
    begin

        IF Rec.FIND('-') THEN
            REPEAT
                FeeFactor.SETFILTER(Fee_ID, ID);
                FeeFactor.SETFILTER("Allow From", '<=%1', WORKDATE());
                FeeFactor.SETFILTER("Allow To", '>=%1', WORKDATE());
                IF FeeFactor.FIND('-') THEN BEGIN
                    "Factor by date" := FeeFactor.Factor;
                    Rec.MODIFY();
                END ELSE BEGIN
                    "Factor by date" := 0;
                    Rec.MODIFY();


                END;
            UNTIL Rec.NEXT() = 0;

    end;


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

