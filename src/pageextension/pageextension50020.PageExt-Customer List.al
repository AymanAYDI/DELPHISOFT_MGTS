pageextension 50020 pageextension50020 extends "Customer List"
{
    // S160001_20    JUH   10.07.17    OnOpenPage    Add Calculation
    //               THM   08.09.17                  MIG2017
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // MGTS:EDD001.01 :TU 24/05/2018 : Minimisation des clics :
    //   #Added new field "FTP Save"
    // 
    // MGTS:EDD001.02 :TU 06/06/2018 : Minimisation des clics :
    //                 - Add new field "FTP Save 2"
    // +----------------------------------------------------------------------------------------------------------------+
    layout
    {

        //Unsupported feature: Property Modification (SubPageLink) on "Control 35".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 33".


        //Unsupported feature: Property Modification (SubPageLink) on "SalesHistSelltoFactBox(Control 1903720907)".


        //Unsupported feature: Property Modification (SubPageLink) on "SalesHistBilltoFactBox(Control 1907234507)".


        //Unsupported feature: Property Modification (SubPageLink) on "CustomerStatisticsFactBox(Control 1902018507)".


        //Unsupported feature: Property Modification (SubPageLink) on "CustomerDetailsFactBox(Control 1900316107)".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1907829707".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1902613707".

        addafter("Control 6")
        {
            field("FTP Save"; "FTP Save")
            {
            }
            field("FTP Save 2"; "FTP Save 2")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 20".


        //Unsupported feature: Property Modification (RunPageLink) on "DimensionsSingle(Action 84)".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 45".


        //Unsupported feature: Property Modification (RunPageView) on "CustomerLedgerEntries(Action 22)".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 18".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 21".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 19".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 63".


        //Unsupported feature: Property Modification (RunPageLink) on ""Sales_Prices"(Action 26)".


        //Unsupported feature: Property Modification (RunPageLink) on ""Sales_LineDiscounts"(Action 71)".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 82".


        //Unsupported feature: Property Modification (RunPageLink) on ""Prices_Prices"(Action 100)".


        //Unsupported feature: Property Modification (RunPageLink) on ""Prices_LineDiscounts"(Action 98)".

    }

    var
        CustSalesLCY: array[4] of Decimal;
        CustDateFilter: array[4] of Text[30];
        i: Integer;
        DateFilter1: Text;
        DateFilter2: Text;
        DateFilter3: Text;
        Customer: Record "18";
        Text001: Label 'Sales (LCY)';


        //Unsupported feature: Code Insertion (VariableCollection) on "OnOpenPage".

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

