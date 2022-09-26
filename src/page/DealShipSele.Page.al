page 50040 "Deal Ship. Sele."
{
    Caption = 'Shipment list';
    Editable = false;
    PageType = List;
    SourceTable = Table50030;

    layout
    {
        area(content)
        {
            repeater()
            {
                Editable = false;
                field(Deal_ID; Deal_ID)
                {
                    Caption = 'Deal ID';
                }
                field(ID; ID)
                {
                    Caption = 'Shipment ID';
                }
                field("BR No."; "BR No.")
                {
                }
                field(Fournisseur; Fournisseur)
                {
                }
                field(Date; Date)
                {
                }
                field(Status; Status)
                {
                }
                field(PI; PI)
                {
                }
                field("A facturer"; "A facturer")
                {
                }
                field("Depart shipment"; "Depart shipment")
                {
                }
                field("Arrival ship"; "Arrival ship")
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

    [Scope('Internal')]
    procedure FNC_InitData()
    var
        DealShip_Re_Loc: Record "50030";
        Deal_Re_Loc: Record "50020";
        Element_Re_Loc: Record "50021";
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

