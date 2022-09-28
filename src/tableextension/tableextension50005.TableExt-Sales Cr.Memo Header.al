tableextension 50005 tableextension50005 extends "Sales Cr.Memo Header"
{
    // 
    // MGTS0124    23.07.19    Changed field: "Customer Price Group" (Propertiy: Lenght)
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Emil Hr. Hristov = ehh
    // Version : MGTS10.009, MGTS10.010
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version       Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.009    09.09.20    ehh     List of changes:
    //                                           Added new field:  50006 Type Order ODI
    // 
    // 002    MGTS10.010    09.09.20    ehh     List of changes:
    //                                           Added new field:  50007 GLN
    // ------------------------------------------------------------------------------------------
    // 
    // MGTSEDI10.00.00.22 | 11.02.2021 | EDI Management : Add field 50010
    // 
    // MGTSEDI10.00.00.23 | 21.05.2021 | EDI Management : Add fields
    //                                                     To Create Purchase Order,
    //                                                     Purchase Order Create Date,
    //                                                     Status Purchase Order Create
    //                                                     Text Purch. Order Create
    //                                                   Error Purch. Order Create
    // 
    // MGTS10.031  | 22.07.2021 | Add fields : 50050, 50051
    fields
    {
        modify("Customer Price Group")
        {

            //Unsupported feature: Property Modification (Data type) on ""Customer Price Group"(Field 34)".

            Description = 'MGTS0124';
        }
        field(50000; "Fiscal Repr."; Code[10])
        {
            Caption = 'Fiscal Repr.';
            Description = 'T-00551-SPEC35';
            TableRelation = Contact;
        }
        field(50006; "Type Order EDI"; Code[20])
        {
            Caption = 'Type Order EDI';
            Description = 'MGTS10.009';
            TableRelation = "Type Order EDI";
        }
        field(50007; GLN; Text[30])
        {
            Caption = 'GLN';
            Description = 'MGTS10.010';
        }
        field(50008; "Type Order EDI Description"; Text[50])
        {
            CalcFormula = Lookup ("Type Order EDI".Description WHERE (Code = FIELD (Type Order EDI)));
            Caption = 'Type Order EDI Description';
            Description = 'MGTS10.009';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Shipment No."; Text[50])
        {
            Caption = 'Shipment No.';
        }
        field(50020; "To Create Purchase Order"; Boolean)
        {
            Caption = 'Commande d''achat a créer';
            Description = 'MGTSEDI10.00.00.23';
        }
        field(50021; "Purchase Order Create Date"; DateTime)
        {
            Caption = 'Date création commande d''achat';
            Description = 'MGTSEDI10.00.00.23';
            Editable = false;
        }
        field(50022; "Status Purchase Order Create"; Option)
        {
            Caption = 'Statut création commande achat';
            Description = 'MGTSEDI10.00.00.23';
            OptionCaption = ' ,Création demande d''achat,Création affaire,Commande créée';
            OptionMembers = " ","Create Req. Worksheet","Create Deal",Created;
        }
        field(50023; "Error Text Purch. Order Create"; Text[250])
        {
            Caption = 'Texte erreur création commande achat';
            Description = 'MGTSEDI10.00.00.23';
            Editable = false;
        }
        field(50024; "Error Purch. Order Create"; Boolean)
        {
            Caption = 'En erreur création commande achat';
            Description = 'MGTSEDI10.00.00.23';
        }
        field(50050; "Mention Under Total"; Text[250])
        {
            Caption = 'Mention Under Total';
            Description = 'MGTS10.030';
        }
        field(50051; "Amount Mention Under Total"; Text[30])
        {
            Caption = 'Amount Mention Under Total';
            Description = 'MGTS10.030';
        }
    }
}

