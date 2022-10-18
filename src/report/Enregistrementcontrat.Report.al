report 50028 "DEL Enregistrement contrat"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/Enregistrementcontrat.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(CaptionTitre; CaptionTitre)
            {
            }
            column(SalespersonCode_Customer; Customer."Salesperson Code")
            {
                IncludeCaption = true;
            }
            column(VendeurName; VendeurName)
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
                IncludeCaption = true;
            }
            column(Partnershipagreement_Customer; Customer."DEL Partnership agreement")
            {
                IncludeCaption = true;
            }
            column(Serviceagreement_Customer; Customer."DEL Service agreement")
            {
                IncludeCaption = true;
            }
            column("LibelléSSA_Customer"; Customer."DEL Libellé SSA")
            {
                IncludeCaption = true;
            }
            column("DatededébutSSA_Customer"; Customer."DEL Date de début SSA")
            {
                IncludeCaption = true;
            }
            column(DatedefinSSA_Customer; Customer."DEL Date de fin SSA")
            {
                IncludeCaption = true;
            }
            column(Level_Customer; Customer."DEL Level")
            {
                IncludeCaption = true;
            }
            column(StatutCE_Customer; Customer."DEL Statut CE")
            {
                IncludeCaption = true;
            }
            column(DateSignatureCE_Customer; Customer."DEL Date Signature CE")
            {
                IncludeCaption = true;
            }
            column(NationalMark_Customer; Customer."DEL National Mark")
            {
                IncludeCaption = true;
            }
            column(MDD_Customer; Customer."DEL MDD")
            {
                IncludeCaption = true;
            }
            column(NORAUTO_Customer; Customer."DEL NORAUTO")
            {
                IncludeCaption = true;
            }
            column(MIDAS_Customer; Customer."DEL MIDAS")
            {
                IncludeCaption = true;
            }
            column(ATU_Customer; Customer."DEL ATU")
            {
                IncludeCaption = true;
            }
            column(ATYSE_Customer; Customer."DEL ATYSE")
            {
                IncludeCaption = true;
            }
            column(CARTERCASH_Customer; Customer."DEL CARTER CASH")
            {
                IncludeCaption = true;
            }
            column(SYNCHRO_Customer; Customer."DEL SYNCHRO")
            {
                IncludeCaption = true;
            }
            column(ParentCompany_Customer; Customer."DEL Parent Company")
            {
                IncludeCaption = true;
            }
            column("DatededébutPA_Customer"; Customer."DEL Date de début PA")
            {
                IncludeCaption = true;
            }
            column(DatedefinPA_Customer; Customer."DEL Date de fin PA")
            {
                IncludeCaption = true;
            }
            column(CommentPA_Customer; Customer."DEL Comment PA")
            {
                IncludeCaption = true;
            }
            column(CaptionGeneral; CaptionGeneral)
            {
            }
            column(CaptionPA; CaptionPA)
            {
            }
            column(CaptionSSA; CaptionSSA)
            {
            }
            column(CaptionMarque; CaptionMarque)
            {
            }
            column(CaptionEnseigne; CaptionEnseigne)
            {
            }
            column("LibelléPA_Customer"; Customer."DEL Libellé PA")
            {
                IncludeCaption = true;
            }
            column(Enfacturation_Customer; Customer."DEL En facturation")
            {
                IncludeCaption = true;
            }
            column(CommentSSA_Customer; Customer."DEL Comment SSA")
            {
                IncludeCaption = true;
            }

            trigger OnAfterGetRecord()
            begin
                VendeurName := '';
                IF Vendeur_Rec.GET(Customer."Salesperson Code") THEN
                    VendeurName := Vendeur_Rec.Name;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Vendeur_Rec: Record "Salesperson/Purchaser";
        CaptionCE: Label 'Charte ethique';
        CaptionEnseigne: Label 'Signboard';
        CaptionGeneral: Label 'General';
        CaptionMarque: Label 'Mark';
        CaptionPA: Label 'Partnership agreement follow up';
        CaptionSSA: Label 'Service agreement follow up';
        CaptionTitre: Label 'ENREGISTREMENT CONTRAT DE PARTENARIAT/SERVICES';
        VendeurName: Text;
}

