page 50049 "DEL Fee Factor"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 16.06.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            16.06.09   Created form

    Caption = 'Fee Factor';
    PageType = List;
    SourceTable = Table50043;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Allow From"; "Allow From")
                {
                }
                field("Allow To"; "Allow To")
                {
                }
                field(Factor; Factor)
                {
                }
                field(Fee_ID; Fee_ID)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        fee: Record "50024";
}

