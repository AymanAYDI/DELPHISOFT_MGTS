tableextension 50003 "DEL SalesInvoiceHeader" extends "Sales Invoice Header"
{

    fields
    {
        field(50000; "DEL Fiscal Repr."; Code[10])
        {
            Caption = 'Fiscal Repr.';
            TableRelation = Contact;
        }
        field(50004; "DEL Event Code"; Enum "DEL Code Event")
        {
            Caption = 'Event Code';
        }
        field(50006; "DEL Type Order EDI"; Code[20])
        {
            Caption = 'Type Order EDI';
            TableRelation = "DEL Type Order EDI";
        }
        field(50007; "DEL GLN"; Text[30])
        {
            Caption = 'GLN';

        }
        field(50008; "DEL Type Order EDI Description"; Text[50])
        {
            CalcFormula = Lookup("DEL Type Order EDI".Description WHERE(Code = FIELD("DEL Type Order EDI")));
            Caption = 'Type Order EDI Description';

            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "DEL Export With EDI"; Boolean)
        {

        }
        field(50011; "DEL Shipment No."; Text[50])
        {
            Caption = 'Shipment No.';
        }
        field(50020; "DEL To Create Purchase Order"; Boolean)
        {
            Caption = 'Commande d''achat a créer';

        }
        field(50021; "DEL Purchase Order Create Date"; DateTime)
        {
            Caption = 'Date création commande d''achat';

            Editable = false;
        }
        field(50022; "DEL Status Purch. Order Create"; Enum "DEL Status Purchase Order")
        {
            Caption = 'Statut création commande achat';
        }
        field(50023; "DEL Error Text Purch. Order Create"; Text[250])
        {
            Caption = 'Texte erreur création commande achat';

            Editable = false;
        }
        field(50024; "DEL Error Purch. Order Create"; Boolean)
        {
            Caption = 'En erreur création commande achat';

        }
        field(50050; "DEL Mention Under Total"; Text[250])
        {
            Caption = 'Mention Under Total';

        }
        field(50051; "DEL Amount Mention Under Total"; Text[30])
        {
            Caption = 'Amount Mention Under Total';

        }
        field(50200; "DEL Sent To Customer"; Boolean)
        {

        }
    }
}

