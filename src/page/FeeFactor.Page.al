page 50049 "Fee Factor"
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
            }
        }
    }

    actions
    {
    }

    var
        fee: Record "50024";
}

