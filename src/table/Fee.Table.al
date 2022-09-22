table 50024 "DEL Fee"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 16.07.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            16.07.09   Added 'Quantity' option for field 4 & 5
    // GRC                              20.07.09   add field 14  + fonction updateFactor
    // CHG02                            06.06.11   Added functions IsAccountNoExisting_FNC, IsInUse_FNC
    //                                             Added glob vars ErrorMsg_Te
    //                                             Added glob text IsAccountExistingErr, IsNotUsedErr
    //                                             Modified trigger OnInsert, OnDelete
    //                                             Modified field "ID - OnValidate", "No compte - OnValidate", "Used For Import" - OnValida
    // CHG03                            02.09.11   Handeld empty code fee in IsInUse_FNC

    LookupPageID = 50024;
    Caption = 'Fee';

    fields
    {
        field(1; ID; Code[20])
        {
            Caption = 'ID';

            trigger OnValidate()
            begin
                //CHG02 START
                IF IsInUse_FNC(xRec.ID, ErrorMsg_Te) THEN
                    ERROR(ErrorMsg_Te);
                //CHG02 STOP
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Amount Type"; Option)
        {
            Caption = 'Amount Type';
            OptionCaption = 'fixed,calculated';
            OptionMembers = "fixed",calculated;
        }
        field(4; "Ventilation Element"; Option)
        {
            OptionCaption = 'Value,CBM Volume,Reception Number,Colis Amount,Gross Weight,Volume CBM Transported,Quantity';
            OptionMembers = Value,"CBM Volume","Reception Number","Colis Amount","Gross Weight","Volume CBM Transported",Quantity;
            Caption = 'Ventilation Element';
        }
        field(5; "Ventilation Position"; Option)
        {
            OptionCaption = 'Prorata Value,Prorata Volume,Prorata Colisage,Prorata Gross Weight,Quantity';
            OptionMembers = "Prorata Value","Prorata Volume","Prorata Colisage","Prorata Gross Weight",Quantity;
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
        field(8; "Field"; Option)
        {
            OptionCaption = 'Net Weight,Gross Weight,Transport Volume,CBM Volume,Colis,Douane,Quantity';
            OptionMembers = "Net Weight","Gross Weight","Transport Volume","CBM Volume",Colis,Douane,Quantity;
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
            TableRelation = "G/L Account".No.;

            trigger OnValidate()
            begin
                //CHG02 START
                IF IsAccountNoExisting_FNC("No compte", "Used For Import", ErrorMsg_Te) THEN
                  ERROR(ErrorMsg_Te);
                //CHG02 STOP
            end;
        }
        field(13; "Used For Import"; Boolean)
        {

            trigger OnValidate()
            begin
                //CHG02 START
                IF IsAccountNoExisting_FNC("No compte", "Used For Import", ErrorMsg_Te) THEN
                  ERROR(ErrorMsg_Te);
                //CHG02 STOP
            end;
        }
        field(14; "Factor by date"; Decimal)
        {
            BlankZero = true;
            Caption = 'factor by period';
            FieldClass = Normal;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = true;
        }
    }

    keys
    {
        key(Key1;ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //CHG02 START
        IF IsInUse_FNC(ID, ErrorMsg_Te) THEN
          ERROR(ErrorMsg_Te);
        //CHG02 STOP
    end;

    trigger OnInsert()
    begin
        Setup.GET();

        //CHG02 START
        IF IsAccountNoExisting_FNC("No compte", "Used For Import", ErrorMsg_Te) THEN
          ERROR('Account No. already existing');
        //CHG02 STOP

        IF ID = '' THEN
          ID := NoSeriesMgt.GetNextNo(Setup."Fee Nos.", TODAY, TRUE);
    end;

    var
        NoSeriesMgt: Codeunit "396";
        Setup: Record "50000";
        FeeFactor: Record "50043";
        ErrorMsg_Te: Text[250];
        IsAccountExistingErr: Label 'The account no. %1 is alrealdy attributed with fee id %2';
        IsNotUsedErr: Label 'The fee %1 is still in use in deal %2 !';

    
    procedure UpdateFactor()
    begin
        //GRC begin
        IF Rec.FIND('-') THEN BEGIN
          REPEAT
            FeeFactor.SETFILTER(Fee_ID,ID);
            FeeFactor.SETFILTER("Allow From",'<=%1',WORKDATE);
            FeeFactor.SETFILTER("Allow To",'>=%1',WORKDATE);
            IF FeeFactor.FIND('-') THEN BEGIN
              "Factor by date" := FeeFactor.Factor;
              Rec.MODIFY();
            END ELSE BEGIN
              "Factor by date" := 0;
              Rec.MODIFY();


           END;
           UNTIL Rec.NEXT = 0;
        END;
        //GRC end
    end;

    
    procedure IsAccountNoExisting_FNC(AccountNo_Co_Par: Code[20];UsedForImport_Bo_Par: Boolean;var ErrorMsg_Te_Par: Text[250]): Boolean
    var
        Fee_Re_Loc: Record "50024";
    begin
        //return true if the account is already used by another fee with the same "Used for import setting"
        Fee_Re_Loc.RESET();
        Fee_Re_Loc.SETRANGE("No compte", AccountNo_Co_Par);
        Fee_Re_Loc.SETRANGE("Used For Import", UsedForImport_Bo_Par);
        IF Fee_Re_Loc.FIND('-') THEN BEGIN
          ErrorMsg_Te_Par := STRSUBSTNO(IsAccountExistingErr, AccountNo_Co_Par, Fee_Re_Loc.ID);
          EXIT(TRUE);
        END ELSE
          EXIT(FALSE);
    end;

    
    procedure IsInUse_FNC(FeeID_Co_Par: Code[20];var ErrorMsg_Te_Par: Text[250]): Boolean
    var
        Element_Re_Loc: Record "50021";
    begin
        //returns true if the fee is in use in a deal

        //CHG03 START
        IF FeeID_Co_Par = '' THEN
          EXIT(FALSE);
        //CHG03 STOP

        Element_Re_Loc.RESET();
        Element_Re_Loc.SETRANGE(Fee_ID, FeeID_Co_Par);
        IF Element_Re_Loc.FIND('-') THEN BEGIN
          ErrorMsg_Te_Par := STRSUBSTNO(IsNotUsedErr, FeeID_Co_Par, Element_Re_Loc.Deal_ID);
          EXIT(TRUE);
        END ELSE
          EXIT(FALSE);
    end;
}

