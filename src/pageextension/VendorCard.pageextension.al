pageextension 50047 "DEL VendorCard" extends "Vendor Card" //26
{
    layout
    {
        addafter("IC Partner Code")
        {
            field("DEL Forwarding Agent Code"; Rec."DEL Forwarding Agent Code")
            { }
        }
        addafter("Responsibility Center")
        {
            field("DEL Supplier Base ID"; Rec."DEL Supplier Base ID") { }
            field("DEL EDI"; Rec."DEL EDI") { }
        }
        addafter("Creditor No.")
        {
            field("DEL Email Payment Advice"; Rec."DEL Email Payment Advice") { }
        }
        addafter("Shipment Method Code")
        {
            field("DEL Ship Per"; Rec."DEL Ship Per") { }
            field("DEL Lead Time Not Allowed"; Rec."DEL Lead Time Not Allowed") { }
        }
    }
    actions
    {
        modify("Co&mments")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        addafter(VendorReportSelections)
        {
            action("DEL Doc&uments")
            {
                Caption = 'Audit report';
                Image = Documents;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Document Sheet";
                RunPageLink = "No." = FIELD("No.");
                RunPageView = SORTING("Table Name", "No.", "Comment Entry No.", "Line No.")
                                  WHERE("Table Name" = CONST(Vendor));
            }
            separator(sp) { }
            action("DEL Notation fournisseur")
            {
                Caption = 'Vendor rating';
                Image = AdjustItemCost;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Vendor Card Notation";
                RunPageLink = "No." = FIELD("No.");
            }
            action("DEL Liasse Documentaire")
            {
                Caption = 'General contract doc case';
                Image = ApplicationWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL Fiche suivi liasse doc";
                RunPageLink = "No." = FIELD("No.");
            }
        }
        addfirst(Documents)
        {
            action("DEL Document Matrix")
            {
                Caption = 'Document Matrix';
                Image = TaxSetup;
                trigger onaction()
                var
                    lpgDocumentMatrix: Page "DEL Document Matrix";
                begin
                    lpgDocumentMatrix.SetVendorFilter(Rec."No.");
                    lpgDocumentMatrix.RUNMODAL();
                end;
            }
        }
        addafter("Purchase Journal")
        {
            action("DEL Fee")
            {
                Caption = 'Fee';
                trigger onaction()
                var
                    feeConnection_Re_Loc: Record "DEL Fee Connection";
                    feeConnection_Page_Loc: Page "DEL Fee Connection";
                begin
                    feeConnection_Re_Loc.RESET();
                    //filter the table
                    feeConnection_Re_Loc.SETRANGE(Type, feeConnection_Re_Loc.Type::Vendor);
                    feeConnection_Re_Loc.SETFILTER("No.", Rec."No.");

                    CLEAR(feeConnection_Page_Loc);
                    feeConnection_Page_Loc.SETTABLEVIEW(feeConnection_Re_Loc);
                    feeConnection_Page_Loc.SETRECORD(feeConnection_Re_Loc);
                    feeConnection_Page_Loc.LOOKUPMODE(TRUE);

                    feeConnection_Page_Loc.FNC_Set_Type(feeConnection_Re_Loc.Type::Vendor, Rec."No.");

                    feeConnection_Page_Loc.RUN()
                end;
            }
            action("DEL Fee Copy")
            {
                Caption = 'Fee Copy';
                trigger onaction()
                begin
                    FNC_CopieFrais();
                end;
            }
            action("DEL Forwarding Agent")
            {
                RunObject = Page "DEL Forwarding Agents";
                RunPageLink = "Vendor No." = FIELD("No.");
                RunPageView = SORTING("Vendor No.", "Location Code")
                                  ORDER(Ascending);
            }
        }
    }
    PROCEDURE FNC_CopieFrais();
    VAR
        Vendor_Re_Loc: Record Vendor;
        FeeMgt_Cu_Loc: Codeunit "DEL Alert and fee copy Mgt";
        Vendor_Fo_Loc: Page "Vendor List";
    BEGIN
        Vendor_Fo_Loc.LOOKUPMODE(TRUE);
        IF Vendor_Fo_Loc.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            Vendor_Fo_Loc.GETRECORD(Vendor_Re_Loc);
            FeeMgt_Cu_Loc.FNC_FeeCopy("Credit Transfer Account Type"::Vendor, Vendor_Re_Loc."No.", Rec."No.");
        END;
    END;
}
