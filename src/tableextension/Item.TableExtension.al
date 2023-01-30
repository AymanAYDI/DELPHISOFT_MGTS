tableextension 50020 "DEL Item" extends Item //27
{


    fields
    {

        // TODO:table product group code has been removed modify("Product Group Code"){
        //      ProductGroup_Rec@1000000000 : Record 5723;
        //                                                           BEGIN
        //                                                             //MIG2017
        //                                                              //T-00712
        //                                                              IF ProductGroup_Rec.GET("Item Category Code","Product Group Code") THEN
        //                                                                 IF ProductGroup_Rec."Code Segment" = '' THEN ERROR(Text0027,"Product Group Code");
        //                                                              //END T-00712

        //                                                              //START THM220817
        //                                                              IF Rec."Product Group Code"<> '' THEN
        //                                                              BEGIN
        //                                                                RecMatriseGroupArtGroup.RESET;
        //                                                                RecMatriseGroupArtGroup.SETRANGE(RecMatriseGroupArtGroup."Product Group Code",Rec."Product Group Code");
        //                                                                IF RecMatriseGroupArtGroup.FINDFIRST THEN
        //                                                                BEGIN
        //                                                                 IF RecMatriseGroupArtGroup.COUNT=1 THEN
        //                                                                   Standardartikelgruppe:=RecMatriseGroupArtGroup."Standard Item Group Code"
        //                                                                   ELSE
        //                                                                   BEGIN
        //                                                                     CLEAR(PageMatriseGroupArtGroup);
        //                                                                     PageMatriseGroupArtGroup.SETTABLEVIEW(RecMatriseGroupArtGroup);
        //                                                                     PageMatriseGroupArtGroup.LOOKUPMODE:=TRUE;
        //                                                                     //PageMatriseGroupArtGroup.EDITABLE(FALSE);
        //                                                                     PageMatriseGroupArtGroup.SETRECORD(RecMatriseGroupArtGroup);
        //                                                                     IF PageMatriseGroupArtGroup.RUNMODAL=ACTION::LookupOK THEN
        //                                                                     BEGIN
        //                                                                       PageMatriseGroupArtGroup.GETRECORD(RecMatriseGroupArtGroup);
        //                                                                       Standardartikelgruppe:=RecMatriseGroupArtGroup."Standard Item Group Code";
        //                                                                     END;
        //                                                                   END;
        //                                                                END
        //                                                                 ELSE
        //                                                                   Standardartikelgruppe:='';
        //                                                              END
        //                                                              ELSE
        //                                                              BEGIN
        //                                                                Standardartikelgruppe:='';
        //                                                              END;
        //                                                              //END THM220817
        //                                                              //MIG2017 END

        //                                                             //>>DELSupport
        //                                                             ModifSegment("Product Group Code","Item Category Code");
        //                                                             //<<DELSupport
        //                                                           END;
        // }
        field(50000; "DEL Weight net"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50001; "DEL Weight brut"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50002; "DEL Code EAN 13"; Code[13])
        {
            DataClassification = CustomerContent;
        }
        field(50003; "DEL Vol cbm"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50004; "DEL Vol cbm carton transport"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                IF ("DEL PCB" = 0) THEN
                    "DEL Vol cbm" := 0
                ELSE
                    "DEL Vol cbm" := ROUND(("DEL Vol cbm carton transport" / "DEL PCB"), 0.00001, '>');

            end;
        }
        field(50005; "DEL PCB"; Integer)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                IF ("DEL PCB" = 0) THEN
                    "DEL Vol cbm" := 0
                ELSE
                    "DEL Vol cbm" := ROUND(("DEL Vol cbm carton transport" / "DEL PCB"), 0.00001, '>');

            end;
        }
        field(50006; "DEL SPCB"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50007; "DEL Certified by QS"; Boolean)
        {
            Caption = 'Qualität geprüft';
            DataClassification = CustomerContent;
        }
        field(50008; "DEL Risk Item"; Boolean)
        {
            Caption = 'Risk Item';
            DataClassification = CustomerContent;
        }
        field(50009; "DEL Code motif de suivi"; Integer)
        {
            TableRelation = "DEL Liste des motifs".No;
            DataClassification = CustomerContent;
        }
        field(50019; "DEL Date de creation"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50020; "DEL Packaging Language FR"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50021; "DEL Packaging Language IT"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50022; "DEL Packaging Language ES"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50023; "DEL Packaging Language NL"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50024; "DEL Packaging Language PT"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50025; "DEL Packaging Language PL"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50026; "DEL Packaging Language HG"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50027; "DEL Packaging Language RO"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50028; "DEL Packaging Language RU"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50029; "DEL OLD marque"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50030; "DEL Marque"; Text[30])
        {
            TableRelation = Manufacturer.Code;
            DataClassification = CustomerContent;
        }
        field(50031; "DEL Carac. complementaire"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50032; "DEL Date prochaine commande"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50033; "DEL Panier type"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50034; "DEL Est. next delivery date"; Date)
        {
            Caption = 'Estimated next delivery date';
            DataClassification = CustomerContent;
        }
        field(50035; "DEL Remaining days"; Integer)
        {
            Caption = 'Remaining days';
            DataClassification = CustomerContent;
        }
        field(50040; "DEL Ampoules: Type"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50041; "DEL Ampoules: Volt"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50042; "DEL Ampoules: Puissance"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50043; "DEL Ampoules: E-mark"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50050; "DEL Couleur1"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50060; "DEL BEG: Taille en cm"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50061; "DEL BEG: Taille en pouce"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50062; "DEL BEG: Materiau balai"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50063; "DEL BEG: Ep. mat balai en mm"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50064; "DEL BEG: Materiau lame"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50070; "DEL Carac. technique 1"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50071; "DEL Carac. technique 2"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50072; "DEL Carac. technique 3"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50080; "DEL Couleur2"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50081; "DEL Affectation vehicule"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50082; "DEL Normes et qualite"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50083; "DEL Date de peremption"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50084; "DEL Code nomenc. douaniere"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50085; "DEL Droit de douane reduit"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50090; "DEL Images"; Integer)
        {
            FieldClass = FlowField;
            //TODO  // CalcFormula = Count("DEL Texte Regulation" WHERE("Attached to Line No." = FIELD("No.")));

            Editable = false;

        }
        field(50091; "DEL Qtés en com panier WEB"; Decimal)
        {
            CalcFormula = Sum("DEL Web_Order_Line".Qty WHERE(Item = FIELD("No."),
                                                        OrderCreated = CONST(false)));
            DecimalPlaces = 0 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50092; "DEL Qty. optimale"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Price"."DEL Qty. optimale" WHERE("Item No." = FIELD("No."),
                                            "Starting Date" = FIELD("DEL Date Filter Startdate"),
                                            "Ending Date" = FIELD("DEL Date Filter Enddate")));
            Editable = false;

            TableRelation = "Purchase Price"."Vendor No." WHERE("Item No." = FIELD("No."));
        }
        field(50094; "DEL Date Filter Startdate"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50095; "DEL Date Filter Enddate"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50096; "DEL Segment Code"; Code[20])
        {
            FieldClass = FlowField;
            //    CalcFormula = Lookup("DEL Product Group"."Code Segment" 
            //     WHERE ("Item Category Code"=FIELD("DEL Item Category Code"),
            //             Code=FIELD("Product Group Code"))); TODO: product grp
            Caption = 'Segment Code';
            Editable = false;

        }
        field(50100; "DEL Show item as new until"; Date)
        {
            Caption = 'Date affichage article nouveautés';
            DataClassification = CustomerContent;
        }
        field(50101; "DEL WEB Sale blocked"; Text[30])
        {
            Caption = 'WEB Sale blocked';
            DataClassification = CustomerContent;
        }
        field(60001; "DEL Item Category Label"; Text[50])
        {
            CalcFormula = Lookup("Item Category".Description WHERE(Code = FIELD("Item Category Code")));
            Caption = 'Item Category Description';

            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category".Description WHERE(Code = FIELD("Item Category Code"));
        }
        field(60002; "DEL Product Group Label"; Text[50])
        {
            //TODO:Product group is no longer here
            // CalcFormula = Lookup("Product Group".Description 
            // WHERE(Code = FIELD("Product Group Code"),
            // "Item Category Code" = FIELD("Item Category Code")));
            Caption = 'Product Group Description';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60003; "DEL Risque Securitaire"; Enum "DEL Risque Quality")
        {
            //TODO CalcFormula = Lookup("DEL Regulation Matrix"."Risque Quality"
            //  WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                         // "Product Group Code"=FIELD("Product Group Code"),
            //                         // Mark=FIELD("Marque Produit"),
            //                         "Product Description"=FIELD("Product Description")));
            Caption = 'Security Level Of Risk';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60005; "DEL NGTS Quality Expert"; Enum "DEL NGTS Quality Expert")

        {
            FieldClass = FlowField;
            //TODO:Product group is no longer here
            // CalcFormula = Lookup("DEL Regulation Matrix"."NGTS Quality Expert"
            //  WHERE("Item Category Code" = FIELD("Item Category Code"),
            //                  "Product Group Code" = FIELD("Product Group Code"),
            //                  Mark = FIELD("Marque Produi"t),
            //              "Product Description"=FIELD("Product Description")));
            Caption = 'NGTS Quality Expert';

            Editable = false;
        }
        field(60006; "DEL Regl. Generale"; Boolean)
        {
            FieldClass = FlowField;
            //TODO: CalcFormula = Lookup("DEL Regulation Matrix"."Regl. Generale" 
            // WHERE ("Item Category Code"=FIELD("Item Category Code"),

            //        "DEL Mark"=FIELD("Marque Produit"),
            //        "Product Description"=FIELD("Product Description")));
            Caption = 'General Product Regulation';

            Editable = false;

        }
        field(60007; "DEL Regl. Matiere"; Boolean)
        {
            //TODO CalcFormula = Lookup("Regulation Matrix"."Regl. Matiere" WHERE (Item Category Code=FIELD(Item Category Code),
            //  Product Group Code=FIELD(Product Group Code),
            //   Mark=FIELD(Marque Produit),
            //          Product Description=FIELD(Product Description)));
            Caption = 'Subtance Regulation';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60008; "DEL Checklist by item"; Integer)
        {
            //TODO CalcFormula = Count("Regulation Matrix Line" WHERE (Item Category Code=FIELD(Item Category Code),
            //                                                     Product Group Code=FIELD(Product Group Code),
            //                                                     Product Description=FIELD(Product Description),
            //                                                     Mark=FIELD(Marque Produit),
            //                                                     Type=FIELD(Regl. Type Filter),
            //                                                     No.=FIELD(Regl. No. Filter)));
            Caption = 'Checklist by item';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60010; "DEL Marque Produit"; Enum "DEL Mark")
        {
            Caption = 'Brand Type';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin


                CALCFIELDS("DEL Risque Securitaire", "DEL NGTS Quality Expert", "DEL Regl. Generale",
                "DEL Regl. Matiere", "DEL Nombre Regl. Generale",
                "DEL Nombre Regl. Matiere", "DEL Regl. Plan Control", "DEL Nbre Regl. Plan control");
                IF "DEL Marque Produit" <> xRec."DEL Marque Produit" THEN
                    VALIDATE("DEL Product Description", '');
            end;
        }
        field(60014; "DEL Nombre Regl. Generale"; Integer)
        { //TODO
            // CalcFormula = Count("DEL Regulation Matrix Line" WHERE("Item Category Code" = FIELD("Item Category Code"),
            //                                                    "Product Group Code" = FIELD("Product Group Code"),
            //                                                     Type = FILTER("General product"),
            //                                                     Mark = FIELD("Marque Produit"),
            //                                                     "Product Description" = FIELD("Product Description")));
            Caption = 'General Product Regulation';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60015; "DEL Nombre Regl. Matiere"; Integer)
        { //TODO
            // CalcFormula = Count("DEL Regulation Matrix Line" WHERE("Item Category Code="FIELD("Item Category Code"),
            //                                                     "Product Group Code" = FIELD("Product Group Code"),
            //                                                     Type = FILTER(Materials),
            //                                                     Mark = FIELD("Marque Produit"),
            //                                                     "Product Description" = FIELD("Product Description")));
            Caption = 'Substance regulation';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60016; "DEL Regl. Type Filter"; Enum "DEL Product Type")
        {
            Caption = 'Regl. Type Filter';
            FieldClass = FlowFilter;

        }
        field(60017; "DEL Regl. No. Filter"; Code[20])
        {
            Caption = 'Filtre N° réglementation';
            FieldClass = FlowFilter;
            TableRelation = "DEL Regulation Matrix Line"."No.";
        }
        field(60025; "DEL Blocking Quality"; Boolean)
        {
            Caption = 'Blocking Quality';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

                IF "DEL Blocking Quality" THEN BEGIN

                    TESTFIELD("DEL Dispensation", FALSE);

                    Blocked := TRUE;

                END
                ELSE
                    Blocked := FALSE;

                "DEL Nom utilisateur" := USERID;
                "DEL Date Of Update" := WORKDATE();

            end;
        }
        field(60026; "DEL Nom utilisateur"; Code[50])
        {
            Caption = 'Validator User';
            DataClassification = CustomerContent;
        }
        field(60027; "DEL Date Of Update"; Date)
        {
            Caption = 'Date Of Update';
            DataClassification = CustomerContent;
        }
        field(60028; "DEL Dispensation"; Boolean)
        {
            Caption = 'Dispensation';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin



                IF "DEL Dispensation" THEN
                    TESTFIELD("DEL Blocking Quality", FALSE);

                "DEL Nom utlisateur 2" := USERID;
                "DEL Date Of Update 2" := WORKDATE();

            end;
        }
        field(60029; "DEL Nom utlisateur 2"; Code[50])
        {
            Caption = 'User Name Making The Last Update';
            DataClassification = CustomerContent;
        }
        field(60030; "DEL Date Of Update 2"; Date)
        {
            Caption = 'Date Of Update';
            DataClassification = CustomerContent;
        }
        field(60031; "DEL Regl. Plan Control"; Boolean)
        {
            //TODO CalcFormula = Lookup("Regulation Matrix"."Plan of control" WHERE(Item Category Code=FIELD(Item Category Code),
            //                                                                   Product Group Code=FIELD(Product Group Code),
            //                                                                   Mark=FIELD(Marque Produit),
            //                                                                   Product Description=FIELD(Product Description)));
            Caption = 'Plan of control Regulation';

            Editable = false;
            FieldClass = FlowField;
        }
        field(60032; "DEL Product Description"; Text[100])
        {
            Caption = 'Description produit';
            DataClassification = CustomerContent;
            //TODO/ 'Product Group Code' is removed.
            // TableRelation = "DEL Regulation Matrix"."Product Description" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                                  "Product Group Code"=FIELD("Product Group Code"),
            //                                                                  Mark=FIELD("Marque Produit"));

            trigger OnValidate()
            begin
                CALCFIELDS("DEL Risque Securitaire", "DEL NGTS Quality Expert", "DEL Regl. Generale", "DEL Regl. Matiere",
                "DEL Nombre Regl. Generale", "DEL Nombre Regl. Matiere", "DEL Regl. Plan Control", "DEL Nbre Regl. Plan control");
            end;
        }
        field(60033; "DEL Nbre Regl. Plan control"; Integer)
        {
            FieldClass = FlowField;
            // TODO: 'Product Group Code' is removed.
            //CalcFormula = Count("DEL Regulation Matrix Line" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                     "Product Group Code"=FIELD("Product Group Code"),
            //                                                     Type=FILTER("Plan of control"),
            //                                                     Mark=FIELD("Marque Produit"),
            //                                                     "Product Description"=FIELD("Product Description")));
            Caption = 'Plan of control regulation';

            Editable = false;

        }
        field(60034; "DEL Marking in the product FR"; Boolean)
        {// TODO:'Product Group Code' is removed.
            // CalcFormula = Exist("DEL Regulation Matrix Text" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                     "Product Group Code"=FIELD("Product Group Code"),
            //                                                     "Product Description"=FIELD("Product Description"),
            //                                                     Mark=FIELD("Marque Produit"),
            //                                                     Type=FILTER("Marking in the product FR")));
            Caption = 'Marking in the product (warning) + Pictogram type in French';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60035; "DEL Marking in the pack FR"; Boolean)
        {//TODO:'Product Group Code' is removed.
            // CalcFormula = Exist("DEL Regulation Matrix Text" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                     "Product Group Code"=FIELD("Product Group Code"),
            //                                                     "Product Description"=FIELD("Product Description"),
            //                                                     Mark=FIELD("Marque Produit"),
            //                                                     Type=FILTER("Marking in the pack FR")));
            Caption = 'Marking in the pack (warning + Pictogram) in French';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60036; "DEL Marking in the product ENU"; Boolean)
        {  //TODO:'Product Group Code' is removed.
            // CalcFormula = Exist("DEL Regulation Matrix Text" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                     "Product Group Code"=FIELD("Product Group Code"),
            //                                                     "Product Description"=FIELD("Product Description"),
            //                                                     Mark=FIELD("Marque Produit"),
            //                                                     Type=FILTER("Marking in the product ENU")));
            Caption = 'Marking in the product (warning) + Pictogram type in English';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60037; "DEL Marking in the pack ENU"; Boolean)
        { //TODO:'Product Group Code' is removed.
            // CalcFormula = Exist("Regulation Matrix Text" WHERE (Item Category Code=FIELD(Item Category Code),
            //                                                     Product Group Code=FIELD(Product Group Code),
            //                                                     Product Description=FIELD(Product Description),
            //                                                     Mark=FIELD(Marque Produit),
            //                                                     Type=FILTER(Marking in the pack ENU)));
            Caption = 'Marking in the pack (warning + Pictogram) in English';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60038; "DEL Manuel instruction"; Enum "DEL Manuel instruction")
        { //TODO
            // CalcFormula = Lookup("DEL Regulation Matrix"."Manuel instruction" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                                      "Product Group Code"=FIELD("Product Group Code"),
            //                                                                      Mark=FIELD("Marque Produit"),
            //                                                                      "Product Description"=FIELD("Product Description")));
            Editable = false;
            FieldClass = FlowField;

        }
        field(60039; "DEL Warning"; Boolean)
        {
            FieldClass = FlowField;
            //TODO:'Product Group Code' is removed.
            // CalcFormula = Exist("DEL Regulation Matrix Text" WHERE ("Item Category Code"=FIELD("Item Category Code"),
            //                                                     "Product Group Code"=FIELD("Product Group Code"),
            //                                                     "Product Description"=FIELD("Product Description"),
            //                                                     Mark=FIELD("Marque Produit"),
            //                                                     Type=FILTER("Warning in French")));
            Editable = false;

        }
        field(91032; "DEL Length.old"; Decimal)
        {
            BlankZero = true;
            Caption = 'Length';

            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(91034; "DEL Width.old"; Decimal)
        {
            BlankZero = true;
            Caption = 'Width';

            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(91036; "DEL Depth.old"; Decimal)
        {
            BlankZero = true;
            Caption = 'Depth';

            MinValue = 0;
            DataClassification = CustomerContent;
        }

    }
    keys
    {//TODO
        // key(Key1;Standardartikelgruppe)
        // {
        // }
        // key(Key2;"Checklistennr.")
        // {
        // }
    }

    //TODO

    // procedure ModifSegment(var ProductCode: Code[20]; var CategCode: Code[20])
    // var
    //     // //TODO ProductGroup_Rec: Record "Product Group";
    //     DefaultDimension_Rec: Record "Default Dimension";
    //     ItemCategory_Rec: Record "Item Category";
    // begin
    //     //MIG2017
    //     IF ProductGroup_Rec.GET(CategCode, ProductCode) THEN BEGIN
    //         IF DefaultDimension_Rec.GET(27, "No.", 'Segment') THEN BEGIN
    //             IF DefaultDimension_Rec."Dimension Value Code" <> ProductGroup_Rec."Code Segment" THEN BEGIN
    //                 DefaultDimension_Rec.VALIDATE("Dimension Value Code", ProductGroup_Rec."Code Segment");
    //                 DefaultDimension_Rec.MODIFY;
    //             END;
    //         END
    //         ELSE BEGIN
    //             DefaultDimension_Rec.INIT;
    //             DefaultDimension_Rec.VALIDATE("Table ID", 27);
    //             DefaultDimension_Rec.VALIDATE("No.", "No.");
    //             DefaultDimension_Rec.VALIDATE("Dimension Code", 'Segment');
    //             DefaultDimension_Rec.VALIDATE("Dimension Value Code", ProductGroup_Rec."Code Segment");
    //             DefaultDimension_Rec.INSERT;
    //         END;
    //     END;
    //     //END MIG2017
    // end;

    procedure ModifCategory(var CategCode: Code[20])
    var
        DefaultDimension_Rec: Record "Default Dimension";
    begin

        IF DefaultDimension_Rec.GET(27, "No.", 'Categorie') THEN BEGIN
            IF DefaultDimension_Rec."Dimension Value Code" <> CategCode THEN BEGIN
                DefaultDimension_Rec.VALIDATE("Dimension Value Code", CategCode);
                DefaultDimension_Rec.MODIFY();
            END;
        END

        ELSE BEGIN

            DefaultDimension_Rec.INIT();
            DefaultDimension_Rec.VALIDATE("Table ID", 27);
            DefaultDimension_Rec.VALIDATE("No.", "No.");
            DefaultDimension_Rec.VALIDATE("Dimension Code", 'Categorie');
            DefaultDimension_Rec.VALIDATE("Dimension Value Code", CategCode);
            DefaultDimension_Rec.INSERT();

        END;

    end;

    procedure GetVolCBM(Update: Boolean): Decimal
    begin

        IF ("DEL Vol cbm" = 0) AND ("DEL PCB" <> 0) THEN BEGIN
            "DEL Vol cbm" := ROUND(("DEL Vol cbm carton transport" / "DEL PCB"), 0.00001, '>');
            IF Update THEN
                MODIFY();
        END;
        EXIT("DEL Vol cbm")

    end;
}

