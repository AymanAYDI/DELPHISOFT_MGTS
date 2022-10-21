enum 50050 "DEL Address format"  // still an option in the std exp status
{
    Extensible = false;

    value(0; "Post Code+City")
    {
        Caption = 'Post Code+City';
    }
    value(1; "City+Post Code")
    {
        Caption = 'City+Post Code';
    }
    value(2; "City+County+Post Code")
    {
        Caption = 'City+County+Post Code';
    }
    value(3; "Blank Line+Post Code+City")
    {
        Caption = 'Blank Line+Post Code+City';
    }
}
