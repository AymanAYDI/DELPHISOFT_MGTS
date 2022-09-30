codeunit 50010 "Export Mail Prod Nouv Et Suiv"
{

    trigger OnRun()
    begin
        CLEARALL;
        CLEARLASTERROR;
        /*
        IF EXISTS('D:\Export\New_products_follow_up.csv') THEN
         ERASE('D:\Export\New_products_follow_up.csv');
        
        IF EXISTS('D:\Export\Tracked_product_follow_up.csv') THEN
         ERASE('D:\Export\Tracked_product_follow_up.csv');
        */
        WTAB := 9;
        //Nouveau produit
        FileVendor.CREATE('C:\Export\New_products_follow_up.csv');

        FileVendor.CREATEOUTSTREAM(FoutStream);

        streamWriter := streamWriter.StreamWriter(FoutStream, encoding.Unicode);

        PurchaseLine_Nouv.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        PurchaseLine_Nouv.SETRANGE("First Purch. Order", TRUE);
        PurchaseLine_Nouv.SETRANGE(Type, PurchaseLine_Nouv.Type::Item);
        PurchaseLine_Nouv.SETRANGE("Photo And DDoc", FALSE);//DEL.SAZ 30.10.18
        IF PurchaseLine_Nouv.FINDSET THEN BEGIN
            //PurchaseHeader_Nouv

            streamWriter.WriteLine('Buy-from Vendor No.' + FORMAT(WTAB)

                                    + 'Name' + FORMAT(WTAB)
                                    + 'Document No.' + FORMAT(WTAB)
                                    + 'No.' + FORMAT(WTAB)
                                    + 'Description' + FORMAT(WTAB)
                                    + 'Order Date' + FORMAT(WTAB)
                                    + 'PI delivery date' + FORMAT(WTAB)
                                    + 'Quantity' + FORMAT(WTAB)
                                    + 'DDOCS provided' + FORMAT(WTAB) //DEL.SAZ 30.10.18
                                    + 'DDOCS date' + FORMAT(WTAB) //DEL.SAZ 30.10.18
                                    + 'DDOCS by' + FORMAT(WTAB) //DEL.SAZ 30.10.18
                                    + 'Picture Taken' + FORMAT(WTAB)
                                    + 'Picture Date' + FORMAT(WTAB)
                                    + 'Photo Taked By' + FORMAT(WTAB)
                                    + 'Purchaser Code');
            REPEAT
                BuyfromVendorName := '';
                IF Vendor_Rec.GET(PurchaseLine_Nouv."Buy-from Vendor No.") THEN
                    BuyfromVendorName := Vendor_Rec.Name;

                PurchaseHeader_Nouv.SETRANGE("No.");
                PurchaseHeader_Nouv.SETRANGE("No.", PurchaseLine_Nouv."Document No.");
                IF PurchaseHeader_Nouv.FINDFIRST THEN;

                streamWriter.WriteLine(PurchaseLine_Nouv."Buy-from Vendor No." + FORMAT(WTAB)
                                  + BuyfromVendorName + FORMAT(WTAB)
                                  + PurchaseLine_Nouv."Document No." + FORMAT(WTAB)
                                  + PurchaseLine_Nouv."No." + FORMAT(WTAB)
                                  + PurchaseLine_Nouv.Description + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."Order Date") + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."Expected Receipt Date") + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv.Quantity) + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."Sample Collected") + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."Collected Date") + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."Sample Collected by") + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."Photo Taked") + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."Photo Date") + FORMAT(WTAB)
                                  + PurchaseLine_Nouv."Photo Taked By" + FORMAT(WTAB)
                                  + FORMAT(PurchaseHeader_Nouv."Purchaser Code"));

            UNTIL PurchaseLine_Nouv.NEXT = 0;
        END;

        streamWriter.Close();
        streamWriter.Dispose();
        FileVendor.CLOSE();
        //Produit suivi
        CLEAR(FileVendor);
        CLEAR(FoutStream);
        CLEAR(streamWriter);

        FileVendor.CREATE('C:\Export\Tracked_product_follow_up.csv');

        FileVendor.CREATEOUTSTREAM(FoutStream);

        streamWriter := streamWriter.StreamWriter(FoutStream, encoding.Unicode);

        PurchaseLine_Suiv.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        PurchaseLine_Suiv.SETRANGE("Risk Item", TRUE);
        PurchaseLine_Suiv.SETRANGE(Type, PurchaseLine_Suiv.Type::Item);

        //DEL.SAZ 19.09.2018
        PurchaseLine_Suiv.SETRANGE("Photo Risk Item Taked", FALSE);
        DateRecCalc := CALCDATE('<-5D>', WORKDATE);
        PurchaseLine_Suiv.SETFILTER("Expected Receipt Date", '>%1', DateRecCalc);
        //END DEL.SAZ 19.09.2018
        IF PurchaseLine_Suiv.FINDSET THEN BEGIN

            streamWriter.WriteLine('Buy-from Vendor No.' + FORMAT(WTAB)
                                    + 'Name' + FORMAT(WTAB)
                                    + 'Document No.' + FORMAT(WTAB)
                                    + 'No.' + FORMAT(WTAB)
                                    + 'Description' + FORMAT(WTAB)
                                    + 'Order Date' + FORMAT(WTAB)
                                    + 'PI delivery date' + FORMAT(WTAB)
                                    + 'Quantity' + FORMAT(WTAB)
                                    + 'Tracking Completed' + FORMAT(WTAB)
                                    + 'tracking completed on' + FORMAT(WTAB)
                                    + 'tracking completed by' + FORMAT(WTAB)
                                    + 'Purchaser Code' + FORMAT(WTAB)
                                    + 'tracking reason');
            REPEAT
                BuyfromVendorName := '';
                IF Vendor_Rec.GET(PurchaseLine_Suiv."Buy-from Vendor No.") THEN
                    BuyfromVendorName := Vendor_Rec.Name;
                //DEL.SAZ 17.09.2018
                motif := '';
                IF Item.GET(PurchaseLine_Suiv."No.") THEN
                    IF Listedesmotifs.GET(Item."Code motif de suivi") THEN
                        motif := Listedesmotifs.Motif;
                //END DEL.SAZ 18.09.2018
                PurchaseHeader_Suiv.SETRANGE("No.");
                PurchaseHeader_Suiv.SETRANGE("No.", PurchaseLine_Suiv."Document No.");
                IF PurchaseHeader_Suiv.FINDFIRST THEN;

                streamWriter.WriteLine(PurchaseLine_Suiv."Buy-from Vendor No." + FORMAT(WTAB)
                                       + BuyfromVendorName + FORMAT(WTAB)
                                       + PurchaseLine_Suiv."Document No." + FORMAT(WTAB)
                                       + PurchaseLine_Suiv."No." + FORMAT(WTAB)
                                       + PurchaseLine_Suiv.Description + FORMAT(WTAB)
                                       + FORMAT(PurchaseLine_Suiv."Order Date") + FORMAT(WTAB)
                                        + FORMAT(PurchaseLine_Suiv."Expected Receipt Date") + FORMAT(WTAB)
                                       + FORMAT(PurchaseLine_Suiv.Quantity) + FORMAT(WTAB)
                                       + FORMAT(PurchaseLine_Suiv."Photo Risk Item Taked") + FORMAT(WTAB)
                                       + FORMAT(PurchaseLine_Suiv."Photo Risk Item Date") + FORMAT(WTAB)
                                       + PurchaseLine_Suiv."Photo Risk Item Taked By" + FORMAT(WTAB)
                                       + FORMAT(PurchaseHeader_Suiv."Purchaser Code") + FORMAT(WTAB)
                                       + motif);

            UNTIL PurchaseLine_Suiv.NEXT = 0;
        END;

        streamWriter.Close();
        streamWriter.Dispose();
        FileVendor.CLOSE();

        SLEEP(9000);

        IF NOT EXISTS('C:\Export\New_products_follow_up.csv') THEN
            ERROR('File Not Found : C:\Export\New_products_follow_up.csv');

        IF NOT EXISTS('C:\Export\Tracked_product_follow_up.csv') THEN
            ERROR('File Not Found : C:\Export\Tracked_product_follow_up.csv');

        //variable  SMTP code unit SMTP Mail

        IF SMTPMailSetup.GET THEN BEGIN
            //report_MGTS@mgts.com
            //SMTPMailSetup."Sender mail"
            SMTP.CreateMessage('report_MGTS', 'report_MGTS@mgts.com', '', 'List New_products_follow_up and Tracked_product_follow_up', 'List New_products_follow_up and Tracked_product_follow_up', TRUE);

            IF SMTPMailSetup.Mail1 <> '' THEN
                SMTP.AddRecipients(SMTPMailSetup.Mail1);
            IF SMTPMailSetup.Mail2 <> '' THEN
                SMTP.AddRecipients(SMTPMailSetup.Mail2);
            IF SMTPMailSetup.Mail3 <> '' THEN
                SMTP.AddRecipients(SMTPMailSetup.Mail3);
            IF SMTPMailSetup.Mail4 <> '' THEN
                SMTP.AddRecipients(SMTPMailSetup.Mail4);
            IF SMTPMailSetup.Mail5 <> '' THEN
                SMTP.AddRecipients(SMTPMailSetup.Mail5);
        END;
        SMTP.AddAttachment('C:\Export\New_products_follow_up.csv', 'New_products_follow_up.csv');
        SLEEP(9000);
        SMTP.AddAttachment('C:\Export\Tracked_product_follow_up.csv', 'Tracked_product_follow_up.csv');
        SLEEP(9000);
        SMTP.Send;
        SLEEP(9000);
        CLEARALL;

        IF EXISTS('C:\Export\New_products_follow_up.csv') THEN
            ERASE('C:\Export\New_products_follow_up.csv');

        IF EXISTS('C:\Export\Tracked_product_follow_up.csv') THEN
            ERASE('C:\Export\Tracked_product_follow_up.csv');

    end;

    var
        PurchaseLine_Nouv: Record "39";
        PurchaseLine_Suiv: Record "39";
        FileVendor: File;
        FoutStream: OutStream;
        streamWriter: DotNet StreamWriter;
        encoding: DotNet Encoding;
        WTAB: Char;
        SMTP: Codeunit "400";
        BuyfromVendorName: Text;
        Vendor_Rec: Record "23";
        SMTPMailSetup: Record "409";
        PurchaseHeader_Nouv: Record "38";
        PurchaseHeader_Suiv: Record "38";
        motif: Text[100];
        Listedesmotifs: Record "50064";
        Item: Record "27";
        DateRecCalc: Date;
}

