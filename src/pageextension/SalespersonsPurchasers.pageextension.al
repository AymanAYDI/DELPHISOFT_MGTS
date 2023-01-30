pageextension 50031 "DEL SalespersonsPurchasers" extends "Salespersons/Purchasers" //14 
{
    layout
    {
        addafter(Name)
        {
            field("DEL ResponsibleCode"; Rec."DEL Responsible Code")
            { }
            field("DEL Responsible"; Rec."DEL Responsible")
            { }
        }
    }
    actions
    {
    }
}

