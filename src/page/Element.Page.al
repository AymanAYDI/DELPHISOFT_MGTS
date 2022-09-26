page 50021 Element
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 20.04.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            20.04.09   Update field Date

    PageType = List;
    SourceTable = Table50021;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(ID; ID)
                {
                }
                field(Deal_ID; Deal_ID)
                {
                }
                field(Instance; Instance)
                {
                }
                field(Type; Type)
                {
                }
                field("Type No."; "Type No.")
                {
                }
                field(Fee_ID; Fee_ID)
                {
                }
                field(Fee_Cu.FNC_Get_Description(Fee_ID);
                    Fee_Cu.FNC_Get_Description(Fee_ID))
                {
                    Caption = 'Description';
                }
                field(Fee_Connection_ID; Fee_Connection_ID)
                {
                }
                field("Subject Type"; "Subject Type")
                {
                }
                field("Subject No."; "Subject No.")
                {
                }
                field(Date; Date)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Element_Cu: Codeunit "50021";
        Fee_Cu: Codeunit "50023";
}

