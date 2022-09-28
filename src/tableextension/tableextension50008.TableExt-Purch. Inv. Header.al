tableextension 50008 tableextension50008 extends "Purch. Inv. Header"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.002, MGTS10.009,MGTS10.010,MGTS10.024
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.002    08.01.20    mhh     List of changes:
    //                                              Added new field: 50013 "Vendor Shipment Date"
    // 
    // 002    MGTS10.009       09.09.20    ehh     List of changes:
    //                                              Added new field: 50014 Type Order ODI
    // 
    // 003    MGTS10.010       09.09.20    ehh     List of changes:
    //                                              Added new field: 50015 GLN
    // 
    // 004     MGTS10.024       10.02.21    mhh     List of changes:
    //                                              Added new field: 50017 "Due Date Calculation"
    // ------------------------------------------------------------------------------------------
    fields
    {
        field(50013; "Vendor Shipment Date"; Date)
        {
            Caption = 'Vendor Shipment Date';
            Description = 'MGTS10.00.002';
        }
        field(50014; "Type Order EDI"; Code[20])
        {
            Caption = 'Type Order EDI';
            Description = 'MGTS10.009';
            TableRelation = "Type Order EDI";
        }
        field(50015; GLN; Text[30])
        {
            Caption = 'GLN';
            Description = 'MGTS10.010';
        }
        field(50016; "Type Order EDI Description"; Text[50])
        {
            CalcFormula = Lookup ("Type Order EDI".Description WHERE (Code = FIELD (Type Order EDI)));
            Caption = 'Type Order EDI Description';
            Description = 'MGTS10.009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "Due Date Calculation"; Date)
        {
            Caption = 'Due Date Calculation';
            Description = 'MGTS10.024';
        }
    }
}

