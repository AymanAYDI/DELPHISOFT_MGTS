codeunit 50010 "DEL Exp Mail Prod Nouv Et Suiv"
{

    trigger OnRun()
    begin
        CLEARALL();
        CLEARLASTERROR();
        WTAB := 9;
        //Nouveau produit
        // TODO: ancien code: à corriger
        // FileVendor.CREATE('C:\Export\New_products_follow_up.csv');
        // FileVendor.CREATEOUTSTREAM(FoutStream);
        // streamWriter := streamWriter.StreamWriter(FoutStream, encoding.Unicode); 
        tempBlob1.CreateOutStream(OutStr, TextEncoding::UTF8);

        PurchaseLine_Nouv.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        PurchaseLine_Nouv.SETRANGE("DEL First Purch. Order", TRUE);
        PurchaseLine_Nouv.SETRANGE(Type, PurchaseLine_Nouv.Type::Item);
        PurchaseLine_Nouv.SETRANGE("DEL Photo And DDoc", FALSE);
        IF PurchaseLine_Nouv.FINDSET() THEN BEGIN
            //PurchaseHeader_Nouv

            OutStr.WriteText('Buy-from Vendor No.' + FORMAT(WTAB)

                                    + 'Name' + FORMAT(WTAB)
                                    + 'Document No.' + FORMAT(WTAB)
                                    + 'No.' + FORMAT(WTAB)
                                    + 'Description' + FORMAT(WTAB)
                                    + 'Order Date' + FORMAT(WTAB)
                                    + 'PI delivery date' + FORMAT(WTAB)
                                    + 'Quantity' + FORMAT(WTAB)
                                    + 'DDOCS provided' + FORMAT(WTAB)
                                    + 'DDOCS date' + FORMAT(WTAB)
                                    + 'DDOCS by' + FORMAT(WTAB)
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
                IF PurchaseHeader_Nouv.FINDFIRST() THEN;

                OutStr.WriteText(PurchaseLine_Nouv."Buy-from Vendor No." + FORMAT(WTAB)
                                  + BuyfromVendorName + FORMAT(WTAB)
                                  + PurchaseLine_Nouv."Document No." + FORMAT(WTAB)
                                  + PurchaseLine_Nouv."No." + FORMAT(WTAB)
                                  + PurchaseLine_Nouv.Description + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."Order Date") + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."Expected Receipt Date") + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv.Quantity) + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."DEL Sample Collected") + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."DEL Collected Date") + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."DEL Sample Collected by") + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."DEL Photo Taked") + FORMAT(WTAB)
                                  + FORMAT(PurchaseLine_Nouv."DEL Photo Date") + FORMAT(WTAB)
                                  + PurchaseLine_Nouv."DEL Photo Taked By" + FORMAT(WTAB)
                                  + FORMAT(PurchaseHeader_Nouv."Purchaser Code"));

            UNTIL PurchaseLine_Nouv.NEXT() = 0;
        END;

        // streamWriter.Close();
        // streamWriter.Dispose();
        // FileVendor.CLOSE(); // TODO: ancien code

        //Produit suivi
        CLEAR(FileVendor);
        CLEAR(OutStr);
        // CLEAR(streamWriter);
        // FileVendor.CREATE('C:\Export\Tracked_product_follow_up.csv');
        // FileVendor.CREATEOUTSTREAM(FoutStream);
        // streamWriter := streamWriter.StreamWriter(FoutStream, encoding.Unicode); // TODO: ancien code

        tempBlob2.CreateOutStream(OutStr, TextEncoding::UTF8);

        PurchaseLine_Suiv.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        PurchaseLine_Suiv.SETRANGE("DEL Risk Item", TRUE);
        PurchaseLine_Suiv.SETRANGE(Type, PurchaseLine_Suiv.Type::Item);
        PurchaseLine_Suiv.SETRANGE("DEL Photo Risk Item Taked", FALSE);
        DateRecCalc := CALCDATE('<-5D>', WORKDATE());
        PurchaseLine_Suiv.SETFILTER("Expected Receipt Date", '>%1', DateRecCalc);
        IF PurchaseLine_Suiv.FINDSET() THEN BEGIN

            OutStr.WriteText('Buy-from Vendor No.' + FORMAT(WTAB)
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
                motif := '';
                IF Item.GET(PurchaseLine_Suiv."No.") THEN
                    IF Listedesmotifs.GET(Item."DEL Code motif de suivi") THEN
                        motif := Listedesmotifs.Motif;
                PurchaseHeader_Suiv.SETRANGE("No.");
                PurchaseHeader_Suiv.SETRANGE("No.", PurchaseLine_Suiv."Document No.");
                IF PurchaseHeader_Suiv.FINDFIRST() THEN;

                OutStr.WriteText(PurchaseLine_Suiv."Buy-from Vendor No." + FORMAT(WTAB)
                                       + BuyfromVendorName + FORMAT(WTAB)
                                       + PurchaseLine_Suiv."Document No." + FORMAT(WTAB)
                                       + PurchaseLine_Suiv."No." + FORMAT(WTAB)
                                       + PurchaseLine_Suiv.Description + FORMAT(WTAB)
                                       + FORMAT(PurchaseLine_Suiv."Order Date") + FORMAT(WTAB)
                                        + FORMAT(PurchaseLine_Suiv."Expected Receipt Date") + FORMAT(WTAB)
                                       + FORMAT(PurchaseLine_Suiv.Quantity) + FORMAT(WTAB)
                                       + FORMAT(PurchaseLine_Suiv."DEL Photo Risk Item Taked") + FORMAT(WTAB)
                                       + FORMAT(PurchaseLine_Suiv."DEL Photo Risk Item Date") + FORMAT(WTAB)
                                       + PurchaseLine_Suiv."DEL Photo Risk Item Taked By" + FORMAT(WTAB)
                                       + FORMAT(PurchaseHeader_Suiv."Purchaser Code") + FORMAT(WTAB)
                                       + motif);

            UNTIL PurchaseLine_Suiv.NEXT() = 0;
        END;

        // streamWriter.Close();
        // streamWriter.Dispose();
        // FileVendor.CLOSE(); // TODO:  ancient code

        SLEEP(9000);

        // IF NOT EXISTS('C:\Export\New_products_follow_up.csv') THEN
        //     ERROR('File Not Found : C:\Export\New_products_follow_up.csv');
        // IF NOT EXISTS('C:\Export\Tracked_product_follow_up.csv') THEN
        //     ERROR('File Not Found : C:\Export\Tracked_product_follow_up.csv'); // TODO: ancient code

        if not tempBlob1.HasValue() then
            ERROR('File Not Found');
        if not tempBlob2.HasValue() then
            ERROR('File Not Found');


        //variable  SMTP code unit SMTP Mail

        if GeneralSetup.GET() then begin
            // TODO: Check
            // SMTP.CreateMessage('report_MGTS', 'report_MGTS@mgts.com', '', 'List New_products_follow_up and Tracked_product_follow_up', 'List New_products_follow_up and Tracked_product_follow_up', TRUE); 
            EmailMessage.Create('', 'List New_products_follow_up and Tracked_product_follow_up', 'List New_products_follow_up and Tracked_product_follow_up', true);
            if GeneralSetup.Mail1 <> '' then
                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::"To", GeneralSetup.Mail1);
            if GeneralSetup.Mail2 <> '' then
                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::"To", GeneralSetup.Mail2);
            if GeneralSetup.Mail3 <> '' then
                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::"To", GeneralSetup.Mail3);
            if GeneralSetup.Mail4 <> '' then
                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::"To", GeneralSetup.Mail4);
            if GeneralSetup.Mail5 <> '' then
                EmailMessage.AddRecipient(Enum::"Email Recipient Type"::"To", GeneralSetup.Mail5);
        end;

        tempBlob1.CreateInStream(InStr);
        EmailMessage.AddAttachment('New_products_follow_up.csv', '', Instr);
        Clear(Instr);
        SLEEP(9000);
        tempBlob2.CreateInStream(InStr);
        EmailMessage.AddAttachment('Tracked_product_follow_up.csv', '', InStr);
        SLEEP(9000);
        EmailSend.Send(EmailMessage);
        SLEEP(9000);
        CLEARALL();

        // IF EXISTS('C:\Export\New_products_follow_up.csv') THEN
        //     ERASE('C:\Export\New_products_follow_up.csv');
        // IF EXISTS('C:\Export\Tracked_product_follow_up.csv') THEN
        //     ERASE('C:\Export\Tracked_product_follow_up.csv'); // TODO: ancient code

    end;

    var
        // SMTPMailSetup: Record "409";
        GeneralSetup: Record "DEL General Setup";
        Listedesmotifs: Record "DEL Liste des motifs";
        Item: Record Item;
        PurchaseHeader_Nouv: Record "Purchase Header";
        PurchaseHeader_Suiv: Record "Purchase Header";
        PurchaseLine_Nouv: Record "Purchase Line";
        PurchaseLine_Suiv: Record "Purchase Line";
        Vendor_Rec: Record Vendor;
        EmailSend: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        tempBlob1: Codeunit "Temp Blob";
        tempBlob2: Codeunit "Temp Blob";
        // streamWriter: DotNet StreamWriter; // TODO:  Cloud
        // encoding: DotNet Encoding; // TODO:  Cloud
        WTAB: Char;
        DateRecCalc: Date;
        FileVendor: File;
        InStr: InStream;
        OutStr: OutStream;
        BuyfromVendorName: Text;
        motif: Text[100];
}

