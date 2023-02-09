xmlport 50013 "DEL Import ligne vente"
{

    Direction = Import;
    // Encoding = UTF16; TODO: Format= VariableText
    FieldSeparator = ';';
    Format = VariableText;
    TableSeparator = ';';
    UseRequestPage = false;

    schema
    {
        textelement(Importlignevente)
        {
            tableelement("Sales Line"; "Sales Line")
            {
                XmlName = 'SalesLine';
                textelement(Post)
                {
                }
                textelement(Article)
                {
                }
                textelement(ArtExt)
                {

                    trigger OnAfterAssignVariable()
                    begin
                        IF Article = '' THEN
                            IF ArtExt <> '' THEN BEGIN
                                ItemCrossRef.SETRANGE("Reference No.", ArtExt);
                                IF ItemCrossRef.FINDFIRST() THEN
                                    REPEAT
                                        ItemCrossRef.CALCFIELDS(ItemCrossRef."DEL Sale blocked");
                                        IF ItemCrossRef."DEL Sale blocked" = FALSE THEN
                                            Article := ItemCrossRef."Item No.";

                                    UNTIL (ItemCrossRef.NEXT() = 0) OR (Article <> '');
                            END;

                        IF Article <> '' THEN BEGIN
                            IF DocCmd = '' THEN
                                DocCmd := "Sales Line".GETFILTER("Document No.");

                            SalesLine.SETFILTER("Document No.", DocCmd);

                            IF SalesLine.FINDLAST() THEN
                                Num := SalesLine."Line No." + 10000
                            ELSE
                                Num += 10000;

                            "Sales Line"."Document Type" := "Sales Document Type"::Order;
                            "Sales Line"."Line No." := Num;
                            "Sales Line"."Document No." := DocCmd;
                            "Sales Line".Type := "Sales Line Type"::Item;
                            "Sales Line".VALIDATE("No.", Article);

                            CLEAR(Article);
                        END;
                    end;
                }
                textelement(des)
                {
                    XmlName = 'Des';
                }
                fieldelement(Quantity; "Sales Line".Quantity)
                {
                }
                textelement(PrixUnit)
                {
                }
                textelement(Montant)
                {
                }

                trigger OnAfterInitRecord()
                begin
                    I += 1;
                    IF I = 1 THEN
                        currXMLport.SKIP();
                end;
            }

            trigger OnBeforePassVariable()
            begin
                DocCmd := "Sales Line".GETFILTER("Document No.");
            end;

            trigger OnAfterAssignVariable()
            begin
                DocCmd := "Sales Line".GETFILTER("Document No.");
            end;
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

    trigger OnInitXmlPort()
    begin
        DocCmd := "Sales Line".GETFILTER("Document No.");
    end;

    trigger OnPostXmlPort()
    begin
        DocCmd := "Sales Line".GETFILTER("Document No.");
    end;

    trigger OnPreXmlPort()
    begin
        DocCmd := "Sales Line".GETFILTER("Document No.");
    end;

    var
        ItemCrossRef: Record "Item Reference";
        SalesLine: Record "Sales Line";
        I: Integer;
        Num: Integer;
        DocCmd: Text;
}

