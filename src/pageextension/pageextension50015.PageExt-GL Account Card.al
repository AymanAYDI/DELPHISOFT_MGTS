pageextension 50015 pageextension50015 extends "G/L Account Card"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 23.03.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // THM                             30.07.13     Add field "No. 2"
    // THS                             17.12.13     Enable as FALSE for "company code"
    // MHH    MGTS0126                 18.09.19     Added new field: "Mobivia Detail"
    //                                 23.11.19     Added new field: "Hyperion Export Sign"
    layout
    {

        //Unsupported feature: Property Modification (SubPageLink) on "Control 1905532107".

        addafter("Control 14")
        {
            field("No. 2"; "No. 2")
            {
                Caption = 'No. acount group';
            }
        }
        addafter("Control 3")
        {
            group(NGTS)
            {
                Caption = 'NGTS';
                field("Reporting Dimension 1 Code"; "Reporting Dimension 1 Code")
                {
                    Caption = 'Reporting Dimension groupe';
                }
                field("Company Code"; "Company Code")
                {
                    Editable = false;
                }
                field("Reporting Dimension 2 Code"; "Reporting Dimension 2 Code")
                {
                    Caption = 'Reporting Dimension local';
                }
                field("Shipment Binding Control"; "Shipment Binding Control")
                {
                }
                field("Mobivia Detail"; "Mobivia Detail")
                {
                }
                field("Hyperion Export Sign"; "Hyperion Export Sign")
                {
                }
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageView) on "Action 41".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 38".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 84".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 166".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 46".

    }
}

