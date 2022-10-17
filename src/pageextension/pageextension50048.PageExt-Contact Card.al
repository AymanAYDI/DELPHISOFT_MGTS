pageextension 50048 pageextension50048 extends "Contact Card"
{
    // NTO    02.08.05/LOCO/JMO- Div. modifications
    // THM    24.04.14    pageAction add notation contact
    // +------------------------------------------------------------------------------------------+
    // | Logico SA                                                                                |
    // | Status:                                                                                  |
    // | Customer/Project:                                                                        |
    // +------------------------------------------------------------------------------------------+
    // Requirement  UserID   Date       Where             Description
    // -------------------------------------------------------------------------------------------+
    // T-00705      THM      19.06.15   PageAction       Modify CaptionML
    // 
    // 
    // MGTSEDI10.00.00.00 | 08.10.2020 | EDI Management : Add field : GLN
    layout
    {

        //Unsupported feature: Property Modification (SubPageLink) on "Control 31".

        addafter("Control 20")
        {
            field(GLN; GLN)
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 90".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 100".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 96".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 3".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 42".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 95".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 6".

        addafter("Action 1907415106")
        {
            action("Notation contact")
            {
                Caption = 'Contact Rating';
                Image = AdjustItemCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50067;
                RunPageLink = No.=FIELD(No.);
            }
        }
    }
}

