report 50030 "Add Item to Deal"
{
    Caption = 'add intem to Deal';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table2000000026)
        {
            DataItemTableView = SORTING (Number)
                                ORDER(Ascending)
                                WHERE (Number = FILTER (1));

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
        DealItem: Codeunit "50024";
        DealCode: Code[20];
        ItemCode: Code[20];
}

