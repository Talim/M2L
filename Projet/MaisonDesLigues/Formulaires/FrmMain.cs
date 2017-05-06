using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MaterialSkin.Controls;
using MaterialSkin;
using Shadow;
using BaseDeDonnees;
using MaisonDesLigues.Utilitaires;
using ComposantNuite;
using System.Collections.ObjectModel;

namespace MaisonDesLigues
{
    public partial class FrmMain : MaterialForm
    {
        private readonly MaterialSkinManager materialSkinManager;

        private Dropshadow _ombre;
        private Bdd UneConnexion;
        private String IdStatutSelectionne = "";

        public FrmMain()
        {
            InitializeComponent();
            materialSkinManager = MaterialSkinManager.Instance;
            materialSkinManager.AddFormToManage(this);
            materialSkinManager.Theme = MaterialSkinManager.Themes.LIGHT;
            materialSkinManager.ColorScheme = new ColorScheme(Primary.BlueGrey800, Primary.BlueGrey900, Primary.BlueGrey500, Accent.LightBlue200, TextShade.WHITE);
        }

        private void tabPage1_Click(object sender, EventArgs e)
        {

        }

        private void FrmMain_Load(object sender, EventArgs e)
        {
            if (!DesignMode)
            {
                _ombre = new Dropshadow(this)
                {
                    ShadowBlur = 10,
                    ShadowSpread = -4,
                    ShadowColor = Color.FromArgb(33, 33, 33)
                };
                _ombre.RefreshShadow();
                _ombre.Refresh();
            }
            UneConnexion = ((FrmLogin)Owner).connection;

            initValues();
        }

        private void initValues()
        {
            //NUITE - RADIO_BUTTON
            RdoNuitéNon.Checked = true;
            //Intervenants - Ateliers
            Utilitaire.RemplirComboBox(UneConnexion, CmbAtelier, "VATELIER01");
            Utilitaire.CreerDesControles(this, UneConnexion, "VSTATUT01", "Rad_", PnlType, "RadioButton", this.rdbStatutIntervenant_StateChanged);

            Utilitaire.CreerDesControles(this, UneConnexion, "VDATEBENEVOLAT01", "ChkDateB_", panel2, "CheckBox", this.rdbStatutIntervenant_StateChanged);
            // on va tester si le controle à placer est de type CheckBox afin de lui placer un événement checked_changed
            // Ceci afin de désactiver les boutons si aucune case à cocher du container n'est cochée
            foreach (Control UnControle in panel2.Controls)
            {
                if (UnControle.GetType().Name == "CheckBox")
                {
                    CheckBox UneCheckBox = (CheckBox)UnControle;
                }
            }


        }

        private void rdbStatutIntervenant_StateChanged(object sender, EventArgs e)
        {
            // stocke dans un membre de niveau form l'identifiant du statut sélectionné (voir règle de nommage des noms des controles : prefixe_Id)
            this.IdStatutSelectionne = ((RadioButton)sender).Name.Split('_')[1];
        }


        private void InscrireBenevole()
        {
            Collection<Int16> IdDatesSelectionnees = new Collection<Int16>();
            Int64? NumeroLicence;

            NumeroLicence = System.Convert.ToInt64(txtLicence.Text);

            foreach (Control UnControle in panel2.Controls)
            {
                if (UnControle.GetType().Name == "CheckBox" && ((CheckBox)UnControle).Checked)
                {
                    /* Un name de controle est toujours formé come ceci : xxx_Id où id représente l'id dans la table
                     * Donc on splite la chaine et on récupére le deuxième élément qui correspond à l'id de l'élément sélectionné.
                     * on rajoute cet id dans la collection des id des dates sélectionnées
                        
                    */
                    IdDatesSelectionnees.Add(System.Convert.ToInt16((UnControle.Name.Split('_'))[1]));
                }
            }
            UneConnexion.InscrireBenevole(TxtNom.Text, TxtPrenom.Text, TxtAdresse.Text, TxtAdresse2.Text != "" ? TxtAdresse2.Text : null, TxtCp.Text, TxtVille.Text, TxtTel.Text , TxtMail.Text != "" ? TxtMail.Text : null, System.Convert.ToDateTime(txtNaissance.Text), NumeroLicence, IdDatesSelectionnees);

        }

        private void InscrireIntervenant()
        {
            // inscription avec les nuitées
            try
            {
                if (RdoNuitéOui.Checked)
                {
                    // inscription avec les nuitées
                    Collection<Int16> NuitsSelectionnes = new Collection<Int16>();
                    Collection<String> HotelsSelectionnes = new Collection<String>();
                    Collection<String> CategoriesSelectionnees = new Collection<string>();
                    foreach (Control UnControle in PnlNuite.Controls)
                    {
                        if (UnControle.GetType().Name == "ResaNuite" && ((ResaNuite)UnControle).GetNuitSelectionnee())
                        {
                            // la nuité a été cochée, il faut donc envoyer l'hotel et la type de chambre à la procédure de la base qui va enregistrer le contenu hébergement 
                            //ContenuUnHebergement UnContenuUnHebergement= new ContenuUnHebergement();
                            CategoriesSelectionnees.Add(((ResaNuite)UnControle).GetTypeChambreSelectionnee());
                            HotelsSelectionnes.Add(((ResaNuite)UnControle).GetHotelSelectionne());
                            NuitsSelectionnes.Add(((ResaNuite)UnControle).IdNuite);
                        }

                    }
                    if (NuitsSelectionnes.Count == 0)
                    {
                        MessageBox.Show("Si vous avez sélectionné que l'intervenant avait des nuités\n in faut qu'au moins une nuit soit sélectionnée");
                    }
                    else
                    {
                        UneConnexion.InscrireIntervenant(TxtNom.Text, TxtPrenom.Text, TxtAdresse.Text, TxtAdresse2.Text != "" ? TxtAdresse2.Text : null, TxtCp.Text, TxtVille.Text, TxtTel.Text, TxtMail.Text != "" ? TxtMail.Text : null, System.Convert.ToInt16(CmbAtelier.SelectedValue), this.IdStatutSelectionne, CategoriesSelectionnees, HotelsSelectionnes, NuitsSelectionnes);
                        MessageBox.Show("Inscription intervenant effectuée");
                    }
                }
                else
                { // inscription sans les nuitées
                    UneConnexion.InscrireIntervenant(TxtNom.Text, TxtPrenom.Text, TxtAdresse.Text, TxtAdresse2.Text != "" ? TxtAdresse2.Text : null, TxtCp.Text, TxtVille.Text, TxtTel.Text, TxtMail.Text != "" ? TxtMail.Text : null, System.Convert.ToInt16(CmbAtelier.SelectedValue), this.IdStatutSelectionne);
                    MessageBox.Show("Inscription intervenant effectuée");

                }
                //REMISE A ZERO
                foreach (Control crt in GpbIdentité.Controls)
                {
                    if (crt.GetType() == typeof(MaterialSingleLineTextField))
                    {
                        crt.Text = "";
                    }
                }
                RdoNuitéNon.Checked = true;


            }
            catch (Exception Ex)
            {
                MessageBox.Show(Ex.Message);
            }
        }

        private void BtnEnregistrer_Click(object sender, EventArgs e)
        {
            switch (TabType.SelectedTab.Text)
            {
                case "Intervenant":
                    InscrireIntervenant();
                    break;
                case "Bénévole":
                    InscrireBenevole();
                    break;
            }
        }

        private void RdbNuiteIntervenant_CheckedChanged(object sender, EventArgs e)
        {
            if (((MaterialRadioButton)sender).Name == "RdoNuitéOui")
            {
                PnlNuite.Visible = true;
                Dictionary<Int16, String> LesNuites = UneConnexion.ObtenirDatesNuites();
                int i = 0;
                foreach (KeyValuePair<Int16, String> UneNuite in LesNuites)
                {
                    ComposantNuite.ResaNuite unResaNuit = new ComposantNuite.ResaNuite(UneConnexion.ObtenirDonnesOracle("VHOTEL01"), (UneConnexion.ObtenirDonnesOracle("VCATEGORIECHAMBRE01")), UneNuite.Value, UneNuite.Key);
                    unResaNuit.Left = 0;
                    unResaNuit.Top = 5 + (24 * i++);
                    unResaNuit.Visible = true;
                    PnlNuite.Controls.Add(unResaNuit);
                }
            }
            else
            {
                PnlNuite.Visible = false;
            }
        }
    }
}
