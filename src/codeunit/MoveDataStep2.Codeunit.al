codeunit 50031 "Move Data Step 2"
{

    trigger OnRun()
    begin
        /*
        Item.SETFILTER("TEMP Droit de douane reduit", '<>%1', 0);
        IF Item.FIND('-') THEN
        REPEAT
           Item."Droit de douane reduit" := Item."TEMP Droit de douane reduit" ;
          Item."TEMP Droit de douane reduit" := 0 ;
          Item.MODIFY;
        UNTIL Item.NEXT=0;
        
        DealItem.SETFILTER("TEMP Droit de douane reduit",'<>%1', 0);
        IF DealItem.FIND('-') THEN
        REPEAT
          DealItem."Droit de douane reduit" := DealItem."TEMP Droit de douane reduit";
          DealItem."TEMP Droit de douane reduit" := 0 ;
          DealItem.MODIFY;
        UNTIL DealItem.NEXT=0;
        */

    end;

    var
        Item: Record "27";
        DealItem: Record "50023";
        decit: Decimal;
        decdit: Decimal;
}

