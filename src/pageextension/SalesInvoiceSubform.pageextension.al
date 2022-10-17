pageextension 50045 "DEL SalesInvoiceSubform" extends "Sales Invoice Subform"
{
    layout
    {
        // TODO: the property 'table relation' cannot be customized
        //Unsupported feature: Property Modification (TableRelation) on "Control 300".


        //Unsupported feature: Property Modification (TableRelation) on "Control 302".


        //Unsupported feature: Property Modification (TableRelation) on "Control 304".


        //Unsupported feature: Property Modification (TableRelation) on "Control 306".


        //Unsupported feature: Property Modification (TableRelation) on "Control 308".


        //Unsupported feature: Property Modification (TableRelation) on "Control 310".

        addafter("Control1")
        {
            field("DEL Ship-to Code"; Rec."DEL Ship-to Code")
            {
            }
            field("DEL Ship-to Name"; Rec."DEL Ship-to Name")
            {
            }
        }
    }
}


