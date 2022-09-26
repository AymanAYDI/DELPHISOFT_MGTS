page 50131 "DocMatrix Setup"
{
    // DEL/PD/20190227/LOP003 : object created

    PageType = Card;
    SourceTable = Table50069;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Sales File Folder"; "Sales File Folder")
                {
                }
                field("Purchase File Folder"; "Purchase File Folder")
                {
                }
                field("Default E-Mail From"; "Default E-Mail From")
                {
                }
                field("Show Notifications"; "Show Notifications")
                {
                }
                field("Statement Test Date"; "Statement Test Date")
                {
                }
                field("Test Active"; "Test Active")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;
    end;
}

