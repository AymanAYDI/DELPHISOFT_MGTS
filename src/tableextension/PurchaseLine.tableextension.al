tableextension 50029 "DEL PurchaseLine" extends "Purchase Line" //39 
{

    fields
    {

        //TODO: Voir codeunit events
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item_Rec: Record Item;
                Item: Record Item;
            begin
                IF Item_Rec.GET("No.") THEN
                    VALIDATE("DEL Total volume", (Item."DEL Vol cbm carton transport" * Quantity
                     / Item."DEL PCB")
                    );
            end;

        }
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            var
                DealItem_Cu: Codeunit "DEL Deal Item";
            begin
                IF MODIFY() THEN;
                //cette fonction synchronise les ‚l‚ments dans la table Deal Item pour cette ACO et lance un recalul de l'affaire si n‚cessaire
                DealItem_Cu.FNC_UpdateWithACOLine('Unit Cost', Rec, xRec);
            end;
        }
        field(50001; "DEL Total volume"; Decimal)
        {
            Caption = 'Total volume';
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
        }
        field(50002; "DEL External reference NGTS"; Text[50])
        {
            Caption = 'External reference NGTS';
            DataClassification = CustomerContent;
        }
        field(50003; "DEL First Purch. Order"; Boolean)
        {
            Caption = 'New product';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50004; "DEL Sample Collected"; Boolean)
        {
            Caption = 'Sample picked';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF ("DEL Sample Collected" = TRUE) AND (Type = Type::Item) THEN BEGIN
                    "DEL Collected Date" := WORKDATE();
                    "DEL Sample Collected by" := USERID;
                END
                ELSE
                    IF ("DEL Sample Collected" = FALSE) AND (Type = Type::Item) THEN BEGIN
                        "DEL Collected Date" := 0D;
                        "DEL Sample Collected by" := '';
                    END;
            end;
        }
        field(50005; "DEL Collected Date"; Date)
        {
            Caption = 'Collected Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50006; "DEL Sample Collected by"; Code[50])
        {
            Caption = 'Sample Collected by';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50007; "DEL Photo Taked"; Boolean)
        {
            Caption = 'Picture Taken';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF ("DEL Photo Taked" = TRUE) AND (Type = Type::Item) THEN BEGIN
                    "DEL Photo Date" := WORKDATE();
                    "DEL Photo Taked By" := USERID;
                END
                ELSE
                    IF ("DEL Photo Taked" = FALSE) AND (Type = Type::Item) THEN BEGIN
                        "DEL Photo Date" := 0D;
                        "DEL Photo Taked By" := '';
                    END;
            end;
        }
        field(50008; "DEL Photo Date"; Date)
        {
            Caption = 'Photo Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50009; "DEL Photo Taked By"; Code[50])
        {
            Caption = 'Photo Taked By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50010; "DEL Risk Item"; Boolean)
        {
            Caption = 'Traked item';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50011; "DEL Photo Risk Item Taked"; Boolean)
        {
            Caption = 'Follow-up effect';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF ("DEL Photo Risk Item Taked" = TRUE) AND (Type = Type::Item) THEN BEGIN
                    "DEL Photo Risk Item Date" := WORKDATE();
                    "DEL Photo Risk Item Taked By" := USERID;
                END
                ELSE
                    IF ("DEL Photo Risk Item Taked" = FALSE) AND (Type = Type::Item) THEN BEGIN
                        "DEL Photo Risk Item Date" := 0D;
                        "DEL Photo Risk Item Taked By" := '';
                    END;
            end;
        }
        field(50012; "DEL Photo Risk Item Date"; Date)
        {
            Caption = 'Traked item Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50013; "DEL Photo Risk Item Taked By"; Code[50])
        {
            Caption = 'Traked item Taked By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50014; "DEL Photo And DDoc"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key19; "Document Type", "Document No.", "No.")
        {
        }
    }



    procedure ExistOldPurch(ItemNo: Code[20]; DocNo: Code[20]): Boolean
    var
        PurchInvLine: Record "Purch. Inv. Line";
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETRANGE("No.", ItemNo);
        PurchaseLine.SETFILTER("Document No.", '<>%1', DocNo);
        PurchInvLine.SETRANGE("No.", ItemNo);
        PurchInvLine.SETRANGE(Type, PurchInvLine.Type::Item);
        IF (PurchaseLine.FINDFIRST() OR PurchInvLine.FINDFIRST()) THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;


    procedure UpdateSalesEstimatedDelivery()
    var
        PurchHeader: Record "Purchase Header";
        PurchSetup: Record "Purchases & Payables Setup";
        SalesLine: Record "Sales Line";
    begin

        IF ("Special Order Sales No." = '') OR ("Special Order Sales Line No." = 0) OR ("Expected Receipt Date" = 0D) THEN
            EXIT;

        IF NOT PurchSetup.GET() THEN
            PurchSetup.INIT();

        PurchHeader.get(rec."Document Type", rec."Document No.");

        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", "Special Order Sales No.");
        SalesLine.SETRANGE("Line No.", "Special Order Sales Line No.");
        IF SalesLine.FINDFIRST() THEN
            CASE PurchHeader."DEL Ship Per" OF
                PurchHeader."DEL Ship Per"::"Air Flight":
                    BEGIN
                        SalesLine."DEL Estimated Delivery Date" := CALCDATE(PurchSetup."DEL Sales Ship Time By Air Flight", "Expected Receipt Date");
                        SalesLine.MODIFY();
                    END;

                PurchHeader."DEL Ship Per"::"Sea Vessel":
                    BEGIN
                        SalesLine."DEL Estimated Delivery Date" := CALCDATE(PurchSetup."DEL Sales Ship Time By Sea Vessel", "Expected Receipt Date");
                        SalesLine.MODIFY();
                    END;

                PurchHeader."DEL Ship Per"::"Sea/Air":
                    BEGIN
                        SalesLine."DEL Estimated Delivery Date" := CALCDATE(PurchSetup."DEL Sales Ship Time By Sea/Air", "Expected Receipt Date");
                        SalesLine.MODIFY();
                    END;

                PurchHeader."DEL Ship Per"::Train:
                    BEGIN
                        SalesLine."DEL Estimated Delivery Date" := CALCDATE(PurchSetup."DEL Sales Ship Time By Train", "Expected Receipt Date");
                        SalesLine.MODIFY();
                    END;

                PurchHeader."DEL Ship Per"::Truck:
                    BEGIN
                        SalesLine."DEL Estimated Delivery Date" := CALCDATE(PurchSetup."DEL Sales Ship Time By Truck", "Expected Receipt Date");
                        SalesLine.MODIFY();
                    END;
            END;

    end;
}

