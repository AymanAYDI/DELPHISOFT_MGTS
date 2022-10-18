xmlport 50006 "DEL Import commande vente"
{
    // T-00778     THM     16.03.16          add "Sale blocked"

    Direction = Import;
    Encoding = UTF16;
    FieldSeparator = ';';
    Format = VariableText;
    TableSeparator = ';';
    UseRequestPage = false;

    schema
    {
        textelement(Importlignevente)
        {
            tableelement(Table50002; Table50002)
            {
                XmlName = 'importCmdeVente';
                fieldelement(Post; "Import Commande vente".Position)
                {
                }
                fieldelement(Article; "Import Commande vente"."No.")
                {
                }
                fieldelement(ArtExt; "Import Commande vente"."Cross-Reference No.")
                {
                }
                fieldelement(Des; "Import Commande vente".Description)
                {
                }
                fieldelement(Quantity; "Import Commande vente".Quantity)
                {
                }
                fieldelement(PrixUnit; "Import Commande vente"."Unit Price")
                {
                }
                fieldelement(Montant; "Import Commande vente".Amount)
                {
                }

                trigger OnAfterInitRecord()
                begin
                    I += 1;
                    IF I = 1 THEN
                        currXMLport.SKIP;
                    LineNo += 10000;
                    "Import Commande vente"."Document No." := DocCmd;
                    "Import Commande vente"."Line No." := LineNo;
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
        ImportCommandevente.DELETEALL;
    end;

    var
        DocCmd: Text;
        I: Integer;
        LineNo: Integer;
        ImportCommandevente: Record "50002";

    [Scope('Internal')]
    procedure SetDocNo(DocNo: Code[20])
    begin
        DocCmd := DocNo;
    end;
}

