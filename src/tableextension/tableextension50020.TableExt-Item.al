tableextension 50020 tableextension50020 extends Item
{
    // 
    // AL.KVK6.0
    // 19.05.16/AL/MK  - Felder gemäss Kennzeichnung
    // 
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 14.10.13                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     USER    Date       Description
    // ---------------------------------------------------------------------------------
    // T-00594            THM   14.10.13    Desactivate TESTFIELD("Replenishment System","Replenishment System"::None);
    // T-00712            SAZ   23.07.15    Function ModifSegment (modify segment code Onvalidate product code)
    //                                      Add field "Segment Code"
    //                    SAZ   23.07.15    Erreur pour code segment manquant
    // T-00716            THM   20.08.15    add field 60000..60030
    // T-00716            THM   24.08.15    add Userid + Date mise à jour
    // T-00716            THM   27.08.15    add CaptionML field 60000..60030
    // T-00716            THM   07.09.15    add Livrables
    // T-00716_1          THM   09.09.15    Add TESTFIELD
    // T-00716_2          THM   14.09.15    add Bloked:=true
    // T-00716_3          THM   23.09.15    Modify CaptionML
    // T-00716_4          THM   29.09.15    change CaptionML
    // T-00746            JUH   10.11.15    Affectation automatique catégorie article
    // T-00747            THM   17.11.15    Comment Code in Dispensation - OnValidate()
    // T-00747            THM   17.11.15    change Caption and name field 60028 and 60025
    // T-00747            THM   19.11.15    add bloqued=false
    // T-00757            THM   07.01.16    add and modify Field
    // T-00758            THM   12.01.16    Modifier length field "Product Description" 20 To 40
    // T-00771            THM   16.02.16    InitValue=YES  field "No Stockkeeping"
    // T-00783            THM   29.04.16    Add Fields
    //                    THM   27.06.16    add OptionString field Marque Produit
    //                    THM   27.06.16    "Product Description" 50 -->100
    //                    THM   27.06.16     "NGTS Quality Expert" ED-->EV
    //                    THM   26.08.16     add ,All Marks
    // THM220817          THM   23.08.17     Ajout l'affactation automatique de groupe article standard
    //                    THM   08.09.17     MIG2017
    // THM030418          THM   03.04.18    Desable create Item
    // RiskItem                 18.06.18    Add Filed 50008
    // SAZ                      17.09.18  Add filed "Code motif de suivi"
    // 
    // Mgts10.00.03.00 | 08.04.2020 | JSON Business Logic Mgt : Item
    // 
    // DELSupport | 16|06|2020 | Fixe segment dimension updating
    // 
    // Mgts10.00.05.00      04.01.2022 : Add Functions : GetSalesPrices
    fields
    {

        //Unsupported feature: Property Insertion (InitValue) on ""No Stockkeeping"(Field 11500)".



        //Unsupported feature: Code Modification on ""Item Category Code"(Field 5702).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemAttributeManagement.InheritAttributesFromItemCategory(Rec,"Item Category Code",xRec."Item Category Code");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        //MIG2017
         //START T-00746
         TESTFIELD("Item Category Code");
         //IF "Item Category Code" <> '' THEN
            ModifCategory("Item Category Code");
         //END T-00746
         //MIG2017 END
        ItemAttributeManagement.InheritAttributesFromItemCategory(Rec,"Item Category Code",xRec."Item Category Code");
        */
        //end;


        //Unsupported feature: Code Insertion on ""Product Group Code"(Field 5704)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //var
        //ProductGroup_Rec: Record "5723";
        //begin
        /*
        //MIG2017
         //T-00712
         IF ProductGroup_Rec.GET("Item Category Code","Product Group Code") THEN
            IF ProductGroup_Rec."Code Segment" = '' THEN ERROR(Text0027,"Product Group Code");
         //END T-00712

         //START THM220817
         IF Rec."Product Group Code"<> '' THEN
         BEGIN
           RecMatriseGroupArtGroup.RESET;
           RecMatriseGroupArtGroup.SETRANGE(RecMatriseGroupArtGroup."Product Group Code",Rec."Product Group Code");
           IF RecMatriseGroupArtGroup.FINDFIRST THEN
           BEGIN
            IF RecMatriseGroupArtGroup.COUNT=1 THEN
              Standardartikelgruppe:=RecMatriseGroupArtGroup."Standard Item Group Code"
              ELSE
              BEGIN
                CLEAR(PageMatriseGroupArtGroup);
                PageMatriseGroupArtGroup.SETTABLEVIEW(RecMatriseGroupArtGroup);
                PageMatriseGroupArtGroup.LOOKUPMODE:=TRUE;
                //PageMatriseGroupArtGroup.EDITABLE(FALSE);
                PageMatriseGroupArtGroup.SETRECORD(RecMatriseGroupArtGroup);
                IF PageMatriseGroupArtGroup.RUNMODAL=ACTION::LookupOK THEN
                BEGIN
                  PageMatriseGroupArtGroup.GETRECORD(RecMatriseGroupArtGroup);
                  Standardartikelgruppe:=RecMatriseGroupArtGroup."Standard Item Group Code";
                END;
              END;
           END
            ELSE
              Standardartikelgruppe:='';
         END
         ELSE
         BEGIN
           Standardartikelgruppe:='';
         END;
         //END THM220817
         //MIG2017 END

        //>>DELSupport
        ModifSegment("Product Group Code","Item Category Code");
        //<<DELSupport
        */
        //end;


        //Unsupported feature: Code Modification on ""No Stockkeeping"(Field 11500).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TESTFIELD("Cost is Adjusted",TRUE);
        ItemStock.GET("No.");
        ItemStock.CALCFIELDS(Inventory,"Net Invoiced Qty.","Assembly BOM");
        IF (ItemStock.Inventory <> 0) OR (ItemStock."Net Invoiced Qty." <> 0) THEN
          ERROR(Text92000,ItemStock.FIELDCAPTION(Inventory),ItemStock.FIELDCAPTION("Net Invoiced Qty."));
        IF "No Stockkeeping" THEN BEGIN
          TESTFIELD("Assembly BOM",FALSE);
          TESTFIELD("Replenishment System","Replenishment System"::None);
        END;

        SalesLine.SETRANGE(Type,SalesLine.Type::Item);
        #12..47

        IF "No Stockkeeping" THEN
          MESSAGE(Text92005);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..7
          //START MIG2017
          // begin THM desactivate control Replenishment System
          //TESTFIELD("Replenishment System","Replenishment System"::None);
          //END MIG2017
        #9..50
        */
        //end;
        field(50000; "Weight net"; Decimal)
        {
        }
        field(50001; "Weight brut"; Decimal)
        {
        }
        field(50002; "Code EAN 13"; Code[13])
        {
        }
        field(50003; "Vol cbm"; Decimal)
        {
        }
        field(50004; "Vol cbm carton transport"; Decimal)
        {

            trigger OnValidate()
            begin
                //>>Mgts10.00.05.00
                IF (PCB = 0) THEN
                    "Vol cbm" := 0
                ELSE
                    "Vol cbm" := ROUND(("Vol cbm carton transport" / PCB), 0.00001, '>');
                //<<Mgts10.00.05.00
            end;
        }
        field(50005; PCB; Integer)
        {

            trigger OnValidate()
            begin
                //>>Mgts10.00.05.00
                IF (PCB = 0) THEN
                    "Vol cbm" := 0
                ELSE
                    "Vol cbm" := ROUND(("Vol cbm carton transport" / PCB), 0.00001, '>');
                //<<Mgts10.00.05.00
            end;
        }
        field(50006; SPCB; Integer)
        {
        }
        field(50007; "Certified by QS"; Boolean)
        {
            Caption = 'Qualität geprüft';
        }
        field(50008; "Risk Item"; Boolean)
        {
            Caption = 'Risk Item';
        }
        field(50009; "Code motif de suivi"; Integer)
        {
            TableRelation = "Liste des motifs".No;
        }
        field(50019; "Date de creation"; Date)
        {
        }
        field(50020; "Packaging Language FR"; Boolean)
        {
        }
        field(50021; "Packaging Language IT"; Boolean)
        {
        }
        field(50022; "Packaging Language ES"; Boolean)
        {
        }
        field(50023; "Packaging Language NL"; Boolean)
        {
        }
        field(50024; "Packaging Language PT"; Boolean)
        {
        }
        field(50025; "Packaging Language PL"; Boolean)
        {
        }
        field(50026; "Packaging Language HG"; Boolean)
        {
        }
        field(50027; "Packaging Language RO"; Boolean)
        {
        }
        field(50028; "Packaging Language RU"; Boolean)
        {
        }
        field(50029; "OLD marque"; Text[30])
        {
        }
        field(50030; Marque; Text[30])
        {
            TableRelation = Manufacturer.Code;
        }
        field(50031; "Caracteristique complementaire"; Text[30])
        {
        }
        field(50032; "Date prochaine commande"; Date)
        {

            trigger OnValidate()
            begin

                // NTO 2 -
                /*
                IF FORMAT("Lead Time Calculation") <> '' THEN BEGIN
                  "Estimated next delivery date" := CALCDATE("Lead Time Calculation", "Date prochaine commande");
                  Rec.MODIFY();
                END;
                */
                // NTO 2 +

            end;
        }
        field(50033; "Panier type"; Boolean)
        {
            Description = 'T-00551-WEBSHOP';
        }
        field(50034; "Estimated next delivery date"; Date)
        {
            Caption = 'Estimated next delivery date';
            Description = 'T-00551-WEBSHOP';
        }
        field(50035; "Remaining days"; Integer)
        {
            Caption = 'Remaining days';
            Description = 'T-00551-WEBSHOP';
        }
        field(50040; "Ampoules: Type"; Text[30])
        {
        }
        field(50041; "Ampoules: Volt"; Text[30])
        {
        }
        field(50042; "Ampoules: Puissance"; Text[30])
        {
        }
        field(50043; "Ampoules: E-mark"; Boolean)
        {
        }
        field(50050; Couleur1; Text[30])
        {
        }
        field(50060; "BEG: Taille en cm"; Decimal)
        {
        }
        field(50061; "BEG: Taille en pouce"; Decimal)
        {
        }
        field(50062; "BEG: Materiau balai"; Text[30])
        {
        }
        field(50063; "BEG: Epaisseur mat balai en mm"; Text[30])
        {
        }
        field(50064; "BEG: Materiau lame"; Text[30])
        {
        }
        field(50070; "Caracteristique technique 1"; Text[30])
        {
        }
        field(50071; "Caracteristique technique 2"; Text[30])
        {
        }
        field(50072; "Caracteristique technique 3"; Text[30])
        {
        }
        field(50080; Couleur2; Text[30])
        {
        }
        field(50081; "Affectation vehicule"; Text[30])
        {
        }
        field(50082; "Normes et qualite"; Text[30])
        {
        }
        field(50083; "Date de peremption"; Date)
        {
        }
        field(50084; "Code nomenclature douaniere"; Text[30])
        {
        }
        field(50085; "Droit de douane reduit"; Decimal)
        {
        }
        field(50090; Images; Integer)
        {
            CalcFormula = Count ("Texte Regulation" WHERE (Attached to Line No.=FIELD(No.)));
            Description = 'Temp400';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50091;"Qtés en commande panier WEB";Decimal)
        {
            CalcFormula = Sum(Web_Order_Line.Qty WHERE (Item=FIELD(No.),
                                                        OrderCreated=CONST(No)));
            DecimalPlaces = 0:2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50092;"Qty. optimale";Decimal)
        {
            CalcFormula = Sum("Purchase Price"."Qty. optimale" WHERE (Item No.=FIELD(No.),
                                                                      Starting Date=FIELD(Date Filter Startdate),
                                                                      Ending Date=FIELD(Date Filter Enddate)));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Purchase Price"."Vendor No." WHERE (Item No.=FIELD(No.));
        }
        field(50094;"Date Filter Startdate";Date)
        {
            FieldClass = FlowFilter;
        }
        field(50095;"Date Filter Enddate";Date)
        {
            FieldClass = FlowFilter;
        }
        field(50096;"Segment Code";Code[20])
        {
            CalcFormula = Lookup("Product Group"."Code Segment" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                       Code=FIELD(Product Group Code)));
            Caption = 'Segment Code';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50100;"Show item as new until";Date)
        {
            Caption = 'Date affichage article nouveautés';
        }
        field(50101;"WEB Sale blocked";Text[30])
        {
            Caption = 'WEB Sale blocked';
        }
        field(60001;"Item Category Label";Text[50])
        {
            CalcFormula = Lookup("Item Category".Description WHERE (Code=FIELD(Item Category Code)));
            Caption = 'Item Category Description';
            Description = 'T-00716';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Category".Description WHERE (Code=FIELD(Item Category Code));
        }
        field(60002;"Product Group Label";Text[50])
        {
            CalcFormula = Lookup("Product Group".Description WHERE (Code=FIELD(Product Group Code),
                                                                    Item Category Code=FIELD(Item Category Code)));
            Caption = 'Product Group Description';
            Description = 'T-00716';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60003;"Risque Securitaire";Option)
        {
            CalcFormula = Lookup("Regulation Matrix"."Risque Quality" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                             Product Group Code=FIELD(Product Group Code),
                                                                             Mark=FIELD(Marque Produit),
                                                                             Product Description=FIELD(Product Description)));
            Caption = 'Security Level Of Risk';
            Description = 'T-00716';
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = " ","0","1","2","3",NC,NA,"?";
        }
        field(60005;"NGTS Quality Expert";Option)
        {
            CalcFormula = Lookup("Regulation Matrix"."NGTS Quality Expert" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                                  Product Group Code=FIELD(Product Group Code),
                                                                                  Mark=FIELD(Marque Produit),
                                                                                  Product Description=FIELD(Product Description)));
            Caption = 'NGTS Quality Expert';
            Description = 'T-00716';
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = " ",JPD,FC,SM,EV,"à definir ";
        }
        field(60006;"Regl. Generale";Boolean)
        {
            CalcFormula = Lookup("Regulation Matrix"."Regl. Generale" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                             Product Group Code=FIELD(Product Group Code),
                                                                             Mark=FIELD(Marque Produit),
                                                                             Product Description=FIELD(Product Description)));
            Caption = 'General Product Regulation';
            Description = 'T-00716';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60007;"Regl. Matiere";Boolean)
        {
            CalcFormula = Lookup("Regulation Matrix"."Regl. Matiere" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                            Product Group Code=FIELD(Product Group Code),
                                                                            Mark=FIELD(Marque Produit),
                                                                            Product Description=FIELD(Product Description)));
            Caption = 'Subtance Regulation';
            Description = 'T-00716';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60008;"Checklist by item";Integer)
        {
            CalcFormula = Count("Regulation Matrix Line" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Product Description=FIELD(Product Description),
                                                                Mark=FIELD(Marque Produit),
                                                                Type=FIELD(Regl. Type Filter),
                                                                No.=FIELD(Regl. No. Filter)));
            Caption = 'Checklist by item';
            Description = 'T-00716';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60010;"Marque Produit";Option)
        {
            Caption = 'Brand Type';
            Description = 'T-00716';
            OptionCaption = ' ,Own brand,Supplier brand,Licence,No Name,Premium Brand,NC,NA,?,All Marks';
            OptionMembers = " ",MDD,"Marque Fournisseur",Licence,"Sans Marque","Marque Prestige",NC,NA,"?","All Marks";

            trigger OnValidate()
            begin
                CALCFIELDS("Risque Securitaire","NGTS Quality Expert","Regl. Generale","Regl. Matiere","Nombre Regl. Generale","Nombre Regl. Matiere","Regl. Plan Control","Nbre Regl. Plan control");
                IF "Marque Produit"<> xRec."Marque Produit" THEN
                VALIDATE("Product Description",'');
            end;
        }
        field(60014;"Nombre Regl. Generale";Integer)
        {
            CalcFormula = Count("Regulation Matrix Line" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Type=FILTER(General product),
                                                                Mark=FIELD(Marque Produit),
                                                                Product Description=FIELD(Product Description)));
            Caption = 'General Product Regulation';
            Description = 'T-00716';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60015;"Nombre Regl. Matiere";Integer)
        {
            CalcFormula = Count("Regulation Matrix Line" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Type=FILTER(Materials),
                                                                Mark=FIELD(Marque Produit),
                                                                Product Description=FIELD(Product Description)));
            Caption = 'Substance regulation';
            Description = 'T-00716';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60016;"Regl. Type Filter";Option)
        {
            Caption = 'Regl. Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,General product,Materials,Plan of control';
            OptionMembers = " ","General product",Materials,"Plan of control";
        }
        field(60017;"Regl. No. Filter";Code[20])
        {
            Caption = 'Filtre N° réglementation';
            FieldClass = FlowFilter;
            TableRelation = "Regulation Matrix Line".No.;
        }
        field(60025;"Blocking Quality";Boolean)
        {
            Caption = 'Blocking Quality';
            Description = 'T-00716';

            trigger OnValidate()
            begin
                //START T-00716_1
                IF "Blocking Quality"  THEN
                BEGIN
                TESTFIELD(Dispensation,FALSE);
                //T-00716_2
                Blocked:=TRUE;
                //T-00716_2
                END
                ELSE
                //START T-00747
                Blocked:=FALSE;
                //STOP T-00747
                //START T-00716_1
                //START T-00716
                "Nom utilisateur":=USERID;
                "Date Of Update":=WORKDATE
                //STOP T-00716
            end;
        }
        field(60026;"Nom utilisateur";Code[50])
        {
            Caption = 'Validator User';
            Description = 'T-00716';
        }
        field(60027;"Date Of Update";Date)
        {
            Caption = 'Date Of Update';
            Description = 'T-00716';
        }
        field(60028;Dispensation;Boolean)
        {
            Caption = 'Dispensation';
            Description = 'T-00716';

            trigger OnValidate()
            begin
                //START T-00716_1


                IF Dispensation THEN
                BEGIN
                //T-00716_2
                //START T-00747
                //Blocked:=FALSE;
                //STOP T-00747
                //T-00716_2
                TESTFIELD("Blocking Quality",FALSE);
                END;


                //START T-00716_1
                //START T-00716
                "Nom utlisateur 2":=USERID;
                "Date Of Update 2":=WORKDATE
                //STOP T-00716
            end;
        }
        field(60029;"Nom utlisateur 2";Code[50])
        {
            Caption = 'User Name Making The Last Update';
            Description = 'T-00716';
        }
        field(60030;"Date Of Update 2";Date)
        {
            Caption = 'Date Of Update';
            Description = 'T-00716';
        }
        field(60031;"Regl. Plan Control";Boolean)
        {
            CalcFormula = Lookup("Regulation Matrix"."Plan of control" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                              Product Group Code=FIELD(Product Group Code),
                                                                              Mark=FIELD(Marque Produit),
                                                                              Product Description=FIELD(Product Description)));
            Caption = 'Plan of control Regulation';
            Description = 'T-00716';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60032;"Product Description";Text[100])
        {
            Caption = 'Description produit';
            TableRelation = "Regulation Matrix"."Product Description" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                             Product Group Code=FIELD(Product Group Code),
                                                                             Mark=FIELD(Marque Produit));

            trigger OnValidate()
            begin
                CALCFIELDS("Risque Securitaire","NGTS Quality Expert","Regl. Generale","Regl. Matiere","Nombre Regl. Generale","Nombre Regl. Matiere","Regl. Plan Control","Nbre Regl. Plan control");
            end;
        }
        field(60033;"Nbre Regl. Plan control";Integer)
        {
            CalcFormula = Count("Regulation Matrix Line" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Type=FILTER(Plan of control),
                                                                Mark=FIELD(Marque Produit),
                                                                Product Description=FIELD(Product Description)));
            Caption = 'Plan of control regulation';
            Description = 'T-00716';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60034;"Marking in the product FR";Boolean)
        {
            CalcFormula = Exist("Regulation Matrix Text" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Product Description=FIELD(Product Description),
                                                                Mark=FIELD(Marque Produit),
                                                                Type=FILTER(Marking in the product FR)));
            Caption = 'Marking in the product (warning) + Pictogram type in French';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60035;"Marking in the pack FR";Boolean)
        {
            CalcFormula = Exist("Regulation Matrix Text" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Product Description=FIELD(Product Description),
                                                                Mark=FIELD(Marque Produit),
                                                                Type=FILTER(Marking in the pack FR)));
            Caption = 'Marking in the pack (warning + Pictogram) in French';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60036;"Marking in the product ENU";Boolean)
        {
            CalcFormula = Exist("Regulation Matrix Text" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Product Description=FIELD(Product Description),
                                                                Mark=FIELD(Marque Produit),
                                                                Type=FILTER(Marking in the product ENU)));
            Caption = 'Marking in the product (warning) + Pictogram type in English';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60037;"Marking in the pack ENU";Boolean)
        {
            CalcFormula = Exist("Regulation Matrix Text" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Product Description=FIELD(Product Description),
                                                                Mark=FIELD(Marque Produit),
                                                                Type=FILTER(Marking in the pack ENU)));
            Caption = 'Marking in the pack (warning + Pictogram) in English';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60038;"Manuel instruction";Option)
        {
            CalcFormula = Lookup("Regulation Matrix"."Manuel instruction" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                                 Product Group Code=FIELD(Product Group Code),
                                                                                 Mark=FIELD(Marque Produit),
                                                                                 Product Description=FIELD(Product Description)));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }
        field(60039;Warning;Boolean)
        {
            CalcFormula = Exist("Regulation Matrix Text" WHERE (Item Category Code=FIELD(Item Category Code),
                                                                Product Group Code=FIELD(Product Group Code),
                                                                Product Description=FIELD(Product Description),
                                                                Mark=FIELD(Marque Produit),
                                                                Type=FILTER(Warning in French)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(91032;"Length.old";Decimal)
        {
            BlankZero = true;
            Caption = 'Length';
            Description = 'Old';
            MinValue = 0;
        }
        field(91034;"Width.old";Decimal)
        {
            BlankZero = true;
            Caption = 'Width';
            Description = 'Old';
            MinValue = 0;
        }
        field(91036;"Depth.old";Decimal)
        {
            BlankZero = true;
            Caption = 'Depth';
            Description = 'Old';
            MinValue = 0;
        }
        field(4006496;"EAN Code Katalog";Text[13])
        {
            Caption = 'EAN Catalogue Code';
            Description = 'AL.KVK4.5';
        }
        field(4006497;"EAN Nummernserie Katalog";Code[10])
        {
            Caption = 'Catalogue EAN Number Series';
            Description = 'AL.KVK4.5';
            TableRelation = "No. Series";
        }
        field(4006498;Katalogbezeichnung;Text[80])
        {
            Caption = 'Catalogue Description';
            Description = 'AL.KVK4.5';
        }
        field(4006499;"Katalogbezeichnung 2";Text[80])
        {
            Caption = 'Catalogue Description 2';
            Description = 'AL.KVK4.5';
        }
        field(4006500;Hersteller;Text[50])
        {
            CalcFormula = Lookup(Manufacturer.Name WHERE (Code=FIELD(Manufacturer Code)));
            Caption = 'Manufacturer';
            Description = 'AL.KVK4.5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006501;"Kurztext Katalog";Text[100])
        {
            CalcFormula = Lookup(Katalogkopf.Kurztext WHERE (Code=FIELD(Hauptkatalogcode)));
            Caption = 'Catalogue Short Text';
            Description = 'AL.KVK4.5';
            FieldClass = FlowField;
        }
        field(4006502;Vorlagencode;Code[20])
        {
            Caption = 'Template Code';
            Description = 'AL.KVK4.5';
            TableRelation = Vorlage.Code WHERE (Dokumententyp=CONST(InDesign));
        }
        field(4006503;Standardartikelgruppe;Code[20])
        {
            Caption = 'Standard Item Group';
            Description = 'AL.KVK4.5';
            TableRelation = "Artikelgruppe Katalog";
        }
        field(4006504;Katalogpreis;Decimal)
        {
            Caption = 'Catalogue Price';
            Description = 'AL.KVK4.5';
        }
        field(4006505;"Katalogartikelnr.";Text[30])
        {
            Caption = 'Sub. Item No.';
            Description = 'AL.KVK4.5';
        }
        field(4006506;"MDM Angelegt am";Date)
        {
            Caption = 'Created On';
            Description = 'AL.KVK4.5';
            Editable = false;
        }
        field(4006507;"MDM Angelegt von";Code[30])
        {
            Caption = 'Created By';
            Description = 'AL.KVK4.5';
            Editable = false;
            TableRelation = User;
        }
        field(4006508;"MDM Aktualisiert am";Date)
        {
            Caption = 'Last Date Modified';
            Description = 'AL.KVK4.5';
            Editable = false;
        }
        field(4006509;"MDM Aktualisiert vom";Code[30])
        {
            Caption = 'Modified By';
            Description = 'AL.KVK4.5';
            Editable = false;
            TableRelation = User;
        }
        field(4006510;"Bilddokument ID";Code[20])
        {
            Caption = 'Picture Document ID';
            Description = 'AL.KVK4.5';
            TableRelation = "Dokument Katalog" WHERE (Art=CONST(Bild));

            trigger OnLookup()
            begin
                // --- AL.KVK6.0 --- //
                CLEAR(gfrmDoklisteB);

                // --- Filter setzen --- //
                gfrmDoklisteB.FilterSetzen(goptQuellenart::Artikel,"No.",0);

                gfrmDoklisteB.LOOKUPMODE(TRUE);
                IF gfrmDoklisteB.RUNMODAL = ACTION::LookupOK THEN BEGIN
                  gfrmDoklisteB.GETRECORD(grecKatDok);
                  IF grecKatDok.Nummer <> "Bilddokument ID" THEN
                    VALIDATE("Bilddokument ID",grecKatDok.Nummer);
                END;
                // --- AL.KVK6.0 END --- //
            end;

            trigger OnValidate()
            begin
                // --- AL.KVK6.0 --- //
                IF Rec."Bilddokument ID" <> '' THEN BEGIN
                  // --- Katalogdokument --- //
                  grecKatDok.RESET;
                  grecKatDok.SETRANGE(Quelle,grecKatDok.Quelle::Artikel);
                  grecKatDok.SETRANGE(Art,grecKatDok.Art::Bild);
                  grecKatDok.SETRANGE(Code,"No.");
                  grecKatDok.SETRANGE(Nummer,"Bilddokument ID");
                  IF NOT grecKatDok.FIND('-') THEN
                    ERROR(AL0001,"Bilddokument ID");
                END;
                // --- AL.KVK6.0 END --- //
            end;
        }
        field(4006512;Publikationsgruppe;Code[20])
        {
            Caption = 'Publication Group';
            Description = 'AL.KVK4.5';
            TableRelation = Publikationsgruppe;
        }
        field(4006513;"Dokument ID";Code[20])
        {
            Caption = 'Dokument ID Image';
            Description = 'AL.KVK4.5';
            TableRelation = "Dokument Katalog";

            trigger OnLookup()
            begin
                // --- AL.KVK6.0 --- //
                CLEAR(gfrmZeichnung);

                // --- Zeichnungsfilter --- //
                grecDokument.RESET;
                grecDokument.SETCURRENTKEY(Art);
                grecDokument.SETRANGE(Art,grecDokument.Art::Zeichnung);
                gfrmZeichnung.SETTABLEVIEW(grecDokument);
                // --- Datensatz holen --- //
                grecDokument.SETRANGE("Dokument ID","Dokument ID");
                IF grecDokument.FIND('-') THEN
                  gfrmZeichnung.SETRECORD(grecDokument);
                gfrmZeichnung.LOOKUPMODE(TRUE);
                IF gfrmZeichnung.RUNMODAL = ACTION::LookupOK THEN BEGIN
                  gfrmZeichnung.GETRECORD(grecDokument);
                  "Dokument ID" := grecDokument."Dokument ID";
                END;
                // --- AL.KVK6.0 END --- //
            end;
        }
        field(4006514;"Katalogseite Hauptkatalog";Text[100])
        {
            CalcFormula = Lookup("Inhaltsverzeichnis Artikel".Seite WHERE (Aktuell=CONST(Yes),
                                                                           Artikelnr.=FIELD(No.)));
            Caption = 'Main Catalogue Page';
            Description = 'AL.KVK4.5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006515;Nettoartikel;Boolean)
        {
            Caption = 'Netto Product';
            Description = 'AL.KVK4.5';
        }
        field(4006516;Liquidationsartikel;Boolean)
        {
            Caption = 'Liquidation Item';
            Description = 'AL.KVK4.5';
        }
        field(4006517;Katalogartikel;Boolean)
        {
            Caption = 'Nonstock Items';
            Description = 'AL.KVK4.5';
        }
        field(4006520;"Checklistennr.";Code[20])
        {
            Caption = 'Checklist Number';
            Description = 'AL.KVK4.5';
            TableRelation = Checklistkopf WHERE (Klasse=CONST(Artikel));

            trigger OnValidate()
            begin
                // --- AL.KVK6.0 --- //
                IF xRec."Checklistennr." <> Rec."Checklistennr." THEN
                  Systemstatus := Systemstatus::"In Entwicklung";
                // --- AL.KVK6.0, END --- //
            end;
        }
        field(4006521;Systemstatus;Option)
        {
            Caption = 'System Status';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;

            trigger OnValidate()
            begin
                // --- AL.KVK6.0 --- //
                IF "Checklistennr." <> '' THEN BEGIN
                  CALCFIELDS("Systemstatus pruefen");
                  IF NOT gcouSystemVerw.SystemstatusPruefen(goptQuelle::Artikel,
                                                            "No.",
                                                            "Systemstatus pruefen",
                                                            Systemstatus,
                                                            TRUE) THEN
                    ERROR(AL0002);
                  // --- Zertifizierung --- //
                  IF (Rec.Systemstatus <> xRec.Systemstatus) AND (Systemstatus = Systemstatus::Zertifiziert) THEN BEGIN
                    grefRecordRef.OPEN(27);
                    grefRecordRef.GETTABLE(Rec);
                    ZertifizierungID := gcouStammVerw.ZertifizierungEinzVerarbeiten(grefRecordRef,
                                                                                    "Checklistennr.",
                                                                                    Systemstatus,
                                                                                    '');
                    IF ZertifizierungID > 0 THEN BEGIN
                      grecZertProt.RESET;
                      grecZertProt.SETCURRENTKEY(Nummer);
                      grecZertProt.SETRANGE(Nummer,"No.");
                      grecZertProt.SETRANGE(Meldungsart,grecZertProt.Meldungsart::Fehler);
                      IF grecZertProt.FIND('-') THEN BEGIN
                        // --- Bereich --- //
                        gcouStammVerw.ZertifizierungBereich(Rec,0);
                        MESSAGE(AL0003);
                        Systemstatus := Systemstatus::"In Entwicklung";
                      END
                      ELSE BEGIN
                        // --- Bereich --- //
                        gcouStammVerw.ZertifizierungBereich(Rec,1);
                        MESSAGE(AL0004);
                      END;
                    END
                    ELSE
                      gcouStammVerw.ZertifizierungBereich(Rec,1);
                  END;
                END;
                // --- AL.KVK6.0, END --- //
            end;
        }
        field(4006522;"Systemstatus pruefen";Boolean)
        {
            CalcFormula = Lookup(Checklistkopf."Systemstatus pruefen" WHERE (Code=FIELD(Checklistennr.)));
            Caption = 'Check System Status';
            Description = 'AL.KVK4.5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006523;Katalogverwendung;Boolean)
        {
            Caption = 'Catalogue Usage';
            Description = 'AL.KVK4.5';
            Editable = false;
        }
        field(4006524;Hauptkatalogcode;Code[20])
        {
            Caption = 'Main Catalogue Code';
            Description = 'AL.KVK4.5';
            TableRelation = Katalogkopf.Code;
        }
        field(4006525;"Bilddokument ID vererbt";Boolean)
        {
            Caption = 'Inherit Picture Document ID';
            Description = 'AL.KVK4.5';
        }
        field(4006528;"Zusatzinfo 1";Text[20])
        {
            Caption = 'Additional Information 1';
            Description = 'AL.KVK4.5';
            TableRelation = Zusatzinfo.Code WHERE (Art=CONST(Zusatzinfo1),
                                                   Code=FIELD(Zusatzinfo 1));
        }
        field(4006529;"Zusatzinfo 2";Text[20])
        {
            Caption = 'Additional Information 2';
            Description = 'AL.KVK4.5';
            TableRelation = Zusatzinfo.Code WHERE (Art=CONST(Zusatzinfo2),
                                                   Code=FIELD(Zusatzinfo 2));
        }
        field(4006530;"Zusatzinfo 3";Text[20])
        {
            Caption = 'Additional Information 3';
            Description = 'AL.KVK4.5';
            TableRelation = Zusatzinfo.Code WHERE (Art=CONST(Zusatzinfo3),
                                                   Code=FIELD(Zusatzinfo 3));
        }
        field(4006531;"Zusatzinfo 4";Text[20])
        {
            Caption = 'Additional Information 4';
            Description = 'AL.KVK4.5';
            TableRelation = Zusatzinfo.Code WHERE (Art=CONST(Zusatzinfo4),
                                                   Code=FIELD(Zusatzinfo 4));
        }
        field(4006532;"Zusatzinfo 5";Text[20])
        {
            Caption = 'Additional Information 5';
            Description = 'AL.KVK4.5';
            TableRelation = Zusatzinfo.Code WHERE (Art=CONST(Zusatzinfo5),
                                                   Code=FIELD(Zusatzinfo 5));
        }
        field(4006533;Katalogseite;Text[100])
        {
            Caption = 'Catalogue Page';
            Description = 'AL.KVK4.5';
            Editable = false;
        }
        field(4006534;"Sprache 01";Code[10])
        {
            CalcFormula = Lookup("Katalog Einrichtung"."Sprache 01" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 1';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006535;"Sprache 02";Code[10])
        {
            CalcFormula = Lookup("Katalog Einrichtung"."Sprache 02" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 1';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006536;"Sprache 03";Code[10])
        {
            CalcFormula = Lookup("Katalog Einrichtung"."Sprache 03" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 3';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006537;"Sprache 04";Code[10])
        {
            CalcFormula = Lookup("Katalog Einrichtung"."Sprache 04" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 4';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006538;"Sprache 05";Code[10])
        {
            CalcFormula = Lookup("Katalog Einrichtung"."Sprache 05" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 5';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006539;"Sprache 06";Code[10])
        {
            CalcFormula = Lookup("Katalog Einrichtung"."Sprache 06" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 6';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006540;"Sprache 07";Code[10])
        {
            CalcFormula = Lookup("Katalog Einrichtung"."Sprache 07" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 7';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006541;"Sprache 08";Code[10])
        {
            CalcFormula = Lookup("Katalog Einrichtung"."Sprache 08" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 8';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006542;"Sprache 09";Code[10])
        {
            CalcFormula = Lookup("Katalog Einrichtung"."Sprache 09" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 9';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006543;"Sprache 10";Code[10])
        {
            CalcFormula = Lookup("Katalog Einrichtung"."Sprache 10" WHERE (Primaerschluessel=CONST()));
            Caption = 'Language 10';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4006544;"ML Bezeichnung 01";Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006545;"ML Bezeichnung 02";Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006546;"ML Bezeichnung 03";Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006547;"ML Bezeichnung 04";Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006548;"ML Bezeichnung 05";Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006549;"ML Bezeichnung 06";Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006550;"ML Bezeichnung 07";Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006551;"ML Bezeichnung 08";Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006552;"ML Bezeichnung 09";Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006553;"ML Bezeichnung 10";Boolean)
        {
            Caption = 'ML Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006554;"ML Beschrieb 01";Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006555;"ML Beschrieb 02";Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006556;"ML Beschrieb 03";Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006557;"ML Beschrieb 04";Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006558;"ML Beschrieb 05";Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006559;"ML Beschrieb 06";Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006560;"ML Beschrieb 07";Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006561;"ML Beschrieb 08";Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006562;"ML Beschrieb 09";Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006563;"ML Beschrieb 10";Boolean)
        {
            Caption = 'ML Description';
            Description = 'AL.KVK4.5';
        }
        field(4006564;Klassifikationscode;Text[8])
        {
            Caption = 'Classification Code';
            Description = 'AL.KVK4.5';
        }
        field(4006565;"Datanaustausch ID";Code[20])
        {
            Caption = 'Data Exchange ID';
            Description = 'AL.KVK4.5';
            Editable = false;
        }
        field(4006566;Datenaustauschart;Option)
        {
            Caption = 'Data Exchange Type';
            Description = 'AL.KVK4.5';
            Editable = false;
            OptionCaption = 'Import,Export,Archive Import,Archive Export';
            OptionMembers = Import,Export,ArchivImport,ArchivExport;
        }
        field(4006567;Transaktionsart;Option)
        {
            Caption = 'Transaction Type';
            Description = 'AL.KVK4.5';
            Editable = false;
            OptionCaption = 'Create,Change,Delete';
            OptionMembers = Neuanlage,"Änderung","Löschnung";
        }
        field(4006571;"Manipulation ID";Integer)
        {
            Caption = 'Manipulation ID';
            Description = 'AL.KVK4.5';
        }
        field(4006575;Langtextnummer;Text[15])
        {
            Caption = 'Long Text No.';
            Description = 'AL.KVK4.5';
        }
        field(4006576;"Vererbung Beschreibungen";Boolean)
        {
            Caption = 'Inherit Descriptions';
            Description = 'AL.KVK4.5';
        }
        field(4006577;"Vererbung Merkmale";Boolean)
        {
            Caption = 'Inherit Features';
            Description = 'AL.KVK4.5';
        }
        field(4006578;"Vererbung Schlagworte";Boolean)
        {
            Caption = 'Inherit Keywords';
            Description = 'AL.KVK4.5';
        }
        field(4006579;"Vererbung Bilder";Boolean)
        {
            Caption = 'Inherit Pictures';
            Description = 'AL.KVK4.5';
        }
        field(4006580;"Vererbung Dokumente";Boolean)
        {
            Caption = 'Inherit Documents';
            Description = 'AL.KVK4.5';
        }
        field(4006581;"Vererbung Grafik";Boolean)
        {
            Caption = 'Inherit Graphic';
            Description = 'AL.KVK4.5';
        }
        field(4006582;"Vererbung Bezeichnung";Boolean)
        {
            Caption = 'Inherit Short Description';
            Description = 'AL.KVK4.5';
        }
        field(4006583;Uebersetzung;Boolean)
        {
            Caption = 'Translation';
            Description = 'AL.KVK4.5';
        }
        field(4006584;"Akt. Kampagnenummer";Code[20])
        {
            CalcFormula = Lookup("Katalog Einrichtung".Kampagnenummer WHERE (Primaerschluessel=CONST()));
            Caption = 'Act. Campaign No.';
            Description = 'AL.KVK4.5';
            FieldClass = FlowField;
            TableRelation = Campaign;
        }
        field(4006585;"Verwendung Print";Boolean)
        {
            Caption = 'Print Usage';
            Description = 'AL.KVK4.5';
        }
        field(4006586;"Verwendung Web";Boolean)
        {
            Caption = 'Web Usage';
            Description = 'AL.KVK4.5';
        }
        field(4006587;"Vererbung Merkmalwerte";Boolean)
        {
            Caption = 'Inherit Feature Values';
            Description = 'AL.KVK4.5';
        }
        field(4006588;ZertifizierungID;BigInteger)
        {
            Caption = 'Certification ID';
            Description = 'AL.KVK4.5';
        }
        field(4006592;Kurztext;Text[100])
        {
            Caption = 'Short Text';
            Description = 'AL.KVK4.5';
        }
        field(4006594;"Neuer Artikel";Boolean)
        {
            Caption = 'New Item';
            Description = 'AL.KVK4.5';
        }
        field(4006595;"Vererbung Referenzen";Boolean)
        {
            Caption = 'Inherit References';
            Description = 'AL.KVK4.5';
        }
        field(4006596;"Bereich 01";Code[10])
        {
            Caption = 'Area 1';
            Description = 'AL.KVK4.5';
            Editable = false;
            TableRelation = Datenbereich;
        }
        field(4006597;"Bereich 02";Code[10])
        {
            Caption = 'Area 2';
            Description = 'AL.KVK4.5';
            Editable = false;
            TableRelation = Datenbereich;
        }
        field(4006598;"Bereich 03";Code[10])
        {
            Caption = 'Area 3';
            Description = 'AL.KVK4.5';
            Editable = false;
            TableRelation = Datenbereich;
        }
        field(4006599;"Bereich 04";Code[10])
        {
            Caption = 'Area 4';
            Description = 'AL.KVK4.5';
            Editable = false;
            TableRelation = Datenbereich;
        }
        field(4006600;"Bereich 05";Code[10])
        {
            Caption = 'Area 5';
            Description = 'AL.KVK4.5';
            Editable = false;
            TableRelation = Datenbereich;
        }
        field(4006601;"Bereich 06";Code[10])
        {
            Caption = 'Area 6';
            Description = 'AL.KVK4.5';
            Editable = false;
            TableRelation = Datenbereich;
        }
        field(4006602;"Bereich 07";Code[10])
        {
            Caption = 'Area 7';
            Description = 'AL.KVK4.5';
            Editable = false;
            TableRelation = Datenbereich;
        }
        field(4006603;"Bereich 08";Code[10])
        {
            Caption = 'Area 8';
            Description = 'AL.KVK4.5';
            Editable = false;
            TableRelation = Datenbereich;
        }
        field(4006604;"Bereich 09";Code[10])
        {
            Caption = 'Area 9';
            Description = 'AL.KVK4.5';
            Editable = false;
            TableRelation = Datenbereich;
        }
        field(4006605;"Bereich 10";Code[10])
        {
            Caption = 'Area 10';
            Description = 'AL.KVK4.5';
            Editable = false;
            TableRelation = Datenbereich;
        }
        field(4006606;"Systemstatus Ber. 01";Option)
        {
            Caption = 'System Status Area 01';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006607;"Systemstatus Ber. 02";Option)
        {
            Caption = 'System Status Area 02';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006608;"Systemstatus Ber. 03";Option)
        {
            Caption = 'System Status Area 03';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006609;"Systemstatus Ber. 04";Option)
        {
            Caption = 'System Status Area 04';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006610;"Systemstatus Ber. 05";Option)
        {
            Caption = 'System Status Area 05';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006611;"Systemstatus Ber. 06";Option)
        {
            Caption = 'System Status Area 06';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006612;"Systemstatus Ber. 07";Option)
        {
            Caption = 'System Status Area 07';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006613;"Systemstatus Ber. 08";Option)
        {
            Caption = 'System Status Area 08';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
        field(4006614;"Systemstatus Ber. 09";Option)
        {
            Caption = 'System Status Area 09';
            Description = 'AL.KVK4.5';
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = Neu,"In Entwicklung",Zertifiziert;
        }
    }
    keys
    {
        key(Key1;Standardartikelgruppe)
        {
        }
        key(Key2;"Checklistennr.")
        {
        }
    }


    //Unsupported feature: Code Modification on "OnDelete".

    //trigger OnDelete()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ApprovalsMgmt.OnCancelItemApprovalRequest(Rec);

        CheckJournalsAndWorksheets(0);
        #4..13
          UNTIL ServiceItem.NEXT = 0;

        DeleteRelatedData;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..16

        //MIG2017
        // --- AL.KVK6.0 --- //
        gcouStammVerw.ArtikelOnDelete(Rec);
        // --- AL.KVK6.0 END --- //
        //MIG2017
        */
    //end;


    //Unsupported feature: Code Modification on "OnInsert".

    //trigger OnInsert()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF "No." = '' THEN BEGIN
          GetInvtSetup;
          InvtSetup.TESTFIELD("Item Nos.");
        #4..8
          "Global Dimension 1 Code","Global Dimension 2 Code");

        SetLastDateTimeModified;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..11
        //MIG2017
        "Date de creation" := TODAY;

        //>>Mgts10.00.03.00
        // --- AL.KVK6.0 --- //
        //gcouStammVerw.ArtikelOnInsert(Rec);
        // --- AL.KVK6.0 END --- //
        //END MIG2017
        //<<Mgts10.00.03.00
        */
    //end;


    //Unsupported feature: Code Modification on "OnModify".

    //trigger OnModify()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetLastDateTimeModified;
        PlanningAssignment.ItemChange(Rec,xRec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetLastDateTimeModified;
        PlanningAssignment.ItemChange(Rec,xRec);

        //>>Mgts10.00.03.00
        //MIG2017
        // --- AL.KVK6.0 --- //
        //gcouStammVerw.ArtikelOnModify(Rec,xRec);
        // --- AL.KVK6.0 END --- //
        //MIG2017
        //<<Mgts10.00.03.00
        */
    //end;


    //Unsupported feature: Code Modification on "TryGetItemNoOpenCard(PROCEDURE 43)".

    //procedure TryGetItemNoOpenCard();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ReturnValue := COPYSTR(ItemText,1,MAXSTRLEN(ReturnValue));
        IF ItemText = '' THEN
          EXIT(DefaultCreate);

        FoundRecordCount := TypeHelper.FindRecordByDescription(ReturnValue,SalesLine.Type::Item,ItemText);

        IF FoundRecordCount = 1 THEN
          EXIT(TRUE);

        ReturnValue := COPYSTR(ItemText,1,MAXSTRLEN(ReturnValue));
        IF FoundRecordCount = 0 THEN BEGIN
          IF NOT DefaultCreate THEN
        #13..53
        IF NOT DefaultCreate THEN
          EXIT(FALSE);
        ERROR(SelectItemErr);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
        //START THM030418
        IF FoundRecordCount = 0 THEN
          ERROR(SelectItemErr);
        //END THM030418
        #10..56
        */
    //end;

    procedure ModifSegment(var ProductCode: Code[20];var CategCode: Code[20])
    var
        ProductGroup_Rec: Record "5723";
        DefaultDimension_Rec: Record "352";
        ItemCategory_Rec: Record "5722";
    begin
        //MIG2017
        IF ProductGroup_Rec.GET(CategCode,ProductCode) THEN BEGIN
           IF DefaultDimension_Rec.GET(27,"No.",'Segment') THEN BEGIN
             IF DefaultDimension_Rec."Dimension Value Code"<> ProductGroup_Rec."Code Segment" THEN BEGIN
                DefaultDimension_Rec.VALIDATE("Dimension Value Code",ProductGroup_Rec."Code Segment");
                DefaultDimension_Rec.MODIFY;
             END;
           END
           ELSE BEGIN
              DefaultDimension_Rec.INIT;
              DefaultDimension_Rec.VALIDATE("Table ID",27);
              DefaultDimension_Rec.VALIDATE("No.","No.");
              DefaultDimension_Rec.VALIDATE("Dimension Code",'Segment');
              DefaultDimension_Rec.VALIDATE("Dimension Value Code",ProductGroup_Rec."Code Segment");
              DefaultDimension_Rec.INSERT;
           END;
        END;
        //END MIG2017
    end;

    procedure ModifCategory(var CategCode: Code[20])
    var
        DefaultDimension_Rec: Record "352";
        ItemCategory_Rec: Record "5722";
    begin
           //MIG2017
           // T-00746 START
           IF DefaultDimension_Rec.GET(27,"No.",'Categorie') THEN BEGIN
             IF DefaultDimension_Rec."Dimension Value Code"<> CategCode THEN BEGIN
                DefaultDimension_Rec.VALIDATE("Dimension Value Code",CategCode);
                DefaultDimension_Rec.MODIFY;
             END;
           END
           // T-00746 END
           ELSE BEGIN
              // T-00746 START
              DefaultDimension_Rec.INIT;
              DefaultDimension_Rec.VALIDATE("Table ID",27);
              DefaultDimension_Rec.VALIDATE("No.","No.");
              DefaultDimension_Rec.VALIDATE("Dimension Code",'Categorie');
              DefaultDimension_Rec.VALIDATE("Dimension Value Code",CategCode);
              DefaultDimension_Rec.INSERT;
              // T-00746 END
           END;
        //END MIG2017
    end;

    procedure GetVolCBM(Update: Boolean): Decimal
    begin
        //>>Mgts10.00.05.00
        IF ("Vol cbm" = 0) AND( PCB <> 0 ) THEN BEGIN
          "Vol cbm" := ROUND(("Vol cbm carton transport" / PCB),0.00001,'>');
           IF Update THEN
            MODIFY;
        END;
        EXIT("Vol cbm")
        //<<Mgts10.00.05.00
    end;

    var
        ItemCategory: Record "5722";
        "--- AL.KVK ---": Integer;
        grecDokEinr: Record "4024041";
        grecDokument: Record "4024045";
        grecArtikelGrp: Record "4006519";
        grecKatDok: Record "4006515";
        grecZertProt: Record "4024050";
        grecCheckZeile: Record "4006524";
        grecCheckZeileRef: Record "4006524";
        gfrmDoklisteB: Page "4024073";
                           gfrmZeichnung: Page "4006563";
                           gcouKatVerw: Codeunit "4006500";
                           gcouSystemVerw: Codeunit "4006498";
                           gcouDokVerw: Codeunit "4006497";
                           gcouStammVerw: Codeunit "4006496";
                           grefRecordRef: RecordRef;
                           goptQuelle: Option Artikel,Artikelgruppe,Kapitel,Kataloggruppe,Gruppensystem,Katalog,Checkliste,Textbaustein,Vorlage;
                           goptQuellenart: Option Artikel,Artikelgruppe,Warengruppe,Kapitel,Kataloggruppe,Textbaustein;
                           RecMatriseGroupArtGroup: Record "50059";
                           PageMatriseGroupArtGroup: Page "50118";
                           Text0027: Label 'Segment code missing product code %1';
        AL0001: Label 'Picture Document %1 cannot be found in the related table.';
        AL0002: Label 'You are not authorized to certify items.';
        AL0003: Label 'Certification failure, please check the log.';
        AL0004: Label 'Certification Log contains warnings.';
}

