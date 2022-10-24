xmlport 50006 "DEL Import commande vente"
{

    Direction = Import;

    //Encoding = UTF16;
    //TODO: The property 'Encoding' can only be set if the property 'Format' is set to 'Xml'
    FieldSeparator = ';';
    Format = VariableText;
    TableSeparator = ';';
    UseRequestPage = false;

    schema
    {
        textelement(Importlignevente)
        {
            tableelement("DEL Import Commande vente"; "DEL Import Commande vente")
            {
                XmlName = 'importCmdeVente';
                fieldelement(Post; "DEL Import Commande vente".Position)
                {
                }
                fieldelement(Article; "DEL Import Commande vente"."No.")
                {
                }
                fieldelement(ArtExt; "DEL Import Commande vente"."Cross-Reference No.")
                {
                }
                fieldelement(Des; "DEL Import Commande vente".Description)
                {
                }
                fieldelement(Quantity; "DEL Import Commande vente".Quantity)
                {
                }
                fieldelement(PrixUnit; "DEL Import Commande vente"."Unit Price")
                {
                }
                fieldelement(Montant; "DEL Import Commande vente".Amount)
                {
                }

                trigger OnAfterInitRecord()
                begin
                    I += 1;
                    IF I = 1 THEN
                        currXMLport.SKIP();
                    LineNo += 10000;
                    "DEL Import Commande vente"."Document No." := DocCmd;
                    "DEL Import Commande vente"."Line No." := LineNo;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort()
    begin
        ImportCommandevente.DELETEALL();
    end;

    var
        ImportCommandevente: Record "DEL Import Commande vente";
        I: Integer;
        LineNo: Integer;
        DocCmd: Text;

    procedure SetDocNo(DocNo: Code[20])
    begin
        DocCmd := DocNo;
    end;
}

