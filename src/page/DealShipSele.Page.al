page 50040 "DEL Deal Ship. Sele."
{
    Caption = 'Shipment list';
    Editable = false;
    PageType = List;
    SourceTable = "DEL Deal Shipment";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field(Deal_ID; Rec.Deal_ID)
                {
                    Caption = 'Deal ID';
                }
                field(ID; Rec.ID)
                {
                    Caption = 'Shipment ID';
                }
                field("BR No."; Rec."BR No.")
                {
                }
                field(Fournisseur; Rec.Fournisseur)
                {
                }
                field("Date"; Rec.Date)
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(PI; Rec.PI)
                {
                }
                field("A facturer"; Rec."A facturer")
                {
                }
                field("Depart shipment"; Rec."Depart shipment")
                {
                }
                field("Arrival ship"; Rec."Arrival ship")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        FNC_InitData();
    end;

    var
        Deal_Cu: Codeunit "50020";


    procedure FNC_InitData()
    var
        DealShip_Re_Loc: Record "DEL Deal Shipment";
        Deal_Re_Loc: Record "DEL Deal";
        Element_Re_Loc: Record "DEL Element";
    begin
        //DealShip_Re_Loc.LOCKTABLE;
        /*
        IF DealShip_Re_Loc.FINDFIRST THEN
          REPEAT
        
            IF Deal_Re_Loc.GET(DealShip_Re_Loc.Deal_ID) THEN BEGIN
              DealShip_Re_Loc.Status := Deal_Re_Loc.Status;
              DealShip_Re_Loc.MODIFY;
            END;
        
            IF DealShip_Re_Loc.Fournisseur = '' THEN BEGIN
              Deal_Cu.FNC_Get_ACO(Element_Re_Loc, DealShip_Re_Loc.Deal_ID);
              IF Element_Re_Loc.FINDFIRST THEN BEGIN
                DealShip_Re_Loc.Fournisseur := Element_Re_Loc."Subject No.";
                DealShip_Re_Loc.MODIFY;
              END;
            END;
        
          UNTIL DealShip_Re_Loc.NEXT = 0;
        
        COMMIT;
        */

    end;
}

