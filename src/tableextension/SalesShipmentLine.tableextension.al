tableextension 50002 "DEL SalesShipmentLine" extends "Sales Shipment Line"
{

    fields
    { //TODO 
        // modify("Customer Price Group")
        // {

        //     //Unsupported feature: Property Modification (Data type) on ""Customer Price Group"(Field 42)".

        // }
        field(50001; "DEL Qty. Init. Client"; Decimal)
        {

        }
        field(50008; "DEL Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';

            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }
        field(50009; "DEL Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';

        }
    }

    //Unsupported feature: Variable Insertion (Variable: Text50000) (VariableCollection) on "InsertInvLineFromShptLine(PROCEDURE 2)".


    //Unsupported feature: Variable Insertion (Variable: Text50001) (VariableCollection) on "InsertInvLineFromShptLine(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "InsertInvLineFromShptLine(PROCEDURE 2)".

    //procedure InsertInvLineFromShptLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SETRANGE("Document No.","Document No.");

    TempSalesLine := SalesLine;
    #4..21

      SalesLine.INSERT;
      NextLineNo := NextLineNo + 10000;
    END;

    TransferOldExtLines.ClearLineNumbers;
    #28..62
      END;

      SalesLine := SalesOrderLine;
      SalesLine."Line No." := NextLineNo;
      SalesLine."Document Type" := TempSalesLine."Document Type";
      SalesLine."Document No." := TempSalesLine."Document No.";
    #69..144
      SalesOrderHeader."Get Shipment Used" := TRUE;
      SalesOrderHeader.MODIFY;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..24


      // T-00551-SALE - Rajout d'une ligne supplémentaire "on get shipment line"
      SalesLine.INIT;
    #66..68

      SalesShipHead.GET("Document No.");
      SalesLine.Description := COPYSTR((STRSUBSTNO(Text50000,"Order No.",SalesShipHead."External Document No.")),1,50);

      SalesLine.INSERT;
      NextLineNo := NextLineNo + 10000;

      SalesLine.INIT;
      SalesLine."Line No." := NextLineNo;
      SalesLine."Document Type" := TempSalesLine."Document Type";
      SalesLine."Document No." := TempSalesLine."Document No.";

      SalesShipHead.GET("Document No.");
      SalesLine.Description := COPYSTR((STRSUBSTNO(Text50001,SalesShipHead."Sell-to Contact",
      SalesShipHead."Sell-to Customer Name",SalesShipHead."Sell-to City")),1,50);

      SalesLine.INSERT;
      NextLineNo := NextLineNo + 10000;
      // T-00551-SALE +


    #25..147
    */
    //end;
}

