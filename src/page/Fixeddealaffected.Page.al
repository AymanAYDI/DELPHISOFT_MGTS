page 50062 "Fixed deal affected"
{
    Caption = 'Fixed deal affected';
    Editable = false;
    PageType = List;
    SourceTable = Table50034;
    SourceTableView = WHERE (Display record=FILTER(No),
                            BL N°=FILTER(<>''));

    layout
    {
        area(content)
        {
            repeater()
            {
                field(ID;ID)
                {
                }
                field(Deal_ID;Deal_ID)
                {
                }
                field("ACO No.";"ACO No.")
                {
                }
                field("Supplier Name";"Supplier Name")
                {
                }
                field("BL N°";"BL N°")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //grc 1 begin
                        //TrackingGeneral.SETRANGE(Order_no,"ACO No.");

                        //IF PAGE.RUNMODAL(PAGE::"Propostition tracking",TrackingGeneral)=ACTION::LookupOK THEN  BEGIN
                    end;
                }
                field("Display record";"Display record")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Affectation manuelle";"Affectation manuelle")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Delete BL No.")
            {
                Caption = 'Delete BL No.';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Text00001: Label 'Impossible de supprimer ce BL.';
                begin
                     IF NOT CONFIRM(Text0001, FALSE) THEN EXIT;
                    
                      Booking_Num:="BL N°";
                      TrackingGeneral.RESET;
                      TrackingGeneral.SETRANGE(Booking_no,Booking_Num);
                      TrackingGeneral.SETRANGE(Order_no,"ACO No.");
                      IF TrackingGeneral.FINDFIRST THEN BEGIN
                        REPEAT
                          TrackingGeneral.Statut :='';
                          TrackingGeneral.MODIFY;
                        UNTIL TrackingGeneral.NEXT = 0;
                      END
                      ELSE
                      ERROR(Text00001);
                    
                    
                      TrackingDetail.SETRANGE(Booking_no,Booking_Num);
                      TrackingDetail.SETRANGE(Order_no,"ACO No.");
                      IF TrackingDetail.FINDFIRST THEN BEGIN
                        REPEAT
                          TrackingDetail.Statut := '';
                          TrackingDetail.MODIFY;
                        UNTIL TrackingDetail.NEXT = 0;
                      END;
                      "BL N°":='';
                      "Forwarder Name" := '';
                      "Supplier Name" := '';
                      "Departure Port" := '';
                      "ETD Requested" := 0D;
                      "Revised ETD" := 0D;
                      "Actual departure date" := 0D;
                      "Arrival port" := '';
                      "Shipping company" := '';
                      "Vessel name" := '';
                      "Actual Arrival date" := 0D;
                      "Customer Delivery date" := 0D;
                      "Display record":=TRUE;
                       MODIFY;
                    CurrPage.UPDATE;
                    /*
                    Rec.SETRANGE("Display record",FALSE);
                    IF Rec.FINDFIRST THEN BEGIN
                      REPEAT
                        Rec."Display record" := TRUE;
                        Rec.MODIFY();
                      UNTIL Rec.NEXT = 0;
                    END;
                    Rec.RESET();
                    
                    COMMIT();
                    
                    
                    Logistic2.SETFILTER("BL N°",'<>%1','');
                    IF Logistic2.FINDFIRST THEN BEGIN
                      REPEAT
                        TrackingGeneral2.SETRANGE(Order_no,Logistic2."ACO No.");
                        TrackingGeneral2.SETFILTER(Statut,'<>%1','');
                        IF (TrackingGeneral2.FINDFIRST)  THEN
                          Logistic2."Display record" :=FALSE;
                          Logistic2.MODIFY();
                      UNTIL Logistic2.NEXT = 0;
                    END;
                    COMMIT();
                    MESSAGE('Mise à jour effectuée');
                    
                    Rec.SETRANGE("Display record",FALSE);
                     */

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        //filtre selectif sur la table logistic, on n'affiche que les affaires dont un fichier xml vient d'arriver begin

        //Rec.SETRANGE("Display record",FALSE);
        //SETFILTER("BL N°",'<>%1','');

        //filtre selectif sur la table logistic, on n'affiche que les affaires dont un fichier xml vient d'arriver end
    end;

    var
        TrackingGeneral: Record "50013";
        TrackingDetail: Record "50014";
        Logistic2: Record "50034";
        Booking_Num: Text[50];
        Text0001: Label 'Do you want to remove BL No ?';
}

