tableextension 50000 "DEL Item" extends Item
{
    fields
    {
        field(50000; "DEL Product Description"; Text[100])
        {
            Caption = 'Product Description';
            DataClassification = ToBeClassified;
        }
        field(50001; "DEL Marque Produit"; Enum "DEL Marque Produit")
        {
            Caption = 'Marque Produit';
            DataClassification = ToBeClassified;
        }
    }
}
