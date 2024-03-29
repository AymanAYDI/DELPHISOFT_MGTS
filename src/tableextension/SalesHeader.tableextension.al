tableextension 50026 "DEL SalesHeader" extends "Sales Header" //36
{

    //Unsupported feature: Property Insertion (Permissions) on ""Sales Header"(Table 36)".

    fields
    {
        //Unsupported feature: Property Deletion (TableRelation) on ""Customer Price Group"(Field 34)". -> code dans le onlookup trigger 
        field(50000; "DEL Fiscal Repr."; Code[10])
        {
            Caption = 'Fiscal Repr.';
            DataClassification = CustomerContent;

            TableRelation = Contact;
        }
        field(50001; "DEL Create By"; Text[50])
        {
            Caption = 'Create By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50002; "DEL Create Date"; Date)
        {
            Caption = 'Create Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50003; "DEL Create Time"; Time)
        {
            Caption = 'Create Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50004; "DEL Event Code"; enum "DEL Code Event")
        {
            Caption = 'Event Code';
            DataClassification = CustomerContent;
        }
        field(50005; "DEL Estimated Delivery Date"; Date)
        {
            Caption = 'Estimated delivery date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                SalesLine_Rec: Record "Sales Line";
            begin
                SalesLine_Rec.SETRANGE(SalesLine_Rec."Document Type", "Document Type");
                SalesLine_Rec.SETRANGE(SalesLine_Rec."Document No.", "No.");
                IF SalesLine_Rec.FINDSET() THEN
                    REPEAT
                        SalesLine_Rec."DEL Estimated Delivery Date" := "DEL Estimated Delivery Date";
                        SalesLine_Rec.MODIFY();
                    UNTIL SalesLine_Rec.NEXT() = 0;

            end;
        }
        field(50006; "DEL Type Order EDI"; Code[20])
        {
            Caption = 'Type Order EDI';
            DataClassification = CustomerContent;

            TableRelation = "DEL Type Order EDI";
        }
        field(50007; "DEL GLN"; Text[30])
        {
            Caption = 'Delivery GLN';
            DataClassification = CustomerContent;

            TableRelation = "DEL EDI Delivery GLN Customer";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50008; "DEL Type Order EDI Description"; Text[50])
        {
            CalcFormula = Lookup("DEL Type Order EDI".Description WHERE(Code = FIELD("DEL Type Order EDI")));
            Caption = 'Type Order EDI Description';

            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "DEL Has Spec. Purch. Order"; Boolean)
        {
            Caption = 'Has special purch. order';
            DataClassification = CustomerContent;

            Editable = false;
        }
        field(50010; "DEL Export With EDI"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50011; "DEL Shipment No."; Text[150])
        {
            Caption = 'Shipment No.';
            DataClassification = CustomerContent;
        }
        field(50020; "DEL To Create Purchase Order"; Boolean)
        {
            Caption = 'Commande d''achat a créer';
            DataClassification = CustomerContent;
        }
        field(50021; "DEL Purchase Order Create Date"; DateTime)
        {
            Caption = 'Date création commande d''achat';
            DataClassification = CustomerContent;

            Editable = false;
        }
        field(50022; "DEL Status Purch. Order Create"; enum "DEL Status Purchase Order")
        {
            Caption = 'Statut création commande achat';
            DataClassification = CustomerContent;
        }
        field(50023; "DEL Err Text Pur. Order Create"; Text[250])
        {
            Caption = 'Texte erreur création commande achat';
            DataClassification = CustomerContent;

            Editable = false;
        }
        field(50024; "DEL Error Purch. Order Create"; Boolean)
        {
            Caption = 'En erreur création commande achat';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                TextCst001: Label 'This change will reset the purchase order creation status. Do you want to continue?';
            begin
                IF NOT HideValidationDialog THEN
                    IF ("DEL Error Purch. Order Create" = FALSE) AND ("DEL Status Purch. Order Create" <> "DEL Status Purch. Order Create"::Created) THEN
                        IF CONFIRM(TextCst001, FALSE) THEN BEGIN
                            "DEL Err Text Pur. Order Create" := '';
                            "DEL To Create Purchase Order" := TRUE;
                        END;
            end;
        }
        field(50050; "DEL Mention Under Total"; Text[250])
        {
            Caption = 'Mention Under Total';
            DataClassification = CustomerContent;
        }
        field(50051; "DEL Amount Mention Under Total"; Text[30])
        {
            Caption = 'Amount Mention Under Total';
            DataClassification = CustomerContent;
        }
        field(50052; "DEL Container No."; Code[30])
        {
            Caption = 'Container Number';
            DataClassification = CustomerContent;
        }
        field(50053; "DEL Dispute Reason"; Code[20])
        {
            Caption = 'Dispute Reason';
            DataClassification = CustomerContent;
        }
        field(50054; "DEL Dispute Date"; Date)
        {
            Caption = 'Dispute Date';
            DataClassification = CustomerContent;
        }

    }

    procedure SelectGLEntryForReverse()
    var
        GLEntry: Record "G/L Entry";
        ReverseGLEntry: Record "G/L Entry";
        GLSetup: Record "General Ledger Setup";
        GLEntries: Page "General Ledger Entries";

    begin

        IF NOT GLSetup.GET() THEN
            GLSetup.INIT();

        GLSetup.TESTFIELD("DEL Provision Source Code");
        GLSetup.TESTFIELD("DEL Provision Journal Batch");
        GLEntry.RESET();
        GLEntry.SETCURRENTKEY("Document No.", "Posting Date");
        GLEntry.FILTERGROUP(2);
        GLEntry.SETRANGE("Source Code", GLSetup."DEL Provision Source Code");
        GLEntry.SETFILTER("Journal Batch Name", GLSetup."DEL Provision Journal Batch");
        GLEntry.SETRANGE("DEL Customer Provision", "Bill-to Customer No.");
        GLEntry.SETRANGE("DEL Reverse With Doc. No.", Text50001);
        GLEntry.FILTERGROUP(0);

        CLEAR(GLEntries);
        GLEntries.SETTABLEVIEW(GLEntry);
        GLEntries.LOOKUPMODE(TRUE);
        IF GLEntries.RUNMODAL() = ACTION::LookupOK THEN
            GLEntries.SetGLEntry(ReverseGLEntry);
        IF ReverseGLEntry.FINDSET() THEN
            REPEAT
                ReverseGLEntry."DEL Reverse With Doc. No." := "No.";
                ReverseGLEntry.MODIFY();
            UNTIL ReverseGLEntry.NEXT() = 0;
    end;

    procedure ShowSelectedEntriesForReverse()
    var
        GLEntry: Record "G/L Entry";
        GLEntriesForReverse: Page "DEL GL Entries For Reverse";
    begin

        TESTFIELD("No.");
        GLEntry.RESET();
        GLEntry.SETCURRENTKEY("DEL Reverse With Doc. No.");
        GLEntry.FILTERGROUP(2);
        GLEntry.SETRANGE("DEL Reverse With Doc. No.", "No.");
        GLEntry.FILTERGROUP(4);
        CLEAR(GLEntriesForReverse);
        GLEntriesForReverse.SetRelatedOrder(Rec);
        GLEntriesForReverse.SETTABLEVIEW(GLEntry);
        GLEntriesForReverse.RUN();
    end;

    var
        Text50001: Label '''''';
}

