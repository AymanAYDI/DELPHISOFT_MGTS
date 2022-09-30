codeunit 50030 "Move Data Step 1"
{

    trigger OnRun()
    begin
        /*
        Item.SETFILTER("Droit de douane reduit", '<>%1', '');
        IF Item.FIND('-') THEN
        REPEAT
          EVALUATE(decit,CONVERTSTR(Item."Droit de douane reduit", ',' , '.' ));
           Item."TEMP Droit de douane reduit" := decit;
          Item."Droit de douane reduit" := '' ;
          Item.MODIFY;
        UNTIL Item.NEXT=0;
        
        DealItem.SETFILTER("Droit de douane reduit",'<>%1', '');
        IF DealItem.FIND('-') THEN
        REPEAT
          EVALUATE(decdit,CONVERTSTR(DealItem."Droit de douane reduit", ',' , '.' ));
          DealItem."TEMP Droit de douane reduit" := decdit;
          DealItem."Droit de douane reduit" := '' ;
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

