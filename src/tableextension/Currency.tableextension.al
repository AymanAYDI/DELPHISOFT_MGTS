tableextension 50000 "DEL Currency" extends Currency
{
    fields
    {
        //TODO
        // field(3010541; "DEL ISO Currency Code"; Code[3])
        // {
        //     Caption = 'ISO Currency Code';
        //     CharAllowed = 'AZ';
        // }
        // field(4006497; "DEL Kennzeichen"; Text[10])
        // {
        //     Description = 'AL.KVK5.0';
        // }
    }


    var
        TypeHelper: Codeunit 10;
        "-DEL_QR-": Integer;
        "--DEL_QR--": label '';
        ASCIILetterErr: Label 'must contain ASCII letters only';
        ISOCodeLengthErr: Label 'The length of the string is %1, but it must be equal to %2 characters. Value: %3.';
        NumericErr: Label 'must contain numbers only';
}

