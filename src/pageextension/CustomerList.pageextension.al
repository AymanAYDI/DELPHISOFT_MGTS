pageextension 50020 "DEL CustomerList" extends "Customer List" //22 
{
    layout
    {
        addafter("Phone No.") //6
        {
            field("DEL FTP Save"; Rec."DEL FTP Save")
            {
            }
            field("DEL FTP Save 2"; Rec."DEL FTP Save 2")
            {
            }
        }
    }
    actions
    {


    }

    var
        CustSalesLCY: array[4] of Decimal;
        CustDateFilter: array[4] of Text[30];
        i: Integer;
        DateFilter1: Text;
        DateFilter2: Text;
        DateFilter3: Text;
        Customer: Record 18;
        Text001: Label 'Sales (LCY)';


    //TODO Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

    //trigger (Variable: CustSalesLCY)()
    //Parameters and return type have not been exported.
    //begin
    /*
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;

    SetWorkflowManagementEnabledState;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    //START MIG2017
    // S160001_20 START
    Customer.RESET;
    IF Customer.FINDFIRST THEN
    BEGIN
    REPEAT
      CustDateFilter[1]:=FORMAT(DMY2DATE(1,1,DATE2DMY(TODAY,3)))+'..'+FORMAT(DMY2DATE(31,12,DATE2DMY(TODAY,3)));
      CustDateFilter[2]:=FORMAT(DMY2DATE(1,1,DATE2DMY(TODAY,3)-1))+'..'+FORMAT(DMY2DATE(31,12,DATE2DMY(TODAY,3)-1));
      CustDateFilter[3]:=FORMAT(DMY2DATE(1,1,DATE2DMY(TODAY,3)-2))+'..'+FORMAT(DMY2DATE(31,12,DATE2DMY(TODAY,3)-2));
      DateFilter1:=CustDateFilter[1];
      DateFilter2:=CustDateFilter[2];
      DateFilter3:=CustDateFilter[3];

      FOR i := 1 TO 3 DO BEGIN
        Customer.SETFILTER(Customer."Date Filter",CustDateFilter[i]);
        Customer.CALCFIELDS(Customer."Sales (LCY)");
        CustSalesLCY[i] := Customer."Sales (LCY)";
      END;

      CustDateFilter[1]:=Text001+' '+FORMAT(DMY2DATE(1,1,DATE2DMY(TODAY,3)),0,'<Year4>');
      CustDateFilter[2]:=Text001+' '+FORMAT(DMY2DATE(1,1,DATE2DMY(TODAY,3)-1),0,'<Year4>');
      CustDateFilter[3]:=Text001+' '+FORMAT(DMY2DATE(1,1,DATE2DMY(TODAY,3)-2),0,'<Year4>');

      Customer."Amount YTD":=CustSalesLCY[1];
      Customer."Amount YTD-1":=CustSalesLCY[2];
      Customer."Amount YTD-2":=CustSalesLCY[3];

      Customer.MODIFY;
    UNTIL Customer.NEXT = 0;
    END;
    // S160001_20 END
    //END MIG2017
    */
    //end;
}

