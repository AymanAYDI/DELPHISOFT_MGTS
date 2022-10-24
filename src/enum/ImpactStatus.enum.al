enum 50009 "DEL Impact Status"  // still an option in STD exp "status" in Tab1530 there is an enum "ActivationStatus" that has the same options but not in the same order 

{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Inactive)
    {
        Caption = 'Inactive';
    }
    value(2; Active)
    {
        Caption = 'Active';
    }
}
