tableextension 50001 "DEL SalesShipmentHeader" extends "Sales Shipment Header"
{

    fields
    {
        //todo modif deu longeur champs du 10 a 20
        // modify("Customer Price Group")
        // {

        //     //Unsupported feature: Property Modification (Data type) on ""Customer Price Group"(Field 34)".


        // }
        field(50000; "DEL Fiscal Repr."; Code[10])
        {
            Caption = 'Fiscal Repr.';

            TableRelation = Contact;
        }
        field(50001; "DEL Container_no"; Text[30])
        {
            Caption = 'N. Conteneur';

            trigger OnLookup()
            begin

                SalesShipmentLine.SETRANGE(SalesShipmentLine."Document No.", "No.");
                SalesShipmentLine.SETFILTER(SalesShipmentLine."Shortcut Dimension 1 Code", '<>%1', '');

                //containerid

                IF SalesShipmentLine.FINDFIRST() THEN BEGIN
                    Trackinggeneral.SETRANGE(Trackinggeneral.Order_no, SalesShipmentLine."Shortcut Dimension 1 Code");
                    Trackinggeneral.SETFILTER(Trackinggeneral.Container_no, '<>%1', '');
                    //Trackinggeneral_Page.SETTABLEVIEW(Trackinggeneral);
                    IF PAGE.RUNMODAL(50140, Trackinggeneral) = ACTION::LookupOK THEN
                        //VALIDATE("Primary Contact No.",Cont."No.");
                        //MESSAGE(Trackinggeneral.Container_no);
            VALIDATE("DEL Container_no", Trackinggeneral.Container_no);
                    MODIFY();
                END;
            end;
        }
        field(50006; "DEL Type Order EDI"; Code[20])
        {
            Caption = 'Type Order EDI';

            //TODO //  TableRelation = "Type Order EDI";
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
        field(50022; "DEL Status Purch. Order Create"; Option)
        {
            Caption = 'Statut création commande achat';

            OptionCaption = ' ,Création demande d''achat,Création affaire,Commande créée';
            OptionMembers = " ","Create Req. Worksheet","Create Deal",Created;
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
    }

    var
        SalesShipmentLine: Record 111;
        Trackinggeneral: Record 50013;
        Trackinggeneral_Page: Page 50140;
}

