report 50030 "DEL Add Item to Deal"
{
    Caption = 'add intem to Deal';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = FILTER(1));

            trigger OnAfterGetRecord()
            begin
                IF (ItemCode <> '') AND (DealCode <> '') THEN
                    DealItem.FNC_Add(DealCode, ItemCode);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(ItemCode; ItemCode)
                    {
                        Caption = 'Item No.';
                    }
                    field(DealCode; DealCode)
                    {
                        Caption = 'Deal No.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        DealItem: Codeunit "DEL Deal Item";
        DealCode: Code[20];
        ItemCode: Code[20];
}

