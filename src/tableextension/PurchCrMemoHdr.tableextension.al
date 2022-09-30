tableextension 50009 "DEL PurchCrMemoHdr" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50014; "DEL Type Order EDI"; Code[20])
        {
            Caption = 'Type Order EDI';

            TableRelation = "DEL Type Order EDI";
        }
        field(50015; "DEL GLN"; Text[30])
        {
            Caption = 'GLN';

        }
        field(50016; "DEL Type Order EDI Description"; Text[50])
        {
            CalcFormula = Lookup("DEL Type Order EDI".Description WHERE(Code = FIELD("DEL Type Order EDI")));
            Caption = 'Type Order EDI Description';

            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "DEL Due Date Calculation"; Date)
        {
            Caption = 'Due Date Calculation';

        }
    }
}

