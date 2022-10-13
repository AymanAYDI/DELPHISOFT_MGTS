report 50028 "Enregistrement contrat"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Enregistrementcontrat.rdlc';

    dataset
    {
        dataitem(DataItem1000000000; Table18)
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
            column(Partnershipagreement_Customer; Customer."Partnership agreement")
            {
                IncludeCaption = true;
            }
            column(Serviceagreement_Customer; Customer."Service agreement")
            {
                IncludeCaption = true;
            }
            column("LibelléSSA_Customer"; Customer."Libellé SSA")
            {
                IncludeCaption = true;
            }
            column("DatededébutSSA_Customer"; Customer."Date de début SSA")
            {
                IncludeCaption = true;
            }
            column(DatedefinSSA_Customer; Customer."Date de fin SSA")
            {
                IncludeCaption = true;
            }
            column(Level_Customer; Customer.Level)
            {
                IncludeCaption = true;
            }
            column(StatutCE_Customer; Customer."Statut CE")
            {
                IncludeCaption = true;
            }
            column(DateSignatureCE_Customer; Customer."Date Signature CE")
            {
                IncludeCaption = true;
            }
            column(NationalMark_Customer; Customer."National Mark")
            {
                IncludeCaption = true;
            }
            column(MDD_Customer; Customer.MDD)
            {
                IncludeCaption = true;
            }
            column(NORAUTO_Customer; Customer.NORAUTO)
            {
                IncludeCaption = true;
            }
            column(MIDAS_Customer; Customer.MIDAS)
            {
                IncludeCaption = true;
            }
            column(ATU_Customer; Customer.ATU)
            {
                IncludeCaption = true;
            }
            column(ATYSE_Customer; Customer.ATYSE)
            {
                IncludeCaption = true;
            }
            column(CARTERCASH_Customer; Customer."CARTER CASH")
            {
                IncludeCaption = true;
            }
            column(SYNCHRO_Customer; Customer.SYNCHRO)
            {
                IncludeCaption = true;
            }
            column(ParentCompany_Customer; Customer."Parent Company")
            {
                IncludeCaption = true;
            }
            column("DatededébutPA_Customer"; Customer."Date de début PA")
            {
                IncludeCaption = true;
            }
            column(DatedefinPA_Customer; Customer."Date de fin PA")
            {
                IncludeCaption = true;
            }
            column(CommentPA_Customer; Customer."Comment PA")
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
            column("LibelléPA_Customer"; Customer."Libellé PA")
            {
                IncludeCaption = true;
            }
            column(Enfacturation_Customer; Customer."En facturation")
            {
                IncludeCaption = true;
            }
            column(CommentSSA_Customer; Customer."Comment SSA")
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
        CaptionGeneral: Label 'General';
        CaptionPA: Label 'Partnership agreement follow up';
        CaptionSSA: Label 'Service agreement follow up';
        CaptionMarque: Label 'Mark';
        CaptionEnseigne: Label 'Signboard';
        Vendeur_Rec: Record "13";
        VendeurName: Text;
        CaptionCE: Label 'Charte ethique';
        CaptionTitre: Label 'ENREGISTREMENT CONTRAT DE PARTENARIAT/SERVICES';
}

