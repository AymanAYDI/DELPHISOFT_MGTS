xmlport 50013 "DEL Import ligne vente"
{
    // T-00778     THM     16.03.16          add "Sale blocked"

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
                                IF ItemCrossRef.FINDFIRST THEN
                                    //START T-00778
                                    REPEAT
                                        ItemCrossRef.CALCFIELDS(ItemCrossRef."DEL Sale blocked");
                                        IF ItemCrossRef."DEL Sale blocked" = FALSE THEN
                                            //STOP T-00778

                                            Article := ItemCrossRef."Item No.";

                                    //START T-00778
                                    UNTIL (ItemCrossRef.NEXT = 0) OR (Article <> '');
                                //STOP T-00778
                            END;

                        //START T-00778
                        IF Article <> '' THEN BEGIN
                            //STOP T-00778
                            IF DocCmd = '' THEN
                                DocCmd := "Sales Line".GETFILTER("Document No.");

                            SalesLine.SETFILTER("Document No.", DocCmd);

                            IF SalesLine.FINDLAST THEN
                                Num := SalesLine."Line No." + 10000
                            ELSE
                                Num += 10000;

                            "Sales Line"."Document Type" := 1;
                            "Sales Line"."Line No." := Num;
                            "Sales Line"."Document No." := DocCmd;
                            "Sales Line".Type := 2;
                            "Sales Line".VALIDATE("No.", Article);

                            CLEAR(Article);
                            //START T-00778
                        END;
                        //STOP T-00778
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
                        currXMLport.SKIP;
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
        Num: Integer;
        SalesHeader: Record "Sales Header";
        SaleHeaderP: Page "Sales Order";
        DocCmd: Text;
        SalesLine: Record "Sales Line";
        ItemCrossRef: Record "Item Reference";
        I: Integer;
}

